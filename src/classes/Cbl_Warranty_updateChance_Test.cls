/**
 * Creat By : Jmark
 * Time : 2016年9月14日10:05:15
 * Describe: 【业务机会】中的最终成交价=【保修合约】的保修价格。   
*/
@isTest
private class Cbl_Warranty_updateChance_Test {

    static testMethod void myUnitTest() {
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
		Contact c=new Contact();
        c.LastName='cesi';
        c.AccountId=acc.Id;
        insert c;
		chance__c cha = new chance__c();
        cha.Name = 'testchance';
        cha.customer__c = acc.Id;
        cha.stage__c = '已回款';
        cha.possible__c = '100%';
        cha.X1__c = 'AMARIS 500E/Compact';
        cha.expireX1__c = Date.today().addYears(1);
        cha.type__c = '1年全保';
        cha.Field1__c = 320000;
        insert cha;
        Warranty__c wty=new Warranty__c();
		wty.Name='测试保修合约';
		wty.warrantytype__c='全保';
		wty.serviceperiod__c='3年';
		wty.customer__c=acc.Id;
		wty.area__c='北区';
		wty.chance__c = cha.Id;
		wty.prince__c = 1000;
		insert wty;
		delete wty;
    }
}