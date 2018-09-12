public class OpportunityConditionCreatedThisWeek {

    public List<OpportunityCondition__c>  AllOpportunities {get;set;}
    String weeklyReportId = '';
    
    public OpportunityConditionCreatedThisWeek(ApexPages.StandardController controller) {
                weeklyReportId = controller.getId();
        AllOpportunities = new List<OpportunityCondition__c>();
        AllOpportunities = [select OpportunityStageName__c,Account__c, Account__r.Name, Opportunity__r.Name,BarndAndType__c,OpportunityClosingTime__c,StagetDescription__c,Amount__c,Opportunity__c,ClosedDate__c,InstalledDate__c from OpportunityCondition__c where Type__c = '本周新增' and SalesWeeklyReport2__c = :weeklyReportId ];    
   }
    
}