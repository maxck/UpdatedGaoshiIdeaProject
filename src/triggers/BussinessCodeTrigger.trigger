trigger BussinessCodeTrigger on ConfigurationList__c (before Insert,before Update) {
    
  
    for(ConfigurationList__c con : Trigger.New){
        
      
        List<Host__c> host=[select dlsjyfw__c from Host__c where ConfigurationList__c=:con.Id LIMIT 1];
        System.debug('con id is :'+ con.Id+'\n'+'host size: '+host.size());
        if(host.size()>0){
        if(host[0].dlsjyfw__c!=null){
            System.debug('The string is:'+host[0].dlsjyfw__c);
            con.BussinessArea__c=String.valueOf(host[0].dlsjyfw__c);
            System.debug('con.BussinessArea__c is: '+con.BussinessArea__c);
        }
        }
        
    }
   
    }