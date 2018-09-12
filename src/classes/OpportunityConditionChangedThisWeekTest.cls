/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OpportunityConditionChangedThisWeekTest {

    @istest(SeeAlldata=true)
    static void OpportunityConditionChangeThisWeekTest() {
        
        // Setup test data
        // Create a unique UserName
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user

        Profile p = [SELECT Id FROM Profile LIMIT 1];

        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        //Name = uniqueUserName
        UserName=uniqueUserName
        //PriceBook__c='01-副总裁'
        );

        System.runAs(u) {
            Product2 product = new Product2(Name = 'test产品');
        insert product;

        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = product.Id,
            UnitPrice = 9000, IsActive = true);
            insert standardPrice;

            Pricebook2 pricebook = new Pricebook2(Name='01-客户经理级价格手册', isActive=true);
            insert pricebook;

            PricebookEntry pricebookEntry = new PricebookEntry(Product2Id=product.Id, Pricebook2Id=pricebook.Id,UnitPrice = 10000, IsActive = true);
            insert pricebookEntry; 
            
            Account acc  =  new Account() ; 
           acc.Name = 'test1230';
           acc.city__c = '福州市';
           acc.province__c = '福建省';
           acc.Cunty__c = '1' ;
           acc.LegalRepresentative__c = '1';
           acc.Duty__c = '1' ;
           acc.ContactNumber__c = '123'; 
           acc.Gender__c = '男';
           insert acc ;
       
           Opportunity  opp = new Opportunity();
           //opp.xsjhmc__c = 'test';
           opp.AccountId = acc.Id;
           opp.FinalCustomer__c = acc.Id;
           opp.StageName = '潜在阶段';
           opp.BusinessOpportunityApprovalStatus__c = '已审批';
           opp.ProcurementMethod__c = '院内采购';
           opp.BusinessSource__c = '渠道';
           opp.Name = 'yuyu';
           opp.CloseDate = date.today();
           insert opp;
           
           Order or1 = new  Order();
           or1.AccountId = acc.Id ;
           or1.EffectiveDate = date.today();
           or1.Status = 'Draft';
           insert or1;
           
           //ApexPages.CurrentPage().getParameters().put('No','11');
       
           Event  ev = new Event();
           ev.AccountName__c = acc.Id ;
           ev.DurationInMinutes = 10;
           ev.ActivityDateTime = date.today();
           insert ev ; 
           
           SalesWeeklyReport__c  Sal   =  new  SalesWeeklyReport__c() ;
           Sal.StartDate__c =  date.today();
           Sal.EndDate__c =  date.today();
           //Sal.User__c = u.Id;
           insert  Sal;
           
           OpportunityCondition__c oppc = new OpportunityCondition__c();
           oppc.SalesWeeklyReport2__c =  Sal.id ; 
           insert oppc ;
           
           OpportunityConditionChangedThisWeek  OCTW = new OpportunityConditionChangedThisWeek(new ApexPages.StandardController(Sal));
           
          // OCTW.OpportunityConditionThisWeek();
        }
        }
}