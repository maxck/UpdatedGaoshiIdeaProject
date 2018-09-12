trigger CustomObject4 on CustomObject4__c (after delete, after insert, after undelete, after update)
{
    Cbl_CustomObject4_updateChance ccopc = new Cbl_CustomObject4_updateChance();
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUndelete || trigger.isUpdate)
        {
           ccopc.handleCO(trigger.new);
        }
        if(trigger.isDelete)
        {
           ccopc.handleCO(trigger.old);
        }
    }
}