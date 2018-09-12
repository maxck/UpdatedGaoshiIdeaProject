/**
 * Creat By : Arvin
 * Time : 2015年2月28日
 * Describe: Cbl_outinstock_updatestock 的测试类
 */
@isTest(SeeAllData=true)
private class Cbl_outinstock_updatestock_Test 
{
    
    
    //测试插入新的出入库记录 
    static testMethod void Test_insertStock()
    {
        //出入库列表
        product__c pro = new product__c();
        pro.Name='test';
        insert pro;
        
        kucun__c kc=new kucun__c();
        //kc.Name='sth';
        insert kc;
        
        stock__c st=new stock__c();
        st.name='test001';
        st.state__c='新品库';
        st.warehouse__c='北京';
        st.ProductNumber__c=pro.id;
        st.virtualnum__c=10;
        st.xcnum__c=10;
        st.Field2__c=kc.Id;
        insert st;
        
        stock__c st1=new stock__c();
        st1.name='test001';
        st1.state__c='废品库';
        st1.warehouse__c='北京';
        st1.ProductNumber__c=pro.id;
        st1.virtualnum__c=10;
        st1.xcnum__c=10;
        st1.Field2__c=kc.Id;
        insert st1;
        
        RecordType RecordIncangk=[Select r.SobjectType, r.Id, r.DeveloperName 
        				From RecordType r 
        				where r.SobjectType='outinstock__c'
        				and r.DeveloperName='incangk'];
        RecordType RecordOutcangk=[Select r.SobjectType, r.Id, r.DeveloperName 
        				From RecordType r 
        				where r.SobjectType='outinstock__c'
        				and r.DeveloperName='outcangk'];
        //入库
        outinstock__c ins = new outinstock__c();
        pro.SpecificationType__c = 'AMARIS750';
        ins.product__c = pro.Id;
        ins.ckplace__c = '北京';
        ins.state__c = '新品库';
        ins.RecordTypeId=RecordIncangk.id;
        ins.isquartify__c='是';
        ins.number__c = 3;
       
       	try
       	{
       		insert ins;
       	}
       	catch(Exception e)
       	{
       		
       	}
        
        //出库
        outinstock__c outs = new outinstock__c();
        outs.product__c = pro.Id;
        outs.ckplace__c = '北京';
        outs.state__c = '新品库';
        outs.number__c = 2;
        outs.RecordTypeId=RecordOutcangk.id;
        insert outs;
        
        
         ins.number__c = 4;
         update ins;
         
        outs.number__c = 1;
        update outs;
        
        
        
        outs.state__c = '废品库';
        update outs;
        
        delete ins;
        delete outs;
    }
    
    //测试更改出入库记录
    static testMethod void Test_updateStock()
    {
    	
        //出入库列表
        product__c pro = new product__c();
        pro.Name='test';
        insert pro;
        
        kucun__c kc=new kucun__c();
        //kc.Name='sth';
        insert kc;
        
        stock__c st=new stock__c();
        st.name='test001';
        st.state__c='新品库';
        st.warehouse__c='北京';
        st.ProductNumber__c=pro.id;
        st.virtualnum__c=10;
        st.xcnum__c=10;
        st.Field2__c=kc.Id;
        insert st;
        
        stock__c st1=new stock__c();
        st1.name='test001';
        st1.state__c='废品库';
        st1.warehouse__c='北京';
        st1.ProductNumber__c=pro.id;
        st1.xcnum__c=10;
        st1.virtualnum__c=10;
        st1.Field2__c=kc.Id;
        insert st1;
        
        RecordType RecordIncangk=[Select r.SobjectType, r.Id, r.DeveloperName 
        				From RecordType r 
        				where r.SobjectType='outinstock__c'
        				and r.DeveloperName='incangk'];
        RecordType RecordOutcangk=[Select r.SobjectType, r.Id, r.DeveloperName 
        				From RecordType r 
        				where r.SobjectType='outinstock__c'
        				and r.DeveloperName='outcangk'];
        //入库
        outinstock__c ins = new outinstock__c();
        pro.SpecificationType__c = 'AMARIS750';
        ins.product__c = pro.Id;
        ins.ckplace__c = '北京';
        ins.state__c = '新品库';
        ins.RecordTypeId=RecordIncangk.id;
        ins.number__c = 3;
       
       	try
       	{
       		insert ins;
       	}
       	catch(Exception e)
       	{
       		
       	}
        
        //出库
        outinstock__c outs = new outinstock__c();
        outs.product__c = pro.Id;
        outs.ckplace__c = '北京';
        outs.state__c = '新品库';
        outs.number__c = 2;
        outs.RecordTypeId=RecordOutcangk.id;
        insert outs;
        
        
         ins.number__c = 4;
         update ins;
         
        outs.number__c = 1;
        update outs;
        
        ins.state__c = '废品库';
        update ins;
        
        outs.state__c = '废品库';
        update outs;
        
        delete ins;
        delete outs;
    
    }
    
    
}