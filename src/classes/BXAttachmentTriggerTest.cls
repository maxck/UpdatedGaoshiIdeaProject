@isTest
private class BXAttachmentTriggerTest {
   @istest
    static void testBXAttachmentTrigger()
    {  
        
      CustomObject22__c  newCustomObject22 = new CustomObject22__c();
        insert newCustomObject22 ;
        
        Attachment newAttachment = new Attachment(body = blob.valueOf('aaaa'), Name = '测试附件', ParentId = newCustomObject22.id);
    insert newAttachment;
    }
}