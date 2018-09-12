/*******************************************
**Create By: Arvin
**Time: ‎2015‎年‎2‎月‎26‎日16:28:50
**Describe: 自动增加修改库存数量，并产生出入库记录
********************************************/
trigger outinstock on outinstock__c (before insert, before update,after delete) 
{
	Cbl_outinstock_updatestock cbloistock = new Cbl_outinstock_updatestock();
	if(Trigger.isBefore)
	{
		
		if(Trigger.isInsert)
		{
			cbloistock.insertStock(trigger.new);
		}
		
		if(Trigger.isUpdate)
		{
			cbloistock.updateStock(trigger.new,Trigger.oldMap);
		}
	}
	if(Trigger.isAfter&&Trigger.isDelete)
	{
		cbloistock.deleteStock(trigger.old);
	}
}