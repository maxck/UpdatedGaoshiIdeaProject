/**
*Create By:jmark
*TIME：2015年3月3日09:22:19
*Descripe:在保修期内，合约产品，全保设备，客户不是VIP时，
 *当设备手动选择生成巡检复选框时，按3个月为间隔在保修期限内生成若干条巡检记录。
 *如果是Vip客户的设备，当设备手动选择生成巡检复选框时，按1个月为间隔在保修期限内生成若干条巡检记录。
 */
trigger Warrantyproduct on Warrantyproduct__c (after insert,before update, after update,after delete,after undelete) {
    Cbl_Warrantyproduct_insertRequest cwpir=new Cbl_Warrantyproduct_insertRequest();
    if(trigger.isAfter)
    {
    	if(trigger.isInsert)
    	{
    	     cwpir.insertRequest(trigger.new);
    	}
        if(trigger.isUpdate)
        {
            cwpir.updateRequest(trigger.new, trigger.oldMap);
        }
    }
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            cwpir.stopRequest(trigger.new, trigger.oldMap);
        }
    }
    Cbl_Warrantyproduct_updateEquipment cwuep = new Cbl_Warrantyproduct_updateEquipment();//实时更新设备最新保修终止日期
    if(trigger.isAfter)
    {
        if(trigger.isInsert || trigger.isUndelete || trigger.isUpdate)
        {
           cwuep.handleWp(trigger.new);
        }
        if(trigger.isDelete)
        {
           cwuep.handleWp(trigger.old);
        }
    }
}