trigger BussniessAreaTrigger on Contract (before Insert,before update,before delete) {
    List <String> nameList=new List<String>();
    String AreaName;
    Set<Id> aId= new Set<Id>();
    for(Contract con : Trigger.New){
        aId.add(con.Id); 
    }
    if(aId.size()>0){
        List<ConfigurationList__c> cl =[select id,name,BussinessArea__c,ContractReview__c from ConfigurationList__c where ContractReview__c in :aId and SynchronizationContract__c = '是'];
        System.debug('cl size:'+cl.size());
        if(cl.size()>0){
            for(Integer i=0;i<cl.size();i++){
                nameList.add(cl.get(i).BussinessArea__c);
                System.debug('namelist: '+cl.get(i).BussinessArea__c);
            }
            AreaName=String.join(NameList,';'); 
    	System.debug('area name--------:'+AreaName);
            
    for(Contract con : Trigger.New){
        //Contract c=new Contract();
        con.Id=cl.get(0).ContractReview__c;
        con.AgencyBusinessScope__c=AreaName; 
        System.debug('contract name--------:'+con.AgencyBusinessScope__c);
    }  
        }
        
    }   
}