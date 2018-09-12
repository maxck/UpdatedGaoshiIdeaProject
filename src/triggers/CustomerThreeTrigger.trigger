trigger CustomerThreeTrigger on CustomerAssets__c (before insert ,before update) {
    Set<Id> setId  = new Set<Id>();
    for(CustomerAssets__c  newCus : trigger.new){
        setId.add(newCus.CustomerName__c);
    }
    Map<Id,List<Account>>  accMap  =  new  Map<Id,List<Account>>();
     for(Account  acc : [select province__c,AccountNature__c,Grade__c from Account  where Id = : setId]){
        if(accMap.containskey(acc.Id)){
            List<Account> tempAcc = accMap.get(acc.Id);
            tempAcc.add(acc);
            accMap .put(acc.Id, tempAcc);
        }
        else
        {
            accMap.put(acc.Id, new List<Account>{acc});    
        }    
    }
    for(CustomerAssets__c newCus : trigger.new){
        
        if (accMap.containsKey(newCus.CustomerName__c))
        {    
            List<Account> productLine =  new List<Account>();
            productLine = accMap.get(newCus.CustomerName__c);
            newCus.Province__c = productLine.get(0).province__c; 
            newCus.AccountNature__c =  productLine.get(0).AccountNature__c ;
            newCus.Grade__c = productLine.get(0).Grade__c ;
            
        }
    } 
}     
    
    
   /** List<Account>   acc  = [select province__c,AccountNature__c,Grade__c from Account  where Id = : setId] ;
    for(CustomerAssets__c  newCus : trigger.new){
        newCus.Province__c = acc.get(0).province__c;
        newCus.AccountNature__c =acc.get(0).AccountNature__c;
        newCus.Grade__c  =acc.get(0).Grade__c ;
    }
} **/