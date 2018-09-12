/*
*1.如果这用户的权限是全国的话，就不考虑销售机会的区域了(销售机会的区域可以为空)，直接看销售机会的产品线。销售机会的产品线不能为空
*2.如果这个用户的区域是 某个省份的话，考虑产品线，根据区域和产品线 共享 销售机会
*3.根据自定义设置共享销售机会数据。
*/
global class SharingOpportunityToUsers implements Database.Batchable<SObject>,  Database.Stateful, Schedulable{
    
    public Map<String, Set<String>> userIds2Provinces = new Map<String, Set<String>>();
    public Map<String, Set<String>> userIds2ProductLines = new Map<String, Set<String>>();
    public Map<String, String> userCode2UserId = new Map<String, String>();
    public Integer successCount = 0;
    
    // execute method for Schedule
    global void execute(SchedulableContext sc) 
    {
        SharingOpportunityToUsers batch = new SharingOpportunityToUsers();
        Database.executeBatch(batch, 500);
    }
    
    global SharingOpportunityToUsers()
    {   
        Set<String> userCodes = new Set<String>();
        for (SharingOpportunity__c tempSharingOpportunity : [select id, name, ProductLine__c, Region__c, NCUserCode__c  from SharingOpportunity__c ])
        {
            userCodes.add(tempSharingOpportunity.NCUserCode__c);
            if (userIds2Provinces.containskey(tempSharingOpportunity.NCUserCode__c))
            {   
                // province
                Set<String> tempProvinces = userIds2Provinces.get(tempSharingOpportunity.NCUserCode__c);
                tempProvinces.addAll(tempSharingOpportunity.Region__c.split(','));
                userIds2Provinces.put(tempSharingOpportunity.NCUserCode__c, tempProvinces);
                //product line
                Set<String> tempProductLines = userIds2ProductLines.get(tempSharingOpportunity.NCUserCode__c);
                tempProductLines.addAll(tempSharingOpportunity.ProductLine__c.split(','));
                userIds2ProductLines.put(tempSharingOpportunity.NCUserCode__c, tempProductLines);
                
            }
            else
            {   
                Set<String> tempProvinces = new Set<String>();
                Set<String> tempProductLines = new Set<String>();
                tempProvinces.addAll(tempSharingOpportunity.Region__c.split(','));
                tempProductLines.addAll(tempSharingOpportunity.ProductLine__c.split(','));
                // province
                userIds2Provinces.put(tempSharingOpportunity.NCUserCode__c, tempProvinces);
                //product line
                userIds2ProductLines.put(tempSharingOpportunity.NCUserCode__c, tempProductLines);
            }
            
        }
        
        for (User tempUser : [select id, name, NCNumber__c from user where NCNumber__c in :userCodes])
        {
            userCode2UserId.put(tempUser.NCNumber__c, tempUser.Id);
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc)    
    {   
        String query = 'select ProductLine__c, Province__c, Id  from opportunity where ProductLine__c != null';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<opportunity> scope) 
    {   
        List<OpportunityShare> newOpportunityShares = new list<OpportunityShare>();
        for (opportunity tempopportunity : scope)
        {   
            // provinces
            List<String> provincesList = new List<String>();
            if (String.isNotBlank(tempopportunity.Province__c))
            {
                provincesList = tempopportunity.Province__c.split(',');
            }
            Set<String> provincesSet = new Set<String>();
            provincesSet.addAll(provincesList);  
            //product line
            List<String> productlinesList = tempopportunity.ProductLine__c.split(',');
            Set<String> productlinesSet = new Set<String>();
            productlinesSet.addAll(productlinesList);
            system.debug('[custom Log]productlinesSet from OPP ' + productlinesSet);
            system.debug('[custom Log]provincesSet from OPP ' + provincesSet);
            
            for (String tempUserCode : userCode2UserId.keySet())
            {   
                
                String userid = userCode2UserId.get(tempUserCode);
                Set<String> usersProvinces = userIds2Provinces.get(tempUserCode);
                Set<String> usersProductLines = userIds2ProductLines.get(tempUserCode);
                Boolean result = isContainsProvince(usersProvinces, usersProductLines, provincesSet, productlinesSet);
                if (result == true)
                {
                    newOpportunityShares.add(new OpportunityShare(OpportunityId = tempopportunity.id, UserOrGroupId = userid, OpportunityAccessLevel = 'Read'));
                }
                else
                {
                    continue;   
                }
            }
        }
        if (newOpportunityShares.size() > 0)
        {
            insert newOpportunityShares;
        }   
        
        successCount = newOpportunityShares.size() + successCount;
        system.debug('[custom Log]successCount ' + successCount);
        
    }
    
    global void finish(Database.BatchableContext bc)
    {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
                           JobItemsProcessed, TotalJobItems
                    FROM AsyncApexJob
                    WHERE Id = :bc.getJobId()]; 
                                        
        User currentUser = [Select Email From User Where Id = :UserInfo.getUserId()];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {currentUser.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Sharing opportunity Batch Status: ' + job.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + job.TotalJobItems +
            ' batches with '+ job.NumberOfErrors + ' failures. \nTotal shared records: ' + successCount);
        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception ex) {
            system.debug('Send Batch Status Email Exception ::' + ex.getMessage());
        }
    }
    public boolean isContainsProvince(Set<String> usersProvinces, Set<String> usersProductLines, Set<String> currentProvinces, Set<String> currentProductLines)
    {   
        system.debug('[custom Log]currentProvinces ' + currentProvinces);
        system.debug('[custom Log]currentProductLines ' + currentProductLines);
        Boolean iscontainsProvinces = false;
        for (String tempcurrentProvince : currentProvinces)
        {   
            system.debug('[custom Log]tempcurrentProvince ' + tempcurrentProvince);
            system.debug('[custom Log]usersProvinces ' + usersProvinces);
            if (usersProvinces.contains(tempcurrentProvince))
            {
                iscontainsProvinces = true;
                break;
            }
        }
        if (usersProvinces.contains('全国'))
        {
            iscontainsProvinces = true;
        }
        system.debug('[custom Log]iscontainsProvinces ' + iscontainsProvinces);
        
        Boolean iscontainsProcutLines = false;
        for (String tempcurrentProductLine : currentProductLines)
        {
            if (usersProductLines.contains(tempcurrentProductLine))
            {
                iscontainsProcutLines = true;
                break;
            }
        } 
        system.debug('[custom Log]iscontainsProcutLines ' + iscontainsProcutLines);
        return (iscontainsProvinces == true && iscontainsProcutLines == true);
        
    }
    
}