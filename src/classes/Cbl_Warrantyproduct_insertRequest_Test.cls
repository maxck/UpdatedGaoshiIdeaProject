/**
*Create By:jmark
*TIME：2015年3月4日13:42:08
*Descripe:在保修期内，合约产品，全保设备，客户不是VIP时，
 *当设备手动选择生成巡检复选框时，按3个月为间隔在保修期限内生成若干条巡检记录。
 *如果是Vip客户的设备，当设备手动选择生成巡检复选框时，按1个月为间隔在保修期限内生成若干条巡检记录。
 */
@isTest
private class Cbl_Warrantyproduct_insertRequest_Test {

    static testMethod void myUnitTest() {
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
        list<RecordType> listrtp=[Select r.Name, r.Id From RecordType r where Name='新机安装']; 
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
		Account acc1=new Account();
		acc1.Name='cesi医院';
		acc1.firstclassify__c='国有医院';
		acc1.area__c='北区';
		acc1.secondperson__c=u.Id;
		acc1.clientlevel__c='普通客户';
		insert acc1;
		Equipment__c equ=new Equipment__c();
		equ.Name='cesixulihao';
		equ.warrantytype__c='设备合同-保修';
		equ.customer__c=acc.Id;
		equ.ismain__c=true;
		equ.warrantySatart__c=Date.today();
		equ.warrantyEnd__c=Date.today().addMonths(5);
		insert equ;
		Equipment__c equ1=new Equipment__c();
		equ1.Name='cesixulihao';
		equ1.warrantytype__c='设备合同-保修';
		equ1.customer__c=acc1.Id;
		equ1.ismain__c=true;
		equ1.warrantySatart__c=Date.today();
		equ1.warrantyEnd__c=Date.today().addMonths(5);
		insert equ1;
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
		war.WhetherCreatePolling__c=true;
		update war;
		Warrantyproduct__c war1=new Warrantyproduct__c();
		war1.Equipment__c=equ1.Id;
		war1.Warranty__c=wty.Id;
		war1.Warrantyenddate__c=Date.today().addMonths(5);
		war1.Warrantystartdate__c=Date.today();
		war1.WhetherCreatePolling__c=true;
		insert war1;
		delete war1;
    }
}