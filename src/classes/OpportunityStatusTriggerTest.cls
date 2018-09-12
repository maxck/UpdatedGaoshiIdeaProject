@isTest
public class OpportunityStatusTriggerTest {
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
	 opp.StageName = '成交阶段';
	 opp.Amount = 0.0;
	 opp.Probability = 10.0;
	 opp.CloseDate = Date.newInstance(2018,08,13);
	 opp.CurrencyIsoCode = 'CNY';
	 opp.ProcurementMethod__c = '院内采购';
	 opp.BusinessSource__c = '专家推荐';
	 //opp.BusinessType__c = false;
	 opp.FinalCustomer__c = acc.id;
	 opp.BusinessOpportunityApprovalStatus__c = '已审批';
	 opp.jdxspzt__c = '草稿';
     opp.SalesOpportunityStatus__c ='中断';
	 opp.TimeInstallation__c = Date.newInstance(2018,08,13);
     insert opp;
        
     CustomObject18__c  cu = new CustomObject18__c();
     cu.Field1__c = opp.Id;
     cu.Amount__c = 1 ;
     cu.UnitCost__c = 1 ;
     cu.State__c ='赢单';
     insert cu;
     
     opp.SalesOpportunityStatus__c ='赢单';
     update  opp ;
    }
    @istest(SeeAlldata=true)
    static void test2 () {
        
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
     opp.SalesOpportunityStatus__c ='丢单';
     opp.ThrowReason__c = '价格';
	 opp.TimeInstallation__c = Date.newInstance(2018,08,13);
     insert opp;
        
     CustomObject18__c  cu = new CustomObject18__c();
     cu.Field1__c = opp.Id;
     cu.Amount__c = 1 ;
     cu.UnitCost__c = 1 ;
     cu.State__c ='赢单';
     insert cu;
    }
}