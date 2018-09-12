@isTest
private class PrintTriggerTest 
{

    @istest(SeeAlldata=true)
    static void testPrintTrigger()
    {
         Product3__c  Pro5  = new Product3__c();
         Pro5.Name ='5';
         insert Pro5 ;
         Product3__c  Pro6  = new Product3__c();
         Pro6.Name ='6';
         insert Pro6 ;
         Product3__c  Pro7  = new Product3__c();
         Pro7.Name ='7';
         insert Pro7 ;
         Product3__c  Pro8  = new Product3__c();
         Pro8.Name ='8';
         insert Pro8 ;
         Product3__c  Pro9  = new Product3__c();
         Pro9.Name ='9';
         insert Pro9 ;
         Product3__c  Pro10  = new Product3__c();
         Pro10.Name ='10';
         insert Pro10 ;
         
         Equipment__c  Eq5 = new Equipment__c();
         Eq5.Name = '5'; 
         Eq5.ProductS__c = Pro5.id ;
         insert Eq5 ; 
         Equipment__c  Eq6 = new Equipment__c();
         Eq6.Name = '6'; 
         Eq6.ProductS__c = Pro6.id ;
         insert Eq6 ; 
         Equipment__c  Eq7 = new Equipment__c();
         Eq7.Name = '7'; 
         Eq7.ProductS__c = Pro7.id ;
         insert Eq7 ; 
         Equipment__c  Eq8 = new Equipment__c();
         Eq8.Name = '8'; 
         Eq8.ProductS__c = Pro8.id ;
         insert Eq8 ; 
         Equipment__c  Eq9 = new Equipment__c();
         Eq9.Name = '9'; 
         Eq9.ProductS__c = Pro9.id ;
         insert Eq9 ; 
         Equipment__c  Eq10 = new Equipment__c();
         Eq10.Name = '10'; 
         Eq10.ProductS__c = Pro10.id ;
         insert Eq10 ; 
         
         CustomObject22__c  Cus5  = new CustomObject22__c() ;
         Cus5.InmarsatSerial05__c = Eq5.Id ;
         Cus5.InmarsatSerial06__c = Eq6.Id ;
         Cus5.InmarsatSerial07__c = Eq7.Id ;
         Cus5.InmarsatSerial08__c = Eq8.Id ;
         Cus5.InmarsatSerial09__c = Eq9.Id ;
         Cus5.InmarsatSerial10__c = Eq10.Id ;
         insert Cus5 ;
    
    }
}