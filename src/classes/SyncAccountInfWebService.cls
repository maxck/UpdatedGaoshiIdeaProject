global with sharing class SyncAccountInfWebService {
    
    webservice static ExecutionResult syncAccountInfo(String accountId) {
        ExecutionResult result = new ExecutionResult();
		result.IsSuccess = true;
        
        if(String.isNotBlank(accountId))
    	{	
			 AccountHelper.syncAccountInfo(accountId);
			 result.IsSuccess = true;
			 result.Message = accountId;
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