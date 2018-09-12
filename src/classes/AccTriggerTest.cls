@isTest
private class AccTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testAccTrigger()
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
       
       Id orderTypeIdA = Schema.SObjectType.CustomerAssets__c .getRecordTypeInfosByName().get('准分子').getRecordTypeId();
       CustomerAssets__c  CustomerAssets  =  new CustomerAssets__c();
       CustomerAssets.CustomerName__c = acc.Id ; 
       CustomerAssets.RecordTypeId = orderTypeIdA  ;
       insert CustomerAssets  ;
       
       
       
         
        
    }
    
}