public class OpportunityConditionNextWeek{
        
   public List<OpportunityCondition__c>  AllOpportunities {get;set;}
   String weeklyReportId = '';
   public OpportunityConditionNextWeek(ApexPages.StandardController controller) {
        weeklyReportId = controller.getId();
        
        AllOpportunities = [select OpportunityStageName__c,Account__c, Account__r.name, Opportunity__r.name, BarndAndType__c,StagetDescription__c,Amount__c,Opportunity__c,ClosedDate__c,InstalledDate__c from OpportunityCondition__c where Type__c = '下周' and SalesWeeklyReport2__c = :weeklyReportId  ];
   }
}