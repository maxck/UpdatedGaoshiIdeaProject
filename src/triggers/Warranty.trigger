trigger Warranty on Warranty__c (after delete, after insert, after undelete, after update) {
    Cbl_Warranty_updateChance cwuc = new Cbl_Warranty_updateChance();
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUndelete || trigger.isUpdate)
        {
           cwuc.insertWar(trigger.new);
        }
        if(trigger.isDelete)
        {
           cwuc.deleteWar(trigger.old);
        }
    }
}