trigger SalesWeeklyReportAfterTrigger on SalesWeeklyReport__c (after insert) {
    
    
    String weekNumber = SalesWeeklyReporHelper.getWeekNumber();
    Date thisWeekStartDate = SalesWeeklyReporHelper.getStartDateOftheWeek();
    Date thisWeekEndDate = thisWeekStartDate.addDays(6);
    
    //本周签单情况,下周预期签单情况
    Date nextWeekStartDate = thisWeekStartDate.addDays(7);
    Date nextWeekStartEnd = thisWeekStartDate.addDays(13);
    Time startTime = Time.newInstance(0,0,0,0);
    Time endTime = Time.newInstance(23,59,59,59);
    DateTime thisWeekStartDateTime = DateTime.newInstanceGMT(thisWeekStartDate, startTime);
    DateTime nextWeekEndDateTime = DateTime.newInstanceGMT(nextWeekStartEnd, endTime);
    system.debug('[Custom Log]thisWeekStartDateTime ' + thisWeekStartDateTime);
    system.debug('[Custom Log]nextWeekEndDateTime ' + nextWeekEndDateTime);
    system.debug('[Custom Log]thisWeekEndDate ' + thisWeekEndDate);
    system.debug('[Custom Log]nextWeekStartDate ' + nextWeekStartDate);
    Map<Id, Id> managerIds2WeekReportIds = new Map<Id, Id>();
    for (SalesWeeklyReport__c tempSalesWeeklyReport : trigger.new)
    {   
        if (tempSalesWeeklyReport.User__c != null)
        {
            managerIds2WeekReportIds.put(tempSalesWeeklyReport.User__c, tempSalesWeeklyReport.id);
        }
    }
    //get opportunity in the this week and next week.
    List<OpportunityCondition__c> allOpportunityConditions = new List<OpportunityCondition__c>();
    for (Opportunity tempOpportunity : [select  StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and CloseDate >= :thisWeekStartDate and CloseDate <= :nextWeekStartEnd])
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
        else if (tempOpportunity.CloseDate >= nextWeekStartDate && tempOpportunity.CloseDate <= nextWeekStartEnd )
        {
            newOpportunityCondition.Type__c = '下周';
        }
        if (String.isNotBlank(newOpportunityCondition.Type__c))
        {
            newOpportunityCondition.Opportunity__c = tempOpportunity.Id;           
            newOpportunityCondition.OpportunityId__c = tempOpportunity.ownerid + '' + managerIds2WeekReportIds.get(tempOpportunity.ownerid) + '' +  tempOpportunity.Id + '' + weekNumber + newOpportunityCondition.Type__c;
            system.debug(' newOpportunityCondition.OpportunityId__c :'+ newOpportunityCondition.OpportunityId__c);
            newOpportunityCondition.Account__c = tempOpportunity.FinalCustomer__c;
            newOpportunityCondition.Amount__c = tempOpportunity.TotalAmount__c;
            newOpportunityCondition.ClosedDate__c = tempOpportunity.CloseDate;
            newOpportunityCondition.InstalledDate__c = tempOpportunity.TimeInstallation__c;
            newOpportunityCondition.StagetDescription__c = tempOpportunity.Description__c;
            newOpportunityCondition.SalesWeeklyReport2__c = managerIds2WeekReportIds.get(tempOpportunity.ownerid);
            newOpportunityCondition.BarndAndType__c = productType;
            newOpportunityCondition.OpportunityStageName__c = tempOpportunity.StageName ;
            if(tempOpportunity.SalesOpportunityStatus__c == '赢单'){
                newOpportunityCondition.OpportunityClosingTime__c = tempOpportunity.lastmodifieddate ;
            }
            allOpportunityConditions.add(newOpportunityCondition);      
        }
    }
    if (allOpportunityConditions.size() >0)
    {
        insert allOpportunityConditions;
    }
    
    
    //本周下周装机情况
    List<LoadingCondition__c> allLoadingCondition = new List<LoadingCondition__c>();
    for (Opportunity tempOpportunity : [select  StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and TimeInstallation__c >= :thisWeekStartDate and TimeInstallation__c<= :nextWeekStartEnd])
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
        else if (tempOpportunity.TimeInstallation__c >= nextWeekStartDate && tempOpportunity.TimeInstallation__c <= nextWeekStartEnd )
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
        insert allLoadingCondition;
    }
    
    
    List<OpportunityCondition__c> allOpportunityConditions1 = new List<OpportunityCondition__c>();
        for(Opportunity opportunityList : [select  Createddate,StageName,SalesOpportunityStatus__c,lastmodifieddate,Id, FinalCustomer__c, Probability, FinalCustomer__r.Id, Name, CloseDate, cpzj__c,TotalAmount__c, TimeInstallation__c, ownerid, Description__c, (select Model__c from Field1__r) from Opportunity where ownerId in :managerIds2WeekReportIds.keySet() and Createddate >= :thisWeekStartDate and Createddate <= :thisWeekEndDate ]){
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
                //system.debug('addOpportunityCondition.Type__c :'+ addOpportunityCondition.Type__c);
                addOpportunityCondition.Opportunity__c = opportunityList.Id;
                addOpportunityCondition.OpportunityId__c = opportunityList.ownerid + '' + managerIds2WeekReportIds.get(opportunityList.ownerid) + '' +  opportunityList.Id + '' + weekNumber + addOpportunityCondition.Type__c;
                //system.debug(' addOpportunityCondition.OpportunityId__c :'+ addOpportunityCondition.OpportunityId__c);
                addOpportunityCondition.Account__c = opportunityList.FinalCustomer__c;
                addOpportunityCondition.Amount__c = opportunityList.TotalAmount__c;
                addOpportunityCondition.ClosedDate__c = opportunityList.CloseDate ; 
                //system.debug('opportunityList.StageName :'+ opportunityList.StageName);
                addOpportunityCondition.OpportunityStageName__c =  opportunityList.StageName ;
                //system.debug('addOpportunityCondition.OpportunityStageName__c :'+ addOpportunityCondition.OpportunityStageName__c);
                addOpportunityCondition.StagetDescription__c = opportunityList.Description__c;
                addOpportunityCondition.SalesWeeklyReport2__c = managerIds2WeekReportIds.get(opportunityList.ownerid);
                addOpportunityCondition.BarndAndType__c = productType;
                allOpportunityConditions1.add(addOpportunityCondition);
            }
        }
        if(allOpportunityConditions1.size() >0){
            insert  allOpportunityConditions1 ;
        }
    
    
    //get event and task in the this week and next week.
    List<WorkPlan__c> newWorkPlans = new List<WorkPlan__c>();
    // event
    for (Event tempEvent : [select Id, subject, ownerId, ActivityDate, StartDateTime, EndDateTime, ActivitiesDistinguish__c, AccountName__c, lxr__c, ActivityTheme__c, ActivityDescription__c, NeedSupport__c, Comment__c, ActivityDate__c, CompletionStatus__c from Event 
                            where StartDateTime >= :thisWeekStartDateTime and StartDateTime <= :nextWeekEndDateTime and 
                            EndDateTime >= :thisWeekStartDateTime and EndDateTime <= :nextWeekEndDateTime
                            and Ownerid in :managerIds2WeekReportIds.keySet()])
    {   
        WorkPlan__c newWorkPlan = new WorkPlan__c();
        Date startDate = tempEvent.StartDateTime.dateGMT();
        Date endDate = tempEvent.EndDateTime.dateGMT();
        if (startDate >= thisWeekStartDate && startDate <= thisWeekEndDate && endDate >= thisWeekStartDate && endDate <= thisWeekEndDate)
        {
            newWorkPlan.Type__c = '本周';
        }
        else if (startDate >= nextWeekStartDate && startDate <= nextWeekStartEnd && endDate >= nextWeekStartDate && endDate <= nextWeekStartEnd)
        {
            newWorkPlan.Type__c = '下周';
        }
        newWorkPlan.ActivitiesDistinguish__c = tempEvent.ActivitiesDistinguish__c;
        newWorkPlan.AccountName__c = tempEvent.AccountName__c;
        newWorkPlan.contact__c = tempEvent.lxr__c;
        newWorkPlan.Subject__c = tempEvent.subject;//ActivityTheme__c;
        newWorkPlan.ActivityDescription__c = tempEvent.ActivityDescription__c;
        newWorkPlan.NeedSupport__c = tempEvent.NeedSupport__c;
        newWorkPlan.Comment__c = tempEvent.Comment__c;
        newWorkPlan.CompletionStatus__c = tempEvent.CompletionStatus__c;
        newWorkPlan.SalesWeeklyReport__c = managerIds2WeekReportIds.get(tempEvent.OwnerId);
        newWorkPlan.EventId__c = tempEvent.ownerid + '' + managerIds2WeekReportIds.get(tempEvent.ownerid) + '' +  tempEvent.Id + '' + weekNumber;
        newworkPlan.ActivityId__c = tempEvent.Id;
        newWorkPlan.ActivityDate__c = tempEvent.ActivityDate;
        newWorkPlan.OpportunityActivityTheme__c = tempEvent.ActivityTheme__c;
        newWorkPlans.add(newWorkPlan);
    }
    if (newWorkPlans.size() > 0)
    {
        insert newWorkPlans;
    }
}