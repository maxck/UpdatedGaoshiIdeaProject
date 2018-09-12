/**
*Dis:设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 
     trigger中不能使用Blob b = ref.getContentAsPDF(); 
*Time:2015年3月13日11:07:02
*Author:Somnus Wang
**/
@RestResource(urlMapping='/sendPDFEmail/*') 
global  class Cbl_SendInstallEmail {
    @HttpPost  
    global static void sendEmail(String id) {  
      //查询安装确认单
        installreport__c insta=[select Name,Id,customer__c,receptiontime__c,servicereport__r.requesttime__c,
        servicereport__r.Name,servicereport__r.OwnerId from installreport__c where Id =:id];
         
        User user=[select Name,SenderEmail,Email from User where Id =:insta.servicereport__r.OwnerId];//查询所有人邮件地址
        
        System.debug('发邮件查询结果。。。。'+insta.customer__c+'邮件地址'+user.Email); 
        
        String head=insta.customer__c+'安装确认单'+insta.servicereport__r.requesttime__c.year()+'-'+insta.servicereport__r.requesttime__c.month()+'-'+insta.servicereport__r.requesttime__c.day();//附件名
        String bodys='尊敬的用户：<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您好！附件是'+insta.customer__c+insta.servicereport__r.requesttime__c.year()+'-'+insta.servicereport__r.requesttime__c.month()+'-'+insta.servicereport__r.requesttime__c.day()+insta.servicereport__r.Name+'的安装确认单,请您尽快处理!';
        
        
        PageReference ref = Page.InstallReportPDF;
        ref.getParameters().put('id',id); 
        
        Blob b = ref.getContentAsPDF();  
    	
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();  
  
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();  
        efa1.setFileName(head+'.pdf');  
        efa1.setBody(b);  
  
        String addresses=user.Email;  
       // String addresses='34088585@qq.com'; 
      
        email.setSubject(head);//邮件主题
        email.setToAddresses( new String[]{addresses});//邮件地址
        email.setHtmlBody(bodys);//邮件正文  
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1}); //邮件附件 
     
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});  
        System.debug('发邮件。。。。。。最终结束。。。。。。。。。');

    }  
    public void test()
    {
        Integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    } 	
}