trigger pollingTrigger on polling__c (before insert , before update) {
    /**for(polling__c newpo : Trigger.new){
        if(newpo.RespondingSpeed__c != null || newpo.ServiceAttitude__c != null|| newpo.SolveEfficiency__c !=null|| newpo.QuotationFees__c !=null||newpo.FieldSpecification__c != null){
            newpo.RevisitDays__c = date.today();
        }
    } **/
    if(Trigger.isInsert){
        for(polling__c newpo : Trigger.new){
            if(newpo.RespondingSpeed__c != null || newpo.ServiceAttitude__c != null|| newpo.SolveEfficiency__c !=null|| newpo.QuotationFees__c !=null||newpo.FieldSpecification__c != null){
                newpo.RevisitDays__c = date.today();
            }else{
                newpo.RevisitDays__c = null;
            }
        }
    }
    if(Trigger.isupdate){
        for(polling__c  newpoll : trigger.new){
            polling__c  poTime = Trigger.oldMap.get(newpoll.Id); 
            system.debug('poTime :' + poTime);
            if(newpoll.RespondingSpeed__c != poTime.RespondingSpeed__c || newpoll.ServiceAttitude__c != poTime.ServiceAttitude__c || newpoll.SolveEfficiency__c != poTime.SolveEfficiency__c || newpoll.QuotationFees__c != poTime.QuotationFees__c || newpoll.FieldSpecification__c != poTime.FieldSpecification__c ){
                system.debug('come  on 1 ');
                newpoll.RevisitDays__c = date.today();
            }
            if(newpoll.RespondingSpeed__c == null && newpoll.ServiceAttitude__c == null && newpoll.SolveEfficiency__c == null && newpoll.FieldSpecification__c== null && newpoll.QuotationFees__c == null){
                newpoll.RevisitDays__c= null ; 
            }
        }
    }
}