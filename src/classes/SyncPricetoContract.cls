global class SyncPricetoContract implements Database.Batchable<sObject>, Schedulable{
 
	global void execute(SchedulableContext sc) {
        SyncPricetoContract temp = new SyncPricetoContract();
        database.executeBatch(temp, 10);
    }
    
    public String query = '';
    
    public SyncPricetoContract ()
    {
    	query = 'select id, ContractAmount__c, EquipmentBasePrice__c from contract ';
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<contract> scope)
    {	
    	Map<String, Decimal> contractId2FinalPrice = new Map<String, Decimal>();//成交总价
    	Map<String, Decimal> contractId2Price = new Map<String, Decimal>();//设备基准总价
    	for (ConfigurationList__c tempConfigurationList : [select id, FinalPrice__c, EquipmentStandardPrice__c, ContractReview__c from ConfigurationList__c where ContractReview__c in :scope])
    	{
    		tempConfigurationList.FinalPrice__c = (tempConfigurationList.FinalPrice__c == null ? 0 : tempConfigurationList.FinalPrice__c);
    		tempConfigurationList.EquipmentStandardPrice__c = (tempConfigurationList.EquipmentStandardPrice__c == null ? 0 : tempConfigurationList.EquipmentStandardPrice__c);
    		//成交总价
    		if (contractId2FinalPrice.containsKey(tempConfigurationList.ContractReview__c))
    		{
    			Decimal finalPrice = contractId2FinalPrice.get(tempConfigurationList.ContractReview__c);
    			finalPrice = finalPrice + tempConfigurationList.FinalPrice__c;
    			contractId2FinalPrice.put(tempConfigurationList.ContractReview__c, finalPrice);
    		}
    		else
    		{
    			contractId2FinalPrice.put(tempConfigurationList.ContractReview__c, tempConfigurationList.FinalPrice__c);
    		}
    		//设备基准总价
    		if (contractId2Price.containsKey(tempConfigurationList.ContractReview__c))
    		{
    			Decimal equipmentStandardPrice = contractId2Price.get(tempConfigurationList.ContractReview__c);
    			equipmentStandardPrice = equipmentStandardPrice + tempConfigurationList.EquipmentStandardPrice__c;
    			contractId2Price.put(tempConfigurationList.ContractReview__c, equipmentStandardPrice);
    		}
    		else
    		{
    			contractId2Price.put(tempConfigurationList.ContractReview__c, tempConfigurationList.EquipmentStandardPrice__c);
    		}
    	}
    	List<Contract> updateContracts = new List<Contract>();
    	for (Contract tempContract : scope)
    	{
    		updateContracts.add(new Contract(Id = tempContract.Id, ContractAmount__c = (contractId2FinalPrice.containsKey(tempContract.Id) ? contractId2FinalPrice.get(tempContract.Id) : 0), 
    										EquipmentBasePrice__c = (contractId2Price.containsKey(tempContract.Id) ? contractId2Price.get(tempContract.Id) : 0)));
    	}
    	
    	if (updateContracts.size() > 0)
    	{
    		Database.update(updateContracts, false);
    	}
    } 
    
    global void finish(Database.BatchableContext BC){}
}