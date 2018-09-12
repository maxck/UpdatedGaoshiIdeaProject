/**
*Create By:jmark
*TIME：2015年2月26日09:14:18
*Descripe:客户查重，根据客户名字查重并提示
 */
public class Cbl_Account_Name {
	 //新建客户是客户名查重
     public void insertCustomerRechecking(list<Account> list_acc)
     {
          for(Account acc:list_acc)
          {
          	  String name=acc.Name;
              list<Account> list_req=[select Id from Account where Name=:name];
              if(list_req != null && list_req.size()>0)
              {
                 acc.addError('客户名为'+name+'的记录已存在');
              }
          }
     }
     //更新客户是客户名查重
     public void updateCustomerRechecking(list<Account> list_acc,map<Id,Account> map_acc)
     {
          list<Account> list_req=new list<Account>();
          for(Account acc:list_acc)
          {
              if(acc.Name != map_acc.get(acc.Id).Name)
              {
                  list_req.add(acc);
              }
          }
          if(list_req != null && list_req.size()>0)
          {
              insertCustomerRechecking(list_req);
          }
     }
}