trigger AccountProductLineTrigger on Account (before update) {
    /*
    for(Account newAcc : trigger.new){
        List<Opportunity>  Opp =  [select  Account.Name  from Opportunity ];
        if(Opp.size() >0 ){
           // List<Opportunity>  Oppo =  [select  Id,(select Adi__c from Field1__r)  from Opportunity where Account.Id=: newAcc.Id];
            List<Opportunity>  Oppo =  [select  ProductLine__c,Id  from Opportunity where Account.Id=: newAcc.Id];
            if(Oppo != null && Oppo.size() > 0 ){
             //List<CustomObject18__c> CusList = Oppo.get(0).Field1__r;
            List<String> nameList1 = new List<String>();
           // for( CustomObject18__c Cus: CusList ){
           for(Opportunity Oppor : Oppo){
                //nameList1.add(Cus.Adi__c );
                nameList1.add(Oppor.ProductLine__c  );
            }
            String  names = String.join(nameList1,',');
            newAcc.ProductLine__c= names;
        }
        }
  
    }*/

    Set<Id> accountIds = new Set<Id>();    
    for(Account newAcc : trigger.new){
        accountIds.add(newAcc.Id);
    }
    Map<Id, List<Opportunity>> accountIds2Opps = new Map<Id, List<Opportunity>>();
    for (Opportunity  Oppo : [select  ProductLine__c,Id,FinalCustomer__c, accountId  from Opportunity where FinalCustomer__c = :accountIds])
    {
        if (accountIds2Opps.containskey(Oppo.FinalCustomer__c ))
        {   
            List<Opportunity> tempOpps = accountIds2Opps.get(Oppo.FinalCustomer__c );
            tempOpps.add(Oppo);
            accountIds2Opps.put(Oppo.FinalCustomer__c , tempOpps);
        }
        else
        {
            accountIds2Opps.put(Oppo.FinalCustomer__c , new List<Opportunity>{Oppo});    
        }
    }
    for(Account newAcc : trigger.new){
        if(accountIds2Opps.containsKey(newAcc.Id)){
            
            List<Opportunity> opportunities = accountIds2Opps.get(newAcc.Id);
            List<String> nameList1 = new List<String>();
           for(Opportunity Oppor : opportunities){
                nameList1.add(Oppor.ProductLine__c  );
            }
            String  names = String.join(nameList1,',');
            newAcc.ProductLine__c= names;
        }
  
    }

}