trigger CustomerFirstManagementTrigger on CustomerFirstManagement__c (after insert , after update,after delete) {
    Set<Id> accountIds = new Set<Id>();
    Set<Id> customerFirstManagementId  = new Set<Id>() ; 
    Set<Id> accountIds1 = new Set<Id>();
    Set<Id> customerFirstManagementId1  = new Set<Id>() ;  
    if(Trigger.isInsert || Trigger.isupdate){
        for(CustomerFirstManagement__c  newCustomerFirstManagement : trigger.new){
        customerFirstManagementId.add(newCustomerFirstManagement.Id);
        system.debug('customerFirstManagementId :'+ customerFirstManagementId);
        accountIds.add(newCustomerFirstManagement.Name__c) ; 
        system.debug('accountIds :'+ accountIds );
    }
    List<CustomerFirstManagement__c>  CustomerFirstManagements = [select id  from CustomerFirstManagement__c where Name__c = : accountIds];
    system.debug('CustomerFirstManagements :'+ CustomerFirstManagements );
    Map<Id, List<Account>> accountIds2Opps = new Map<Id, List<Account>>();
    for (Account Acc : [select  CustomerFirst__c,Id from Account where Id = :accountIds])
    {
        if (accountIds2Opps.containskey(Acc.Id))
        {   
            List<Account> tempAcc = accountIds2Opps.get(Acc.Id);
            tempAcc.add(Acc);
            accountIds2Opps.put(Acc.Id, tempAcc);
        }
        else
        {
            accountIds2Opps.put(Acc.Id, new List<Account>{Acc});    
        }
    }
    for(CustomerFirstManagement__c  newCustomerFirstManagement : trigger.new){
        if(accountIds2Opps.containsKey(newCustomerFirstManagement.Name__c)){
            List<Account> AccountList= accountIds2Opps.get(newCustomerFirstManagement.Name__c);
            system.debug('AccountList.size() :'+ AccountList.size());
            if(AccountList.size() > 0){
                system.debug('CustomerFirstManagements.size() '+ CustomerFirstManagements.size());
                if(CustomerFirstManagements.size() > 0){
                    AccountList.get(0).CustomerFirst__c= '是';
                    update AccountList ;
                }else{
                    AccountList.get(0).CustomerFirst__c= '否';
                    update AccountList ;
                }
            }
        }
  
    }
    
    }
    
    
    if(trigger.isdelete){
        for(CustomerFirstManagement__c oldCustomerFirstManagement : trigger.old){
            customerFirstManagementId1.add(oldCustomerFirstManagement.Id);
            system.debug('customerFirstManagementId1 :'+ customerFirstManagementId1);
            accountIds1.add(oldCustomerFirstManagement.Name__c) ; 
            system.debug('accountIds1 :'+ accountIds1 );    
        }
        List<CustomerFirstManagement__c>  CustomerFirstManagements1 = [select id,Name__c  from CustomerFirstManagement__c where Name__c = : accountIds1];
    system.debug('CustomerFirstManagements1 :'+ CustomerFirstManagements1 );
    Map<Id, List<Account>> accountIds2Opps1 = new Map<Id, List<Account>>();
    for (Account Acc1 : [select  CustomerFirst__c,Id from Account where Id = :accountIds1])
    {
        if (accountIds2Opps1.containskey(Acc1.Id))
        {   
            List<Account> tempAcc1 = accountIds2Opps1.get(Acc1.Id);
            tempAcc1.add(Acc1);
            accountIds2Opps1.put(Acc1.Id, tempAcc1);
        }
        else
        {
            accountIds2Opps1.put(Acc1.Id, new List<Account>{Acc1});    
        }
    }
    for(CustomerFirstManagement__c  oldCustomerFirstManagement : trigger.old){
        if(accountIds2Opps1.containsKey(oldCustomerFirstManagement.Name__c)){
            List<Account> AccountList1= accountIds2Opps1.get(oldCustomerFirstManagement.Name__c);
            system.debug('AccountList1.size() :'+ AccountList1.size());
            if(AccountList1.size() > 0){
                system.debug('CustomerFirstManagements1.size() '+ CustomerFirstManagements1.size());
                if(CustomerFirstManagements1.size() > 0){
                    AccountList1.get(0).CustomerFirst__c= '是';
                    update AccountList1 ;
                }else{
                    AccountList1.get(0).CustomerFirst__c= '否';
                    update AccountList1 ;
                }
            }
        }
  
    }
    }
    
}