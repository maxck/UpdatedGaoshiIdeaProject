/*
*Creat By : Arvin
*Email: arvinxiang@frensworkz.com
*Time : 2015年03月02日
*Describe :  备件申请审批判断是否提交审批,审批通过
*/
trigger sparepart on sparepart__c (after delete, before insert, before update) 
{
	Cbl_sparepart_spstate cblspstate = new Cbl_sparepart_spstate();
	Cbl_sparepart_whetherperiod cbspwhe=new Cbl_sparepart_whetherperiod();//新建备件申请时，判断是否在保修期内
	if(Trigger.isBefore)
	{
		
		//创建备件申请的触发
		if(Trigger.isInsert)
		{
			cblspstate.insertsparepart(trigger.new);
			cbspwhe.insertWhetherPeriod(trigger.new);
		}
		
		//修改备件申请的触发
		if(Trigger.isUpdate)
		{
			cblspstate.updatesparepart(trigger.new, trigger.oldMap);
		}
	}
	
	//删除备件申请的触发
	if(Trigger.isAfter&&Trigger.isDelete)
	{
		cblspstate.deletesparepart(trigger.old);
	}
}