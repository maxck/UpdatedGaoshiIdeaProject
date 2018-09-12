/**
*Create By:jmark
*TIME：2015年3月3日09:22:19
*Descripe:在保修期内，设备保修，全保设备，客户不是VIP时，
 *当设备手动选择生成巡检复选框时，按3个月为间隔在保修期限内生成若干条巡检记录。
 *如果是Vip客户的设备，当设备手动选择生成巡检复选框时，按1个月为间隔在保修期限内生成若干条巡检记录。
 */
trigger Equipment on Equipment__c (before insert,after insert,before update, after update) {
	Cbl_Equipment_InsertRequest ceir=new Cbl_Equipment_InsertRequest();
	Cbl_Equipment_time cet=new Cbl_Equipment_time();
    if(trigger.isAfter)
    {
    	if(trigger.isInsert)
    	{
    	     ceir.insertRequest(trigger.new);
    	}
        if(trigger.isUpdate)
        {
            ceir.updateRequest(trigger.new, trigger.oldMap);
        }
    }
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            ceir.stopRequest(trigger.new, trigger.oldMap);
            cet.updateTime(trigger.new, trigger.oldMap);
        }
        if(trigger.isInsert)
        {
            cet.insertTime(trigger.new);
        }
    }
}