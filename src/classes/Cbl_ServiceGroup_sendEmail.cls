/**
*Create By:jmark
*TIME：2015年4月9日10:03:47
*Description:针对服务请求，在添加技术服务小组内的成员后，系统自动发邮件提醒该成员及技术部副经理
 */
public class Cbl_ServiceGroup_sendEmail {
	//新建时发邮件
     public void insertSendEmail(list<servicegroup__c> list_group)
     {
         	 Set<String> str_email=new Set<String>();//处理需要发送邮件的邮箱
         	 UserRole ur=[Select Name,Id From UserRole where Name='021-技术服务部经理'];
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
             for(servicegroup__c req:list_group)
	         {
	         	system.debug('----------------------req.Email__c'+req.Email__c);
	         	system.debug('----------------------req.AccountName__c'+req.AccountName__c);
	         	system.debug('----------------------req.UserName__c'+req.UserName__c);
	         	if(req.Email__c != null && !str_email.contains(req.Email__c))
	         	{
	         	   str_email.add(req.Email__c);//增加设备所有人的邮件
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
	         	    email.setSubject('服务小组建立--'+req.serName__c); 
	         	    String str=' 您好!'+req.AccountName__c+req.serName__c+'已建立服务小组，'+req.UserName__c+'已加入服务小组。<br/>设备注册码链接地址：https://ap4.salesforce.com/'+req.servicerequest__c;
	         	    system.debug('--------------------str'+str);
	         	    email.setHtmlBody(str); 
	         	    Messaging.Sendemailresult[] r1=Messaging.sendEmail(new Messaging.Singleemailmessage[]{email}); 
	         	}	
	         } 
     }
}