/**
*Create By:jmark
*TIME：2015年2月26日13:20:39
*Descripe:新机安装后进行的PMMA测试证书时间自动关联到设备基础信息下的保修开始时间
 */
public class Cbl_installreport_time {
      //新建安装确认单时
      public void insertInstallreportTime(list<installreport__c> list_ins)
      {
           set<Id> set_Equipment=new set<Id>();//装设备ID
           set<Id> set_servicerequest=new set<Id>();//装服务请求ID
           list<installreport__c> list_req=new list<installreport__c>();//装满足条件的安装确认单
           for(installreport__c ins:list_ins)
           {
               if(ins.receptiontime__c != null)
               {
                   set_servicerequest.add(ins.servicereport__c);
               }
           }
           system.debug('------------------set_servicerequest'+set_servicerequest);
           set<Id> set_request=new set<Id>();//装符合条件服务请求ID
           list<servicerequest__c> list_ser=new list<servicerequest__c>();
           list<RecordType> listrtp=[Select r.Name, r.Id,r.developername From RecordType r where r.developername='htaz']; 
           if(set_servicerequest.size()>0)//查询出满足条件的服务请求
           {
               list_ser=[select Id,RecordTypeId from servicerequest__c where Id in:set_servicerequest];
           }
           if(list_ser.size()>0)
           {
               for(servicerequest__c ser:list_ser)//判断满足记录类型为新机安装
               {
                  if(ser.RecordTypeId == listrtp[0].Id)
                  {
                      set_request.add(ser.Id);
                  }
               }
           }
           if(set_request.size()>0)
           {
               for(installreport__c ins:list_ins)//获取是新机安装的安装确认单记录
	           {
	               for(Id id:set_request)
	               {
	                   if(ins.servicereport__c == id)
	                   {
	                       list_req.add(ins);
	                       set_Equipment.add(ins.EquId__c);
	                   }
	               }
	           }
	           list<Equipment__c> list_equ=new list<Equipment__c>();
	           if(set_Equipment.size()>0)//取出符合条件的设备记录
	           {
	               list_equ=[select Id,warrantySatart__c from Equipment__c where Id in:set_Equipment];
	           }
	           system.debug('------------------list_equ'+list_equ);
	           if(list_equ.size()>0 && list_req.size()>0)//给符合条件的设备记录赋值
	           {
	               for(Equipment__c equ:list_equ)
	               {
	                   for(installreport__c ins:list_req)
	                   {
	                       if(equ.Id == ins.EquId__c)
	                       {
	                          equ.warrantySatart__c=ins.receptiontime__c;
	                       }
	                   }
	               }
	               update list_equ;
	           }
           }
      }
      //更新安装确认单时
      public void updateInstallreportTime(list<installreport__c> list_ins,map<Id,installreport__c> map_ins)
      {
           list<installreport__c> list_req=new list<installreport__c>();
           for(installreport__c ins:list_ins)
           {
               if(ins.receptiontime__c != map_ins.get(ins.Id).receptiontime__c)
               {
                   list_req.add(ins);
               }
           }
           if(list_req.size()>0)
           {
               insertInstallreportTime(list_req);
           }
      }
}