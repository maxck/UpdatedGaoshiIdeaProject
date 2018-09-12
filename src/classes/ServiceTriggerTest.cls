@isTest
private class ServiceTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testServiceTrigger()
    {
        Case ca = new Case();
        ca.Status = '等待备件';
        ca.Origin = '自建';
        insert ca ;  
        
        WorkOrder wo = new WorkOrder();
        //wo.Case.id = ca.Id;
        insert wo ; 
        
        ServiceAppointment  se  =  new ServiceAppointment();
        se.DueDate = datetime.now() ;
        se.ParentRecordId = wo.Id ;
        try
        {
	        insert se;  
        }
        catch(Exception e)
        {
        	system.debug('inser error is ' + e);
        }
    }
}