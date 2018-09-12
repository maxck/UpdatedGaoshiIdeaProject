global class ScheduleSyncWeeklyReportData implements Database.Batchable<sObject>, Schedulable{
    
    public String qurey;
    
    global void execute(SchedulableContext sc) {
        ScheduleSyncWeeklyReportData temp = new ScheduleSyncWeeklyReportData();
        database.executeBatch(temp, 10);
    }
    
    global ScheduleSyncWeeklyReportData()
    {   
        String weekNumber = SalesWeeklyReporHelper.getWeekNumber();
        //Integer weekNumberConvertToInteger = Integer.valueof(weekNumber);
        qurey = 'select Id, WeekNumberCalc__c, User__c, StartDate__c, EndDate__c, NewOpportunityThisWeek__c, DifferenceNumberThisWeek__c, OpportunityNumber__c, SalesAmount__c from SalesWeeklyReport__c where WeekNumberCalc__c = ' + weekNumber;
        system.debug('qurey :'+ qurey);    
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qurey);
    }
    
    global void execute(Database.BatchableContext BC, List<SalesWeeklyReport__c> scope)
    {   
        Set<Id> managerIds = new Set<Id>();
        Date startDate = Date.today();
        Date endDate = Date.today();
        String weekNumber = SalesWeeklyReporHelper.getWeekNumber();
        List<SalesWeeklyReport__c> updateSalesWeeklyReports = new List<SalesWeeklyReport__c>();
        Map<Id, Id> managerIds2WeekReportIds = new Map<Id, Id>();
        for(SalesWeeklyReport__c tempSalesWeeklyReport : scope)
        {   
            startDate = (tempSalesWeeklyReport.StartDate__c != null ? tempSalesWeeklyReport.StartDate__c : startDate);
            endDate = (tempSalesWeeklyReport.EndDate__c != null ? tempSalesWeeklyReport.EndDate__c : endDate);
            //weekNumber = String.valueOf(tempSalesWeeklyReport.WeekNumberCalc__c);
            managerIds.add(tempSalesWeeklyReport.User__c);
            if (tempSalesWeeklyReport.User__c != null)
            {
                managerIds2WeekReportIds.put(tempSalesWeeklyReport.User__c, tempSalesWeeklyReport.id);
            }
        }
        
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
        
        for(SalesWeeklyReport__c tempSalesWeeklyReport : scope)
        {   
            SalesWeeklyReport__c updateSalesWeeklyReport = new SalesWeeklyReport__c();
            updateSalesWeeklyReport.Id = tempSalesWeeklyReport.Id;
            updateSalesWeeklyReport.OpportunityNumber__c = (oppId2TotalNumber.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2TotalNumber.get(tempSalesWeeklyReport.User__c));
            updateSalesWeeklyReport.SalesAmount__c = (oppId2TotalAmount.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2TotalAmount.get(tempSalesWeeklyReport.User__c));
            updateSalesWeeklyReport.NewOpportunityThisWeek__c = (oppId2CurrenWeekNumber.get(tempSalesWeeklyReport.User__c) == null ? 0 : oppId2CurrenWeekNumber.get(tempSalesWeeklyReport.User__c));
            updateSalesWeeklyReports.add(updateSalesWeeklyReport);
        }
        if (updateSalesWeeklyReports.size() > 0)
        {
            update updateSalesWeeklyReports;
        }
        Date thisWeekStartDate = startDate;
        Date thisWeekEndDate = endDate;
        Date nextWeekStartDate = startDate.addDays(8);
        Date nextWeekEndDate = startDate.addDays(14);
        Time startTime = Time.newInstance(0,0,0,0);
        Time endTime = Time.newInstance(23,59,59,59);
        DateTime thisWeekStartDateTime = DateTime.newInstanceGMT(thisWeekStartDate, startTime);
        DateTime nextWeekEndDateTime = DateTime.newInstanceGMT(thisWeekEndDate, endTime);
        //get opportunity in the this week and next week.
        List<OpportunityCondition__c> allOpportunityConditions = new List<OpportunityCondition__c>();
        for (Opportunity tempOpportunity : [select  StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and CloseDate >= :thisWeekStartDate and CloseDate <= :nextWeekEndDate])
        {   
            //产品型号
            List<String>  productTypes  =  new List<String>() ; 
            for(CustomObject18__c  Cus : tempOpportunity.Field1__r ){
                productTypes.add(Cus.Model__c);
            } 
            String productType = String.join(productTypes, ','); 
            
            OpportunityCondition__c newOpportunityCondition = new OpportunityCondition__c();
            if (tempOpportunity.CloseDate >= thisWeekStartDate && tempOpportunity.CloseDate <= thisWeekEndDate && tempOpportunity.Probability == 100)
            {
                newOpportunityCondition.Type__c = '本周';
            }
            else if (tempOpportunity.CloseDate >= nextWeekStartDate && tempOpportunity.CloseDate <= nextWeekEndDate )
            {
                newOpportunityCondition.Type__c = '下周';
            }
            if (String.isNotBlank(newOpportunityCondition.Type__c))
            {
                newOpportunityCondition.Opportunity__c = tempOpportunity.Id;
                newOpportunityCondition.OpportunityId__c = tempOpportunity.ownerid + '' + managerIds2WeekReportIds.get(tempOpportunity.ownerid) + '' +  tempOpportunity.Id + '' + weekNumber + newOpportunityCondition.Type__c;
                newOpportunityCondition.Account__c = tempOpportunity.FinalCustomer__c;
                newOpportunityCondition.Amount__c = tempOpportunity.TotalAmount__c;
                newOpportunityCondition.ClosedDate__c = tempOpportunity.CloseDate;
                newOpportunityCondition.InstalledDate__c = tempOpportunity.TimeInstallation__c;
                newOpportunityCondition.StagetDescription__c = tempOpportunity.Description__c;
                newOpportunityCondition.SalesWeeklyReport2__c = managerIds2WeekReportIds.get(tempOpportunity.ownerid);
                newOpportunityCondition.BarndAndType__c = productType;
                newOpportunityCondition.OpportunityStageName__c= tempOpportunity.StageName;
                if(tempOpportunity.SalesOpportunityStatus__c == '赢单'){
                    newOpportunityCondition.OpportunityClosingTime__c = tempOpportunity.lastmodifieddate ;
                }
                allOpportunityConditions.add(newOpportunityCondition);      
            }
        }
        if (allOpportunityConditions.size() >0)
        {
            Database.upsert(allOpportunityConditions, OpportunityCondition__c.Fields.OpportunityId__c);
        }
        
        
        //本周下周装机情况
    List<LoadingCondition__c> allLoadingCondition = new List<LoadingCondition__c>();
    for (Opportunity tempOpportunity : [select  StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and TimeInstallation__c >= :thisWeekStartDate and TimeInstallation__c<= :nextWeekEndDate])
    {   
        //产品型号
        List<String>  productTypes  =  new List<String>() ; 
        for(CustomObject18__c  Cus : tempOpportunity.Field1__r ){
            productTypes.add(Cus.Model__c);
        } 
        String productType = String.join(productTypes, ','); 
        
        LoadingCondition__c newLoadingCondition = new LoadingCondition__c();
        if (tempOpportunity.TimeInstallation__c >= thisWeekStartDate && tempOpportunity.TimeInstallation__c <= thisWeekEndDate )
        {
            newLoadingCondition .Type__c = '本周';
        }
        else if (tempOpportunity.TimeInstallation__c >= nextWeekStartDate && tempOpportunity.TimeInstallation__c <= nextWeekEndDate )
        {
            newLoadingCondition .Type__c = '下周';
        }
        if (String.isNotBlank(newLoadingCondition.Type__c))
        {
            newLoadingCondition .Opportunity__c = tempOpportunity.Id;           
            newLoadingCondition .Key__c= tempOpportunity.ownerid + '' + managerIds2WeekReportIds.get(tempOpportunity.ownerid) + '' +  tempOpportunity.Id + '' + weekNumber + newLoadingCondition .Type__c;
            system.debug(' newLoadingCondition .Opportunity__c :'+ newLoadingCondition .Opportunity__c);
            newLoadingCondition .Account__c = tempOpportunity.FinalCustomer__c;
            newLoadingCondition .Amount__c = tempOpportunity.TotalAmount__c;
            newLoadingCondition .ClosedDate__c = tempOpportunity.CloseDate;
            newLoadingCondition .InstalledDate__c = tempOpportunity.TimeInstallation__c;
            newLoadingCondition .StagetDescription__c = tempOpportunity.Description__c;
            newLoadingCondition .SalesWeeklyReport2__c = managerIds2WeekReportIds.get(tempOpportunity.ownerid);
            newLoadingCondition .BarndAndType__c = productType;
            newLoadingCondition .OpportunityStageName__c = tempOpportunity.StageName ;
            allLoadingCondition.add(newLoadingCondition );      
        }
    }
    if (allLoadingCondition.size() >0)
    {
        Database.upsert(allLoadingCondition, LoadingCondition__c.Fields.Key__c);
    }
        
        
        List<OpportunityCondition__c> allOpportunityConditions1 = new List<OpportunityCondition__c>();
        for(Opportunity opportunityList : [select  Createddate,StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and Createddate >= :thisWeekStartDate and Createddate <= :thisWeekEndDate]){
            List<String>  productTypes  =  new List<String>() ; 
            for(CustomObject18__c  Cus : opportunityList.Field1__r ){
                productTypes.add(Cus.Model__c);
            } 
            String productType = String.join(productTypes, ','); 
            OpportunityCondition__c addOpportunityCondition = new OpportunityCondition__c();
            if (opportunityList.Createddate>= thisWeekStartDate && opportunityList.Createddate<= thisWeekEndDate )
            {
                addOpportunityCondition.Type__c = '本周新增';
            }
            if (String.isNotBlank(addOpportunityCondition.Type__c)){
                addOpportunityCondition.Opportunity__c = opportunityList.Id;
                addOpportunityCondition.OpportunityId__c = opportunityList.ownerid + '' + managerIds2WeekReportIds.get(opportunityList.ownerid) + '' +  opportunityList.Id + '' + weekNumber + addOpportunityCondition.Type__c;
                addOpportunityCondition.Account__c = opportunityList.FinalCustomer__c;
                addOpportunityCondition.Amount__c = opportunityList.TotalAmount__c;
                addOpportunityCondition.ClosedDate__c = opportunityList.CloseDate ; 
                addOpportunityCondition.OpportunityStageName__c =  opportunityList.StageName ;
                addOpportunityCondition.StagetDescription__c = opportunityList.Description__c;
                addOpportunityCondition.BarndAndType__c = productType;
                addOpportunityCondition.SalesWeeklyReport2__c = managerIds2WeekReportIds.get(opportunityList.ownerid);
                allOpportunityConditions1.add(addOpportunityCondition);
            }
        }
        if(allOpportunityConditions1.size() >0){
            Database.upsert(allOpportunityConditions1, OpportunityCondition__c.Fields.OpportunityId__c);
        }
        
        
        //get event and task in the this week and next week.
        List<WorkPlan__c> newWorkPlans = new List<WorkPlan__c>();
        // event
        for (Event tempEvent : [select Id, ownerId, ActivityDate, subject,StartDateTime, EndDateTime, ActivitiesDistinguish__c, AccountName__c, lxr__c, ActivityTheme__c, ActivityDescription__c, NeedSupport__c, Comment__c, ActivityDate__c, CompletionStatus__c from Event 
                                where StartDateTime >= :thisWeekStartDateTime and StartDateTime <= :nextWeekEndDateTime and 
                                EndDateTime >= :thisWeekStartDateTime and EndDateTime <= :nextWeekEndDateTime
                                and Ownerid in :managerIds2WeekReportIds.keySet()])
        {   
            WorkPlan__c newWorkPlan = new WorkPlan__c();
            if (startDate >= thisWeekStartDate && startDate <= thisWeekEndDate && endDate >= thisWeekStartDate && endDate <= thisWeekEndDate)
            {
                newWorkPlan.Type__c = '本周';
            }
            else if (startDate >= nextWeekStartDate && startDate <= nextWeekEndDate && endDate >= nextWeekStartDate && endDate <= nextWeekEndDate)
            {
                newWorkPlan.Type__c = '下周';
            }
            newWorkPlan.ActivitiesDistinguish__c = tempEvent.ActivitiesDistinguish__c;
            newWorkPlan.AccountName__c = tempEvent.AccountName__c;
            newWorkPlan.contact__c = tempEvent.lxr__c;
            newWorkPlan.Subject__c = tempEvent.subject;
            newWorkPlan.ActivityDescription__c = tempEvent.ActivityDescription__c;
            newWorkPlan.NeedSupport__c = tempEvent.NeedSupport__c;
            newWorkPlan.Comment__c = tempEvent.Comment__c;
            newWorkPlan.CompletionStatus__c = tempEvent.CompletionStatus__c;
            newWorkPlan.SalesWeeklyReport__c = managerIds2WeekReportIds.get(tempEvent.OwnerId);
            newworkPlan.ActivityId__c = tempEvent.Id;
            newWorkPlan.EventId__c = tempEvent.ownerid + '' + managerIds2WeekReportIds.get(tempEvent.ownerid) + '' +  tempEvent.Id + '' + weekNumber;
            newWorkPlan.ActivityDate__c = tempEvent.ActivityDate;
            newWorkPlan.OpportunityActivityTheme__c = tempEvent.ActivityTheme__c;
            newWorkPlans.add(newWorkPlan);
        }
        if (newWorkPlans.size() > 0)
        {
            Database.upsert(newWorkPlans, WorkPlan__c.Fields.EventId__c);
        }

    }
    
    global void finish(Database.BatchableContext BC){}
}