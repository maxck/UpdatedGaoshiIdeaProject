@isTest
private class  CompleteTimeTest 
{

    @istest(SeeAlldata=true)
    static void testCompleteTimeTrigger ()
    {
  Case case1 = new Case(
    RecordTypeId = '0126F00000175p4QAA',
    Status = '等待备件',
    Origin = 'Call Center',
    Priority = 'Medium',
    IsEscalated = false,
    CurrencyIsoCode = 'CNY',
    OwnerId = '0056F0000082F6LQAU',
    WorkDate__c = Date.newInstance(2018,06,24),
    VerySatisfied__c = false,
    ReturnTime__c = Date.newInstance(2018,06,25),
    upgrade__c = false,
    CompleteTime__c = Date.newInstance(2018,06,25));
     insert case1 ;


}
}