trigger AccTrigger on CustomerAssets__c (after insert) {
    
    /**Set<Id> setId  = new Set<Id>();
    Id orderTypeIdA = Schema.SObjectType.CustomerAssets__c .getRecordTypeInfosByName().get('准分子').getRecordTypeId();
    Id orderTypeIdB = Schema.SObjectType.CustomerAssets__c .getRecordTypeInfosByName().get('飞白').getRecordTypeId();
    for(CustomerAssets__c  newCus  : trigger.new){
        setId.add(newCus.CustomerName__c); 
        system.debug('newCus.CustomerName__c :'+ newCus.CustomerName__c);   
    }
    List<Account> accList = [select Id,CustomerAssetDifferentiation__c,(select Id,RecordTypeId from CustomerName__r) from Account where Id = : setId ];
    if(accList != null){
        List<CustomerAssets__c > CusList = accList.get(0).CustomerName__r ;
        system.debug('accList.get(0).CustomerName__r :'+ accList.get(0).CustomerName__r);
        for(Integer i = 0 ; i< CusList.size();i++){
            if(CusList.get(i).RecordTypeId == orderTypeIdA  || CusList.get(i).RecordTypeId == orderTypeIdB){
                accList.get(0).CustomerAssetDifferentiation__c = '有客户资产';
                upsert accList ; 
                break ;
            }else{
                accList.get(0).CustomerAssetDifferentiation__c = '无客户资产';
                upsert accList ; 
            }
        }  
    } **/
    
    Id orderTypeIdA = Schema.SObjectType.CustomerAssets__c .getRecordTypeInfosByName().get('准分子').getRecordTypeId();
    Id orderTypeIdB = Schema.SObjectType.CustomerAssets__c .getRecordTypeInfosByName().get('飞白').getRecordTypeId();
    Set<Id> accountIds = new Set<Id>();    
    for(CustomerAssets__c  newCus : trigger.new){
      accountIds.add(newCus.CustomerName__c );
    }
    Map<Id, List<Account>> accountIds2Opps = new Map<Id, List<Account>>();
    for (Account Acc : [select Id,CustomerAssetDifferentiation__c,(select Id,RecordTypeId from CustomerName__r) from Account where Id = : accountIds])
    {
      if (accountIds2Opps.containskey(Acc.Id))
      {  
        List<Account> tempAcc = accountIds2Opps.get(Acc.Id);
        tempAcc.add(Acc);
      accountIds2Opps.put(Acc.Id  , tempAcc);
      }
      else
      {
        accountIds2Opps.put(Acc.Id , new List<Account>{Acc});   
      }
    }
    for( CustomerAssets__c  newCus : trigger.new){
        if(accountIds2Opps.containsKey(newCus.CustomerName__c )){
          
          List<Account> accountList= accountIds2Opps.get(newCus.CustomerName__c);
          List<CustomerAssets__c > CusList = accountList.get(0).CustomerName__r ;
          for(Integer i = 0 ; i< CusList.size();i++){
            if(CusList.get(i).RecordTypeId == orderTypeIdA  || CusList.get(i).RecordTypeId == orderTypeIdB){
                accountList.get(0).CustomerAssetDifferentiation__c = '有客户资产';
                upsert accountList; 
                break ;
            }else{
                accountList.get(0).CustomerAssetDifferentiation__c = '无客户资产';
                upsert accountList; 
            }
        }  
        }
  
    }
}