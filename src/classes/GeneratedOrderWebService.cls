global with sharing class GeneratedOrderWebService {
    
    webservice static ExecutionResult generatedOrder(String contractId) {
        ExecutionResult result = new ExecutionResult();
		result.IsSuccess = true;
	    result.Message = '成功创建订单！';   
        
        List<Order> newOrders = new List<Order>();
	    String warenttyRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('技术服务延保销售').getRecordTypeId();
	    String domesticTradeRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('设备内贸销售').getRecordTypeId();
	    String overseasTradeRecordTypeId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('设备外贸销售').getRecordTypeId();
	    Set<Id> contractIds = new Set<Id>();
	    Map<String, List<ConfigurationList__c>> contractId2ConfigLists = new Map<String, List<ConfigurationList__c>>();
	    Map<Id, ConfigurationList__c> Id2ConfigurationLists = new Map<Id, ConfigurationList__c>();
        
        Contract newContract = [select id, AccountId, FinalCustomer_del__c, ScopeLicense__c, Financing__c, customerfirst__c, Yanbao__c, StartDate, ContractCharacter__c, 
        						ContractAmount__c, HospitalBusinessLicense__c, HospitalPracticeApproval__c, WarrantyPeriod__c, AccessoriesWarrantyPrice__c, PublicPrivate__c, 
        						Classify__c, ClassifyII__c, ClassifyIII__c, StandardAcceptanceClause__c, Owner__c, DebtHolders__c, PerformancEsplit__c, ChannelDeliveryMethod__c, 
        						OrderClerk__c, WhetherOA__c, MarketingOrganizing__c, OrderNumber__c
        						from contract where id = :contractId];
        if (newContract.OrderNumber__c > 0)
        {
        	result.IsSuccess = false;
	    	result.Message = '已经生成订单，请检查数据!'; 
        }
        else if (newContract.OrderNumber__c <= 0)
        {
        	for (ConfigurationList__c tempConfigurationList : [select id, name, Opportuniy__c, MainQuantity__c, TheMainCurrencyTaxPrice__c, ProductName__c, Productname66__c, configurationList__c,
                            TotalTaxAmount__c, Unit__c, 
                            ContractReview__c, 
                            TaxInclusive__c, Model__c, FinalPrice__c, DeductionCategory__c, discount__c, ReceiptCountry__c, Quantity__c, Taxfreeprice__c,
                            NoTaxAmount__c, TotalCurrencyTax__c, LocalCurrencyTaxPrice__c, StandardPrice__c, RegistrationNumber__c, MaterialModel__c,
                            MaterialCoding__c, LogisticsOrganization__c, TaxRate__c, TaxCode__c, tax__c, SystemStandardTotalPrice__c, order__c, EquipmentStandardPrice__c,
                            EquipmentTotalPrice__c, EquipmentDiscount__c, CommonName__c, project__c, ProjectInformation__c, ProductNumber__c,
                            (select id, name, product__c, NumberTypeIN__c, SystemStandardPricePer__c, ProductNumber__c from ConfigurationList__r), //主机
                            (select Id, name, product__c, NumberTypeIN__c, SystemStandardPricePer__c, ProductNumber__c from Configurationlist44__r),//必选配件
                            (select Id, name, ProductName__c, ProductStatus__c, NumberTypeIN__c, SystemStandardPricePer__c,SystemStandardTotalPrice__c, ProductNumber__c from ConfigurationList11__r),//可选配件
                            (select Id, name, ExtendWarrantyPrice__c, UnitPrice__c, TotalPrice__c, ExtendMonth__c, SystemStandardPricePer__c, SystemStandardPriceTotal__c from ConfigurationListEW__r)//延保
                from ConfigurationList__c where ContractReview__c = :contractId])
		    {   
		        Id2ConfigurationLists.put(tempConfigurationList.id, tempConfigurationList);
		        if (contractId2ConfigLists.containsKey(tempConfigurationList.ContractReview__c))
		        {
		            List<ConfigurationList__c> configLists = contractId2ConfigLists.get(tempConfigurationList.ContractReview__c);
		            configLists.add(tempConfigurationList);
		            contractId2ConfigLists.put(tempConfigurationList.ContractReview__c, configLists);
		        }
		        else
		        {
		            contractId2ConfigLists.put(tempConfigurationList.ContractReview__c, new List<ConfigurationList__c>{tempConfigurationList});
		        }
		        
		    }
		    if (newContract != null)
		    {
		    	Order newOrder = new Order(AccountId = newContract.AccountId,//客户 
	                            FinalCustomer__c = newContract.FinalCustomer_del__c, //最终用户
	                            ScopeLicense__c = newContract.ScopeLicense__c, //是否在许可范围内
	                            Financing__c = newContract.Financing__c, //是否融资
	                            FirstCamp__c = newContract.customerfirst__c,//是否首营 
	                            WarrantyExtension__c = newContract.Yanbao__c,//是否延保
	                            EffectiveDate = (newContract.StartDate == null ? date.today() : newContract.StartDate),
	                            Status = 'Draft',
	                            ContractCharacter__c = newContract.ContractCharacter__c,//合同性质
	                            ContractAmount__c = newContract.ContractAmount__c,//合同金额(万)
	                            HospitalBusinessLicense__c = newContract.HospitalBusinessLicense__c,//医院的营业执照
	                            HospitalPracticeApproval__c = newContract.HospitalPracticeApproval__c,//医院执业批准书
	                            WarrantyPeriod__c = newContract.WarrantyPeriod__c,//保修期（月）
	                            AccessoriesWarrantyPrice__c = newContract.AccessoriesWarrantyPrice__c,//配件保修价格
	                            PublicPrivate__c = newContract.PublicPrivate__c,//公立/民营
	                            Classify__c = newContract.Classify__c,//分类I
	                            ClassifyII__c = newContract.ClassifyII__c,
	                            ClassifyIII__c = newContract.ClassifyIII__c,
	                            StandardAcceptanceClause__c = newContract.StandardAcceptanceClause__c,//是否标准验收条款
	                           Merchandiser__c=newContract.Owner__c,//归属人
	                           ResponsiblePerson__c=newContract.DebtHolders__c,//催款责任人
	                           PerformanceSplit__c=newContract.PerformancEsplit__c,//业绩绩效拆分
	                           ChannelDelivery__c=newContract.ChannelDeliveryMethod__c,//渠道交付方式
	                           OrderClerk__c=newContract.OrderClerk__c,//订单业务员
	                            OA__c=newContract.WhetherOA__c,//合同是否上传OA
	                            MarketingOrganizing__c = newContract.MarketingOrganizing__c,//销售组织
	                            contractId = newContract.Id
	                            );
		        Order newWarrentyOrder = new Order(AccountId = newContract.AccountId,//客户 
		                    FinalCustomer__c = newContract.FinalCustomer_del__c, //最终用户
		                    ScopeLicense__c = newContract.ScopeLicense__c, //是否在许可范围内
		                    Financing__c = newContract.Financing__c, //是否融资
		                    FirstCamp__c = newContract.customerfirst__c,//是否首营 
		                    WarrantyExtension__c = newContract.Yanbao__c,//是否延保
		                    EffectiveDate = (newContract.StartDate == null ? date.today() : newContract.StartDate),
		                    Status = 'Draft',
		                    ContractCharacter__c = newContract.ContractCharacter__c,//合同性质
		                    ContractAmount__c = newContract.ContractAmount__c,//合同金额(万)
		                    HospitalBusinessLicense__c = newContract.HospitalBusinessLicense__c,//医院的营业执照
		                    HospitalPracticeApproval__c = newContract.HospitalPracticeApproval__c,//医院执业批准书
		                    WarrantyPeriod__c = newContract.WarrantyPeriod__c,//保修期（月）
		                    AccessoriesWarrantyPrice__c = newContract.AccessoriesWarrantyPrice__c,//配件保修价格
		                    PublicPrivate__c = newContract.PublicPrivate__c,//公立/民营
		                    Classify__c = newContract.Classify__c,//分类I
		                    ClassifyII__c = newContract.ClassifyII__c,
		                    ClassifyIII__c = newContract.ClassifyIII__c,
		                    StandardAcceptanceClause__c = newContract.StandardAcceptanceClause__c,//是否标准验收条款
		                    Merchandiser__c=newContract.Owner__c,//归属人
		                    ResponsiblePerson__c=newContract.DebtHolders__c,//催款责任人
		                    PerformanceSplit__c=newContract.PerformancEsplit__c,//业绩绩效拆分
		                    ChannelDelivery__c=newContract.ChannelDeliveryMethod__c,//渠道交付方式
		                    OrderClerk__c=newContract.OrderClerk__c,//订单业务员
		                     OA__c=newContract.WhetherOA__c,//合同是否上传OA
		                     MarketingOrganizing__c = newContract.MarketingOrganizing__c,//销售组织
		                    contractId = newContract.Id
		                    );
		        if (newContract.Yanbao__c == '是')
		        {
		            newWarrentyOrder.recordtypeId = warenttyRecordTypeId;
		            newOrders.add(newWarrentyOrder);
		        }
		        if (newContract.ContractCharacter__c == '内贸')
		        {
		            newOrder.recordtypeId = domesticTradeRecordTypeId;
		            newOrders.add(newOrder);
		        }
		        else if (newContract.ContractCharacter__c == '外贸')
		        {
		            newOrder.recordtypeId = overseasTradeRecordTypeId;
		            newOrders.add(newOrder);
		        }
		    }
		    //创建订单
		    system.debug('[Custom Log] newOrders is ' + newOrders);
		    system.debug('[Custom Log] newOrders size is ' + newOrders.size());
		    if (newOrders.size() > 0)
		    {	
		    	try{
			        insert newOrders;
		    	}
		    	catch(Exception e)
		    	{
		    		result.IsSuccess = false;
		    		result.Message = '创建订单失败，请重试！';   
		    	}
		        system.debug('[Custom Log] after insert newOrders is ' + newOrders);
		        // copy config list from contract.
		        List<ConfigurationList__c> newConfigurationListForOrders = new List<ConfigurationList__c>();
		        for (Order tempOrder : newOrders)
		        {
		            if (contractId2ConfigLists.containsKey(tempOrder.contractid))
		            {   
		                for (ConfigurationList__c tempConfigurationList : contractId2ConfigLists.get(tempOrder.contractid))
		                {   
		                    ConfigurationList__c newConfigurationList = new ConfigurationList__c();
		                    newConfigurationList = tempConfigurationList.clone(false, true, false, false);
		                    newConfigurationList.order__c = tempOrder.Id;
		                    newConfigurationList.ContractReview__c = null;
		                    newConfigurationList.Opportuniy__c = null;
		                    newConfigurationListForOrders.add(newConfigurationList);
		                }
		            }
		        }
		        if (newConfigurationListForOrders.size() > 0)
		        {
		            insert newConfigurationListForOrders;
		            List<Host__c> hostlists = new List<Host__c>();
		            List<OptionalAccessories__c> OptionalAccessoriesLists = new List<OptionalAccessories__c>();
		            List<TheRequiredAccessories__c> TheRequiredAccessorieslists = new List<TheRequiredAccessories__c>();
		            List<ExtendedWarrantyProduct__c> extendProducts = new List<ExtendedWarrantyProduct__c>();
		            for (ConfigurationList__c existConfigurationList : newConfigurationListForOrders)
		            {
		                if (Id2ConfigurationLists.containsKey(existConfigurationList.getCloneSourceId()))
		                {
		                    ConfigurationList__c sourceConfigurationList = Id2ConfigurationLists.get(existConfigurationList.getCloneSourceId());
		                    Host__c newHost = new Host__c();
		                    OptionalAccessories__c newOptionalAccessories = new OptionalAccessories__c();
		                    TheRequiredAccessories__c newTheRequiredAccessories = new TheRequiredAccessories__c();
		                    ExtendedWarrantyProduct__c newExtendedWarrantyProduct = new ExtendedWarrantyProduct__c();
		                    
		                    for (Host__c tempHost : sourceConfigurationList.ConfigurationList__r)
		                    {
		                        newHost = tempHost.clone(false, true, false, false);
		                        newHost.ConfigurationList__c = existConfigurationList.Id;
		                        hostlists.add(newHost);
		                    }
		                    
		                    for (OptionalAccessories__c tmepOptionalAccessories : sourceConfigurationList.ConfigurationList11__r)
		                    {
		                        newOptionalAccessories = tmepOptionalAccessories.clone(false, true, false, false);
		                        newOptionalAccessories.ConfigurationList__c = existConfigurationList.Id;
		                        OptionalAccessoriesLists.add(newOptionalAccessories);
		                    }
		                    
		                    for (TheRequiredAccessories__c tempTheRequiredAccessories : sourceConfigurationList.Configurationlist44__r)
		                    {
		                        newTheRequiredAccessories = tempTheRequiredAccessories.clone(false, true, false, false);
		                        newTheRequiredAccessories.ConfigurationLst__c = existConfigurationList.Id;
		                        TheRequiredAccessorieslists.add(newTheRequiredAccessories);
		                    }
		                    
		                    for (ExtendedWarrantyProduct__c tempExtendedWarrantyProduct : sourceConfigurationList.ConfigurationListEW__r)
		                    {
		                        newExtendedWarrantyProduct = tempExtendedWarrantyProduct.clone(false, true, false, false);
		                        newExtendedWarrantyProduct.ConfigurationList__c = existConfigurationList.Id;
		                        extendProducts.add(newExtendedWarrantyProduct);
		                    }
		                    
		                }
		            }
		            if (hostlists.size() > 0) insert hostlists;
		            if (OptionalAccessoriesLists.size() > 0) insert OptionalAccessoriesLists;
		            if (TheRequiredAccessorieslists.size() > 0) insert TheRequiredAccessorieslists;
		            if (extendProducts.size() > 0) insert extendProducts;
		            
		        }
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