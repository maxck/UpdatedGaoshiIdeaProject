trigger ConfigureTrigger on Contract (after insert,after update) {
    map<string, Contract> ObjMap = new map<string, Contract>();
    
    for(Contract obj: Trigger.new)
    {
        
        if (obj.Opportunity__c != Null)
        {
            ObjMap.put(obj.Opportunity__c, obj);
        }
        
    
    }
            
    List<ConfigurationList__c> cases = [SELECT Id,  Opportuniy__c,order__c,ContractReview__c,RecordType.Name
                                        FROM ConfigurationList__c WHERE Opportuniy__c IN :ObjMap.KeySet() And SynchronizationContract__c = '是'];
    List<ConfigurationList__c> caseUpdateList = new List<ConfigurationList__c>();
    Integer i=0;
    for(ConfigurationList__c c: cases)
    {
        if(c.order__c==null){
        Contract obj2=new Contract();
        obj2 = ObjMap.get(c.Opportuniy__c);
        c.ContractReview__c= obj2.Id;
    
        caseUpdateList.add(c);
        }
        
    }
        
        if(caseUpdateList.size() > 0)
    {
        update caseUpdateList;
    } 
    
    
}