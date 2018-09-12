trigger OppAmountTrigger2 on Opportunity (before insert ,before update) {
    //Set<Id> setId  =new Set<Id>(); 
    /*for(Opportunity newOpp : trigger.new){
        setId.add(newOpp.Id);
    }
    
    Map<Id,Decimal >  cusMap  =  new  Map<Id,Decimal >(); 
    for(CustomObject18__c  Cus: [select TotalMoney__c,Field1__c   from CustomObject18__c where  Field1__c in :setId]){    
        if(CusMap.containskey(Cus.Field1__c )){
            Decimal  tempCus = cusMap.get(Cus.Field1__c);
            tempCus = tempCus + Cus.TotalMoney__c;   
            cusMap .put(Cus.Field1__c,tempCus);
        }
        else
        {
            cusMap.put(Cus.Field1__c, 0.00);    
        }    
    } 
    
    for(Opportunity newOpp : trigger.new){ 
        if (cusMap.containsKey(newOpp.id))
        {
             Decimal tempTotalAmount = cusMap.get(newOpp.id);  
             newOpp.Amount =  tempTotalAmount;   
        } 
    } */
    
    for(Opportunity newOpp : trigger.new){
        newOpp.Amount =  newOpp.TotalAmount__c;
    }
    
    
 }