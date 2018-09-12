trigger ServiceTrigger on ServiceAppointment (before insert,before update) {
    Set<Id> setId  =  new Set<Id>();
    for(ServiceAppointment  newSer : trigger.new){
        setId.add(newSer.ParentRecordId);
        system.debug('setId : '+ setId);
    }
    List<WorkOrder> WOList =[select Id ,Case.Id from WorkOrder where Id =: setId ];
    system.debug('WOList.size() : '+ WOList.size());
    if(WOList.size() > 0){
        for(ServiceAppointment  newSer : trigger.new){
            newSer.ServiceRequest__c = WOList.get(0).Case.Id ;
        }
    }

}