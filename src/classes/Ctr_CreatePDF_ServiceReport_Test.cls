/**按钮型
*Dis:技术服务报告报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  测试类
            设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  测试类
*Time:2015年3月13日12:35:03
*Author:Somnus Wang
**/
@isTest
private class Ctr_CreatePDF_ServiceReport_Test {

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
		ins.hfmj__c=1;
		ins.hfnm__c=1;
		ins.hvv__c=1;
		ins.lfmj__c=1;
		ins.lfnm__c=1;
		ins.initialpressure__c=1;
		ins.intracavitypressure__c=1;
		ins.qiangzuidashuchunengliang__c=1;
		ins.traincase__c='设备操作';
		insert ins;	
		/*ins.state__c='已完成';
		update ins;*/
		//故障
        faultcategory__c fg=new faultcategory__c();
        fg.Name='testgz';
        insert fg;
		servicereport__c serp=new servicereport__c();
		serp.servicerequest__c=ser.Id;
		serp.servicetype__c='维修';
		serp.person__c=c.Id;
		serp.state__c='未开始';
		serp.hfmjend__c=6;
		serp.hfnmend__c=5;
		serp.hvvend__c=4;
		serp.lfmjend__c=5;
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
            
        //SendPDFEmail.sendPdf(serp.Id);
 		PageReference pageRef = Page.CreatePDF;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('idss',serp.Id);
        ApexPages.currentPage().getParameters().get('idss');
        
		Ctr_CreatePDF_ServiceReport ctr=new Ctr_CreatePDF_ServiceReport();
		Ctr_CreatePDF_ServiceReport.Wrapper wrap=new Ctr_CreatePDF_ServiceReport.Wrapper();
		Ctr_CreatePDF_ServiceReport.InnerClass inners=new Ctr_CreatePDF_ServiceReport.InnerClass();
   
        //安装确认单
        //SendPDFEmail.sendInstsReportPdf(ins.Id);
 		PageReference pages = Page.InstallReportPDF;
        Test.setCurrentPage(pages);
        ApexPages.currentPage().getParameters().put('id',ins.Id);
        ApexPages.currentPage().getParameters().get('id');
        
        Ctr_CreatePDF_InstallReport inctr=new Ctr_CreatePDF_InstallReport();
        Ctr_CreatePDF_InstallReport.Wrapper ww=new Ctr_CreatePDF_InstallReport.Wrapper();
            
		 
        }
		
 		
    }
  }