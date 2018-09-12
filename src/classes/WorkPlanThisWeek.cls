public class WorkPlanThisWeek{
    
    
    public List<WorkPlan__c>  AllEvents {set;get;}
    
    String weeklyReportId = '';
    public WorkPlanThisWeek(ApexPages.StandardController controller) {
        weeklyReportId = controller.getId();
        AllEvents =  [select OpportunityActivityTheme__c,Comment__c,ActivityId__c,ActivityDate__c,CompletionStatus__c,CreatedDate,AccountName__c,AccountName__r.name,WeekChinese__c,Subject__c,ActivityDescription__c,contact__c,contact__r.name,NeedSupport__c from WorkPlan__c where Type__c = '本周' and SalesWeeklyReport__c = :weeklyReportId order by createddate];
        for(WorkPlan__c  wp : AllEvents){
           // Datetime dt = wp.CreatedDate.addHours(8);
            //system.debug('dt :'+ dt);
           // String weekDay = number2MonthName.get(dt.formatGmt('EEE'));
            //wp.ActivityDate__c=     ;
            //system.debug('ev.WeekDay__c :'+ ev.WeekDay__c );
        }
    }
    public static Map<String, String> number2MonthName = new Map<String, String>
        {
            'Mon' => '星期一',
            'Tue' => '星期二',
            'Wed' => '星期三',
            'Thu' => '星期四',
            'Fri' => '星期五',
            'Sat' => '星期六',
            'Sun' => '星期日'
            
        }; 
}