@isTest
private class pollingTriggerTest {

    @istest(SeeAlldata=true)
    static void testpollingTrigger ()
    
    {
     Account acc  =  new Account() ; 
       acc.Name = 'kehu';
       acc.city__c = '福州市';
       acc.province__c = '福建省';
       acc.Cunty__c = '1' ;
       acc.LegalRepresentative__c = '1';
       acc.Duty__c = '1' ;
       acc.ContactNumber__c = '123'; 
       acc.Gender__c = '男';
     insert acc ;
     
     product__c pro = new product__c();
     pro.Name = '123';
     insert pro ;
     
     Equipment__c  eq = new Equipment__c();
     eq.Name = '123';
     eq.customer__c = acc.Id;
     eq.warrantytype__c ='保外';
     insert eq;
     
    /**servicerequest__c servicerequest = new servicerequest__c(
    OwnerId = '0056F0000082F6LQAU',
    Name = '123123',
    CurrencyIsoCode = 'CNY',
    RecordTypeId = '01290000000mqmoAAA',
    
    approvestate__c = '草稿',
    isupgrade__c = false,
    customer__c = acc.Id ,
    requesttime__c = Date.newInstance(2018,07,09),
    Field1__c = '保内免费',
    Field2__c = '准分子设备',
    Equipment__c = pro.Id,
    Field8__c = false);**/

    //insert servicerequest ;
      servicerequest__c   ser  = new servicerequest__c();
      ser.Name = 'aa';
      ser.requesttime__c = Date.newInstance(2018,07,09);
      ser.Field2__c ='准分子设备';
      ser.customer__c =acc.Id;
      ser.Equipment__c = eq.id ;
      insert ser ;
      
      
      
      polling__c poll = new polling__c();
   poll.pollingdate__c = Date.newInstance(2018,07,09);
   poll.Accunt1__c = acc.id;
   poll.DeviseSerialNumber__c = eq.id;
   poll.RecordTypeId = '0126F0000019If7QAE';
   poll.RespondingSpeed__c = '1';
   poll.ServiceAttitude__c = '3';
   poll.SolveEfficiency__c = '3';
   poll.QuotationFees__c = '2';
   poll.FieldSpecification__c = '4';
   poll.RespondingSpeed__c='3';
   poll.servicerequest__c=ser.Id ;
   insert  poll;
   
   
   poll.FieldSpecification__c = '3';
   update poll;
    
    }
    
}