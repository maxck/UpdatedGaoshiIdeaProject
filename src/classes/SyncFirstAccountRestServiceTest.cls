/**
 * test for SyncFirstAccountRestService
 */
@isTest
private class SyncFirstAccountRestServiceTest {

    static testMethod void myUnitTest() {
        
        Account newAccount = new Account(Name = '测试客户', NewAccount__c = '否', CountyHospital__c = '否', TypeEnterprise__c = '医疗机构', CustomerApprovalStatus__c = '草稿');
        insert newAccount;
        Account currentAccount = [select CRMCodingFormula__c from account where id = :newAccount.id limit 1];
        String instanceUrl = URL.getSalesforceBaseUrl().toExternalForm();
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        //validate param
        req.requestURI = instanceUrl + '/services/apexrest/SyncFirstAccountRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req.httpMethod = 'POST';
        String requestParam = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                      '<TheFirstProduct>是</TheFirstProduct>' + 
                      '<FieldVisitQualified>状态良好</FieldVisitQualified>' + 
                      '<CustomerFirst>是</CustomerFirst>' + 
                      '<ProposedSpecies>拟供品种</ProposedSpecies>' + 
                      '<PermitNumber>GB-111111</PermitNumber>' + 
                      '<QualityManager>张经理</QualityManager>' + 
                      '<CRMCoding>' + currentAccount.CRMCodingFormula__c + '</CRMCoding>' + 
                      '<SalesOrganization>高视</SalesOrganization>' +  
                      '<ThroughTheFirstCamp>是</ThroughTheFirstCamp>' +
                    '</request>';
        req.requestBody = Blob.valueof(requestParam);
        RestContext.request = req;
        RestContext.response = res;
        SyncFirstAccountRestService.createFirstAccount();     
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        //validate param
        req1.requestURI = instanceUrl + '/services/apexrest/SyncFirstAccountRestService';  
        system.debug('instanceUrl info is ' + instanceUrl);
        req1.httpMethod = 'POST';
        String requestParam1 = '<?xml version="1.0" encoding="UTF-8"?>' +
                    '<request>' +
                      ' <TheFirstProduct>是</TheFirstProduct>' + 
                      ' <FieldVisitQualified>状态良好</FieldVisitQualified>' + 
                      ' <CustomerFirst>是</CustomerFirst>' + 
                      ' <ProposedSpecies>拟供品种</ProposedSpecies>' + 
                      ' <PermitNumber>GB-111111</PermitNumber>' + 
                      ' <QualityManager>张经理</QualityManager>' + 
                      ' <CRMCoding>' + currentAccount.CRMCodingFormula__c + '</CRMCoding>' + 
                      ' <SalesOrganization>高视</SalesOrganization>' + 
                      ' <ThroughTheFirstCamp>是</ThroughTheFirstCamp>' + 
                    '</request>';
        req1.requestBody = Blob.valueof(requestParam1);
        RestContext.request = req1;
        RestContext.response = res1;
        SyncFirstAccountRestService.createFirstAccount();    
    }
}