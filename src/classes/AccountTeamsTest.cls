@isTest
private class AccountTeamsTest 
{

    @istest(SeeAlldata=true)
    static void testAccountTeams()
    {
       test.startTest();
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
        test.stoptest(); 
        
    }
    
}