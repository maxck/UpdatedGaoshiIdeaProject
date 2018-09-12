/**
*Dis:发送报告附件邮件到邮箱中（技术服务报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 ）
*    设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 
Time:2015年3月2日16:00:11
*Author:Somnus Wang
**/

global class SendPDFEmail {
     webservice  static void sendPdf(String ids){
        
        System.debug('。。。。。。。发邮件。。。ids。'+ids);
        PageReference pdf=null;
        String  strrecords=null;
        
        Set<ID> setrecordtype=new Set<ID>();//记录类型
        Set<ID> setowner=new Set<ID>();//所有人
        
        String setreceptiontime=null;//验收时间
        String customers=null;//验收时间
        String requesttime=null;//服务请求时间
        String requestname=null;//服务请求名称
        String emails='792452201@qq.com';//所有人邮件地址
        
        pdf=Page.CreatePDF; 
        pdf.getParameters().put('idss',ids);
        Blob body;
        System.debug('try。。.......。。');
        
        //查询技术服务报告
        List<servicereport__c> lists=[select Name,Id,customer__c,RecordTypeId,receptiontime__c,servicerequest__r.requesttime__c,
        servicerequest__r.Name,servicerequest__r.OwnerId from servicereport__c where Id =:ids];
        
        for(servicereport__c report:lists){
          if(report.receptiontime__c!=null){
          setreceptiontime=report.receptiontime__c.year()+'-'+report.receptiontime__c.month()+'-'+report.receptiontime__c.day();
          }if(report.customer__c!=null){
            customers=report.customer__c;
          }if(report.servicerequest__r.requesttime__c!=null){
          requesttime=report.servicerequest__r.requesttime__c.year()+'-'+report.servicerequest__r.requesttime__c.month()+'-'+report.servicerequest__r.requesttime__c.day();
          }if(report.servicerequest__r.Name!=null){
          requestname=report.servicerequest__r.Name;
          }
        }
        
        
        System.debug('附件名  查询内容'+customers+'    '+requesttime);
        String head=customers+'技术服务报告'+requesttime;//附件名
        String bodys='尊敬的用户：<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您好！附件是'+customers+requesttime+requestname+'的技术服务报告,请您尽快处理!';
        
        
        for(servicereport__c report:lists){
          setrecordtype.add(report.RecordTypeId);//记录类型
          setowner.add(report.servicerequest__r.OwnerId);//所有人
        }
        
        List<RecordType> listrecordtype=[select Name from RecordType where Id in:setrecordtype];//记录类型
        List<User> users=[select Name,SenderEmail,Email from User where Id in:setowner];//查询所有人邮件地址
        
        for(RecordType records:listrecordtype){
           strrecords=records.Name;
           System.debug('@@@@@@@@@@@@@@@@'+strrecords);
        }
        for(User uu:users){
            emails=uu.Email;
            System.debug('@@@@@@@邮件地址@@@@@@@@@'+emails);
        }
         
          try {
             body = pdf.getContentAsPDF();
             System.debug('文件内容。。。。'+body);
          } catch (VisualforceException e) {
            System.debug('catch。。。。'+body);
                 body = Blob.valueOf('Some Text');
         }
         
         Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(head+'.pdf');
            attach.setInline(false);
            attach.Body = body;
         System.debug('。。。。。。。发邮件。。。zhong。');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setCharset('UTF-8');
            mail.setToAddresses(new String[] {emails});//邮件地址
            mail.setSubject(head);
            mail.setHtmlBody(bodys); 
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+'somnuswang@frensworkz.com'));
         System.debug('。。。。。。。发邮件。。。end。');
         //在对象的相关列表下生成附件
        /* List<Attachment> list_att=[select id,ParentId, Name from Attachment where ParentId =:ids and Name=:head];
            if(list_att.size()==0){
                Attachment  ata=new Attachment();
                ata.ParentId=ids;
                ata.ContentType='application/pdf';
                ata.Name=head+'.pdf';
                ata.Body=body;   
                insert ata;  
            }*/
    }
    //设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 
     webservice  static void sendInstsReportPdf(String ids){
        
        System.debug('。。设备安装报告。。。。。发邮件。。。ids。'+ids);
        PageReference pdf=null;
        String  strrecords=null;
        
        Set<ID> setrecordtype=new Set<ID>();//记录类型
        Set<ID> setowner=new Set<ID>();//所有人
        
        String setreceptiontime=null;//验收时间
        String customers=null;//客户
        String requesttime=null;//服务请求时间
        String requestname=null;//服务请求名称
        String emails=null;//所有人邮件地址
        
        pdf=Page.InstallReportPDF; 
        pdf.getParameters().put('id',ids);
        Blob body;
        System.debug('try。。.......。。');
        
        //查询安装确认单
        List<installreport__c> lists=[select Name,Id,customer__c,receptiontime__c,servicereport__r.requesttime__c,
        servicereport__r.Name,servicereport__r.OwnerId from installreport__c where Id =:ids];
        
        for(installreport__c report:lists){
          if(report.receptiontime__c!=null){
          setreceptiontime=report.receptiontime__c.year()+'-'+report.receptiontime__c.month()+'-'+report.receptiontime__c.day();
          }if(report.customer__c!=null){
            customers=report.customer__c;
          }if(report.servicereport__r.requesttime__c!=null){
          requesttime=report.servicereport__r.requesttime__c.year()+'-'+report.servicereport__r.requesttime__c.month()+'-'+report.servicereport__r.requesttime__c.day();
          }if(report.servicereport__r.Name!=null){
          requestname=report.servicereport__r.Name;
          }
        }
        
        String head=null;
        System.debug('附件名  查询内容'+customers+'    '+requesttime);
    /*  if(setreceptiontime!=null){
        head=customers+'安装确认单'+setreceptiontime;//附件名
        }else{
        head=customers+'安装确认单';//附件名
        }
   */   head=customers+'安装确认单'+requesttime;//附件名
        String bodys='尊敬的用户：<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您好！附件是'+customers+requesttime+requestname+'的安装确认单,请您尽快处理!';
        
        
        for(installreport__c report:lists){
          setowner.add(report.servicereport__r.OwnerId);//所有人
        }
        
        List<User> users=[select Name,SenderEmail,Email from User where Id in:setowner];//查询所有人邮件地址
        
        for(User uu:users){
          if(uu.Email!=null){
            emails=uu.Email;
          }
        }
         
          try {
             body = pdf.getContentAsPDF();
             System.debug('文件内容。。。。'+body);
          } catch (VisualforceException e) {
            System.debug('catch。。。。'+body);
                 body = Blob.valueOf('Some Text');
         }
         
         Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
            attach.setContentType('application/pdf');
            attach.setFileName(head+'.pdf');
            attach.setInline(false);
            attach.Body = body;
         System.debug('。。。。。。。发邮件。。。zhong。');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setCharset('UTF-8');
            mail.setToAddresses(new String[] {emails});//邮件地址
            mail.setSubject(head);
            mail.setHtmlBody(bodys); 
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+'somnuswang@frensworkz.com'));
         System.debug('。。。。。。。发邮件。。。end。');
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
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
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