trigger IntermediateTableTrigger on IntermediateTable__c (before insert) {
    Integer  year  = 0;
    Integer month  = 0 ;
   
    for(IntermediateTable__c  newIn : trigger.new){
        DateTime time1 = date.today() ; 
        system.debug('time1 : '+ time1 );
        //Date myDate = time1.date();
        //system.debug('myDate :'+ myDate );
        year  =  time1.year();
        system.debug('year :'+ year  );
        month  =  time1.month();
        system.debug('month  :'+ month );
        
        newIn.Year__c = year ;
       // system.debug('newIn.Year__c :'+ newIn.Year__c);
         newIn.Month__c  = month ;
       // system.debug('newIn.Month__c :'+ newIn.Month__c);
       newIn.Key__c  =  newIn.Year__c +'.'+ newIn.Month__c ; 
       system.debug('newIn.Key__c :'+ newIn.Key__c );
        

    }
}