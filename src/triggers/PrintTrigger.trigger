trigger PrintTrigger on CustomObject22__c (before insert,before update) {
Set<Id> setId5 = new Set<Id>();
Set<Id> setId6 = new Set<Id>();
Set<Id> setId7 = new Set<Id>();
Set<Id> setId8 = new Set<Id>();
Set<Id> setId9 = new Set<Id>();
Set<Id> setId10 = new Set<Id>();
for(CustomObject22__c  newCu : Trigger.new){
setId5.add(newCu.InmarsatSerial05__c);
setId6.add(newCu.InmarsatSerial06__c);
setId7.add(newCu.InmarsatSerial07__c);
setId8.add(newCu.InmarsatSerial08__c);
setId9.add(newCu.InmarsatSerial09__c);
setId10.add(newCu.InmarsatSerial10__c);
}
List<Equipment__c>  EquipmentList5  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId5];
List<Equipment__c>  EquipmentList6  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId6];
List<Equipment__c>  EquipmentList7  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId7];
List<Equipment__c>  EquipmentList8  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId8];
List<Equipment__c>  EquipmentList9  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId9];
List<Equipment__c>  EquipmentList10  =  [select id ,ProductNameCG__c,ProductModelCG__c from Equipment__c where id =: setId10];
for(CustomObject22__c  newCu : Trigger.new){
    if(EquipmentList5.size() > 0){
        newCu.EquipmentName5__c  =  EquipmentList5.get(0).ProductNameCG__c ;
        newCu.EquipmentModel5__c =  EquipmentList5.get(0).ProductModelCG__c;    
    }
     if(EquipmentList6.size() > 0){
        newCu.EquipmentName6__c  =  EquipmentList6.get(0).ProductNameCG__c ;
        newCu.EquipmentModel6__c =  EquipmentList6.get(0).ProductModelCG__c;    
    }
     if(EquipmentList7.size() > 0){
        newCu.EquipmentName7__c  =  EquipmentList7.get(0).ProductNameCG__c ;
        newCu.EquipmentModel7__c =  EquipmentList7.get(0).ProductModelCG__c;    
    }
     if(EquipmentList8.size() > 0){
        newCu.EquipmentName8__c  =  EquipmentList8.get(0).ProductNameCG__c ;
        newCu.EquipmentModel8__c =  EquipmentList8.get(0).ProductModelCG__c;    
    }
     if(EquipmentList9.size() > 0){
        newCu.EquipmentName9__c  =  EquipmentList9.get(0).ProductNameCG__c ;
        newCu.EquipmentModel9__c =  EquipmentList9.get(0).ProductModelCG__c;    
    }
     if(EquipmentList10.size() > 0){
        newCu.EquipmentName10__c  =  EquipmentList10.get(0).ProductNameCG__c ;
        newCu.EquipmentModel10__c =  EquipmentList10.get(0).ProductModelCG__c;    
    }
}


}