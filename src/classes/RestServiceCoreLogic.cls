public class RestServiceCoreLogic {
    
    
    public static RestServiceUtil.Result createFirstAccount(RestServiceUtil.FirstAccountRequestParam firstAccountRequestParam)
    {
        RestServiceUtil.Result result = new RestServiceUtil.Result();
        Account tempAccount = new Account();
        try
        {
	        tempAccount = [select id, name, CRMCodingFormula__c from account where CRMCodingFormula__c = :firstAccountRequestParam.CRMCoding limit 1];
        }
        catch(exception e)
        {
        	result.success = false;
            result.message = '客户编码无效。';
            return result;
        }
        CustomerFirstManagement__c newCustomerFirstManagement = new CustomerFirstManagement__c();
        newCustomerFirstManagement.Name__c = tempAccount.Id;
        newCustomerFirstManagement.TheFirstProduct__c = firstAccountRequestParam.TheFirstProduct;
        newCustomerFirstManagement.FieldVisitQualified__c = firstAccountRequestParam.FieldVisitQualified;
        newCustomerFirstManagement.CustomerFirst__c = firstAccountRequestParam.CustomerFirst;
        newCustomerFirstManagement.ProposedSpecies__c = firstAccountRequestParam.ProposedSpecies;
        newCustomerFirstManagement.PermitNumber__c = firstAccountRequestParam.PermitNumber;
        newCustomerFirstManagement.QualityManager__c = firstAccountRequestParam.QualityManager;
        newCustomerFirstManagement.SalesOrganization__c = firstAccountRequestParam.SalesOrganization;
        newCustomerFirstManagement.ThroughTheFirstCamp__c = firstAccountRequestParam.ThroughTheFirstCamp;
        newCustomerFirstManagement.CustomerCode__c = firstAccountRequestParam.CRMCoding;
        
        
        try
        {
            insert newCustomerFirstManagement;
            result.success = true;
            result.message = '首营信息创建成功。';
        }
        catch(Exception e)
        {
            result.success = false;
            result.message = '创建首营客户信息失败：' + e;
        }
        
        return result;
    }
    
    public static RestServiceUtil.Result createProduct(RestServiceUtil.ProductRequestParam productRequestParam)
    {
        RestServiceUtil.Result result = new RestServiceUtil.Result();
        
        
        Product3__c newProduct = new Product3__c();
        newProduct.OpenQuotationUnitPrice__c = productRequestParam.OpenQuotationUnitPrice;
        newProduct.TotalPrice0fOpenQuotation__c = productRequestParam.TotalPrice0fOpenQuotation;
        newProduct.OriginalInventoryCoding__c = productRequestParam.OriginalInventoryCoding;
        newProduct.Model__c = productRequestParam.Model;
        newProduct.Describe__c = productRequestParam.Describe;
        newProduct.Number__c = productRequestParam.NumberString;
        newProduct.NewInventoryCoding__c = productRequestParam.NewInventoryCoding;
        newProduct.Type__c = productRequestParam.Type;
        
        newProduct.TaxRate__c = productRequestParam.TaxRate;
        newProduct.Name = RestServiceUtil.replaceSpcialChart(productRequestParam.Name, '&amp;', '&');
        newProduct.MaterialCoding__c = productRequestParam.MaterialCoding;
        newProduct.MaterialClassification__c = productRequestParam.MaterialClassification;
        newProduct.PrimaryUnit__c = productRequestParam.PrimaryUnit;
        newProduct.ProductLine__c = productRequestParam.ProductLine;
        newProduct.InventoryCommonName__c = RestServiceUtil.replaceSpcialChart(productRequestParam.InventoryCommonName, '&amp;', '&');
        newProduct.RegistrationNumber__c = productRequestParam.RegistrationNumber;
        try
        {   
            List<Product3__c> exsitProducts = [select id from Product3__c where MaterialCoding__c = :productRequestParam.MaterialCoding];
            Product3__c exsitProduct;
            if (exsitProducts.size() > 0)
            {
                exsitProduct = exsitProducts.get(0);
                newProduct.id = exsitProduct.Id;
                update newProduct;
            }
            else
            {
                insert newProduct;
            
            }
            result.success = true;
            result.message = '产品信息创建成功。';
        }
        catch(Exception e)
        {
            result.success = false;
            result.message = '创建产品信息失败：' + e;
        }
        
        return result;
    }
    
    /*
    *发货
    */
    public static RestServiceUtil.Result createOrUpdateDeliveryInfo(RestServiceUtil.DeliveryInfoRequestParam deliveryRequestParam)
    {
        RestServiceUtil.Result result = new RestServiceUtil.Result();
        
        DeliveryInformation__c tempDeliveryInformation = new DeliveryInformation__c();
        tempDeliveryInformation.ProductNumber__c = deliveryRequestParam.ProductNumber;
        tempDeliveryInformation.ShipableQuantity__c = deliveryRequestParam.ShipableQuantity;
        tempDeliveryInformation.ShippedQuantity__c = deliveryRequestParam.ShippedQuantity;
        tempDeliveryInformation.ProductName__c = deliveryRequestParam.ProductName;
        // get order id according to order number.
        try
        {   
            Order currentOrder = null;
            currentOrder = [select id from order where OrderNumber = :deliveryRequestParam.OrderNumber];
            tempDeliveryInformation.order1__c = currentOrder.Id;
        }
        catch(exception e)
        {
            result.success = false;
            result.message = '该订单号码不存在：' + e;
            return result;
        }
        
        try
        {
            insert tempDeliveryInformation;
            result.success = true;
            result.message = '发货信息更新或者创建成功。';
        }
        catch(Exception e)
        {
            result.success = false;
            result.message = '发货信息创建失败：' + e;
        }
        
        return result;
    }
    
    /*
    *回款
    */
    public static RestServiceUtil.Result createOrUpdatePaybackInfo(RestServiceUtil.PayBackinfoRequestParam payBackRequestParam)
    {
        RestServiceUtil.Result result = new RestServiceUtil.Result();
        
        ReturnDetails__c tempReturnDetails = new ReturnDetails__c();
        tempReturnDetails.RepaymentAmount__c = payBackRequestParam.RepaymentAmount;
        try
        {
	        tempReturnDetails.RemittanceDate__c = payBackRequestParam.RemittanceDate;
        }
        catch(Exception e)
        {
        	result.success = false;
            result.message = '时间格式不正确，请修复：' + e;
            return result;
        }
        
        // get order id according to order number.
        try
        {   
            Order currentOrder = null;
            currentOrder = [select id from order where OrderNumber = :payBackRequestParam.OrderNumber];
            tempReturnDetails.Order__c = currentOrder.Id;
        }
        catch(exception e)
        {
            result.success = false;
            result.message = '该订单号码不存在：' + e;
            return result;
        }
        
        
        try
        {
            insert tempReturnDetails;
            result.success = true;
            result.message = '回款信息创建成功。';
        }
        catch(Exception e)
        {
            result.success = false;
            result.message = '回款信息更创建失败：' + e;
        }
        
        return result;
    }
    public static Date formateDateString (String stringDate, String splitChart)
	{   
	    List<String> dateString = stringDate.split(splitChart);
	    Date result = date.today();
	    result = Date.newinstance(Integer.valueOf(dateString[0]), Integer.valueOf(dateString[1]), Integer.valueOf(dateString[2]));
	    return result;
	}
	//2018-08-28 17:38:15
	public static Datetime formateDateTimeString (String stringDateTime, String splitDateChart)
	{   
	    List<String> splitString = stringDateTime.split(' ');
		Datetime result = datetime.now();
		List<String> dateString = splitString[0].split(splitDateChart);
		List<String> timeString = splitString[1].split(':');
		result = DateTime.newinstance(Integer.valueOf(dateString[0]), Integer.valueOf(dateString[1]), Integer.valueOf(dateString[2]), 
									  Integer.valueOf(timeString[0]), Integer.valueOf(timeString[1]), Integer.valueOf(timeString[2]));
	    return result;
	}
    
}