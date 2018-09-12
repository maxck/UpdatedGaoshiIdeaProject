/**
*Dis:设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  测试类
     trigger中不能使用Blob b = ref.getContentAsPDF(); 
*Time:2015年3月13日11:07:02
*Author:Somnus Wang
**/
@isTest
private class Cbl_SendInstallEmail_Test {

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
        //安装确认单
        installreport__c ins=new installreport__c();
        ins.servicereport__c=ser.Id;
        ins.person__c=c.Id;
        ins.state__c='进行中';
        ins.qiangzuidashuchunengliang__c = 2;
        ins.receptiontime__c=Date.today();
        ins.arrivaldate__c=Date.today();
        ins.completedate__c=Date.today();
        ins.endtime__c=Date.today();  
        ins.hometime__c=Date.today();
        ins.leavetime__c=Date.today();
        ins.starttime__c=Date.today();
        insert ins; 
        ins.receptiontime__c=Date.today().addDays(1);
        update ins;
        SendPDFEmail spdf=new SendPDFEmail();
        spdf.test();
        Cbl_SendInstallEmail csie=new Cbl_SendInstallEmail();
        csie.test();
       // Cbl_SendInstallEmail.sendEmail(ins.Id);
     }
        static testmethod void testMe() {
        Test.setMock(HttpCalloutMock.class, new Stubby());
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://cs6.salesforce.com/services/apexrest/sendPDFEmail');
        req.setMethod('POST');
        Http h = new Http();
        Cbl_CreateInstallPDF.createVF('12345678911111111a',UserInfo.getSessionId());
         }
}