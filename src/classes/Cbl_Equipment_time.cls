/**
*Create By:jmark
*TIME：2015年3月3日09:22:19
*Descripe:新建保存或更新时计算机龄
 */
public class Cbl_Equipment_time {
	//新建时
     public void insertTime(list<Equipment__c> list_equ)
     {
     	 Date now=Date.today();
         for(Equipment__c equ:list_equ)
         {
             if(equ.installationdate__c != null)
             {
                 if(equ.installationdate__c <=now)
                 {
                 	 
                     Integer daynum=equ.installationdate__c.daysBetween(now);
                     Double year= Math.round(daynum/365.0*10)/10.0;
                     system.debug('------------------year'+year);
                     equ.machineage__c=year;
                 }else
                 {
                     equ.machineage__c=null;
                 }
             }
         }
     }
     //更新时
     public void updateTime(list<Equipment__c> list_equ,map<Id,Equipment__c> map_equ)
     {
     	 list<Equipment__c> list_req=new list<Equipment__c>();
         for(Equipment__c equ:list_equ)
         {
             if(equ.installationdate__c != map_equ.get(equ.Id).installationdate__c)
             {
                 list_req.add(equ);
             }
         }
         if(list_req.size()>0)
         {
            insertTime(list_req);
         }
     }
}