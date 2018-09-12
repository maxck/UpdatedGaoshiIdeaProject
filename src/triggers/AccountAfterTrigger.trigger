trigger AccountAfterTrigger on Account (after insert, after update) {
    for(Account newAccount : Trigger.new) 
    {
        if (Trigger.isUpdate && AccountHelper.isFirstRun == true)
        {   
            AccountHelper.isFirstRun = false;
            Account oldAccount = Trigger.oldMap.get(newAccount.Id);
            if (oldAccount.CustomerApprovalStatus__c != newAccount.CustomerApprovalStatus__c && newAccount.CustomerApprovalStatus__c == '已审批')
            {
                //AccountHelper.syncAccountInfo(newAccount.Id);
            }
        }
    }
}