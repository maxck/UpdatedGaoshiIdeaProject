/**
*Create By:jmark
*TIME：2015年3月4日15:24:23
*Descripe:新建备件申请时，判断是否在保修期内
 */
public class Cbl_sparepart_whetherperiod {
	//新建记录时
    public void insertWhetherPeriod(list<sparepart__c> list_spa)
    {
        for(sparepart__c spa:list_spa)
        {
            //判断是否在设备合同保修期内
            servicerequest__c ser=[select requesttime__c,Equipment__c,Equipment__r.warrantySatart__c,Equipment__r.warrantyEnd__c from servicerequest__c where Id=:spa.servicerequest__c];
            if(ser.Equipment__r.warrantySatart__c != null && ser.Equipment__r.warrantyEnd__c != null)
            {
                 if(ser.requesttime__c >= ser.Equipment__r.warrantySatart__c && ser.requesttime__c <= ser.Equipment__r.warrantyEnd__c)
                 {
                     spa.Whetherthewarrantyperiod__c='是';
                 }
                 else
                 {
                     spa.Whetherthewarrantyperiod__c='否';
                 }
            }
            //判断是否在产品合约保修期内
            list<Warrantyproduct__c> list_war=[select Warrantystartdate__c,Warrantyenddate__c from Warrantyproduct__c where Equipment__c = :ser.Equipment__c];
            if(list_war != null && list_war.size()>0)
            {
                for(Warrantyproduct__c war:list_war)
                {
                    if(war.Warrantystartdate__c != null && war.Warrantyenddate__c != null)
                    {
                         if(ser.requesttime__c >= war.Warrantystartdate__c && ser.requesttime__c <= war.Warrantyenddate__c)
		                 {
		                     spa.Whetherthewarrantyperiod__c='是';
		                 }
                    }
                }
            }
        }
    }
}