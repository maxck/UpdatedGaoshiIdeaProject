public with sharing class OpportunityConditionChangedThisWeek {
    public List<OpportunityCondition__c>  AllOpportunitiesCondition {get;set;}
    String weeklyReportId = '';
        
   public OpportunityConditionChangedThisWeek(ApexPages.StandardController controller) {
       weeklyReportId = controller.getId();
        AllOpportunitiesCondition = new List<OpportunityCondition__c>();
        AllOpportunitiesCondition = [select OpportunityStageName__c,Account__c, Account__r.Name, Opportunity__r.Name,BarndAndType__c,OpportunityClosingTime__c,StagetDescription__c,Amount__c,Opportunity__c,ClosedDate__c,InstalledDate__c from OpportunityCondition__c where Type__c = '本周变化' and SalesWeeklyReport2__c = :weeklyReportId ];    
   }
    
}