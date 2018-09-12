public class RestServiceUtil {
    
    public static FirstAccountRequestParam parseFirstAccountRequest(String fristAccountRquestXML)
    {
        FirstAccountRequestParam firstAccountReuqestParam = new FirstAccountRequestParam();
        Result tempResult = new Result();
        try{
            XmlStreamReader reader = new XmlStreamReader(fristAccountRquestXML);
            while(reader.hasNext())
            {   
                //产品是否首营
                try{
                    if(reader.getLocalName() == 'TheFirstProduct')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.TheFirstProduct = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                    tempResult.message = '产品是否首营(TheFirstProduct)参数异常：TheFirstProduct,，或者参数格式错误错误 (' + e + ')';
                    tempResult.success = false;
                    firstAccountReuqestParam.result = tempResult;
                    return firstAccountReuqestParam;
                }
                //实地考察合格
                try{
                    if(reader.getLocalName() == 'FieldVisitQualified')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.FieldVisitQualified = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                //客户是否首营
                try{
                    if(reader.getLocalName() == 'CustomerFirst')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.CustomerFirst = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                    tempResult.message = '客户是否首营(CustomerFirst)参数异常：CustomerFirst为空,，或者参数格式错误错误 (' + e + ')';
                    tempResult.success = false;
                    firstAccountReuqestParam.result = tempResult;
                    return firstAccountReuqestParam;
                }
                 //拟供品种
                try{
                    if(reader.getLocalName() == 'ProposedSpecies')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.ProposedSpecies = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                 //许可证号
                try{
                    if(reader.getLocalName() == 'PermitNumber')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.PermitNumber = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                
                 //质量负责人
                try{
                    if(reader.getLocalName() == 'QualityManager')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.QualityManager = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                 //客户编码
                try{
                    if(reader.getLocalName() == 'CRMCoding')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.CRMCoding = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                    tempResult.message = '客户编码(CRMCoding)参数异常：CRMCoding为空，或者参数格式错误错误(' + e + ')';
                    tempResult.success = false;
                    firstAccountReuqestParam.result = tempResult;
                    return firstAccountReuqestParam;
                }
                 //销售组织
                try{
                    if(reader.getLocalName() == 'SalesOrganization')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.SalesOrganization = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                
                //ThroughTheFirstCamp__c 是否通过首营
                 //销售组织
                try{
                    if(reader.getLocalName() == 'ThroughTheFirstCamp')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            firstAccountReuqestParam.ThroughTheFirstCamp = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse First Account Request xml Exception info is' + e);
                }
                
                reader.next();
                
            }
            tempResult.message = '参数验证通过';
            tempResult.success = true;
            firstAccountReuqestParam.result = tempResult;    
        }
        catch (Exception e) {
          system.debug('parse firstAccountrequst xml Exception info is' + e);
          return null;
        }          
        
        return firstAccountReuqestParam;
    }
    
    
    public static ProductRequestParam parseProductRequest(String productRquestXML)
    {
        ProductRequestParam productReuqestParam = new ProductRequestParam();
        productRquestXML = replaceSpcialChart(productRquestXML, '&', '&amp;');
        Result tempResult = new Result();
        try{
            XmlStreamReader reader = new XmlStreamReader(productRquestXML);
            while(reader.hasNext())
            {   
                //公开报价单价
                try{
                    if(reader.getLocalName() == 'OpenQuotationUnitPrice')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.OpenQuotationUnitPrice = Decimal.valueof(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //公开报价总价
                try{
                    if(reader.getLocalName() == 'TotalPrice0fOpenQuotation')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.TotalPrice0fOpenQuotation = Decimal.valueof(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                 //原存货编码
                try{
                    if(reader.getLocalName() == 'OriginalInventoryCoding')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.OriginalInventoryCoding = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                 //型号
                try{
                    if(reader.getLocalName() == 'Model')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.Model = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                 //描述
                try{
                    if(reader.getLocalName() == 'Describe')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.Describe = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                 //数量
                try{
                    if(reader.getLocalName() == 'Number')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.NumberString = Integer.valueOf(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                 //新存货编码
                try{
                    if(reader.getLocalName() == 'NewInventoryCoding')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.NewInventoryCoding = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                 //类型
                try{
                    if(reader.getLocalName() == 'Type')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.Type = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                //税率
                try{
                    if(reader.getLocalName() == 'TaxRate')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.TaxRate = Decimal.valueOf(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //物料名称
                try{
                    if(reader.getLocalName() == 'Name')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.Name = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //物料编码
                try{
                    if(reader.getLocalName() == 'MaterialCoding')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.MaterialCoding = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //物料分类
                try{
                    if(reader.getLocalName() == 'MaterialClassification')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.MaterialClassification = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //主计量单位
                try{
                    if(reader.getLocalName() == 'PrimaryUnit')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.PrimaryUnit = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //产品线   
                try{
                    if(reader.getLocalName() == 'ProductLine')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.ProductLine = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                //存货通用名称
                try{
                    if(reader.getLocalName() == 'InventoryCommonName')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.InventoryCommonName = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
            
                //注册证号
                try{
                    if(reader.getLocalName() == 'RegistrationNumber')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            productReuqestParam.RegistrationNumber = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse Product Request xml Exception info is' + e);
                }
                
                reader.next();
                
            }
            tempResult.message = '参数验证通过';
            tempResult.success = true;
            productReuqestParam.result = tempResult;    
        }
        catch (Exception e) {
            system.debug('parse product request xml Exception info is' + e);
            tempResult.message = '参数验证失败：' + e;
            tempResult.success = false;
            productReuqestParam.result = tempResult; 
            
            return productReuqestParam;
        }          
        
        return productReuqestParam;
    }
    
    /*
    *首营客户信息
    **/
    public class FirstAccountRequestParam
    {
        public String TheFirstProduct{Set;get;}
        public String FieldVisitQualified{Set;get;}
        public String CustomerFirst{Set;get;}
        public String ProposedSpecies{Set;get;}
        public String PermitNumber{Set;get;}
        public String QualityManager{Set;get;}
        public String CRMCoding{Set;get;}
        public String SalesOrganization{Set;get;}
        public String ThroughTheFirstCamp{set;get;}
        
        public Result result{set;get;}
    }    
    
    /*
    *产品信息(物料信息)
    **/
    public class ProductRequestParam
    {
        public Decimal OpenQuotationUnitPrice{Set;get;}
        public Decimal TotalPrice0fOpenQuotation{Set;get;}
        public String OriginalInventoryCoding{Set;get;}
        public String Model{Set;get;}
        public String Describe{Set;get;}
        public Integer NumberString{Set;get;}
        public String NewInventoryCoding{Set;get;}
        public String Type{Set;get;}
        
        //new content
        public Decimal TaxRate{set;get;}
        public String Name{set;get;}
        public String MaterialCoding{set;get;}
        public String MaterialClassification{set;get;}
        public String PrimaryUnit{set;get;}
        public String ProductLine{set;get;}
        public String InventoryCommonName{set;get;}
        public String RegistrationNumber{set;get;}

        public Result result{set;get;}
    } 
    
  /*
  *public class ,return result
  */
  public class Result
  {
    public Boolean success{set;get;}
    public String message{set;get;}
  }
  
  /*
  *回款明细
  */
  public class PayBackinfoRequestParam
  {
    public Decimal RepaymentAmount{set;get;}
    public Date RemittanceDate{set;get;}
    public String OrderNumber{set;get;}
    
    public Result result{set;get;}
  }
  
  public static PayBackinfoRequestParam parsePayBackRequest(String paybackRquestXML)
  {
        PayBackinfoRequestParam paybackReuqestParam = new PayBackinfoRequestParam();
        Result tempResult = new Result();
        try{
            XmlStreamReader reader = new XmlStreamReader(paybackRquestXML);
            while(reader.hasNext())
            {   
                //回款金额
                try{
                    if(reader.getLocalName() == 'RepaymentAmount')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            paybackReuqestParam.RepaymentAmount = Decimal.valueof(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse pay back Request xml Exception info is' + e);
                }
                
                //回款时间
                try{
                    if(reader.getLocalName() == 'RemittanceDate')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            paybackReuqestParam.RemittanceDate = Date.parse(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse pay back Request xml Exception info is' + e);
                    tempResult.message = '请传入正确的日期格式，形如YYYY-MM-DD';
		            tempResult.success = false;
		            paybackReuqestParam.result = tempResult;   
		            return paybackReuqestParam; 
                }
                
                 //订单号
                try{
                    if(reader.getLocalName() == 'OrderNumber')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            paybackReuqestParam.OrderNumber = reader.getText();
                        }
                    }
                }catch(Exception e){
                    system.debug('parse pay back Request xml Exception info is' + e);
                }
                reader.next();
                
            }
            tempResult.message = '参数验证通过';
            tempResult.success = true;
            paybackReuqestParam.result = tempResult;    
        }
        catch (Exception e) {
            system.debug('parse pay back request xml Exception info is' + e);
            tempResult.message = '参数验证失败：' + e;
            tempResult.success = false;
            paybackReuqestParam.result = tempResult; 
            
            return paybackReuqestParam;
        }          
        
        return paybackReuqestParam;
    }
    
  /*
  *发货信息
  */
  public class DeliveryInfoRequestParam
  {
    public Decimal ShipableQuantity{set;get;}
    public Decimal ShippedQuantity{set;get;}
    public String ProductNumber{set;get;}
    public String OrderNumber{set;get;}
    public String ProductName{set;get;}
    
    public Result result{set;get;}
  }
  
  public static DeliveryinfoRequestParam parseDeliveryRequest(String deliveryRquestXML)
  {
        DeliveryInfoRequestParam deliveryReuqestParam = new DeliveryInfoRequestParam();
        Result tempResult = new Result();
        try{
            XmlStreamReader reader = new XmlStreamReader(deliveryRquestXML);
            while(reader.hasNext())
            {   
            	//已发货数量
                try{
                    if(reader.getLocalName() == 'ShippedQuantity')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            deliveryReuqestParam.ShippedQuantity = Decimal.valueof(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse delivery Request xml Exception info is' + e);
                }
            	
                //可发货数量
                try{
                    if(reader.getLocalName() == 'ShipableQuantity')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            deliveryReuqestParam.ShipableQuantity = Decimal.valueof(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse delivery Request xml Exception info is' + e);
                }
                
                //产品编号
                try{
                    if(reader.getLocalName() == 'ProductNumber')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            deliveryReuqestParam.ProductNumber = String.valueOf(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse delivery Request xml Exception info is' + e);
                }
                
                 //订单号
                try{
                    if(reader.getLocalName() == 'OrderNumber')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            deliveryReuqestParam.OrderNumber = String.valueOf(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse delivery Request xml Exception info is' + e);
                }
                 //产品名
                try{
                    if(reader.getLocalName() == 'ProductName')
                    {
                        reader.next();
                        if(String.isNotBlank(reader.getText()))
                        {
                            deliveryReuqestParam.ProductName = String.valueOf(reader.getText());
                        }
                    }
                }catch(Exception e){
                    system.debug('parse delivery Request xml Exception info is' + e);
                }
                reader.next();
                
            }
            tempResult.message = '参数验证通过';
            tempResult.success = true;
            deliveryReuqestParam.result = tempResult;    
        }
        catch (Exception e) {
            system.debug('parse delivery request xml Exception info is' + e);
            tempResult.message = '参数验证失败：' + e;
            tempResult.success = false;
            deliveryReuqestParam.result = tempResult; 
            
            return deliveryReuqestParam;
        }          
        
        return deliveryReuqestParam;
    }
    public static String replaceSpcialChart(String oldString, String regExp, String replacement)
    {
    	oldString = oldString.replaceAll(regExp, replacement);
    	return oldString;
    }
    
}