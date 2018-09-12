/**
 * Creat By : Jmark
 * Time : 2016年9月14日09:27:08
 * Describe: 业务机会视图引用最新项目进展记录的信息：
 * A． 显示项目进展记录中的哪几个字段? 需显示5个字段：拜访日期，拜访人员，拜访方式，沟通内容，下一步方案
 * B． 最新项目进展记录最新的标准是什么？ 标准是：最后一次录入的一条项目进展记录（最新的创建时间）。
 * C． 项目进展记录创建后会不会修改更新，此时修改过内容是否再覆盖？，如最后一条记录创建后再更新，则以更新后的内容为准，即修改过的内容再覆盖。
 * D． 项目进展记录创建后会不会删除，此时怎么处理？如创建后删除，则自动修改成被删除记录的前一条记录。
 *    
 */
@isTest
private class Cbl_CustomObject4_updateChance_Test {

    static testMethod void myUnitTest() {
        Profile profile=[Select p.Name, p.Id From Profile p where Name='系统管理员']; 
        list<RecordType> listrtp=[Select r.Name, r.Id,r.developername From RecordType r where r.developername='htaz']; 
        UserRole ur=new UserRole(); 
		ur.Name='01-总经理'; 
		insert ur; 
		User u=new User(); 
		u.FirstName='李'; 
		u.LastName='四'; 
		u.Alias='李四'; 
		u.Username='lisi@frensworkz.com'; 
		u.Email='lisi@frensworkz.com'; 
		u.CommunityNickname='lisi'; 
		u.UserRoleId=ur.Id; 
		u.ProfileId=profile.Id; 
		u.TimeZoneSidKey='Asia/Shanghai'; 
		u.LocaleSidKey='en_AU'; 
		u.EmailEncodingKey='UTF-8'; 
		u.LanguageLocaleKey='en_US'; 
		insert u; 
		Account acc=new Account();
		acc.Name='momo医院';
		acc.firstclassify__c='国有医院';
		acc.area__c='北区';
		acc.secondperson__c=u.Id;
		acc.clientlevel__c='公司VIP';
		insert acc;
		Contact c=new Contact();
        c.LastName='cesi';
        c.AccountId=acc.Id;
        insert c;
		chance__c cha = new chance__c();
        cha.Name = 'testchance';
        cha.customer__c = acc.Id;
        cha.stage__c = '已回款';
        cha.possible__c = '100%';
        cha.X1__c = 'AMARIS 500E/Compact';
        cha.expireX1__c = Date.today().addYears(1);
        cha.type__c = '1年全保';
        cha.Field1__c = 320000;
        insert cha;
        CustomObject4__c co = new CustomObject4__c();
        co.business_chance__c = cha.Id;
        co.Visit_member__c = c.Id;
        co.Visit_date__c = Date.today();
        co.communication_content__c = 'TEST';
        co.next_step__c = 'TEST';
        co.Field1__c = '电话拜访';
        insert co;
        co.Visit_date__c = Date.today().addDays(1);
        delete co;
    }
}