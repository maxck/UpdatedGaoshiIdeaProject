/**
 * 
 *test for ScheduleCalcChangedOpp
 */
@isTest
private class ScheduleCalcChangedOppTest {

    static testMethod void myUnitTest() {
        
        Account acc  =  new Account() ; 
           acc.Name = 'test1230';
           acc.city__c = '福州市';
           acc.province__c = '福建省';
           acc.Cunty__c = '1' ;
           acc.LegalRepresentative__c = '1';
           acc.Duty__c = '1' ;
           acc.ContactNumber__c = '123'; 
           acc.Gender__c = '男';
           insert acc ;
       
        Opportunity  opp = new Opportunity();
        //opp.xsjhmc__c = 'test';
        opp.AccountId = acc.Id;
        opp.FinalCustomer__c = acc.Id;
        opp.StageName = '潜在阶段';
        opp.ProcurementMethod__c = '院内采购';
        opp.BusinessSource__c = '渠道';
        opp.CloseDate = SalesWeeklyReporHelper.getStartDateOftheWeek().adddays(1);
        opp.Name = 'yuyu';
        insert opp;
        opp.StageName = '立项阶段';
        update opp;
        test.startTest();
        Date startDate = SalesWeeklyReporHelper.getStartDateOftheWeek();
        Date endDate = startDate.addDays(6);
        List<opportunityhistory> history = [select id, OpportunityId, Opportunity.OwnerId, stagename  from opportunityhistory where Opportunity.stagename != '成交阶段' and CloseDate >= :startDate and CloseDate <= :endDate];
        system.debug('[Custom Log]history ' + history.size());
        
        ScheduleCalcChangedOpp batch = new ScheduleCalcChangedOpp();
        Id batchId = Database.executeBatch(batch, 200);
        System.schedule('ScheduleCalcChangedOpp-full','0 0 13 * * ?',batch);
        test.stopTest();
        
    }
}