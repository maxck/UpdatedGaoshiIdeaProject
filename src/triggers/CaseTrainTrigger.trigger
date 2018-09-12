trigger CaseTrainTrigger on Case (after insert,after update) {
    Id orderTypeIdE = Schema.SObjectType.WorkOrder.getRecordTypeInfosByName().get('产品培训卡').getRecordTypeId();
    Set<Id>  setId = new Set<Id>();
    List<WorkOrder>  newWOs= new List<WorkOrder>();
    for(Case newCa : Trigger.new){
        setId.add(newCa.Id);
        system.debug('setId : '+ setId );
        
         if(newCa.WQZW1__c == true || newCa.WQZW2__c == true ||newCa.WQZW3__c == true ||newCa.WQZW4__c == true ||newCa.WQZW5__c == true || newCa.JBZW1__c== true ||newCa.JBZW2__c== true ||newCa.JBZW3__c== true ||newCa.JBZW4__c== true ||newCa.JBZW5__c== true ||newCa.WZW1__c== true ||newCa.WZW2__c== true ||newCa.WZW3__c== true ||newCa.WZW4__c== true ||newCa.WZW5__c== true ||newCa.YES7__c== true ||newCa.YES8__c== true ||newCa.NO7__c== true ||newCa.NO8__c== true ||newCa.Chinese__c== true ||newCa.English__c== true  ){
             WorkOrder  newWO= new WorkOrder();
             system.debug('come 1');
             newWO.RecordTypeId =  orderTypeIdE ;
             newWO.CaseId = newCa.Id ;
             newWO.AccountId = newCa.AccountId;
             newWOs.add(newWO);
             system.debug('newWOs.size() :'+ newWOs.size());                 
         }
    }
    List<WorkOrder> woList =[select id,CaseId from WorkOrder where CaseId =: setId ];
    system.debug('woList.size() :'+ woList.size());
    if (newWOs.size() > 0 && woList.size() <= 1 ){      
        insert newWOs;     
    }  
}