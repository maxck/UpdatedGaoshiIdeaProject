/**
 */
@isTest
private class ContractAfterTriggerTest {

    static testMethod void myUnitTest() {
		
		Account newAccount = new Account (Name = '测试最终客户', CustomerFirst__c = '是');
		insert newAccount;
		Contract newContract = new Contract(accountid = newAccount.Id, ContractReviewStatus__c = '草稿', Field1__c = true, StartDate = date.today());
		insert newContract;
		newContract.ContractReviewStatus__c = '已审批';
		update newContract;
    }
}