/**
*Create By:Jmark
*TIME：2016年9月14日10:22:38
*Descripe:设备保修到期后自动生成对应的新的业务机会，提前一年通知，并增加提醒功能
 */
@isTest
private class SchedulableEquipmentChance_Test {

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
		equ.warrantySatart__c=Date.today();
		equ.warrantyEnd__c=Date.today().addMonths(3);
		equ.OwnerId = u.Id;
		insert equ;
		Warranty__c wty=new Warranty__c();
		wty.Name='测试保修合约';
		wty.warrantytype__c='全保';
		wty.serviceperiod__c='3年';
		wty.customer__c=acc.Id;
		wty.area__c='北区';
		insert wty;
		Warrantyproduct__c war=new Warrantyproduct__c();
		war.Equipment__c=equ.Id;
		war.Warranty__c=wty.Id;
		war.Warrantyenddate__c=Date.today().addDays(365);
		war.Warrantystartdate__c=Date.today();
		insert war;
		SchedulableEquipmentChance srtc=new SchedulableEquipmentChance();
		string ch1='0 30 9 * * ?';
        System.schedule('自动计算设备机龄测试',ch1,srtc);
        Test.stopTest();
    }
}