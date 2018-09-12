/**
*Dis:创建服务小组的时候将关联的服务请求权限给服务小组用户的测试类
*Auther:Victor Li
*Time:2015年3月2日13:53:54
**/ 
@isTest(SeeAllData=true)
private class Cbl_ServiceGroup_Share_Test {

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
		
		User u1=new User(); 
		u1.FirstName='李q'; 
		u1.LastName='四q'; 
		u1.Alias='李四q'; 
		u1.Username='liss@frensworkz.com'; 
		u1.Email='lisi@frensworkz.com'; 
		u1.CommunityNickname='lisis'; 
		u1.UserRoleId=ur.Id; 
		u1.ProfileId=profile.Id; 
		u1.TimeZoneSidKey='Asia/Shanghai'; 
		u1.LocaleSidKey='en_AU'; 
		u1.EmailEncodingKey='UTF-8'; 
		u1.LanguageLocaleKey='en_US'; 
		insert u1;
		 
		Account acc=new Account();
		acc.Name='momo医院';
		acc.firstclassify__c='国有医院';
		acc.area__c='北区';
		acc.secondperson__c=u.Id;
		acc.clientlevel__c='公司VIP';
		insert acc;
       
        Contact con = new Contact();
        con.LastName = 'xxx';
        con.AccountId = acc.Id;
        insert con;  
                            
        Equipment__c equ=new Equipment__c();
		equ.Name='cesixulihao';
		equ.warrantytype__c='全保';
		equ.customer__c=acc.Id;
		equ.ismain__c=true;
		equ.warrantySatart__c=Date.today();
		equ.warrantyEnd__c=Date.today().addMonths(5);
		insert equ;
     
        servicerequest__c sq = new servicerequest__c();
        sq.Name = 'xxx';
        sq.requesttime__c = Date.today();
        sq.state__c = '未开始';
        sq.person__c = con.Id;
        sq.secondperson__c = u.Id;
        sq.Equipment__c = equ.Id;
        sq.customer__c = acc.Id;
        sq.RecordTypeId = listrtp[0].Id;
        insert sq;
        
        servicegroup__c sg = new servicegroup__c();
        sg.servicerequest__c = sq.Id;
        sg.user__c = u.Id;
        insert sg;
        
        sg.user__c = u1.Id;
        update sg;
    }
}