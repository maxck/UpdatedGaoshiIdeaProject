trigger CompleteTime on Case (before insert,before update) {
    /**Set<String>  setZt = new Set<String>() ;
    //Set<String>  setZt1 = new Set<String>() ;
    if(trigger.isInsert){
        for(Case  newCas: trigger.new){
            setZt.add (newCas.Status);
            system.debug('setZt :'+ setZt);
        }
    }
    if(trigger.isupdate){
        for(Case  newCaseor : trigger.new){
            Case CompleteTime = Trigger.oldMap.get(newCaseor.Id); 
            system.debug('CompleteTime :' + CompleteTime );
            if(newCaseor.Status != CompleteTime.Status){
                system.debug('come  on 1 ');
                newCaseor.CompleteTime__c = date.today();
            }
            if(newCaseor.CompleteTime__c== null){
                newCaseor.CompleteTime__c = null ; 
            }
            
            
        }
    }**/
    
        for(Case newCase : trigger.new){
        if(newCase.Status == '回访'){
            newCase.CompleteTime__c = date.today();
        }else{
            newCase.CompleteTime__c = null;
        }
    }   
}