@isTest
private class NewWorkTest 
{

    @istest(SeeAlldata=true)
    static void testNewWork()
    {
       Id orderTypeIdA = Schema.SObjectType.Case.getRecordTypeInfosByName().get('技术服务').getRecordTypeId();
       Case newCa = new Case(); 
       newCa.RecordTypeId = orderTypeIdA  ; 
       newCa.Origin = '自建';
       insert newCa ; 
       
    }
    @istest(SeeAlldata=true)
    static void testNewWork1()
    {
       Id orderTypeIdB = Schema.SObjectType.Case.getRecordTypeInfosByName().get('样机安装').getRecordTypeId();
       Case newCa1 = new Case(); 
       newCa1.RecordTypeId = orderTypeIdB  ; 
       newCa1.Origin = '自建';
       insert newCa1 ; 
       
    }
    @istest(SeeAlldata=true)
    static void testNewWork2()
    {
       Id orderTypeIdC = Schema.SObjectType.Case.getRecordTypeInfosByName().get('维修维护').getRecordTypeId();
       Case newCa2 = new Case(); 
       newCa2.RecordTypeId = orderTypeIdC  ; 
       newCa2.Origin = '自建';
       insert newCa2 ; 
       
    }
    
}