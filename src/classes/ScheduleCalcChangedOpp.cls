global class ScheduleCalcChangedOpp implements Database.Batchable<sObject>, Schedulable {
    
    public String qurey;
    public Date startDate;
    public Date endDate;
    
    global void execute(SchedulableContext sc) {
        ScheduleCalcChangedOpp temp = new ScheduleCalcChangedOpp();
        database.executeBatch(temp, 10);
    }
    
    global ScheduleCalcChangedOpp()
    {   
        startDate = SalesWeeklyReporHelper.getStartDateOftheWeek();
        endDate = startDate.addDays(6);
        
        //Integer weekNumberConvertToInteger = Integer.valueof(weekNumber);
        qurey = 'select id, OpportunityId, Opportunity.OwnerId, Opportunity.StageName, Opportunity.SalesOpportunityStatus__c, Opportunity.lastmodifieddate, ' +
        		' Opportunity.FinalCustomer__c, Opportunity.Probability, Opportunity.FinalCustomer__r.Id, Opportunity.Name, Opportunity.CloseDate, ' + 
        		//' Opportunity.cpzj__c, Opportunity.TotalAmount__c, Opportunity.TimeInstallation__c, Opportunity.Description__c  from opportunityhistory where Opportunity.stagename != \'成交阶段\' and Opportunity.CloseDate >= :startDate and Opportunity.CloseDate <= :endDate';
    			' Opportunity.cpzj__c, Opportunity.TotalAmount__c, Opportunity.TimeInstallation__c, Opportunity.Description__c  from OpportunityFieldHistory where createddate >= :startDate and createddate <= :endDate and field = \'StageName\'';
    	system.debug('startDate is ' + startDate);
    	system.debug('endDate is ' + endDate);
    	system.debug('qurey is ' + qurey);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(qurey);
    }
    
    global void execute(Database.BatchableContext BC, List<OpportunityFieldHistory> scope)
    {   
    	String weeknumber = SalesWeeklyReporHelper.getWeekNumber ();
        Set<Id> userIds = new Set<Id>();
        Map<Id, Set<Id>> OwnerId2OppNumber = new Map<Id, Set<Id>>();
        Map<Id, Opportunity> oppId2Opportunities = new Map<Id, Opportunity>();
        Set<Id> opportunityIds = new Set<id>();
        for(OpportunityFieldHistory tempopportunityhistory : scope)
        {   
        	userIds.add(tempopportunityhistory.Opportunity.OwnerId);
        	opportunityIds.add(tempopportunityhistory.OpportunityId);
        	oppId2Opportunities.put(tempopportunityhistory.OpportunityId, tempopportunityhistory.Opportunity);
        	if (OwnerId2OppNumber.containskey(tempopportunityhistory.Opportunity.OwnerId))
        	{ 
        		Set<Id> tempOpportunityIds = OwnerId2OppNumber.get(tempopportunityhistory.Opportunity.OwnerId);
        		tempOpportunityIds.add(tempopportunityhistory.OpportunityId);
        		OwnerId2OppNumber.put(tempopportunityhistory.Opportunity.OwnerId, tempOpportunityIds);
        	}
        	else
        	{
        		OwnerId2OppNumber.put(tempopportunityhistory.Opportunity.OwnerId, new Set<Id>{tempopportunityhistory.OpportunityId});
        		
        	}
        }
        //get brand and type
        Map<Id, String> OppId2BrandTypes = new Map<Id, String>();
        for (CustomObject18__c tempchanceproduct : [select id, Model__c, Field1__c from CustomObject18__c where Field1__c in :opportunityIds])
        {
        	if (OppId2BrandTypes.containskey(tempchanceproduct.Field1__c))
        	{ 
        		String tempBrandType = OppId2BrandTypes.get(tempchanceproduct.Field1__c) + tempchanceproduct.Model__c;
        		OppId2BrandTypes.put(tempchanceproduct.Field1__c, tempBrandType);
        	}
        	else
        	{
        		OppId2BrandTypes.put(tempchanceproduct.Field1__c, tempchanceproduct.Model__c);
        	}
        }
        List<SalesWeeklyReport__c> updateSalesWeeklyReports = new List<SalesWeeklyReport__c>();
        List<OpportunityCondition__c> allOpportunityConditions = new List<OpportunityCondition__c>();
        for(SalesWeeklyReport__c tempSalesWeeklyReport : [select id, Ownerid, user__c from SalesWeeklyReport__c where ownerid in :userIds and StartDate__c >= :startDate and StartDate__c <= :endDate])
        {   
            SalesWeeklyReport__c updateSalesWeeklyReport = new SalesWeeklyReport__c();
            updateSalesWeeklyReport.Id = tempSalesWeeklyReport.id;
            updateSalesWeeklyReport.DifferenceNumberThisWeek__c = (OwnerId2OppNumber.containsKey(tempSalesWeeklyReport.Ownerid) ? OwnerId2OppNumber.get(tempSalesWeeklyReport.Ownerid).size() : 0);
            updateSalesWeeklyReports.add(updateSalesWeeklyReport);
            
            Set<Id> currentOnwerOpportunityIds = OwnerId2OppNumber.get(tempSalesWeeklyReport.Ownerid);
            for (Id tempOpportunityId : currentOnwerOpportunityIds)
            {	
            	Opportunity tempOpportunity = oppId2Opportunities.get(tempOpportunityId);
            	String productType = OppId2BrandTypes.get(tempOpportunity.Id);
		        OpportunityCondition__c newOpportunityCondition = new OpportunityCondition__c();
	            newOpportunityCondition.Type__c = '本周变化';
		        if (String.isNotBlank(newOpportunityCondition.Type__c))
		        {
		            newOpportunityCondition.Opportunity__c = tempOpportunity.Id;           
		            newOpportunityCondition.OpportunityId__c = tempOpportunity.ownerid + '' + tempSalesWeeklyReport.Ownerid + '' +  tempOpportunity.Id + '' + weekNumber + newOpportunityCondition.Type__c;
		            system.debug(' newOpportunityCondition.OpportunityId__c :'+ newOpportunityCondition.OpportunityId__c);
		            newOpportunityCondition.Account__c = tempOpportunity.FinalCustomer__c;
		            newOpportunityCondition.Amount__c = tempOpportunity.TotalAmount__c;
		            newOpportunityCondition.ClosedDate__c = tempOpportunity.CloseDate;
		            newOpportunityCondition.InstalledDate__c = tempOpportunity.TimeInstallation__c;
		            newOpportunityCondition.StagetDescription__c = tempOpportunity.Description__c;
		            newOpportunityCondition.SalesWeeklyReport2__c = tempSalesWeeklyReport.id;
		            newOpportunityCondition.BarndAndType__c = productType;
		            newOpportunityCondition.OpportunityStageName__c = tempOpportunity.StageName ;
		            if(tempOpportunity.SalesOpportunityStatus__c == '赢单'){
		                newOpportunityCondition.OpportunityClosingTime__c = tempOpportunity.lastmodifieddate ;
		            }
		            allOpportunityConditions.add(newOpportunityCondition);      
		        }
            }
        }
        
        if (updateSalesWeeklyReports.size() > 0)
        {
        	update updateSalesWeeklyReports;
        }
		if (allOpportunityConditions.size() > 0)
		{
			upsert allOpportunityConditions;
		}
    }
    
    global void finish(Database.BatchableContext BC){}

    
}