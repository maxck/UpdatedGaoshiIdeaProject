trigger OpportunityStatusTrigger on Opportunity (after insert,after update) {
    Set<Id> setId = new Set<Id>();
   // Set<String> setString  =  new Set<String>();
    String  setString='' ;
    
    for(Opportunity newOpp : Trigger.new){
        setId.add(newOpp.Id);
        system.debug('setId :'+ setId);
        setString = newOpp.SalesOpportunityStatus__c;
        system.debug('setString : '+ setString);
    }
    List<CustomObject18__c> Cu18List = [select id,Field1__c,State__c from CustomObject18__c where Field1__c = : setId];
    if(setString == '丢单'){
        for(CustomObject18__c cu : Cu18List){
        system.debug('进入丢单for');
            cu.State__c = '丢单';
            update cu;
            system.debug('丢单update完成');
        }
    } else if(setString == '赢单'){
        Integer i =0;
        Integer j =0;
        system.debug('进入赢单');
        for(CustomObject18__c cu : Cu18List){
            if(cu.State__c=='赢单'){
                i= i +1;
                system.debug('i : '+ i);
            } else if (cu.State__c=='跟进'){
                j=j+1;
                system.debug('j : '+ j );
            }
        }
        system.debug('i:'+i+'j:'+j);
        if( i < = 0 || j > 0){
                system.debug('进入最后判断');
                for(Opportunity newOpp : Trigger.new){
                    newOpp.addError('销售机会产品中无赢单或是有跟进');
                }
                
            }
    }
}