trigger ServiceGroup on servicegroup__c (before update,before insert,after insert) {
	
	Cbl_ServiceGroup_Share cblServiceGroupShare = new Cbl_ServiceGroup_Share();
	
	if(trigger.isBefore)
	{
		if(trigger.isBefore)
		{
			System.debug('是否进入1。。。。。。');
			cblServiceGroupShare.insertServiceGroup(trigger.new);
		}
		if(trigger.isUpdate)
		{
			cblServiceGroupShare.updateServiceGroup(trigger.new, trigger.oldMap);
		}
	}
	if(trigger.isAfter && trigger.isInsert)
	{
	    Cbl_ServiceGroup_sendEmail csge=new Cbl_ServiceGroup_sendEmail();
	    csge.insertSendEmail(trigger.new);
	}

}