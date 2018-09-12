trigger OpportunityAccountNameTrigger on Opportunity (before insert,before update) {
    Set<Id> setId = new Set<Id>();
    for(Opportunity opp : trigger.new){
        setId.add(opp.EquipmentSerialNumber__c);
        system.debug('setId : '+ setId);
    }
    if(setId != null){
        List<Equipment__c>  eqList = [select id,customer__c from Equipment__c where id = : setId];
        if(eqList.size() > 0){
            for(Opportunity opp : trigger.new){
                opp.AccountId = eqList.get(0).customer__c;
                //update opp ;
            }
        }
    }
}