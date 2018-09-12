@isTest
private class OpportunityRecordTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testOpportunityRecordTrigger()
    {
      
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
       
       Id orderTypeIdA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
       Opportunity  Opp = new Opportunity();
       Opp.Name = '1';
       //Opp.Account.Id= acc.Id;
       Opp.FinalCustomer__c  =  acc.Id ;
       Opp.SalesOpportunityStatus__c = '丢单';
       Opp.ThrowReason__c = '价格';
       Opp.TimeInstallation__c = date.today();
       Opp.StageName = '立项阶段';
       Opp.ProcurementMethod__c = '院内采购';
       Opp.BusinessSource__c = '专家推荐';
       Opp.CloseDate = date.today();
       Opp.RecordTypeId = orderTypeIdA  ;
       insert  Opp;
       
       update acc ; 
      
    }
    
}