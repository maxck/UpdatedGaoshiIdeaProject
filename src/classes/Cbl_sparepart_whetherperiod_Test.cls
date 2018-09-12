/**
*Create By:jmark
*TIME：2015年3月4日17:21:09
*Descripe:新建备件申请时，判断是否在保修期内
 */
@isTest
private class Cbl_sparepart_whetherperiod_Test {

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
		equ.installationdate__c=Date.newInstance(2014, 4, 5);
		equ.warrantySatart__c=Date.newInstance(2014, 4, 5);
		equ.warrantyEnd__c=Date.newInstance(2015, 1, 5);
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
		insert ser;
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
		war.Warrantyenddate__c=Date.today().addMonths(5);
		war.Warrantystartdate__c=Date.today();
		insert war;
		sparepart__c spa=new sparepart__c();
		spa.situation__c='保修期';
        spa.requesttime__c=Datetime.now();
		spa.servicerequest__c=ser.Id;
        spa.state__c='维修测试';
		insert spa;
        }
		
    }
}