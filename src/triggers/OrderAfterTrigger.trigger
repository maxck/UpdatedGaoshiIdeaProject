trigger OrderAfterTrigger on Order (after insert) {
    for(Order newOrder : Trigger.new) 
    {
        if (Trigger.isInsert && OrderHelper.isFirstRun == true)
        {   
            OrderHelper.isFirstRun = false;
            //OrderHelper.syncOrderinfo(newOrder.id);    
        }
    }
}