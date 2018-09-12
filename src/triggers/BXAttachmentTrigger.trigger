trigger BXAttachmentTrigger on Attachment (after insert ,after update) {
    Set<String> parentIds = new Set<String>();
    for (Attachment tempAttachment : trigger.new)
    {
      system.debug('tempAttachment.parentId :'+ tempAttachment.parentId);
      if (String.valueOf(tempAttachment.parentId).startsWith('a29'))
      {
        system.debug('come on 1 ');
        parentIds.add(tempAttachment.parentId);
      }
    }
    system.debug('parentIds.size() :'+ parentIds.size());
    if (parentIds.size() > 0) 
    {
      List<CustomObject22__c> updateCustomObject22s = new List<CustomObject22__c>();
      for (CustomObject22__c tempCustomObject22 : [select id, Field1__c from CustomObject22__c where id in :parentIds])
      {  
          system.debug('come on 2 ');
        tempCustomObject22.Field1__c = true;
        updateCustomObject22s.add(tempCustomObject22);
      }
      update updateCustomObject22s;
    }
}