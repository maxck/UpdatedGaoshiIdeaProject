/*
*Creat By : Arvin
*Email: arvinxiang@frensworkz.com
*Time : 2015年03月02日
*Describe :  备件明细申请审批通过并状态为已发货 自动创建出库记录，通过出库记录做库存减少
*/
trigger sparepartdetail on sparepartdetail__c (before insert,before update,after delete) 
{
	Cbl_sparepartdetail_state cblspdetail = new Cbl_sparepartdetail_state();
	if(Trigger.isBefore)
	{
		
		//新建备件明细触发
		if(Trigger.isInsert)
		{
			cblspdetail.insertspdetail(trigger.new);
		}
		
		//更新备件明细触发
		if(Trigger.isUpdate)
		{
			cblspdetail.updatespdetail(trigger.new, trigger.oldMap);
		}
	}
	//删除备件明细触发
	if(Trigger.isAfter&&Trigger.isDelete)
	{
		cblspdetail.deletespdetail(trigger.old);
	}

}