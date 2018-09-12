global  with sharing class SyncOrderWebservice {
    
    webservice static ExecutionResult syncOrderDataToNC(String orderId, String isFirstAccount) {
        ExecutionResult result = new ExecutionResult(); 
        //自定义配置
        Set<String> userIds = new set<String>();
        for (UserSettings__c tempUserSetings : [select id, name, UserId__c from  UserSettings__c where isActive__c = true])
        {
        	userIds.add(tempUserSetings.UserId__c);
        }
        if(String.isNotBlank(orderId))
    	{	
    		 if (isFirstAccount == '否')
    		 {
    			result.IsSuccess = false;
             	result.Message = '首营客户才能同步到NC，请确认客户信息！'; //Invalid Parameters. 
    		 }
    		 else if (userIds.contains(userinfo.getuserId()))
    		 {
				 Orderhelper.ExecutionResult excuteResult =  OrderHelper.syncOrderinfo(orderId);
				 system.debug('[Custom Log] SyncOrderWebservice sync result is ' + excuteResult);
				 result.IsSuccess = excuteResult.IsSuccess;
				 if (result.IsSuccess)
				 {
		             result.Message = '同步成功！';  		 
				 }
				 else
				 {
		             result.Message = '同步失败, 请参照同步日志！'; //Invalid Parameters. 
				 }    		 
    		 }
    		 else if (!userIds.contains(userinfo.getuserId()))
    		 {
    		 	result.IsSuccess = false;
             	result.Message = '您没有权限同步该订单！'; 
    		 }
    	}
        else
        {
            result.IsSuccess = false;
            result.Message = '参数不可用'; //Invalid Parameters. 
        }
        return result;
    }
    
    
    
    global class ExecutionResult 
    {   
        webservice boolean IsSuccess { get; set; }
        webservice String Message { get; set; }
        
        public ExecutionResult(){}
    }
}