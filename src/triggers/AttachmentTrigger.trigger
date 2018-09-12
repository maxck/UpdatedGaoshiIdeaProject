trigger AttachmentTrigger on Attachment (after insert, after update) {
    
    Set<String> parentIds = new Set<String>();
    
    for (Attachment tempAttachment : trigger.new)
    {
    	if (String.valueOf(tempAttachment.parentId).startsWith('800'))
    	{
    		parentIds.add(tempAttachment.parentId);
    	}
    }
    
    if (parentIds.size() > 0)
    {
    	List<Contract> updateContracts = new List<Contract>();
    	for (Contract tempContract : [select id, Field1__c from Contract where id in :parentIds])
    	{	
    		tempContract.Field1__c = true;
    		updateContracts.add(tempContract);
    	}
    	update updateContracts;
    }
    
}