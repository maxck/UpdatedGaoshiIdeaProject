public class OpportunityHelper {
    
    //unlock records  
    @future (callout=true)
    public static void unlockRecords(List<Id> records)
    {
        system.debug('[Custom Log] opp records set is ' + records);
        List<Id> unLockedOppIds =  new List<Id>();
        for (Id tempId : records)
        {
            //Boolean result = Approval.isLocked(tempId);
            //if (result)
                unLockedOppIds.add(tempId);
        }
        system.debug('[Custom Log] unlock opp records set is ' + unLockedOppIds);
        if (unLockedOppIds.size() > 0)
        {
            Approval.unlock(unLockedOppIds);
        }
    }
    
}