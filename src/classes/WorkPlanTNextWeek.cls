public class WorkPlanTNextWeek
{   
    public List<WorkPlan__c>  EventList2 {set;get;}

    String weeklyReportId = '';
    public WorkPlanTNextWeek(ApexPages.StandardController controller) {
        weeklyReportId = controller.getId();
        EventList2 =  [select OpportunityActivityTheme__c,Comment__c,CompletionStatus__c,ActivityDate__c,ActivityId__c,AccountName__c, AccountName__r.name,CreatedDate,WeekChinese__c,Subject__c,ActivityDescription__c,contact__c, contact__r.name,NeedSupport__c from WorkPlan__c where Type__c = '下周' and SalesWeeklyReport__c = :weeklyReportId order by createddate];
        for(WorkPlan__c  el : EventList2){
                Datetime dt = el.CreatedDate.addHours(8);
                system.debug('dt :'+ dt);
                String weekDay = number2MonthName.get(dt.formatGmt('EEE'));
                el.WeekChinese__c = weekDay ;
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