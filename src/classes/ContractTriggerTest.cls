@isTest
private class ContractTriggerTest {
   @istest
    static void testContractTrigger()
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
        
        Opportunity  Opp = new Opportunity();
       Opp.Name = '1';
       Opp.AccountId = acc.Id ; 
       Opp.FinalCustomer__c = acc.Id;
       Opp.StageName = '潜在阶段';
       Opp.ProcurementMethod__c = '院内采购';
       Opp.BusinessSource__c = '专家推荐';
       Opp.CloseDate = date.today();
       insert  Opp; 
       
       Contract con  = new Contract();
       con.WarrantyPeriod__c = 1 ; 
       con.AccountId =  acc.id;
       con.Opportunity__c = Opp.Id ; 
       con.ContractCharacter__c = '内贸';
       insert con ;
    }
}