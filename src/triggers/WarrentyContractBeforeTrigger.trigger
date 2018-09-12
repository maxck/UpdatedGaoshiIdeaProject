trigger WarrentyContractBeforeTrigger on CustomObject22__c (before insert, before update) {
    
    for(CustomObject22__c c : trigger.new){
    	if (Trigger.isupdate )
    	{
    		CustomObject22__c oldContract = trigger.oldMap.get(c.Id);
    		if ((((oldContract.Approval__c == '草稿' || oldContract.Approval__c == '已拒绝') && c.Approval__c == '待审批') ||
    			(oldContract.Approval__c == '待审批' && c.Approval__c == '已审批')) && c.Field1__c == false
    		)
    		{
    			c.addError('请先上传附件，而后在进行审批或者提交审批操作！!');
    		}
    	}
    }
    
}