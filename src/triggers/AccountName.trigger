/**
*Create By:jmark
*TIME：2015年2月26日09:14:18
*Descripe:客户查重，根据客户名字查重并提示
 */
trigger AccountName on Account (before insert, before update) {
	if(trigger.isBefore)
	{
		Cbl_Account_Name cblaccname=new Cbl_Account_Name();
	    if(trigger.isInsert)
	    {
	        cblaccname.insertCustomerRechecking(trigger.new);
	    }
	    if(trigger.isUpdate)
	    {
	        cblaccname.updateCustomerRechecking(trigger.new, trigger.oldMap);
	    }
	}

}