@isTest
public class ProductLineTest {
	@istest(SeeAlldata=true)
    static void test () {
        
     Account acc  =  new Account() ; 
     acc.Name = 'kehu';
     acc.city__c = '福州市';
     acc.province__c = '福建省';
     acc.Cunty__c = '1' ;
     acc.LegalRepresentative__c = '1';
     acc.Duty__c = '1' ;
     acc.ContactNumber__c = '123'; 
     acc.Gender__c = '男';
     insert acc ;
     
     Opportunity opp = new Opportunity();
	 opp.Name = '11222';
	 opp.StageName = '潜在阶段';
	 opp.Amount = 0.0;
	 opp.Probability = 10.0;
	 opp.CloseDate = Date.newInstance(2018,08,13);
	 opp.CurrencyIsoCode = 'CNY';
	 opp.ProcurementMethod__c = '院内采购';
	 opp.BusinessSource__c = '专家推荐';
	 opp.BusinessType__c = false;
	 opp.FinalCustomer__c = acc.id;
	 opp.BusinessOpportunityApprovalStatus__c = '草稿';
	 opp.jdxspzt__c = '草稿';
	 opp.TimeInstallation__c = Date.newInstance(2018,08,13);
     insert opp;
     
     ConfigurationList__c con1 = new ConfigurationList__c();
	 //con1.Name = '海德堡HRA';
     con1.RecordTypeId='0126F000001UVaSQAW';
	 con1.CurrencyIsoCode = 'CNY';
	 con1.cpx__c = '海德堡';
	 con1.xh__c = 'HRA';
     insert con1;
        
     ConfigurationList__c con = new ConfigurationList__c();
	 //con.Name = '111 HRA 2018-8-13';
	 con.ConfigName__c ='111 HRA 2018-8-13';
	 con.CurrencyIsoCode = 'CNY';
	 con.Opportuniy__c = opp.Id;
	 con.cpx__c = '海德堡';
	 con.xh__c = 'HRA';
     insert con;
     
     
    
    }
    
}