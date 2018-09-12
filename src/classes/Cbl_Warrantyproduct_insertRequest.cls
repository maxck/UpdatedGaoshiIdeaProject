/**
*Create By:jmark
*TIME：2015年3月3日10:09:15
*Descripe:在保修期内，合约产品，全保设备，客户不是VIP时，
 *当设备手动选择生成巡检复选框时，按3个月为间隔在保修期限内生成若干条巡检记录。
 *如果是Vip客户的设备，当设备手动选择生成巡检复选框时，按1个月为间隔在保修期限内生成若干条巡检记录。
 */
public class Cbl_Warrantyproduct_insertRequest {
     //新建设备记录时
      public void insertRequest(list<Warrantyproduct__c> list_war)
      {
      	   list<Warrantyproduct__c> list_req=new list<Warrantyproduct__c>();
      	   for(Warrantyproduct__c war:list_war)
      	   {
      	       if(war.WhetherCreatePolling__c == true && war.warrantytype__c == '全保')
      	       {
      	           list_req.add(war);
      	       }
      	   }
      	   if(list_req.size()>0)
      	   {
      	      RecordType retp=[Select r.Id From RecordType r where Name='巡检'];
      	      for(Warrantyproduct__c war:list_req)
      	      {
      	           Date startdate=war.Warrantystartdate__c;
               	   Date enddate=war.Warrantyenddate__c;
               	   Integer days=startdate.daysBetween(enddate);
               	   Integer months=days/30;
               	   list<servicerequest__c> list_ser=new list<servicerequest__c>();
	           	   if(months>0)
	           	   {
	               	   if(war.CoustomerStage__c == '公司VIP')
	                   {
	                        for(Integer i=0;i<=months;i++)
	                        {
	                            servicerequest__c serv=new servicerequest__c();
	                            serv.RecordTypeId=retp.Id;
	                            serv.Name=war.CustomerName__c+'巡检-'+String.valueOf(startdate.addDays(30*i));
	                            serv.requesttime__c=startdate.addDays(30*i);
	                            serv.customer__c=war.CoustomerID__c;
	                            serv.Equipment__c=war.Equipment__c;
	                            serv.state__c='服务中';
	                            serv.secondperson__c=war.OwnManage__c;
	                            serv.approvestate__c='草稿';
	                            list_ser.add(serv);
	                        }
	                   }
	                   else
	                   {
	                         for(Integer i=0;i*3<=months;i++)
	                        {
	                            servicerequest__c serv=new servicerequest__c();
	                            serv.RecordTypeId=retp.Id;
	                            serv.Name=war.CustomerName__c+'巡检-'+String.valueOf(startdate.addDays(30*i*3));
	                            serv.requesttime__c=startdate.addDays(30*i*3);
	                            serv.customer__c=war.CoustomerID__c;
	                            serv.Equipment__c=war.Equipment__c;
	                            serv.state__c='服务中';
	                            serv.secondperson__c=war.OwnManage__c;
	                            serv.approvestate__c='草稿';
	                            list_ser.add(serv);
	                        }
	                   }
	                   insert list_ser;
	           	   }
      	      }
      	   }
      }
      //更新设备记录时
      public void updateRequest(list<Warrantyproduct__c> list_war,map<Id,Warrantyproduct__c> map_war)
      {
      	  list<Warrantyproduct__c> list_req=new list<Warrantyproduct__c>();
          for(Warrantyproduct__c war:list_war)
      	  {
      	       if(map_war.get(war.Id).WhetherCreatePolling__c == false && war.WhetherCreatePolling__c == true )
	           {
	               list_req.add(war);
	           }
      	  }
      	  if(list_req.size()>0)
      	  {
      	       insertRequest(list_req);
      	  }
      }
      //更新设备记录时阻止选定已经生成巡检的记录在次生成
      public void stopRequest(list<Warrantyproduct__c> list_war,map<Id,Warrantyproduct__c> map_war)
      {
      	  for(Warrantyproduct__c war:list_war)
      	  {
      	       if(map_war.get(war.Id).WhetherCreatePolling__c == true && war.WhetherCreatePolling__c == false )
	           {
	               war.addError('生成巡检复选框一经选定不可修改');
	           }
      	  }
          
      }
}