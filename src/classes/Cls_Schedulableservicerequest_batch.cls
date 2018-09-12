/**
*Create By:jmark
*TIME：2015年3月3日15:15:11
*Descripe: 巡检服务请求，在请求时间头10天发送邮件给所有人和第二责任人
 */
global class Cls_Schedulableservicerequest_batch implements Database.Batchable<SObject>{
      global Database.queryLocator start(Database.BatchableContext ctx)
     {
     	   system.debug('--------------------start');//查询出所有满足条件的设备记录
     	   Date reqdate=Date.today().addDays(10) ;
           return Database.getQueryLocator([select Name,requesttime__c,SecondEmail__c,OwnEmail__c from servicerequest__c where RecordTypeId='012N00000004chGIAQ' and requesttime__c =: reqdate]); 
     }
     global void execute(Database.BatchableContext ctx, list<servicerequest__c> list_ser)
     {
     	   if(list_ser != null && list_ser.size()>0)
     	   {
     	   	   for(servicerequest__c ser:list_ser)
     	   	   {
     	   	       Set<String> str_email=new Set<String>();//处理需要发送邮件的邮箱
	     	       if(ser.SecondEmail__c != null)
		 	       {
		 	             if(!str_email.contains(ser.SecondEmail__c))
		 	             {
		 	                 str_email.add(ser.SecondEmail__c);
		 	             }
		 	       }
		 	       if(ser.OwnEmail__c != null)
		 	       {
		 	             if(!str_email.contains(ser.OwnEmail__c))
		 	             {
		 	                 str_email.add(ser.OwnEmail__c);
		 	             }
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
		         	    email.setSubject(ser.Name+'巡检提醒'); 
		         	    String str='尊敬的用户：<br/><br/>&nbsp;&nbsp;您好！现在'+ser.Name+'巡检即将在'+String.valueOf(ser.requesttime__c)
		         	    +'到达申请时间，请您尽快处理。<br/>巡检服务请求链接地址：https://ap1.salesforce.com/'+ser.Id;
		         	    email.setHtmlBody(str); 
		         	    Messaging.Sendemailresult[] r1=Messaging.sendEmail(new Messaging.Singleemailmessage[]{email}); 
	         	   }
     	   	   }
     	   }	      
     }
     global void finish(Database.BatchableContext ctx)
     {
                
     }
}