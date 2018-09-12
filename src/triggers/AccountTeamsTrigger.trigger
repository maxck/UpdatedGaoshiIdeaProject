trigger AccountTeamsTrigger on Account (after insert) {
    Set<Id>  setId =  new Set<Id>() ;
    for(Account account : trigger.new ){
        if(account.Id != null){
        system.debug('account.Id :'+ account.Id);
        setId.add(account.id);
        }
    }
    if(setId.size() != null){
        String teamMemberRole = '无';
        String accountAccess = 'Edit', opportunityAccessLevel = 'Edit', caseAccessLevel = 'Edit';
        List<Account> accounts = [select id ,ownerid,owner.name from account where id = :setId];
        List<User> users = [select id from User where name = : accounts.get(0).owner.name] ;
        system.debug('accounts.get(0).ownerid :'+ accounts.get(0).ownerid);
        List<AccountTeamMember> members = new list<AccountTeamMember>();
        //List<AccountShare> sharingRules = new list<AccountShare>();

        for(Account a : accounts) {
            members.add(New AccountTeamMember(AccountId = a.Id, TeamMemberRole = teamMemberRole, UserId= a.ownerid));
            //sharingRules.add(new AccountShare(AccountAccessLevel = accountAccess, OpportunityAccessLevel = opportunityAccessLevel, CaseAccessLevel = caseAccessLevel,UserOrGroupId = users.get(0).id, AccountId = a.Id));
            }

        insert members;
        system.debug('insert success 1 ');
        //insert sharingRules;  
        //system.debug('insert success 2');  
    }

}