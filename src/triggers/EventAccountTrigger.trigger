trigger EventAccountTrigger on Event (before insert , before update ) {
    Id orderTypeIdB = Schema.SObjectType.Event.getRecordTypeInfosByName().get('服务行动').getRecordTypeId();
    Set<Id> setId = new Set<Id>() ;
    Id setId1   ;
    for(Event ev : trigger.new ){
        setId.add(ev.Case__c);
        system.debug('setId : '+ setId );
        setId1 =ev.RecordTypeId ;
    }
    List<Case> caseList = [select AccountId,Id,CaseNumber from Case where Id = : setId ];
    if(caseList.size() > 0 && setId1 == orderTypeIdB  ){
        for(Event ev : trigger.new ){
        ev.AccountName__c =  caseList.get(0).AccountId ; 
       
       }
    }
    

}