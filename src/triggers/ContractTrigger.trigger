trigger ContractTrigger on Contract (before insert ,before update) {
    Set<Id> setId  = new Set<Id>();
    for(Contract c : trigger.new){
        setId.add(c.Opportunity__c);
    	if (Trigger.isupdate )
    	{
    		Contract oldContract = trigger.oldMap.get(c.Id);
    		if ((((oldContract.ContractReviewStatus__c == '草稿' || oldContract.ContractReviewStatus__c == '已拒绝') && c.ContractReviewStatus__c == '待审批') ||
    			(oldContract.ContractReviewStatus__c == '待审批' && c.ContractReviewStatus__c == '已审批')) && c.Field1__c == false
    		)
    		{
    			c.addError('请先上传附件，而后在进行审批或者提交审批操作！');
    		}
    	}
    }
    List<Opportunity> opp = [select id,AccountId from Opportunity where id =: setId];
    for(Contract  c : trigger.new){
        if(opp.size() > 0 ){
            c.AccountId =  opp.get(0).AccountId ; 
        }
    }
    
    
}