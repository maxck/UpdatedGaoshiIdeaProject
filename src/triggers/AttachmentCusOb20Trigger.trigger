trigger AttachmentCusOb20Trigger on Attachment (after insert, after update) {
    
    Set<String> parentIds = new Set<String>();
    
    for (Attachment tempAttachment : trigger.new)
    {
    	if (String.valueOf(tempAttachment.parentId).startsWith('a27'))
    	{
    		parentIds.add(tempAttachment.parentId);
    	}
    }
    
    if (parentIds.size() > 0)
    {
    	List<CustomObject20__c> updateCus = new List<CustomObject20__c>();
    	for (CustomObject20__c tempCus : [select id, Field1__c from CustomObject20__c where id in :parentIds])
    	{	
    		tempCus.Field1__c = true;
    		updateCus.add(tempCus);
    	}
    	update updateCus;
    }
    
}