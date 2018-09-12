trigger ProductLineTrigger on ConfigurationList__c (before insert,before update,after insert,after update) {

    String sname;
    for(ConfigurationList__c con : trigger.new){
        if(Trigger.isBefore){
            if( con.RecordTypeId !='0126F000001UVaSQAW'){
                List<Opportunity> oList=[SELECT FinalCustomer__r.Name FROM Opportunity where Id=:con.Opportuniy__c];
                if(oList.size()>0){
                    //con.Name=oList[0].FinalCustomer__r.Name+' '+con.xh__c+' '+Date.today().format();
                    con.ConfigName__c=oList[0].FinalCustomer__r.Name+' '+con.xh__c+' '+Date.today().format();
                }


                sname=con.cpx__c + con.xh__c;
                if(sname!=null){
                    List<ConfigurationList__c> cList=[SELECT Id FROM ConfigurationList__c where ConfigName__c=:sname];
                    if(cList.size()>0){
                        con.configurationList__c=cList[0].Id;
                        System.debug('库存名称'+con.configurationList__r.Name+' sname:'+sname);
                    }
                }
            }
        }
        /* if(Trigger.isAfter && Trigger.isInsert){
		 if(con.RecordTypeId !='0126F000001UVaSQAW'){
		 ExtendedWarrantyProduct__c ew=new ExtendedWarrantyProduct__c();
		 ew.RecordTypeId='0126F0000017c4F';
		 //ew.Name='延保 '+con.Name;
		 ew.Name='延保 '+con.ConfigName__c;
		 ew.ConfigurationList__c=con.Id;
		 insert ew;
		 }
		 }  */
    }
}