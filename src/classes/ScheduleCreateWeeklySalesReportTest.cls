@isTest
private class ScheduleCreateWeeklySalesReportTest {
    
    @istest
    static void testBatch() {
        
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

        Product2 product = new Product2(Name = 'test产品');
        insert product;

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
           opp.ProcurementMethod__c = '院内采购';
           opp.BusinessSource__c = '渠道';
           opp.Name = 'yuyu';
           opp.CloseDate = date.today()+7;
           insert opp;
       
           Event  ev = new Event();
           ev.AccountName__c = acc.Id ;
           ev.DurationInMinutes = 10;
           ev.ActivityDateTime = date.today();
           insert ev ; 
           
           SalesWeeklyReport__c  Sal   =  new  SalesWeeklyReport__c() ;
           Sal.StartDate__c =  date.today().addDays(9);
           Sal.EndDate__c =  date.today().addDays(9);
           Sal.Key__c = 'asadfas1123123';
           insert  Sal;  
           
           CustomObject18__c CustomObject18  =  new CustomObject18__c();
           CustomObject18.Adi__c =  'HAI';
           CustomObject18.UnitCost__c = 1 ;
           CustomObject18.Amount__c = 1 ;
           CustomObject18.Field1__c =  opp.Id; 
           insert CustomObject18 ; 
        test.startTest();
        //test.isrunningtest();
        ScheduleCreateWeeklySalesReport batch = new ScheduleCreateWeeklySalesReport();
        //Id batchId = Database.executeBatch(batch, 200);
        System.schedule('ScheduleCreateWeeklySalesReport-test','0 0 10 * * ?',batch);
        
        test.stopTest();   
 
        
    }
    
}