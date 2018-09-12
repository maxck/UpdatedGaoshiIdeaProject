/**
*Dis:技术服务报告报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  
     trigger中不能使用Blob b = ref.getContentAsPDF(); 
*Time:2015年3月13日11:51:11
*Author:Somnus Wang
**/
public  class Cbl_CreateServiceReportPDF {
      @future(callout=true)  
   public static void createVF(String id,String userSessionId){  
       String addr='https://cs6.salesforce.com/services/apexrest/sendServiceEmail'; 
       
        HttpRequest req = new HttpRequest();  
        
        req.setEndpoint( addr );  
        req.setMethod('POST');  
        req.setHeader('Authorization', 'OAuth ' + userSessionId);  
        req.setHeader('Content-Type','application/json');  
        
        Map<String,String> postBody = new Map<String,String>(); 
        postBody.put('id',id);//把id值传给发送邮件的方法  
        String reqBody = JSON.serialize(postBody);  
  
        req.setBody(reqBody);  
        Http http = new Http();  
        HttpResponse response = http.send(req);  
        System.debug('生成Pdf.。。。。。。结束。。。。。。。。。');
    }  
}