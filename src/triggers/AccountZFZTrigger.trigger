trigger AccountZFZTrigger on Account (before update) {
     
    Id orderTypeIdC = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
    Id orderTypeIdD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
    Set<Id> accountIds = new Set<Id>(); 
    String  AccountPL  = '';  
    String  SystemPL = 'SCHWIND';
    for(Account newAcc : trigger.new){
      accountIds.add(newAcc.Id);
    }
    Map<Id, List<Opportunity>> accountIds2Opps = new Map<Id, List<Opportunity>>();
    for (Opportunity  Oppo : [select  ProductLine__c,SalesOpportunityStatus__c ,BusinessOpportunityApprovalStatus__c ,StageName,RecordTypeId,Id, FinalCustomer__c from Opportunity where FinalCustomer__c  = :accountIds])
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
              AccountPL = opportunities.get(i).ProductLine__c ;
              if(AccountPL != null){
              Integer a = AccountPL .IndexOf(SystemPL);
              system.debug('a :' +  a );
              system.debug('opportunities.get(i).ProductLine__c:'+ opportunities.get(i).ProductLine__c);
              if((opportunities.get(i).RecordTypeId == orderTypeIdC || opportunities.get(i).RecordTypeId == orderTypeIdD) &&  (opportunities.get(i).StageName != '潜在阶段' ) && (opportunities.get(i).BusinessOpportunityApprovalStatus__c =='已审批') && a!=-1  ){
                  newAcc.ExcimerOpportunity__c= '有准分子销售机会';
                  break ;
              }else {
                  newAcc.ExcimerOpportunity__c= '无准分子销售机会';
              }    
              }
            }
          
        }
    }
}