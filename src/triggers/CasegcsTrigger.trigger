trigger CasegcsTrigger on Case (after insert,before update) {
     //Id orderTypeIdA = Schema.SObjectType.Case.getRecordTypeInfosByName().get('样机安装').getRecordTypeId();
     Id  idCase ;
    if(Trigger.IsInsert){
        for(Case  newCa : Trigger.new){
        idCase = newCa.Id ;
        List<Case>  caseList = new List<Case>();
        if(newCa.Origin == '自建'){
            Case   cases =  new Case() ;
            cases.Id = idCase ;
            cases.engineer__c = newCa.CreatedById ; 
            caseList.add(cases);
            
            system.debug('fuzhi wancheng');
        }
            if(caseList.size() > 0){
                update   caseList;  
            }
        
      }        
    }
    if(Trigger.isUpdate){
        for(Case  newCa : Trigger.new){
            if(newCa.Origin == '自建'){
            newCa.engineer__c = newCa.CreatedById ; 

        }        
    }
}
}