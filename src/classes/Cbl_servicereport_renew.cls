/**
*Create By:jmark
*TIME：2015年2月26日10:35:25
*Descripe:设备参数更新
 */
public class Cbl_servicereport_renew {
	//新建技术服务报告更新设备参数
     public void insertRenewEquipment(list<servicereport__c> list_ser)
     {
     	 set<String> set_Id=new set<String>();
         for(servicereport__c ser:list_ser)
         {
            if(ser.EquId__c != null)
            {
                set_Id.add(ser.EquId__c);
            }
         }
         list<Equipment__c> list_equ=new list<Equipment__c>();
         if(set_Id.size()>0)
         {
            list_equ=[select Id,firstpressure__c,otherpressure__c,lasernum__c,
            hfmj__c,hfnm__c,hvv__c,lfmj__c,lfnm__c,zdnlvsmj__c,nlvsmj__c from Equipment__c where Id in:set_Id];
         }
         if(list_equ.size()>0)
         {
             for(servicereport__c ser:list_ser)
	         {
	            for(Equipment__c equ:list_equ)
	            {
	                if(ser.EquId__c == equ.Id)
	                {
	                   equ.firstpressure__c=ser.firstpressureend__c;
	                   equ.otherpressure__c=ser.otherpressureend__c;
	                   equ.lasernum__c=ser.lasernumend__c;
	                   equ.hfmj__c=ser.hfmjend__c;
	                   equ.hfnm__c=ser.hfnmend__c;
	                   equ.hvv__c=ser.hvvend__c;
	                   equ.lfmj__c=ser.lfmjend__c;
	                   equ.lfnm__c=ser.lfnmend__c;
	                   equ.zdnlvsmj__c=ser.zdnlvsmjend__c;
	                   equ.nlvsmj__c=ser.nlvsmjend__c;
	                }
	            }
	         }
	         update list_equ;
         }
     }
     //更新技术服务报告更新设备参数
     public void updateRenewEquipment(list<servicereport__c> list_ser,map<Id,servicereport__c> map_ser)
     {
         
     }
}