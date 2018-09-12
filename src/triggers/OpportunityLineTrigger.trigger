trigger OpportunityLineTrigger on Opportunity (before update) {
    /**for(Opportunity newOpp : trigger.new){
        List<CustomObject18__c>  Cus =  [select  Adi__c,Field1__c  from CustomObject18__c where Field1__c =: newOpp.Id];
        //system.debug('Cus.get(0).Adi__c :'+ Cus.get(0).Adi__c );
        system.debug('Cus.size() :'+Cus.size());
        if(Cus != null && Cus.size() > 0 ){
            List<String> nameList = new List<String>();
            for( CustomObject18__c Cust : Cus){
                nameList.add(Cust.Adi__c);
            }
            String  names = String.join(nameList,',');
            newOpp.ProductLine__c = names;
        }
        
    } **/
    Set<Id> setId  =new Set<Id>();
    for(Opportunity newOpp : trigger.new){
        setId.add(newOpp.Id);
    }
    
    Map<Id,List<CustomObject18__c>>  cusMap  =  new  Map<Id,List<CustomObject18__c>>();
    for(CustomObject18__c  Cus : [select Adi__c,Field1__c from CustomObject18__c where Field1__c =: setId]){
        if(CusMap.containskey(Cus.Field1__c)){
            List<CustomObject18__c > tempCus = cusMap.get(Cus.Field1__c);
            tempCus.add(Cus);
            cusMap .put(Cus.Field1__c, tempCus);
        }
        else
        {
            cusMap.put(Cus.Field1__c, new List<CustomObject18__c >{Cus});    
        }    
    }
    for(Opportunity newOpp : trigger.new){
        
        if (cusMap.containsKey(newOpp.id))
        {    
            List<CustomObject18__c> productLine =  new List<CustomObject18__c>();
            productLine = cusMap.get(newOpp.id);
            List<String> productlineNames = new List<String>();
            for( CustomObject18__c tempproductLine : productLine){
                 if (String.isNotBlank(tempproductLine.Adi__c)) productlineNames.add(tempproductLine.Adi__c);
            }
            String  names = String.join(productlineNames,',');
            newOpp.ProductLine__c = names ;
            if(productLine.size() >1){
                newOpp.ProductLinesNumber__c = productLine.size();
            }else {
                newOpp.ProductLinesNumber__c = null ; 
            }
        }
    } 
    /*List<CustomObject18__c>  Cus =  [select  Adi__c,Field1__c  from CustomObject18__c where Field1__c =: setId];
    //system.debug('Cus.get(0).Adi__c :'+ Cus.get(0).Adi__c );
    system.debug('Cus.size() :'+Cus.size());
    if(Cus != null && Cus.size() > 0 ){
         List<String> nameList = new List<String>();
         for( CustomObject18__c Cust : Cus){
             nameList.add(Cust.Adi__c);
            }
         String  names = String.join(nameList,',');
         for(Opportunity newOpp : trigger.new){
             newOpp.ProductLine__c = names ;
         }           
    }
    if(Cus.size() > 1){
        for(Opportunity newOpp : trigger.new){
             newOpp.ProductLinesNumber__c= Cus.size() ;
         }    
    }
    if(Cus.size() == 1){
        for(Opportunity newOpp : trigger.new){
             newOpp.ProductLinesNumber__c= null ;
         }    
    }*/

}