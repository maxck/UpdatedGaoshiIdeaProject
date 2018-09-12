/*
*创建当前周的销售周报
锁定上周周报
****/
global class ScheduleCreateWeeklySalesReport implements Schedulable{
    
    global void execute(SchedulableContext sc) {
        
        String weekNumber = SalesWeeklyReporHelper.getWeekNumber();
        Date startDate = SalesWeeklyReporHelper.getStartDateOftheWeek();
        Date endDate = startDate.addDays(6);
        
        Set<String> profilenames = new Set<String>{'大型屈光区域经理',  
				'大型屈光大区经理',  
				'大型屈光欧堡区域经理',
				'大型屈光欧堡大区经理',   
				'大型欧堡大区经理',  
				'大型欧堡区域经理',  
				'常规设备销售部销售简档',
				'常规设备销售部大区经理简档'};
		
        
        //获取系统中已经创建了周报的用户
        Set<Id> allUserIds = new Set<Id>();
        for(User tempuser : [select Id, name from user where isactive = true and usertype = 'Standard' and profile.name in :profilenames])
        {   
            allUserIds.add(tempuser.id);
           
        }
        //获取系统中已经创建了本周周报的用户
        Set<Id> exsitedUserIds = new Set<Id>();
        for (SalesWeeklyReport__c tempSalesWeeklyReport : [ select Id, WeekNumberCalc__c, User__c, ownerId from SalesWeeklyReport__c where createddate >= :startDate and createddate <= :endDate and User__c in :allUserIds])
        {
            exsitedUserIds.add(tempSalesWeeklyReport.User__c);
            exsitedUserIds.add(tempSalesWeeklyReport.ownerId);
        }
        system.debug('[Custom Log] exsitedUserIds ' + exsitedUserIds);
        List<SalesWeeklyReport__c> newSalesWeeklyReports = new List<SalesWeeklyReport__c>();
        for (Id tempUserId : allUserIds)
        {   
            if (!exsitedUserIds.contains(tempUserId))
            {   
                SalesWeeklyReport__c tempSalesWeeklyReport = new SalesWeeklyReport__c();
                tempSalesWeeklyReport.StartDate__c = startDate;
                tempSalesWeeklyReport.EndDate__c = endDate;
                tempSalesWeeklyReport.User__c = tempUserId;
                tempSalesWeeklyReport.Key__c = tempSalesWeeklyReport.User__c + weekNumber + Date.today().year();
                tempSalesWeeklyReport.ownerid = tempUserId;
                
                newSalesWeeklyReports.add(tempSalesWeeklyReport);
            }
        }
        if (newSalesWeeklyReports.size() > 0)
        {
            database.Upsert(newSalesWeeklyReports, SalesWeeklyReport__c.Fields.key__c);           
        }
        Date lastWeekStartDate = startDate.addDays(-7);
        Date lastWeekEndDate = startDate.addDays(-1);
        //锁定上周周报
        List<Id> lockedLastWeekSalesWeekklyReports = new List<Id>();
        for (SalesWeeklyReport__c tempSalesWeeklyReport : [ select Id from SalesWeeklyReport__c where createddate >= :lastWeekStartDate and createddate <= :lastWeekEndDate and User__c in :allUserIds])
        {   
            lockedLastWeekSalesWeekklyReports.add(tempSalesWeeklyReport.Id);
        }
        try
        {
            approval.lock(lockedLastWeekSalesWeekklyReports);
        }
        catch(Exception e)
        {
            system.debug('lock the records failed : ' + e);
        }
    }
}