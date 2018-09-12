global class ScheduleSyncAmount2 implements Schedulable{
    
    //public static String CRON_EXP = '0 0 17 * *？';


    global void execute(SchedulableContext sc) {
        String  Key  =  date.today().year()+'.'+date.today().month();
        IntermediateTable__c currentIntermediateTable = new IntermediateTable__c();
        try
        {
            currentIntermediateTable = [select LargeOBAmount__c,RuleAmount__c,LargeQGAmount__c,Year__c,TotalOpportunityAmount__c ,RuleOpportunityAmount__c,LargeRefractivePhase__c,LargEuropeanAuctionStage__c,ConventionalClosingStage__c  from IntermediateTable__c where  Key__c = :Key limit 1];
        
        }
        catch(Exception e)
        {   
            //如果没有查到数据的话，创建 一条本月度的数据。
            currentIntermediateTable = new IntermediateTable__c();
            currentIntermediateTable.Key__c = Key ; 
            currentIntermediateTable.Name =  currentIntermediateTable.Key__c ;   
            insert currentIntermediateTable;
            currentIntermediateTable = [select LargeOpportunityAmount2__c ,LargeOBAmount__c,RuleAmount__c,LargeQGAmount__c,Year__c,TotalOpportunityAmount__c ,RuleOpportunityAmount__c,LargeRefractivePhase__c,LargEuropeanAuctionStage__c,ConventionalClosingStage__c  from IntermediateTable__c where  Key__c = :Key limit 1];
        }
        
         Decimal totalAmount  = 0 ;  
        // 计算所有销售机会总金额
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  StageName != '潜在阶段'And BusinessOpportunityApprovalStatus__c ='已审批'  And ClosedDateYear__c = : currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断')]){
            totalAmount =  Decimal.valueof(String.valueOf(results.get('totalAmount'))); 
            system.debug('totalAmount :'+ totalAmount);   
        }
         
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();   
        currentIntermediateTable.TotalOpportunityAmount__c =  totalAmount ; 
        
        //计算所有常规销售机会总金额
        Decimal totalNormalAmount  = 0 ; 
        Id orderTypeIdC = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会').getRecordTypeId();
        Id orderTypeIdC1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdC OR RecordTypeId =:orderTypeIdC1) And StageName != '潜在阶段' And BusinessOpportunityApprovalStatus__c ='已审批' And ClosedDateYear__c = : currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断') ]){
            totalNormalAmount =  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.RuleOpportunityAmount__c =  totalNormalAmount ; 
        
        //计算所有大型销售机会总金额
        Decimal totalLargeOppAmount  = 0 ; 
        Id orderTypeIdJ = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
        Id orderTypeIdJ1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
        Id orderTypeIdJ2 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
        Id orderTypeIdJ3 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdJ OR RecordTypeId =:orderTypeIdJ1 OR RecordTypeId =:orderTypeIdJ2 OR RecordTypeId =:orderTypeIdJ3) And StageName != '潜在阶段' And BusinessOpportunityApprovalStatus__c ='已审批' And ClosedDateYear__c = : currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断') ]){
            totalLargeOppAmount =  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.LargeOpportunityAmount2__c =  totalLargeOppAmount ; 

        //计算大型屈光预计成交总金额
        Decimal totalAmountLargeQGAmount  = 0 ; 
        Id orderTypeIdD = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
        Id orderTypeIdD1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
        
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdD OR RecordTypeId = :orderTypeIdD1) And StageName != '潜在阶段' And BusinessOpportunityApprovalStatus__c ='已审批' And ClosedDateYear__c = : currentIntermediateTable.Year__c ]){
            totalAmountLargeQGAmount=  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.LargeQGAmount__c=  totalAmountLargeQGAmount; 
        
        
        //计算大型欧堡预计成交总金额  
        Decimal totalAmountLargeOBAmount  = 0 ; 
        Id orderTypeIdE = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
        Id orderTypeIdE1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdE OR RecordTypeId = :orderTypeIdE1) And StageName != '潜在阶段' And BusinessOpportunityApprovalStatus__c ='已审批'  And ClosedDateYear__c =: currentIntermediateTable.Year__c ]){
            totalAmountLargeOBAmount=  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.LargeOBAmount__c=  totalAmountLargeOBAmount; 
        
         //计算常规预计成交总金额  
        Decimal totalAmountRuleAmount  = 0 ; 
        Id orderTypeIdF = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会').getRecordTypeId();
        Id orderTypeIdF1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdE OR RecordTypeId = :orderTypeIdE1) And StageName != '潜在阶段' And BusinessOpportunityApprovalStatus__c ='已审批'  And ClosedDateYear__c = :currentIntermediateTable.Year__c ]){
            totalAmountRuleAmount=  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.RuleAmount__c=  totalAmountRuleAmount ; 

        //计算大型屈光成交阶段金额
        Decimal totalAmountLargeRefractivePhase  = 0 ; 
        Id orderTypeIdG  = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会').getRecordTypeId();
        Id orderTypeIdG1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型屈光销售机会（大区经理)').getRecordTypeId();
        
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdG OR RecordTypeId = :orderTypeIdG1) And StageName = '成交阶段' And BusinessOpportunityApprovalStatus__c ='已审批' And ClosedDateYear__c = : currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断') ]){
            totalAmountLargeRefractivePhase =  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.LargeRefractivePhase__c =  totalAmountLargeRefractivePhase ; 
        
        
        //计算大型欧堡成交阶段金额 
        Decimal totalAmountLargEuropeanAuctionStage  = 0 ; 
        Id orderTypeIdH = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会').getRecordTypeId();
        Id orderTypeIdH1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('大型欧堡销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdH OR RecordTypeId = :orderTypeIdH1) And StageName = '成交阶段' And BusinessOpportunityApprovalStatus__c ='已审批'  And ClosedDateYear__c =: currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断') ]){
            totalAmountLargEuropeanAuctionStage =  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.LargEuropeanAuctionStage__c=  totalAmountLargEuropeanAuctionStage; 
        
         //计算常规成交阶段总金额  
        Decimal totalAmountConventionalClosingStage  = 0 ; 
        Id orderTypeIdI = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会').getRecordTypeId();
        Id orderTypeIdI1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('常规销售机会（大区经理）').getRecordTypeId();
        for(AggregateResult results   : [select sum(TotalAmount__c) totalAmount from Opportunity where  (RecordTypeId = :orderTypeIdI OR RecordTypeId = :orderTypeIdI1) And StageName = '成交阶段' And BusinessOpportunityApprovalStatus__c ='已审批'  And ClosedDateYear__c = :currentIntermediateTable.Year__c And (SalesOpportunityStatus__c != '丢单' OR SalesOpportunityStatus__c != '中断') ]){
            totalAmountLargEuropeanAuctionStage =  Decimal.valueof(String.valueOf(results.get('totalAmount')));    
        }
        currentIntermediateTable.Key__c = date.today().year()+'.'+date.today().month();
        currentIntermediateTable.ConventionalClosingStage__c=  totalAmountConventionalClosingStage  ; 
        
        
        Database.upsert(currentIntermediateTable, IntermediateTable__c.Key__c);
        
    }
    
    global ScheduleSyncAmount2()
    {   
    }
    
}