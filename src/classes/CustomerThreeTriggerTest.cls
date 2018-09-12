@isTest
private class  CustomerThreeTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testCustomerThreeTrigger ()
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
       acc.AccountNature__c = '单体民营';
       acc.Grade__c = '单体民营 ';
       insert acc ;
       
       test.startTest();
       CustomerAssets__c  cus  = new  CustomerAssets__c();
       cus.CustomerName__c  =  acc.Id;
       cus.Fundus__c = 100 ;  
       insert cus ;
       
       test.stoptest(); 
       
     }
}