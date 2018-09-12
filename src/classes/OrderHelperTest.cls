/**
* test for OrderHelper
*** */
@isTest
private class OrderHelperTest {
	
	public class MockHttpResponseGenerator implements HttpCalloutMock {
	    // Implement this interface method
	    public HTTPResponse respond(HTTPRequest req) {
	        // Create a fake response
	        HttpResponse res = new HttpResponse();
	        res.setHeader('Content-Type', 'text/xml');
	        res.setBody('<?xml version="1.0" encoding="UTF-8"?>' +
						'<ufinterface billtype="30" filename="30246d797default.xml" isexchange="Y" replace="Y" roottag="sendresult" sender="default" successful="N">' +
						    '<sendresult>' +
						        '<billpk>' +
						        '</billpk>' +
						        '<bdocid>1655246d7bd000000000000000000000000000300</bdocid>' +
						        '<filename>30246d797default.xml</filename>' +
						        '<resultcode>-32000</resultcode>' +
						        '<resultdescription></resultdescription>' +
						        '<content></content>' +
						    '</sendresult>' +
						'</ufinterface>');
	        res.setStatusCode(200);
	        return res;
	    }
	}
	
    static testMethod void myUnitTest() {
		
		URLConfig__c tempURLConfig = new URLConfig__c(Name = 'RequestURL', URL__c = 'https://www.baidu.com');   
		insert tempURLConfig;
        Account acc  =  new Account() ; 
        acc.Name = 'test1230';
        acc.city__c = '福州市';
        acc.province__c = '福建省';
        acc.Cunty__c = '1' ;
        acc.LegalRepresentative__c = '1';
        acc.Duty__c = '1' ;
        acc.ContactNumber__c = '123'; 
        acc.Gender__c = '男';
        insert acc ;
        
        Order or1 = new  Order();
        or1.AccountId = acc.Id ;
        or1.EffectiveDate = date.today();
        or1.Status = 'Draft';
        insert or1;
		
		ConfigurationList__c configurationlist = new ConfigurationList__c();
		//configurationlist.Name = '333';
		configurationlist.CurrencyIsoCode = 'CNY';
		configurationlist.order__c = or1.Id;
	    insert configurationlist;
		
		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
		
		OrderHelper.syncOrderinfoByTrigger(or1.id);
		Map<String, String> map1 = OrderHelper.PublicPrivate2Code;
		Map<String, String> map2 = Orderhelper.Classify12Code;
		Map<String, String> map3 = Orderhelper.Classify22Code;
		Map<String, String> map4 = Orderhelper.Classify32Code;
		Map<String, String> map5 = Orderhelper.orderTypeName2Code;
		Map<String, String> map6 = Orderhelper.unitTranslation;
		Map<String, String> map7 = Orderhelper.projectName2Code;
		String tempStr = Orderhelper.convertDateTimetoString(datetime.now());
		Decimal tempD = Orderhelper.setCustomScale(1.02222, 2);
		//Map<String, String> map8 = Orderhelper.orderTypeName2Code;
        
    }
}