trigger SalesWeeklyReportBeforeTrigger on SalesWeeklyReport__c (before insert, before update) {
    
    //calc current weeknumber in the year
    String weekNumber = SalesWeeklyReporHelper.getWeekNumber();
    
    if (Trigger.isInsert)
    {   
        Date startDate = SalesWeeklyReporHelper.getStartDateOftheWeek();
        Date endDate = startDate.addDays(6);
        
        Set<Id> managerIds = new Set<Id>();
        for (SalesWeeklyReport__c tempSalesWeeklyReport : trigger.new)
        {
            tempSalesWeeklyReport.StartDate__c = startDate;
            tempSalesWeeklyReport.EndDate__c = endDate;
            tempSalesWeeklyReport.User__c = (tempSalesWeeklyReport.User__c != null ? tempSalesWeeklyReport.User__c : userinfo.getuserid());
            tempSalesWeeklyReport.Key__c = tempSalesWeeklyReport.User__c + weekNumber + Date.today().year();
            tempSalesWeeklyReport.WeekNumberCalc__c = Integer.valueOf(weekNumber);
            managerIds.add(tempSalesWeeklyReport.User__c);
            // intial value
            tempSalesWeeklyReport.OpportunityNumber__c = 0;
            tempSalesWeeklyReport.SalesAmount__c = 0;
            tempSalesWeeklyReport.NewOpportunityThisWeek__c = 0;
            tempSalesWeeklyReport.DifferenceNumberThisWeek__c = 0;
        }
        
        if (SalesWeeklyReporHelper.isFirstRun)
        {
            SalesWeeklyReporHelper.isFirstRun = false;
            Map<String, Decimal> oppId2TotalNumber = new Map<String, Decimal>();
            Map<String, Decimal> oppId2TotalAmount = new Map<String, Decimal>();
            Map<String, Decimal> oppId2CurrenWeekNumber = new Map<String, Decimal>();
            //本周新增机会数,本周机会变化总数,销售机会总数,销售机会总金额
            for (AggregateResult results  : [select  count(Id) totalNumber, sum(TotalAmount__c) totalAmount, ownerid from Opportunity where ownerId in:managerIds  group by ownerid ])
            {
                system.debug('[Custom Log]totalNumber ' + results.get('totalNumber') );
                system.debug('[Custom Log]totalAmount ' + results.get('totalAmount') );
                system.debug('[Custom Log]ownerid ' + results.get('ownerid') );
                String oppId = String.valueOf(results.get('ownerid'));
                Decimal totalNumber = Decimal.valueof(String.valueOf(results.get('totalNumber')));
                Decimal totalAmount = Decimal.valueof(String.valueOf(results.get('totalAmount')));
                oppId2TotalNumber.put(oppId, totalNumber);
                oppId2TotalAmount.put(oppId, totalAmount);
            }
            for (AggregateResult results : [select  count(Id) totalNumber, ownerid from Opportunity where ownerId in:managerIds and  createddate >= :startDate and createddate <= :endDate group by ownerid])
            {   
                String oppId = String.valueOf(results.get('ownerid'));
                Decimal totalNumber = Decimal.valueof(String.valueOf(results.get('totalNumber')));
                oppId2CurrenWeekNumber.put(oppId, totalNumber);
            }
            for (SalesWeeklyReport__c tempSalesWeeklyReport : trigger.new)
            {
                tempSalesWeeklyReport.OpportunityNumber__c = (oppId2TotalNumber.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2TotalNumber.get(tempSalesWeeklyReport.User__c) );
                tempSalesWeeklyReport.SalesAmount__c = (oppId2TotalAmount.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2TotalAmount.get(tempSalesWeeklyReport.User__c));
                tempSalesWeeklyReport.NewOpportunityThisWeek__c = (oppId2CurrenWeekNumber.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2CurrenWeekNumber.get(tempSalesWeeklyReport.User__c));
            }
        }
        
        
        
    }
}