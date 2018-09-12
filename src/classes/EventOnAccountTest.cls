@isTest(seeAllData=true)
private class EventOnAccountTest {

    @isTest static void test_method_one() {
        Account d = new Account();
        d.Name='a';
        d.province__c='重庆市';
        d.city__c='渝中区';
        d.Cunty__c='111';
        d.NewAccount__c='否';
        d.CountyHospital__c='否';
        d.TypeEnterprise__c='医疗机构';
        d.AccountType__c='综合';
        d.BigCustomer__c='是';
        d.AccountNature__c='公立医院';
        d.Grade__c='公立二级';
        d.SalesActivityDivision__c=null;
        insert d;
        
        Account d2 = new Account();
        d2.Name='b';
        d2.province__c='重庆市';
        d2.city__c='渝中区';
        d2.Cunty__c='111';
        d2.NewAccount__c='否';
        d2.CountyHospital__c='否';
        d2.TypeEnterprise__c='医疗机构';
        d2.AccountType__c='综合';
        d2.BigCustomer__c='是';
        d2.AccountNature__c='公立医院';
        d2.Grade__c='公立二级';
        d2.SalesActivityDivision__c=null;
        insert d2;
        
        Account d3 = new Account();
        d3.Name='c';
        d3.province__c='重庆市';
        d3.city__c='渝中区';
        d3.Cunty__c='111';
        d3.NewAccount__c='否';
        d3.CountyHospital__c='否';
        d3.TypeEnterprise__c='医疗机构';
        d3.AccountType__c='综合';
        d3.BigCustomer__c='是';
        d3.AccountNature__c='公立医院';
        d3.Grade__c='公立二级';
        d3.SalesActivityDivision__c=null;
        insert d3;

        Event s = new Event();
        s.AccountName__c = d.Id;
        s.ActivitiesDistinguish__c='客户相关活动';
        s.DurationInMinutes=10;
        s.ActivityDateTime=DateTime.newInstance(2018, 1, 31, 7, 8, 16);
        insert s;
        s.AccountName__c  = d3.Id;
        update s ; 
        
        
        Event s2 =new Event();
        s2.AccountName__c = d.Id;
        s2.ActivitiesDistinguish__c='客户相关活动';
        s2.DurationInMinutes=10;
        s2.ActivityDateTime=DateTime.newInstance(2018, 1, 31, 7, 8, 16);
        insert s2;
        
        Event s3 =new Event();
        s3.AccountName__c = d.Id;
        s3.ActivitiesDistinguish__c='客户相关活动';
        s3.DurationInMinutes=10;
        s3.ActivityDateTime=DateTime.newInstance(2018, 1, 31, 7, 8, 16);
        insert s3;
        
        
        Account acc = [SELECT Id, SalesActivityDivision__c FROM Account WHERE Id=:d.Id];
        Account acc2 = [SELECT Id, SalesActivityDivision__c FROM Account WHERE Id=:d2.Id];
        Account acc3 = [SELECT Id, SalesActivityDivision__c FROM Account WHERE Id=:acc2.Id];
        List<Event> con =[SELECT AccountName__c FROM Event WHERE AccountName__c=:d.Id];
        List<Event> con2 =[SELECT AccountName__c FROM Event WHERE AccountName__c=:d2.Id];
        List<Event> con3 =[SELECT AccountName__c FROM Event WHERE AccountName__c=''];
        System.debug('SalesActivityDivision__c: '+d.SalesActivityDivision__c);

       
        
        test.startTest();
        update s3 ;
        update acc;
        update con;
        delete s3;
        delete s;
        delete s2;
        undelete s;
        update d2;
        insert con2;
        //update con3;
        update acc3;
        test.stopTest();
       
    }

}