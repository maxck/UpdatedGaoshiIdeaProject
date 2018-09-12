trigger OpportunityCloseTimeTrigger  on Opportunity (before insert,before update) {
    Set<String>  setZt = new Set<String>() ;
    //Set<String>  setZt1 = new Set<String>() ;
    if(trigger.isInsert){
        for(Opportunity  newOpp : trigger.new){
            setZt.add (newOpp.SalesOpportunityStatus__c);
            system.debug('setZt :'+ setZt);
        }
    }
    if(trigger.isupdate){
        for(Opportunity  newOppor : trigger.new){
            Opportunity  OppTime = Trigger.oldMap.get(newOppor.Id); 
            system.debug('OppTime :' + OppTime );
            if(newOppor.SalesOpportunityStatus__c != OppTime.SalesOpportunityStatus__c){
                system.debug('come  on 1 ');
                newOppor.OpportunityClosingTime__c = date.today();
                newOppor.CloseDate = date.today();
            }
            if(newOppor.SalesOpportunityStatus__c == null){
                newOppor.OpportunityClosingTime__c = null ; 
            }
        }
    }
    
}