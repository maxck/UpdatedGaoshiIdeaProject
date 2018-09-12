trigger OpportunityRecord2Trigger on Account (before update) {
    
    
    Id orderTypeIdC = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
    Id orderTypeIdD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
    Set<Id> accountIds = new Set<Id>();    
    for(Account newAcc : trigger.new){
      accountIds.add(newAcc.Id);
    }
    Map<Id, List<Opportunity>> accountIds2Opps = new Map<Id, List<Opportunity>>();
    for (Opportunity  Oppo : [select  SalesOpportunityStatus__c ,BusinessOpportunityApprovalStatus__c ,StageName,RecordTypeId,Id, FinalCustomer__c from Opportunity where FinalCustomer__c  = :accountIds])
    {
      if (accountIds2Opps.containskey(Oppo.FinalCustomer__c  ))
      {  
        List<Opportunity> tempOpps = accountIds2Opps.get(Oppo.FinalCustomer__c  );
        tempOpps.add(Oppo);
      accountIds2Opps.put(Oppo.FinalCustomer__c  , tempOpps);
      }
      else
      {
        accountIds2Opps.put(Oppo.FinalCustomer__c , new List<Opportunity>{Oppo});   
      }
    }
    for(Account newAcc : trigger.new){
        if(accountIds2Opps.containsKey(newAcc.Id)){
          
          List<Opportunity> opportunities = accountIds2Opps.get(newAcc.Id);
          for(Integer i = 0 ; i< opportunities.size() ; i ++){
              
              if((opportunities.get(i).RecordTypeId == orderTypeIdC || opportunities.get(i).RecordTypeId == orderTypeIdD) &&  (opportunities.get(i).StageName != '潜在阶段' ) && (opportunities.get(i).BusinessOpportunityApprovalStatus__c =='已审批')  ){
                  newAcc.RefractionOpportunity__c= '有屈光销售机会';
                  i = opportunities.size() ;
              }else {
                  newAcc.RefractionOpportunity__c= '无屈光销售机会';
              }
          }
            
        }
  
    }
}