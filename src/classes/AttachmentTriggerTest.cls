@isTest
private class AttachmentTriggerTest {
   @istest
    static void testAttachmentTrigger()
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
      Contract newContract = new Contract(Name = '测试合同', accountid = acc.id);
        insert newContract;
        
        Attachment newAttachment = new Attachment(body = blob.valueOf('aaaa'), Name = '测试附件', ParentId = newContract.id);
    insert newAttachment;
    }
}