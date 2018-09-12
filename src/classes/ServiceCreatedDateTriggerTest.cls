@isTest
private class ServiceCreatedDateTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testServiceCreatedDateTrigger()
    {  
        Account acc =  new Account();
        acc.Name = 'Test9999';
        insert acc;
        Contact  con  =  new Contact();
        con.LastName = 'T1';
        con.AccountId = acc.Id;
        insert con;
        Equipment__c  eq =  new Equipment__c();
        eq.customer__c = acc.Id ; 
        eq.Name  = '12';
        insert eq;
        
       Id orderTypeIdA = Schema.SObjectType.Case.getRecordTypeInfosByName().get('合同安装').getRecordTypeId();
       Case newCa = new Case(); 
       newCa.RecordTypeId = orderTypeIdA  ; 
       //newCa.engineer__c = u.Id;
       newCa.Origin = '自建';
       newCa.Equipment__c = eq.Id ;
       newCa.ContactId = con.Id ;
       newCa.AccountId = acc.Id ;
       newCa.YES7__c  = true ;
       insert newCa ; 
       
       WorkType wt = new WorkType();
       wt.Name = '123';
       wt.EstimatedDuration = 12.00;
       wt.ShouldAutoCreateSvcAppt = true ;
       insert wt ;
       
       WorkOrder wo = new WorkOrder();
       wo.WorkTypeId = wt.Id ;
       wo.CaseId = newCa.Id ;
       insert wo ;
       
       
       
    }
}