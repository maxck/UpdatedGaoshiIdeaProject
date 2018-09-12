@isTest(seeAllData=true)
private class OpportunityAccountNameTriggerTest {

    @isTest static void TestOpportunityAccountNameTrigger() {
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
       
       Equipment__c  eq  =  new Equipment__c();
       eq.customer__c = acc.Id ;
       eq.Name = '123' ; 
       eq.warrantytype__c = '设备合同-保修';
       insert eq ;
       
       Id orderTypeIdA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规保修销售').getRecordTypeId();
       Opportunity  Opp = new Opportunity();
       Opp.RecordTypeId  =  orderTypeIdA ;
       Opp.Name = '111';
       Opp.AccountId = acc.Id ;
       Opp.CloseDate = date.today();
       Opp.StageName = '潜在阶段';
       Opp.BusinessSource__c = '专家推荐';
       Opp.EquipmentSerialNumber__c = eq.Id ;
       insert Opp ;
    
    }
}