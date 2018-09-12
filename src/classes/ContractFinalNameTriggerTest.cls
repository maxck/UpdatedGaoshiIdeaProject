@isTest
private class ContractFinalNameTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testContractFinalNameTrigger ()
    {
    Account acc = new Account();
    acc.Name = 'll';
    insert acc ;
    
    Opportunity  opp = new Opportunity();
    opp.Name = 'pp';
    Opp.Name = '1';
    Opp.AccountId = acc.Id;
    Opp.FinalCustomer__c = acc.Id;
    Opp.StageName = '潜在阶段';
    Opp.ProcurementMethod__c = '院内采购';
    Opp.BusinessSource__c = '专家推荐';
    Opp.CloseDate = date.today();
    insert opp ;
    
    Contract  co = new Contract();
    co.AccountId = acc.Id ;
    co.Opportunity__c = Opp.id;
    co.WarrantyPeriod__c = 2 ;
    co.ContractCharacter__c ='内贸';
    insert co ;
    
    ConfigurationList__c configurationlist = new ConfigurationList__c();
    //configurationlist.OwnerId = '0056F0000082F6LQAU';
    //configurationlist.Name = '333';
    configurationlist.CurrencyIsoCode = 'CNY';
    //configurationlist.RecordTypeId = '0126F000001UVaNQAW';
    configurationlist.Opportuniy__c = opp.Id;
    configurationlist.ContractReview__c = co.Id;
    configurationlist.SynchronizationContract__c = '是';
    insert configurationlist;
    update co;   
       
     }
}