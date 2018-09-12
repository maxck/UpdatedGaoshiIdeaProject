trigger NewWorkTrigger on Case (after insert ) {
    Id orderTypeIdA = Schema.SObjectType.Case.getRecordTypeInfosByName().get('技术服务').getRecordTypeId();
    Id orderTypeIdB = Schema.SObjectType.WorkOrder.getRecordTypeInfosByName().get('产品培训卡').getRecordTypeId();
    Id orderTypeIdC = Schema.SObjectType.Case.getRecordTypeInfosByName().get('合同安装').getRecordTypeId();
    Id orderTypeIdD = Schema.SObjectType.Case.getRecordTypeInfosByName().get('样机安装').getRecordTypeId();
    Id orderTypeIdE = Schema.SObjectType.WorkOrder.getRecordTypeInfosByName().get('合同安装单').getRecordTypeId();
    Id orderTypeIdF = Schema.SObjectType.Case.getRecordTypeInfosByName().get('维修维护').getRecordTypeId();
    Id orderTypeIdG = Schema.SObjectType.WorkOrder.getRecordTypeInfosByName().get('技术服务工作单').getRecordTypeId();
    //Set<Id> setId  = new Set<Id>();
    for(Case newCase : trigger.new){
        //setId.add(newCase.RecordTypeId);
        List<WorkOrder>  newWOs= new List<WorkOrder>();
        if(newCase.RecordTypeId == orderTypeIdA){
            WorkOrder  newWO= new WorkOrder();
            system.debug('come 1');
            newWO.RecordTypeId =  orderTypeIdB ;
            newWO.CaseId = newCase.Id ;
            newWO.AccountId = newCase.AccountId;
            newWOs.add(newWO);
            system.debug('newWOs.size() :'+ newWOs.size());           
        }
        if(newCase.RecordTypeId == orderTypeIdC || newCase.RecordTypeId == orderTypeIdD){
            WorkOrder  newWO= new WorkOrder();
            system.debug('come 1');
            newWO.RecordTypeId =  orderTypeIdE ;
            newWO.CaseId = newCase.Id ;
            newWO.AccountId = newCase.AccountId;
            newWOs.add(newWO);
            system.debug('newWOs.size() :'+ newWOs.size());           
        }
        if(newCase.RecordTypeId == orderTypeIdF){
            WorkOrder  newWO= new WorkOrder();
            system.debug('come 1');
            newWO.RecordTypeId =  orderTypeIdG ;
            newWO.CaseId = newCase.Id ;
            newWO.AccountId = newCase.AccountId;
            newWOs.add(newWO);
            system.debug('newWOs.size() :'+ newWOs.size());           
        }
    if (newWOs.size() > 0){
        
        insert newWOs;     
    }  
  }
     
}