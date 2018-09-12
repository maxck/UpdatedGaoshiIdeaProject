trigger ContractFinalNameTrigger on Contract (before insert ,before update) {
    Set<Id> setId =  new Set<Id>();
    Decimal  Am = 0.00;
    Set<Id> setCoId =  new Set<Id>(); 
    List<String> ModelNames = new List<String>();
    String Models = '';
    Decimal  Bm = 0.00;
    for(Contract  newCo : Trigger.new){
        setId.add(newCo.Opportunity__c);
        system.debug('setId : '+ setId );
    }
    List<Opportunity> opp = [select id,FinalCustomer__c from Opportunity where id = : setId];
    if(opp.size() > 0){
        for(Contract  newCo : Trigger.new){
            newCo.FinalCustomer_del__c = opp.get(0).FinalCustomer__c  ;
        }
    }
    List<ConfigurationList__c> coList  =  [select id,FinalPrice__c,Model__c,Opportuniy__c,SystemStandardTotalPrice__c from ConfigurationList__c  where Opportuniy__c =: setId and SynchronizationContract__c = '是'];
    if(coList.size() > 0){
        for(ConfigurationList__c co : coList ){
            if(co.FinalPrice__c != null){
                Am = Am+ co.FinalPrice__c ;
            }
            if(co.SystemStandardTotalPrice__c != null){
                Bm = Bm+ co.SystemStandardTotalPrice__c ;
            }
            system.debug('Am : '+ Am);
            if (String.isNotBlank(co.id)) {
                setCoId.add(co.id);
                system.debug('setCoId :'+ setCoId);
            }
        }
    }
    List<Host__c> hoList = [select id,Model__c,ConfigurationList__c  from Host__c  where ConfigurationList__c in : setCoId ];
    for(Host__c ho : hoList){
        if (String.isNotBlank(ho.Model__c)) {
            ModelNames.add(ho.Model__c);
            system.debug('ModelNames :'+ ModelNames);
        }
        Models = String.join(ModelNames,',');
        system.debug('Models :'+ Models);
    }
    for(Contract  newCo : Trigger.new){
        newCo.ContractAmount__c  = Am ;
        newCo.ConfigurationListModel__c = Models;
        newCo.EquipmentBasePrice__c = Bm ;
    }

}