@istest
private  class AttachmentCusOb20TriggerTest {
	@istest
    static void TestAttachmentCusOb20Trigger(){
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
        CustomObject20__c newCus = new CustomObject20__c(TransactionAmount__c = 1, Account__c = acc.id);
        insert newCus;
        
        Attachment newAttachment = new Attachment(body = blob.valueOf('aaaa'), Name = '测试附件', ParentId = newCus.id);
    insert newAttachment;
    }
}