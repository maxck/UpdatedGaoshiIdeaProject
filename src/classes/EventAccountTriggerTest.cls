@isTest
private class EventAccountTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testEventAccountTrigger()
    { 
        Case ca = new Case();
        ca.Status = '等待备件';
        ca.Origin = '自建';
        insert ca ; 
        
        Event ev = new Event();
        ev.Case__c = ca.Id ;
        ev.DurationInMinutes = 1 ;
        ev.ActivityDateTime=DateTime.newInstance(2018, 1, 31, 7, 8, 16);
        insert ev ;
     }
   }