trigger CustomLevelTrigger on Opportunity (before insert,before update) {
   /**  for(Opportunity newopp : trigger.new){
        List<Account> accList = [select Grade__c,province__c from Account where Id =: newopp.FinalCustomer__c ];
        if(accList != null && accList.size() > 0){
            Account acc  = accList.get(0);
            newopp.CustomLevel__c = acc.Grade__c ; 
            newopp.Province__c   =  acc.province__c  ;
        }
     } **/
     
     Set<Id>  setId  = new  Set<Id>() ; 
     for(Opportunity newopp : trigger.new){
         setId.add(newopp.FinalCustomer__c );
         }
     Map<Id,List<Account>>  accMap  =  new  Map<Id,List<Account>>();
     for(Account  acc : [select AccountNature__c,Grade__c,province__c,city__c from Account where Id =: setId]){
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
    for(Opportunity newOpp : trigger.new){
        
        if (accMap.containsKey(newOpp.FinalCustomer__c))
        {    
            List<Account> productLine =  new List<Account>();
            productLine = accMap.get(newOpp.FinalCustomer__c);
            newopp.CustomLevel__c = productLine.get(0).Grade__c ; 
            newopp.Province__c   =  productLine.get(0).province__c  ;
            newopp.AccountNature__c  =   productLine.get(0).AccountNature__c;
            newopp.City__c  =  productLine.get(0).city__c ;
             
        }
    } 
}    
     
   /**  List<Account> accList = [select Grade__c,province__c from Account where Id =: setId ];
     for(Opportunity newopp : trigger.new){
         if(accList != null && accList.size() > 0){
         Account acc  = accList.get(0);
         newopp.CustomLevel__c = acc.Grade__c ; 
         newopp.Province__c   =  acc.province__c  ;
         }
     }
     
}**/