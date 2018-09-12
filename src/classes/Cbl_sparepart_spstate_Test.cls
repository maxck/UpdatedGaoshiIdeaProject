/*
*Creat By : Arvin
*Email: arvinxiang@frensworkz.com
*Time : 2015年03月05日
*Describe : Cbl_sparepart_spstate 的测试类
*/
@isTest
private class Cbl_sparepart_spstate_Test {

	//测试创建备件申请
    static testMethod void Test_insertsparepart() {
    	
        product__c pro = new product__c();
        pro.Name='test';
        insert pro;
        
        kucun__c kc=new kucun__c();
        insert kc;
        
        stock__c st=new stock__c();
        st.name='test001';
        st.state__c='新品库';
        st.warehouse__c='北京';
        st.ProductNumber__c=pro.id;
        st.virtualnum__c=10;
        st.Field2__c=kc.Id;
        insert st;
        
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
        list<RecordType> listrtp=[Select r.Name, r.Id,r.developername From RecordType r where r.developername='htaz']; 
        //UserRole ur=new UserRole(); 
		//ur.Name='01-总经理'; 
		//insert ur; 
		User u=new User(); 
		u.FirstName='李'; 
		u.LastName='四'; 
		u.Alias='李四'; 
		u.Username='lisi@frensworkz.com'; 
		u.Email='lisi@frensworkz.com'; 
		u.CommunityNickname='lisi'; 
		//u.UserRoleId=ur.Id; 
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
        //备件申请
        sparepart__c sp = new sparepart__c();
        sp.spstate__c='审批中';
        sp.situation__c='保修期';
        sp.requesttime__c=Datetime.now();
        sp.servicerequest__c=ser.Id;
        sp.state__c='维修测试';
      //   try
      //  {
        	insert sp;
      //  }
      //  catch(Exception e)
      // 	{
       		
      // 	}
        sparepartdetail__c spd = new sparepartdetail__c();
        spd.sparepart__c=sp.Id;
        spd.partnum__c=st.Id;
        spd.number__c=2;
        spd.sparepart__c=sp.Id;
        insert spd;
        
        delete sp;
    
    }
    //测试更改备件申请
    static testMethod void Test_updatesparepart() {
    	
        product__c pro = new product__c();
        pro.Name='test';
        insert pro;
        
        kucun__c kc=new kucun__c();
        insert kc;
        
        stock__c st=new stock__c();
        st.name='test001';
        st.state__c='新品库';
        st.warehouse__c='北京';
        st.ProductNumber__c=pro.id;
        st.virtualnum__c=10;
        st.Field2__c=kc.Id;
        insert st;
        
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
        list<RecordType> listrtp=[Select r.Name, r.Id,r.developername From RecordType r where r.developername='htaz']; 
        //UserRole ur=new UserRole(); 
		//ur.Name='01-总经理'; 
		//insert ur; 
		User u=new User(); 
		u.FirstName='李'; 
		u.LastName='四'; 
		u.Alias='李四'; 
		u.Username='lisi@frensworkz.com'; 
		u.Email='lisi@frensworkz.com'; 
		u.CommunityNickname='lisi'; 
		//u.UserRoleId=ur.Id; 
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
        //备件申请
        sparepart__c sp = new sparepart__c();
        sp.spstate__c='草稿';
        sp.situation__c='保修期';
        sp.requesttime__c=Datetime.now();
        sp.servicerequest__c=ser.Id;
        sp.state__c='维修测试';
       // try
        //{
        	insert sp;
        //}
       // catch(Exception e)
       //	{
       		
      // 	}
        sparepartdetail__c spd = new sparepartdetail__c();
        spd.sparepart__c=sp.Id;
        //spd.state__c='未发货';
        spd.partnum__c=st.Id;
        spd.number__c=2;
        spd.sparepart__c=sp.Id;
        insert spd;
        sp.spstate__c='审批中';
        update sp;
        
        sp.spstate__c='审批拒绝';
        update sp;
        
        delete sp;
    }
}