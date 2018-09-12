/**
*Create By:jmark
*TIME：2016年8月26日10:09:52
*Descripe:1、在设备对象中有字段设备保修终止日期，在此日期一年前自动生成新的业务机会，并邮件提醒。
          2、邮件提醒业务机会所有人，业务机会所有人=原设备所有人。
          3、设备对象下的相关列表有合约产品这一项，合约产品中有个字段叫保修结束日期。
                          现在的触发条件是：设备下如果关联有合约产品，以最新的合约产品的保修结束日期提前一年生成对应业务机会并邮件提醒；
                          如果没有，以设备对象的设备保修终止日期提前一年生成业务机会并邮件提醒。
 */
global class Batch_Equipment_NewChance implements Database.Batchable<SObject>{
      global Database.queryLocator start(Database.BatchableContext ctx)
     {
           system.debug('--------------------start');//查询出所有满足条件的设备记录
           return Database.getQueryLocator([select OwnerId,Owner.Email,Name,CustomerName__c,Equipmentname__c,warrantyEnd__c,product__c,product__r.Name,customer__c from Equipment__c]); 
     }
     global void execute(Database.BatchableContext ctx, list<Equipment__c> list_equ)
     {
           list<Warrantyproduct__c> list_war = [select Warrantyenddate__c,Equipment__c from Warrantyproduct__c where  Equipment__c in: list_equ and Warrantyenddate__c != null order by Warrantyenddate__c desc];
           map<Id,Warrantyproduct__c> map_war = new map<Id,Warrantyproduct__c>();
           system.debug('list_warlist_warlist_war'+list_war);
           if(list_war.size() > 0)
           {
               for(Warrantyproduct__c war:list_war)
               {
                   if(!map_war.containsKey(war.Equipment__c))
                   {
                       map_war.put(war.Equipment__c,war);
                   }
               }
           }
           system.debug('map_warmap_warmap_war'+map_war);
           Date now=Date.today();
           RecordType rt=[Select r.Name, r.Id From RecordType r where Name='保修销售'  and sobjecttype = 'chance__c'];
           for(Equipment__c eq:list_equ)
           {
               Date enddate = null;
               if(map_war.containsKey(eq.Id))
               {
                   enddate = map_war.get(eq.Id).Warrantyenddate__c;
                   //eq.newwarrantyEnd__c = map_war.get(eq.Id).Warrantyenddate__c;
               }
               else
               {
                   if(eq.warrantyEnd__c != null)
                   enddate = eq.warrantyEnd__c;
                   //eq.newwarrantyEnd__c = eq.warrantyEnd__c;
               }
               if(enddate != null)
               {
                   Integer days = now.daysBetween(enddate);
                   if(days == 365)//相隔一年，新建业务机会，发送邮件。
                   {
                       chance__c chance=new chance__c(); 
                       String strname=now.addYears(1).year()+'-'+eq.CustomerName__c+'-'+eq.product__r.Name+'-保修合约机会';
                       chance.Name=strname;
                       chance.customer__c=eq.customer__c;
                       chance.RecordTypeId=rt.Id;
                       chance.X1__c = eq.product__r.Name;
                       chance.expireX1__c=enddate;
                       chance.type__c='3年全保';
                       chance.Field1__c=500000;
                       chance.OwnerId=eq.OwnerId;
                       chance.stage__c='未启动';
                       chance.possible__c='30%';
                       insert chance;
                       if(eq.Owner.Email != null)
                       {
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            String[] toAddresses = new String[]{eq.Owner.Email};
                            mail.setToAddresses(toAddresses);
                            mail.setCharset('UTF-8'); 
                            mail.setUseSignature(false);
                            mail.setSubject(chance.Name); 
                            String str='尊敬的用户：<br/><br/>&nbsp;&nbsp;您好！现在'+eq.CustomerName__c+'的'+eq.Equipmentname__c+eq.Name+'的设备保修即将在'+String.valueOf(enddate)
                            +'到期，系统已自动生成新的保修业务机会，请您尽快处理。<br/>设备链接地址'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+eq.Id+'<br/>业务机会链接地址：'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+chance.Id;
                            mail.setHtmlBody(str); 
                            Messaging.Sendemailresult[] r1=Messaging.sendEmail(new Messaging.Singleemailmessage[]{mail}); 
                       }
                   }
               }
           }
          // update list_equ;
     }
     global void finish(Database.BatchableContext ctx)
     {
                
     }
}