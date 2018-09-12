global with sharing class GeneratedQCWebservice {
    
    public static String hospitalRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('医院').getRecordTypeId();
    public static String Equipment1RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('准分子检查设备').getRecordTypeId();
    public static String Equipment2RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('准分子设备').getRecordTypeId();
    public static String Equipment3RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('常规设备资产').getRecordTypeId();
    public static String Equipment4RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('欧堡设备').getRecordTypeId();
    public static String Equipment5RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('自动检眼仪设备').getRecordTypeId();
    public static String Equipment6RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('非本公司客户资产').getRecordTypeId();
    public static String Equipment7RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('飞白检查设备').getRecordTypeId();
    public static String Equipment8RecordTypeId = Schema.SObjectType.Equipment__c.getRecordTypeInfosByName().get('飞白设备').getRecordTypeId();
    public static String bigRecordTypeId = Schema.SObjectType.polling__c.getRecordTypeInfosByName().get('大型设备巡检').getRecordTypeId();
    public static String normalRecordTypeId = Schema.SObjectType.polling__c.getRecordTypeInfosByName().get('常规设备巡检').getRecordTypeId();
    
    webservice static ExecutionResult generatedQC(List<String> diviceIds) {
        ExecutionResult result = new ExecutionResult(); 
        
        //大型类型
        Set<String> bigTypes = new Set<String>{Equipment1RecordTypeId, Equipment2RecordTypeId, Equipment5RecordTypeId, Equipment7RecordTypeId, Equipment8RecordTypeId};
        //常规类型
        Set<String> normalTypes = new Set<String>{Equipment3RecordTypeId, Equipment4RecordTypeId, Equipment6RecordTypeId};
        
        List<polling__c> newpollings = new List<polling__c>( );
        
        Set<String> accountIds = new Set<String>();
        for (Equipment__c tempEquipment : [select id, name, customer__c, warrantyEnd__c, UsefulLife__c, customer__r.name from Equipment__c where id in :diviceIds ])
        {
        	accountIds.add(tempEquipment.customer__c);
        }
        //查找符合条件的客户
        Set<String> rightAccountIds = new Set<String>();
        for (Account tempAccount : [select id, name from account where id in :accountIds and recordtypeid = :hospitalRecordTypeId])
        {
        	rightAccountIds.add(tempAccount.Id);
        }
        
        //创建巡检
        for (Equipment__c tempEquipment : [select id, name, customer__c, warrantyEnd__c, UsefulLife__c, customer__r.name, recordtypeid from Equipment__c where id in :diviceIds ])
        {	
        	if (rightAccountIds.contains(tempEquipment.customer__c))
        	{	
        		polling__c temppolling = new polling__c();
        		if (tempEquipment.recordtypeid != Equipment6RecordTypeId)
				{	
					temppolling = new polling__c(WarrantyExpirationDate__c = tempEquipment.warrantyEnd__c, DeviseSerialNumber__c = tempEquipment.Id, Accunt1__c = tempEquipment.customer__c, EquipmentLife__c = tempEquipment.UsefulLife__c);
				}
				else
				{
					temppolling = new polling__c(DeviseSerialNumber__c = tempEquipment.Id, Accunt1__c = tempEquipment.customer__c);
				}
				//大型
				if (bigTypes.contains(tempEquipment.recordtypeid))
				{
					temppolling.recordtypeid = bigRecordTypeId;
				}
				//常规
				else if (normalTypes.contains(tempEquipment.recordtypeid))
				{
					temppolling.recordtypeid = normalRecordTypeId;
				}
				newpollings.add(temppolling);  
        		
        	}
        }
        
        if (newpollings.size() > 0)
        {
        	Database.SaveResult[] newPollingResult = Database.insert(newpollings, false);  
        	Integer errorNum = 0;
        	Integer successNum = 0;
        	Set<String> errormsgs = new Set<String>();
	        for(Database.SaveResult sr : newPollingResult)
	        {
	        	if(!sr.isSuccess())
	            {
	           		errorNum++;
	           		for (Database.Error err : sr.getErrors())
	           		{
		           		errormsgs.add(err.getMessage());
	           		}
	            }
	            else
	            {
	           		successNum++;
	            }
	        }
	        List<String> errormsgList = new List<String>();
	        errormsgList.addAll(errormsgs);
	        result.IsSuccess = true;
	        result.Message = '成功创建' + successNum + '条，失败' + errorNum + '条' ;
	        if (errorNum > 0)
	        {
	        	result.Message =  result.Message + ', 错误信息是' + String.join(errormsgList, ',');
	        }
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