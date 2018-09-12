global class BatchUpdateAccountTeam implements Database.Batchable<sObject>, Schedulable{
    
    public Map<Id, Id> oldUserIds2NewuserIds{set;get;}
    public Set<Id> UserIds{set;get;}
    global void execute(SchedulableContext sc) {
        BatchUpdateAccountTeam temp = new BatchUpdateAccountTeam();
        database.executeBatch(temp, 10);
    }
    
    global BatchUpdateAccountTeam()
    {   
    	oldUserIds2NewuserIds = new Map<Id, Id>();
    	UserIds = new Set<Id>();
    	for (BatchUpdateAccountTeam__c tempBatchUpdateAccountTeam : [select id, name, OlderUserId__c, NewUserId__c from BatchUpdateAccountTeam__c where IsExcuted__c = false])
    	{
    		oldUserIds2NewuserIds.put(tempBatchUpdateAccountTeam.OlderUserId__c, tempBatchUpdateAccountTeam.NewUserId__c);
    		UserIds.add(tempBatchUpdateAccountTeam.OlderUserId__c);
    	}
    	
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
    	
    	String qurey = 'select id, UserId, AccountAccessLevel, CaseAccessLevel, OpportunityAccessLevel, TeamMemberRole, AccountId  from AccountTeamMember where IsDeleted = false and userid in :UserIds';
    	
        return Database.getQueryLocator(qurey);
    }
    
    global void execute(Database.BatchableContext BC, List<AccountTeamMember> scope)
    {   
        Set<Id> managerIds = new Set<Id>();
        List<AccountTeamMember> updateAccountTeamMembers = new List<AccountTeamMember>();
        List<AccountTeamMember> deleteAccountTeamMembers = new List<AccountTeamMember>();
        for(AccountTeamMember tempAccountTeamMember : scope)
        {   
        	deleteAccountTeamMembers.add(tempAccountTeamMember);
        	AccountTeamMember updateAccountTeamMember = new AccountTeamMember();
        	updateAccountTeamMember.AccountAccessLevel = tempAccountTeamMember.AccountAccessLevel;
        	updateAccountTeamMember.TeamMemberRole = tempAccountTeamMember.TeamMemberRole;
        	updateAccountTeamMember.AccountId = tempAccountTeamMember.AccountId;
        	updateAccountTeamMember.UserId = oldUserIds2NewuserIds.get(tempAccountTeamMember.UserId);
        	updateAccountTeamMembers.add(updateAccountTeamMember);
        }
        if (deleteAccountTeamMembers.size() > 0)
        {
        	delete deleteAccountTeamMembers;
        }
        
        if (updateAccountTeamMembers.size() > 0)
        {
			insert updateAccountTeamMembers;        	
        }
		List<BatchUpdateAccountTeam__c> updateBatchUpdateAccountTeams = new List<BatchUpdateAccountTeam__c>();
        for (BatchUpdateAccountTeam__c tempBatchUpdateAccountTeam : [select id, name, OlderUserId__c, NewUserId__c, IsExcuted__c from BatchUpdateAccountTeam__c where IsExcuted__c = false])
    	{	
    		tempBatchUpdateAccountTeam.IsExcuted__c = true;
			updateBatchUpdateAccountTeams.add(tempBatchUpdateAccountTeam);
    	}
    	if (updateBatchUpdateAccountTeams.size() > 0)
    	{
    		update updateBatchUpdateAccountTeams;
    	}
        
    }
    
    global void finish(Database.BatchableContext BC){}
 
    
}