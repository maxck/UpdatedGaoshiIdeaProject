/**
 * test for BatchUpdateAccountTeam
 */
@isTest
private class BatchUpdateAccountTeamTest {

    static testMethod void myUnitTest() {
		
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
		insert u;

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
		
		BatchUpdateAccountTeam__c newBatchUpdateAccountTeam = new BatchUpdateAccountTeam__c(name = 'asdasfasd898asd', OlderUserId__c = userinfo.getUserId(), 
		NewUserId__c = u.Id);
		insert newBatchUpdateAccountTeam;
        test.startTest();
        BatchUpdateAccountTeam batch = new BatchUpdateAccountTeam();
        //Id batchId = Database.executeBatch(batch, 200);
        System.schedule('batch-full','0 0 13 * * ?',batch);
        
        test.stopTest();
        
		

        
    }
}