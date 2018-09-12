public class SalesWeeklyReporHelper {
    
    public static Boolean isFirstRun = true;
    
    public static String getWeekNumber ()
    {
    	Datetime now = Date.today();
        String dayOfWeek = now.format('EEEE');
        Date startDate;
        if (dayOfWeek == 'Sunday')
        {   
            startDate = Date.today().toStartOfWeek().addDays(-6);
        }
        else
        {
            startDate = Date.today().toStartOfWeek().addDays(1);
        }
    	String weekNumber = DateTime.newInstanceGmt(startDate, Time.NewInstance(12,0,0,0)).format('w');
    	return weekNumber;
    }
    
    public static Date getStartDateOftheWeek()
    {
    	
    	Datetime now = Date.today();
        String dayOfWeek = now.format('EEEE');
        Date startDate;
        if (dayOfWeek == 'Sunday')
        {   
            startDate = Date.today().toStartOfWeek().addDays(-6);
        }
        else
        {
            startDate = Date.today().toStartOfWeek().addDays(1);
        }
    	return startDate;
    }
    
}