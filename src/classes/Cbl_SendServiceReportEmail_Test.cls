/**
*Dis:技术服务报告报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  测试类
     trigger中不能使用Blob b = ref.getContentAsPDF(); 
*Time:2015年3月13日12:35:03
*Author:Somnus Wang
**/
@isTest
private class Cbl_SendServiceReportEmail_Test { 

      static testMethod void testFutureCallSuccess(){
          
          
         Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
        list<RecordType> listrtp=[Select r.Name, r.Id,r.developername From RecordType r where r.developername='htaz']; 
        UserRole ur=new UserRole(); 
        ur.Name='01-总经理'; 
        insert ur; 
        User u=new User(); 
        u.FirstName='李'; 
        u.LastName='四'; 
        u.Alias='李四'; 
        u.Username='lisi@frensworkz.com'; 
        u.Email='lisi@frensworkz.com'; 
        u.CommunityNickname='lisi'; 
        u.UserRoleId=ur.Id; 
        u.ProfileId=profile.Id; 
        u.TimeZoneSidKey='Asia/Shanghai'; 
        u.LocaleSidKey='en_AU'; 
        u.EmailEncodingKey='UTF-8'; 
        u.LanguageLocaleKey='en_US'; 
        insert u; 
          
          System.runAs(u){
              Account acc=new Account();
        acc.Name='momo医院';
        acc.firstclassify__c='国有医院';
        acc.area__c='北区';
        acc.secondperson__c=u.Id;
        acc.clientlevel__c='公司VIP';
        insert acc;
        Equipment__c equ=new Equipment__c();
        equ.Name='cesixulihao';
        equ.warrantytype__c='全保';
        equ.customer__c=acc.Id;
        equ.ismain__c=true;
        insert equ;
        Contact c=new Contact();
        c.LastName='cesi';
        c.AccountId=acc.Id;
        insert c;
        servicerequest__c ser=new servicerequest__c();
        ser.Name='第一次安装';
        ser.RecordTypeId=listrtp[0].Id;
        ser.requesttime__c=Date.today();
        ser.customer__c=acc.Id;
        ser.person__c=c.Id;
        ser.Equipment__c=equ.Id;
        ser.secondperson__c=u.Id;
        ser.OwnerId=u.Id;
        insert ser;
        //备件申请
        sparepart__c sp = new sparepart__c();
        sp.spstate__c='审批中';
        sp.situation__c='保修期';
        sp.requesttime__c=Datetime.now();
        sp.servicerequest__c=ser.Id;
        sp.state__c='维修测试';
        insert sp;
        //故障
        faultcategory__c fg=new faultcategory__c();
        fg.Name='testgz';
        insert fg;
        //服务技术报告
        servicereport__c serp=new servicereport__c();
        serp.servicerequest__c=ser.Id;
        serp.servicetype__c='维修';
        serp.person__c=c.Id;
        serp.state__c='未开始';
        serp.hfmjend__c=6;
        serp.hfnmend__c=5;
        serp.hvvend__c=4;
        serp.lfmjend__c=5;
        serp.lfnmend__c=5;
        serp.firstpressureend__c=6;
        serp.otherpressureend__c=5;
        serp.lasernumend__c=6;
        serp.nlvsmjend__c=8;
        serp.solution__c='dsfhksjdhfksd';
        serp.receptiontime__c=Date.today();
        serp.reportdate__c=Date.today();
        serp.dotime__c=Date.today();
        serp.completetime__c=Date.today();
        serp.endtime__c=Date.today();  
        serp.hometime__c=Date.today();
        serp.leavetime__c=Date.today();
        serp.starttime__c=Date.today();
        serp.bugtype__c=fg.Id;
        serp.information__c='sdsfsdf';
        serp.sparepart__c= sp.Id;
        insert serp;
        serp.hvvend__c=9;
        update serp;
        Cbl_SendServiceReportEmail cssre=new Cbl_SendServiceReportEmail();
        cssre.test();
        //Cbl_SendServiceReportEmail.sendEmail(serp.Id);
          }
          
        
      }     
      static testmethod void testMe() {
        Test.setMock(HttpCalloutMock.class, new Stubby());
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://cs6.salesforce.com/services/apexrest/sendServiceEmail');
        req.setMethod('POST');
        Http h = new Http();
        Cbl_CreateServiceReportPDF.createVF('12345678911111111a',UserInfo.getSessionId());
         }
    }