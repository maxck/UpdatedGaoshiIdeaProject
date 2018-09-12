/**
*Create By:jmark
*TIME：2015年3月5日09:16:14
*Descripe: 注册码在到期前两周自动发邮件提醒第一责任人、第二责任人、高级助理
 */
@isTest
private class Cls_SchedulableRegistrationcBatch_Test {

    static testMethod void myUnitTest() {
    	Test.StartTest();
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
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
		insert equ;
		registrationcode__c reg=new registrationcode__c();
		reg.Name='zucema';
		reg.equipment__c=equ.Id;
		reg.type__c='ORK';
		reg.codenum__c=1000;
		reg.registrationcodedate__c=Date.today().addDays(14);
		insert reg;
		SchedulableRegistrationcode srtc=new SchedulableRegistrationcode();
		string ch1='0 30 9 * * ?';
        System.schedule('自动计算设备机龄测试',ch1,srtc);
        Test.stopTest();
    }
}