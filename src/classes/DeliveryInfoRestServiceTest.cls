/**
 * test for DeliveryInfoRestService
 */
@isTest
private class DeliveryInfoRestServiceTest {

    static testMethod void myUnitTest() {
        String instanceUrl = URL.getSalesforceBaseUrl().toExternalForm();
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        //validate param
        req.requestURI = instanceUrl + '/services/apexrest/DeliveryInfoRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req.httpMethod = 'POST';
        String requestParam = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                    '<ShipableQuantity>12000.1</ShipableQuantity>' +
                    '<DeliveryInformationId>120</DeliveryInformationId>' + 
                    '<OrderNumber>XEPRB10PC2</OrderNumber>' + 
                    '</request>';
        req.requestBody = Blob.valueof(requestParam);
        RestContext.request = req;
        RestContext.response = res;
        DeliveryInfoRestService.createDeliveryInfo(); 
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        //validate param
        req1.requestURI = instanceUrl + '/services/apexrest/DeliveryInfoRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req1.httpMethod = 'POST';
        String requestParam1 = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                    '<ShipableQuantity>12000.1</aaShipableQuantity>' +
                    '<DeliveryInformationId>120</DeliveryInformationId>' + 
                    '<OrderNumber>XEPRB10PC2</OrderNumber>' + 
                    '</request>';
        req1.requestBody = Blob.valueof(requestParam1);
        RestContext.request = req1;
        RestContext.response = res1;
        DeliveryInfoRestService.createDeliveryInfo();     
        
    }
}