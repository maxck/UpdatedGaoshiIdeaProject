/**
*Create By:jmark
*TIME：2015年2月27日13:10:13
*Descripe: 注册码在到期前两周自动发邮件提醒第一责任人、第二责任人、高级助理
 */
global class Cls_SchedulableRegistrationcodeBatch implements Database.Batchable<SObject>{
      global Database.queryLocator start(Database.BatchableContext ctx)
     {
     	   system.debug('--------------------start');//查询出所有注册码记录
           return Database.getQueryLocator([select Name,EquipmentName__c,Customer__c,registrationcodedate__c,equipment__c,codenum__c,EquOwnEmail__c,CusSecondEmail__c from registrationcode__c where registrationcodedate__c > today ]); 
     }
     global void execute(Database.BatchableContext ctx, list<registrationcode__c> list_reg)
     {
     	 system.debug('--------------------execute');
         if(list_reg != null && list_reg.size()>0)
	     {
	     	 Date now=Date.today();//判断是否满足注册码在到期前两周的条件
	     	 list<registrationcode__c> list_request=new list<registrationcode__c>();
	         for(registrationcode__c reg:list_reg)
	         {
	         	if(reg.registrationcodedate__c != null)
	         	{
	         	     Integer day=now.daysBetween(reg.registrationcodedate__c);
	         	     system.debug('--------------------day'+day);
	         	     if(day == 14)
	         	     {
	         	         list_request.add(reg);//满足注册码在到期前两周的条件加入集合
	         	     }
	         	}  
	         }
	         if(list_request.size()>0)
	         {
	         	 Set<String> str_email=new Set<String>();//处理需要发送邮件的邮箱
	         	 UserRole ur=[Select Name,Id From UserRole where Name='0211-高级助理'];
	         	 list<User> list_user=[select Email from user where UserRoleId=:ur.Id];
	         	 if(list_user != null && list_user.size()>0)
	         	 {
	         	     for(User u:list_user)
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
	             for(registrationcode__c req:list_request)
		         {
		         	if(req.EquOwnEmail__c != null && !str_email.contains(req.EquOwnEmail__c))
		         	{
		         	   str_email.add(req.EquOwnEmail__c);//增加设备所有人的邮件
		         	}
		         	if(req.CusSecondEmail__c != null && !str_email.contains(req.CusSecondEmail__c))
		         	{
		         	   str_email.add(req.CusSecondEmail__c);////增加设备第二责任人的邮件
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
		         		system.debug('--------------------stremail'+stremail);
		         	    Messaging.Singleemailmessage email=new Messaging.Singleemailmessage();
		         	    email.setToAddresses(stremail); 
		         	    email.setSubject('设备'+req.EquipmentName__c+'注册码快到期提醒'); 
		         	    String str='尊敬的用户：<br/><br/>&nbsp;&nbsp;您好！现在'+ req.Customer__c+'的'+req.EquipmentName__c+'设备注册码为'+req.Name +'，即将在'+String.valueOf(req.registrationcodedate__c)+'到期，请您尽快处理。设备注册码链接地址：https://ap1.salesforce.com/'+req.Id;
		         	    system.debug('--------------------str'+str);
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