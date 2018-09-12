@isTest(SeeAlldata=true)
public class TestConfig {
    static testMethod void myUnitTest() {
        
        //
        Product2 newCkdj2 = [select Id, name from product2 limit 1];
        PriceBookEntry newPriceBookEntry = [select id, Pricebook2Id from PriceBookEntry where product2Id = :newCkdj2 .id and CurrencyIsoCode = 'CNY' limit 1];
        
       Account newAccount = new Account(Name = '测试客户For');
        insert newAccount;
        
        
        
        
        Order newOrder = new Order();   
        newOrder.Name = 'test Order';
        newOrder.AccountId = newAccount.Id;
        newOrder.EffectiveDate = date.today();
        newOrder.Status = 'Draft';
        newOrder.Pricebook2Id = newPriceBookEntry.Pricebook2Id;
        //newOrder.Id = ExportOrder.order__c;
        insert newOrder;
        //
        
        String currentConfigId = '';
        
        ConfigurationList__c config=new ConfigurationList__c();
        //config.Name='test1';
        Id configListRecordTypeId = Schema.SObjectType.ConfigurationList__c.getRecordTypeInfosByName().get('库存').getRecordTypeId();
        config.RecordTypeId = configListRecordTypeId;
        config.order__c = newOrder.Id;
        insert config;
        
        ApexPages.StandardController sc=new ApexPages.StandardController(config);
        NewConfigrationList ncl=new NewConfigrationList(sc);
        currentConfigId=sc.getId();
        
        
        
        
        
    }
}