/**
*Create By:jmark
*TIME：2015年3月5日14:26:53
*Descripe: 巡检服务请求，在请求时间头一天发送邮件给所有人和第二责任人
 */
@isTest
private class Cls_Schedulableservicerequest_batch_Test {

    static testMethod void myUnitTest() {
        Test.StartTest();
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员'];
        list<RecordType> listrtp=[Select r.Name, r.Id From RecordType r where Name='巡检']; 
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
		equ.installationdate__c=Date.newInstance(2014, 4, 5);
		equ.warrantySatart__c=Date.today();
		equ.warrantyEnd__c=Date.today().addMonths(3);
		Contact c=new Contact();
		c.LastName='cesi';
		c.AccountId=acc.Id;
		insert c;
		servicerequest__c ser=new servicerequest__c();
		ser.Name='巡检';
		ser.RecordTypeId=listrtp[0].Id;
		ser.requesttime__c=Date.today().addDays(10);
		ser.customer__c=acc.Id;
		ser.person__c=c.Id;
		ser.Equipment__c=equ.Id;
		ser.secondperson__c=u.Id;
		insert ser;
		Schedulableservicerequest srtc=new Schedulableservicerequest();
		string ch1='0 30 9 * * ?';
        System.schedule('自动计算设备机龄测试',ch1,srtc);
        Test.stopTest();
    }
}