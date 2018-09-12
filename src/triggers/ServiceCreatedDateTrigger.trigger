trigger ServiceCreatedDateTrigger on ServiceAppointment (after insert) {
    Set<Datetime>  setTime =  new Set<Datetime>();
    DateTime dt  ;
    Date dd ; 
    Set<Id>  setId = new Set<Id>() ;
    for(ServiceAppointment newS : Trigger.new){
        setTime.add(newS.CreatedDate);
        system.debug('setTime :'+ setTime);
        setId.add(newS.ServiceRequest__c);
        system.debug('setId : '+setId);
        dt = newS.CreatedDate ; 
        system.debug('dt :'+ dt);
        dd = dt.date();
        system.debug('dd :'+ dd);
    }
    
    List<Case> caseList  = [select id,SendTime__c from Case where id =: setId];
    caseList.get(0).SendTime__c = dt ;
    upsert caseList ;
    
}