trigger OpportunityAfterTrigger on Opportunity (after insert, after update) {
    
    List<Id> unlockOppIds = new List<Id>();
    
    for(Opportunity newOpportunity : Trigger.new) 
    {	
        if (Trigger.isUpdate)
        {	
	    	Opportunity oldOpportunity = Trigger.oldMap.get(newOpportunity.Id);
        	if (( oldOpportunity.BusinessOpportunityApprovalStatus__c == '草稿' && newOpportunity.BusinessOpportunityApprovalStatus__c == '待审批') || ( oldOpportunity.jdxspzt__c == '草稿' && newOpportunity.jdxspzt__c == '待审批'))
        	unlockOppIds.add(newOpportunity.Id);
        }
    }
    if (unlockOppIds.size() > 0 && !System.isBatch())
    {
    	OpportunityHelper.unlockRecords(unlockOppIds);
    }
}