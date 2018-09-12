public class LoadingConditionThisWeek {

    public List<LoadingCondition__c>  AllOpportunities {get;set;}
    String weeklyReportId = '';
    
    public LoadingConditionThisWeek(ApexPages.StandardController controller) {
                weeklyReportId = controller.getId();
        AllOpportunities = new List<LoadingCondition__c>();
        AllOpportunities = [select OpportunityStageName__c,Account__c, Account__r.Name, Opportunity__r.Name,BarndAndType__c,StagetDescription__c,Amount__c,Opportunity__c,ClosedDate__c,InstalledDate__c from LoadingCondition__c where Type__c = '本周' and SalesWeeklyReport2__c = :weeklyReportId ];    
   }
    
}