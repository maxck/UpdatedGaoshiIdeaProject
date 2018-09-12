/**
 * test for SyncProductInfoRestService
 */
@isTest
private class SyncProductInfoRestServiceTest {

    static testMethod void myUnitTest() {
        String instanceUrl = URL.getSalesforceBaseUrl().toExternalForm();
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        //validate param
        req.requestURI = instanceUrl + '/services/apexrest/SyncProductInfoRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req.httpMethod = 'POST';
        String requestParam = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                    '<OpenQuotationUnitPrice>12000.1</OpenQuotationUnitPrice>' +
                    '<TotalPrice0fOpenQuotation>120</TotalPrice0fOpenQuotation>' + 
                    '<OriginalInventoryCoding>XEPRB10PC2</OriginalInventoryCoding>' + 
                    '<Model>12312</Model>' + 
                    '<Describe>B超探头B1-10MHz</Describe>' + 
                    '<Number>1</Number>' + 
                    '<NewInventoryCoding>01PWCAB10MH</NewInventoryCoding>' + 
                    '<Type>必选配件</Type>' + 
                    '<TaxRate>0.2</TaxRate>' + 
                    '<Name>治疗仪</Name>' + 
                    '<MaterialCoding>XEPRB10PC2</MaterialCoding>' + 
                    '<MaterialClassification>甲级</MaterialClassification>' + 
                    '<PrimaryUnit>台</PrimaryUnit>' + 
                    '<ProductLine>产品线</ProductLine>' + 
                    '<InventoryCommonName>治疗仪AVCX</InventoryCommonName>' + 
                    '<RegistrationNumber>XEPRB10PC2ddd</RegistrationNumber>' + 
                    '</request>';
        req.requestBody = Blob.valueof(requestParam);
        RestContext.request = req;
        RestContext.response = res;
        SyncProductInfoRestService.createProduct(); 
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        //validate param
        req1.requestURI = instanceUrl + '/services/apexrest/SyncProductInfoRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req1.httpMethod = 'POST';
        String requestParam1 = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                    '<OpenQuotationUnitPrice>12000.1</OpenQuotationUnitPrice>' +
                    '<11TotalPrice0fOpenQuotation>120</TotalPrice0fOpenQuotation>' + 
                    '<OriginalInventoryCoding>XEPRB10PC2</OriginalInventoryCoding>' + 
                    '<Model>12312</Model>' + 
                    '<Describe>B超探头B1-10MHz</Describe>' + 
                    '<Number>1</Number>' + 
                    '<NewInventoryCoding>01PWCAB10MH</NewInventoryCoding>' + 
                    '<Type>必选配件</Type>' + 
                    '<TaxRate>0.2</TaxRate>' + 
                    '<Name>治疗仪</Name>' + 
                    '<MaterialCoding>XEPRB10PC2</MaterialCoding>' + 
                    '<MaterialClassification>甲级</MaterialClassification>' + 
                    '<PrimaryUnit>台</PrimaryUnit>' + 
                    '<ProductLine>产品线</ProductLine>' + 
                    '<InventoryCommonName>治疗仪AVCX</InventoryCommonName>' + 
                    '<RegistrationNumber>XEPRB10PC2ddd</RegistrationNumber>' + 
                    '</request>';
        req1.requestBody = Blob.valueof(requestParam1);
        RestContext.request = req1;
        RestContext.response = res1;
        SyncProductInfoRestService.createProduct();            
    }
}