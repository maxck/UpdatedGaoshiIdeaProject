trigger OpportunityRecordTrigger on Account (before update) {
   /** Id orderTypeIdA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
    Set<Id> setId = new Set<Id>();
    for(Account newAcc : trigger.new){
        setId .add(newAcc.Id); 
        system.debug('setId :'+ setId);   
    }
    List<Opportunity>  opp =[select Id,RecordTypeId,AccountId from Opportunity where FinalCustomer__c = : setId];
    for(Account newAcc : trigger.new){
        for(Opportunity  oppo : opp){
            if(oppo.RecordTypeId == orderTypeIdA){
                newAcc.SalesOpportunityDifferentiation__c = '有';
            }else{
                newAcc.SalesOpportunityDifferentiation__c = '无';
            }
        }
    
    } **/
    
    Id orderTypeIdA = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
    Id orderTypeIdB = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会（大区经理）').getRecordTypeId();
    /**Id orderTypeIdC = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
    Id orderTypeIdD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
    Id orderTypeIdE = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会').getRecordTypeId();
    Id orderTypeIdF = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会（大区经理）').getRecordTypeId(); **/
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
              if((opportunities.get(i).RecordTypeId == orderTypeIdA || opportunities.get(i).RecordTypeId == orderTypeIdB) &&  (opportunities.get(i).StageName != '潜在阶段' ) && (opportunities.get(i).BusinessOpportunityApprovalStatus__c =='已审批')  ){
                  newAcc.SalesOpportunityDifferentiation__c = '有欧堡销售机会';
                  i = opportunities.size() ;
              }else {
                  newAcc.SalesOpportunityDifferentiation__c = '无欧堡销售机会';
              }
              /**if((opportunities.get(i).RecordTypeId == orderTypeIdC || opportunities.get(i).RecordTypeId == orderTypeIdD) &&  (opportunities.get(i).StageName != '潜在阶段' ) && (opportunities.get(i).BusinessOpportunityApprovalStatus__c =='已审批')  ){
                  newAcc.RefractionOpportunity__c= '有屈光销售机会';
                  break ;
              }else {
                  newAcc.RefractionOpportunity__c= '无屈光销售机会';
              }
              if((opportunities.get(i).RecordTypeId == orderTypeIdE || opportunities.get(i).RecordTypeId == orderTypeIdF) &&  (opportunities.get(i).StageName != '潜在阶段' ) && (opportunities.get(i).BusinessOpportunityApprovalStatus__c =='已审批') ){
                  newAcc.RegularOpportunities__c= '有常规销售机会';
                  break ;
              }else {
                  newAcc.RegularOpportunities__c= '无常规销售机会';
              } **/
          }
            
          /** for(Opportunity Oppo : opportunities){
               system.debug('Oppo.RecordTypeId '+ Oppo.RecordTypeId);
                if(Oppo.RecordTypeId == orderTypeIdA){
                newAcc.SalesOpportunityDifferentiation__c = '有欧堡销售机会';
            }else{
                newAcc.SalesOpportunityDifferentiation__c = '无欧堡销售机会';
            }   
            } **/
            
        }
  
    }
}