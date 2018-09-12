/**
*Create By:jmark
*TIME：2015年2月27日09:13:53
*Descripe:自动计算设备机龄
 */
global class Cls_EquipmentBatch implements Database.Batchable<SObject>{
      global Database.queryLocator start(Database.BatchableContext ctx)
     {
     	   system.debug('--------------------start');
           return Database.getQueryLocator([select installationdate__c,machineage__c,Name from Equipment__c]); 
     }
     global void execute(Database.BatchableContext ctx, List<Equipment__c> list_equ)
     {
     	 system.debug('--------------------execute');
         if(list_equ != null && list_equ.size()>0)
	     {
	     	 Date now=Date.today();
	         for(Equipment__c eq:list_equ)
	         {
	             if(eq.installationdate__c != null)
	             {
	             	system.debug('--------------------now='+now);
	                 if(eq.installationdate__c <= now)
	                 {
	                     Integer daynum=eq.installationdate__c.daysBetween(now);
	                     Double year= Math.round(daynum/365.0*10)/10.0;
	                     system.debug('--------------------year='+year);
	                     system.debug('--------------------Name='+eq.Name);
	                     eq.machineage__c=year;
	                 }
	                 else
	                 {
	                     eq.machineage__c=null;
	                 }
	             }
	         }
	         Database.update(list_equ, false);  
	     }           
     }
     global void finish(Database.BatchableContext ctx)
     {
                
      }
}