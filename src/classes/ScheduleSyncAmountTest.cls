@isTest
private class ScheduleSyncAmountTest {
    
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
           
           Id orderTypeIdC = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会').getRecordTypeId();
           Opportunity  opp = new Opportunity();
           //opp.xsjhmc__c = 'test';
           opp.AccountId = acc.Id;
           opp.RecordTypeId =  orderTypeIdC  ; 
           opp.FinalCustomer__c = acc.Id;
           opp.StageName = '成交阶段';
           opp.ProcurementMethod__c = '院内采购';
           opp.BusinessSource__c = '渠道';
           opp.Name = 'yuyu';
           opp.BusinessOpportunityApprovalStatus__c = '已审批';
           opp.CloseDate = date.today();
           insert opp;
           
           CustomObject18__c CustomObject181  =  new CustomObject18__c();
           CustomObject181.Adi__c =  'HAI';
           CustomObject181.UnitCost__c = 1 ;
           //CustomObject181.Amount__c = 1 ;
           CustomObject181.Field1__c =  opp.Id; 
           insert CustomObject181 ; 
           
           Id orderTypeIdD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
           Opportunity  opp2 = new Opportunity();
           //opp.xsjhmc__c = 'test';
           opp2.AccountId = acc.Id;
           opp2.RecordTypeId =  orderTypeIdD  ; 
           opp2.FinalCustomer__c = acc.Id;
           opp2.StageName = '成交阶段';
           opp2.ProcurementMethod__c = '院内采购';
           opp2.BusinessSource__c = '渠道';
           opp2.Name = 'yuyu';
           opp2.BusinessOpportunityApprovalStatus__c = '已审批';
           opp2.CloseDate = date.today();
           insert opp2;
           
           CustomObject18__c CustomObject182  =  new CustomObject18__c();
           CustomObject182.Adi__c =  'HAI';
           CustomObject182.UnitCost__c = 1 ;
           //CustomObject182.Amount__c = 1 ;
           CustomObject182.Field1__c =  opp2.Id; 
           insert CustomObject182 ; 
           
           Id orderTypeIdE = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
           Opportunity  opp3 = new Opportunity();
           //opp.xsjhmc__c = 'test';
           opp3.AccountId = acc.Id;
           opp3.RecordTypeId =  orderTypeIdE  ; 
           opp3.FinalCustomer__c = acc.Id;
           opp3.StageName = '成交阶段';
           opp3.ProcurementMethod__c = '院内采购';
           opp3.BusinessSource__c = '渠道';
           opp3.Name = 'yuyu';
           opp3.BusinessOpportunityApprovalStatus__c = '已审批';
           opp3.CloseDate = date.today()+7;
           insert opp3;
           
           CustomObject18__c CustomObject183  =  new CustomObject18__c();
           CustomObject183.Adi__c =  'HAI';
           CustomObject183.UnitCost__c = 1 ;
           //CustomObject183.Amount__c = 1 ;
           CustomObject183.Field1__c =  opp3.Id; 
           insert CustomObject183 ; 
           
        test.startTest();
        ScheduleSyncAmount2  batch = new ScheduleSyncAmount2 ();
         IntermediateTable__c  IntermediateTable  = new IntermediateTable__c();
        IntermediateTable.Name = '1';
        insert  IntermediateTable ;  
        //Id batchId = Database.executeBatch(batch, 200);
        System.schedule('batch-full','0 0 13 * * ?',batch);
        
        test.stopTest();   
    } 
    
}