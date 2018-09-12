/**
*Dis:创建服务小组的时候将关联的服务请求权限给服务小组用户
*Auther:Victor Li
*Time:2015年3月2日13:53:54
**/   
public class Cbl_ServiceGroup_Share {
	
	//插入服务小组时共享
	public void insertServiceGroup(list<servicegroup__c> listServiceGroup)
	{
		
		//服务请求ID
		Set<Id> set_SqId = new Set<Id>();
		
		for(servicegroup__c sg:listServiceGroup)
		{
			if(sg.servicerequest__c != null)
			{ 
				set_SqId.add(sg.servicerequest__c);
			}
		}
		
		//满足条件的服务请求		
		List<servicerequest__c> listServicereQuest = [select Id from servicerequest__c
		                                              where Id in:set_SqId];
	
		
		List<servicerequest__Share> listShareServicereQuest = new List<servicerequest__Share>();
		for(servicegroup__c sg:listServiceGroup)
		{
			for(servicerequest__c sq:listServicereQuest)
			{
				if(sg.servicerequest__c == sq.Id)
				{					
					servicerequest__Share sQShare = new servicerequest__Share();
					sQShare.UserOrGroupId = sg.user__c;
					sQShare.ParentId = sq.Id;
					sQShare.AccessLevel = 'Edit';
					sQShare.RowCause = Schema.servicerequest__Share.RowCause.Recruiter__c;
					listShareServicereQuest.add(sQShare);
				}
			}
		}
   	
		Database.SaveResult[] lsr = Database.insert(listShareServicereQuest,false);  
		System.debug(lsr + '******lsr*****');
		Integer i=0;
       
       // Process the save results
       for(Database.SaveResult sr : lsr)
       {
           if(!sr.isSuccess())
           {
              
              Database.Error err = sr.getErrors()[0];
              if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION&&
                  err.getMessage().contains('AccessLevel')))
              {
                  trigger.newMap.get(listShareServicereQuest[i].ParentId).addError(
                  'Unable to grant sharing access due to following exception: '
                  + err.getMessage());
              }
           }
           i++;
       }
		                                      		
	}
	
	 //更新
    public void updateServiceGroup(List<servicegroup__c> oldListServiceGroup,Map<id,servicegroup__c> mapOldServiceGroup)
    {
        //订单数据库对象
        List<servicegroup__c> oldServiceGroup = new List<servicegroup__c>();
        
        for(servicegroup__c sg:oldListServiceGroup)
        {
            if(sg.servicerequest__c != mapOldServiceGroup.get(sg.id).servicerequest__c || sg.user__c != mapOldServiceGroup.get(sg.id).user__c)
            {
                oldServiceGroup.add(sg);
            }
        }
        if(oldServiceGroup.size() > 0)
        {
            insertServiceGroup(oldServiceGroup);
        }
    }

}