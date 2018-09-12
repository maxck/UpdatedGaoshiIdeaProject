/**
*Create By:jmark
*TIME：2015年3月3日10:08:14
*Descripe:在保修期内，设备保修，全保设备，客户不是VIP时，
 *当设备手动选择生成巡检复选框时，按3个月为间隔在保修期限内生成若干条巡检记录。
 *如果是Vip客户的设备，当设备手动选择生成巡检复选框时，按1个月为间隔在保修期限内生成若干条巡检记录。
 */
public class Cbl_Equipment_InsertRequest {
	  //新建设备记录时
      public void insertRequest(list<Equipment__c> list_equ)
      {
      	   list<Equipment__c> list_req=new list<Equipment__c>();
           for(Equipment__c equ:list_equ)
           {
               if(equ.WhetherCreatePolling__c == true && equ.warrantytype__c == '全保')
               {
                   list_req.add(equ);
               }
           }
           if(list_req.size()>0)
           {
           	   RecordType retp=[Select r.Id From RecordType r where Name='巡检'];
               for(Equipment__c equ:list_req)
               {
               	   Date startdate=equ.warrantySatart__c;
               	   Date enddate=equ.warrantyEnd__c;
               	   Integer days=startdate.daysBetween(enddate);
               	   Integer months=days/30;
               	   system.debug('=====================months'+months);
               	   list<servicerequest__c> list_ser=new list<servicerequest__c>();
               	   if(months>0)
               	   {
	               	   if(equ.CustomerGrade__c == '公司VIP')
	                   {
	                        for(Integer i=1;i<=months;i++)
	                        {
	                            servicerequest__c serv=new servicerequest__c();
	                            serv.RecordTypeId=retp.Id;
	                            serv.Name=equ.CustomerName__c+'巡检-'+String.valueOf(startdate.addDays(30*i));
	                            serv.requesttime__c=startdate.addDays(30*i);
	                            serv.customer__c=equ.customer__c;
	                            serv.Equipment__c=equ.Id;
	                            serv.state__c='服务中';
	                            serv.secondperson__c=equ.OwnManage__c;
	                            serv.approvestate__c='草稿';
	                            list_ser.add(serv);
	                        }
	                   }
	                   else
	                   {
	                         for(Integer i=1;i*3<=months;i++)
	                        {
	                            servicerequest__c serv=new servicerequest__c();
	                            serv.RecordTypeId=retp.Id;
	                            serv.Name=equ.CustomerName__c+'巡检-'+String.valueOf(startdate.addDays(30*i*3));
	                            serv.requesttime__c=startdate.addDays(30*i*3);
	                            serv.customer__c=equ.customer__c;
	                            serv.Equipment__c=equ.Id;
	                            serv.state__c='服务中';
	                            serv.secondperson__c=equ.OwnManage__c;
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
      public void updateRequest(list<Equipment__c> list_equ,map<Id,Equipment__c> map_equ)
      {
      	  list<Equipment__c> list_req=new list<Equipment__c>();
          for(Equipment__c equ:list_equ)
      	  {
      	       if(map_equ.get(equ.Id).WhetherCreatePolling__c == false && equ.WhetherCreatePolling__c == true )
	           {
	               list_req.add(equ);
	           }
      	  }
      	  if(list_req.size()>0)
      	  {
      	       insertRequest(list_req);
      	  }
      }
      //更新设备记录时阻止选定已经生成巡检的记录在次生成
      public void stopRequest(list<Equipment__c> list_equ,map<Id,Equipment__c> map_equ)
      {
      	  for(Equipment__c equ:list_equ)
      	  {
      	       if(map_equ.get(equ.Id).WhetherCreatePolling__c == true && equ.WhetherCreatePolling__c == false )
	           {
	               equ.addError('生成巡检复选框一经选定不可修改');
	           }
      	  }
          
      }
}