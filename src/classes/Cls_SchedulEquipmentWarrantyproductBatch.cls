/**
*Create By:jmark
*TIME：2015年2月28日09:32:41
*Descripe:设备合同信息中保修到期前3个月，自动生成业务机会。并邮件发给：武总、陈经理、主管、高级助理
 */
global class Cls_SchedulEquipmentWarrantyproductBatch implements Database.Batchable<SObject>{
      global Database.queryLocator start(Database.BatchableContext ctx)
     {
           system.debug('--------------------start');//查询出所有满足条件的设备记录
           return Database.getQueryLocator([select OwnerId,Name,CustomerName__c,Equipmentname__c,warrantyEnd__c,product__c,customer__c from Equipment__c where  warrantyEnd__c > NEXT_MONTH]); 
     }
     global void execute(Database.BatchableContext ctx, list<Equipment__c> list_equ)
     {
           if(list_equ != null && list_equ.size()>0)
           {
               Date now=Date.today();
               list<Equipment__c> list_req=new list<Equipment__c>();
               for(Equipment__c eq:list_equ)
               {
                    if(eq.warrantyEnd__c != null)
                    {
                         Integer months=now.monthsBetween(eq.warrantyEnd__c);
                         system.debug('--------------------months'+months);
                         if(months == 3)
                         {
                             list_req.add(eq);//满足设备合同信息中保修到期前3个月条件加入集合
                         }
                    } 
                    
               }
               set<Id> set_user=new set<Id>();//设备上的所有人ID
               map<Id,Id> map_id=new map<Id,Id>();//用户存放用户对应的主管
               if(list_req.size()>0)
               {
                   for(Equipment__c req:list_req)
                   {
                       set_user.add(req.OwnerId);
                   }
                   list<User> list_user=new list<User>();
                   if(set_user.size()>0)
                   {
                       set<String> set_role=new set<String>();
                       set_role.add('021301-北京工程师');
                       set_role.add('021401-上海工程师');
                       set_role.add('021501-广州高级工程师');
                       set_role.add('021502-广州工程师');
                       list_user=[select Id,RoleName__c,ManagerId from User where Id in:set_user];
                       if(list_user.size()>0)
                       {
                          for(User u:list_user)
                          {
                              if(!map_id.containsKey(u.Id))
                              {
                                  if(set_role.contains(u.RoleName__c))
                                  {
                                      map_id.put(u.Id,u.ManagerId);
                                  }
                                  else
                                  {
                                      map_id.put(u.Id,u.Id);
                                  }
                              }
                          }
                       }
                   }
                   system.debug('--------------------map_id'+map_id);
                   Set<String> str_email=new Set<String>();//处理需要发送邮件的邮箱
                   set<String> str_Name=new set<String>();
                   set<Id> str_urId=new set<Id>();
                   str_Name.add('0211-高级助理');
                   str_Name.add('021-技术部副经理 ');
                   str_Name.add('02-副总经理 ');
                   list<UserRole> list_ur=[Select Name,Id From UserRole where Name in:str_Name];
                   if(list_ur != null && list_ur.size()>0)
                   {
                       for(UserRole u:list_ur)
                       {
                           str_urId.add(u.Id);
                       }
                   }
                   list<User> list_user1=[select Email from user where UserRoleId in:str_urId];
                   if(list_user1 != null && list_user1.size()>0)//添加高级助理的电子邮件
                   {
                         for(User u:list_user1)
                         {
                             if(u.Email != null)
                             {
                                 if(!str_email.contains(u.Email))
                                 {
                                     str_email.add(u.Email);
                                 }
                             }
                         }
                    }
                   RecordType rt=[Select r.Name, r.Id From RecordType r where Name='保修销售' and sobjecttype = 'chance__c'];
                   for(Equipment__c eq:list_req)
                   {
                       chance__c chance=new chance__c();
                       String strname=eq.CustomerName__c+now.year()+'保修合约机会';
                       chance.Name=strname;
                       chance.customer__c=eq.customer__c;
                       chance.RecordTypeId=rt.Id;
                       chance.OwnerId=map_id.get(eq.OwnerId);
                       chance.stage__c='预期';
                       chance.possible__c='10%';
                       chance.expireX1__c=eq.warrantyEnd__c;
                       chance.type__c='3年全保';
                       chance.Field1__c=500000;
                       insert chance;
                       system.debug('---------------------chance.Id'+chance.Id);
                       if(!str_email.contains(chance.OwnEmail__c) && chance.OwnEmail__c != null)
                       {
                             str_email.add(chance.OwnEmail__c);
                       }
                       if(str_email.size()>0)
                       {
                        String[] stremail=new String[str_email.size()];
                        Integer i=0;
                        for(String s:str_email)
                        {
                           stremail[i]=s;
                           i++;
                        }
                        //新建邮件发送
                        system.debug('--------------------str_email'+str_email);
                        Messaging.Singleemailmessage email=new Messaging.Singleemailmessage();
                        email.setToAddresses(stremail);
                        system.debug('---------------------chance.Name'+chance.Name); 
                        email.setSubject(chance.Name); 
                        String str='尊敬的用户：<br/><br/>&nbsp;&nbsp;您好！现在'+eq.CustomerName__c+'的'+eq.Equipmentname__c+eq.Name+'的设备保修合约即将在'+String.valueOf(eq.warrantyEnd__c)
                        +'到期，系统已自动生成新的保修业务机会，请您尽快处理。<br/>设备链接地址：https://ap1.salesforce.com/'+eq.Id+'<br/>业务机会链接地址：https://ap1.salesforce.com/'+chance.Id;
                        email.setHtmlBody(str); 
                        Messaging.Sendemailresult[] r1=Messaging.sendEmail(new Messaging.Singleemailmessage[]{email}); 
                       }
                   }
               }       
           }
     }
     global void finish(Database.BatchableContext ctx)
     {
                
     }
}