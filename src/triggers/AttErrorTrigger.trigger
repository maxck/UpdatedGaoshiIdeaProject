trigger AttErrorTrigger on CustomObject20__c (before insert,before update) {
	 for(CustomObject20__c c : trigger.new){
      if (Trigger.isupdate )
      {
        CustomObject20__c oldCus = trigger.oldMap.get(c.Id);
        if ((((oldCus.Approval__c == '草稿' || oldCus.Approval__c == '已拒绝') && c.Approval__c == '待审批') ||
    			(oldCus.Approval__c == '待审批' && c.Approval__c == '已审批')) && c.Field1__c == false
    		)
        {
          c.addError('请先上传附件，而后在进行审批或者提交审批操作！!');
        }
      }
    }
}