/**
 * Creat By : Jmark
 * Time : 2016年9月9日14:35:47
 * Describe: 新建，更新，删除时给设备的设备最新保修终止日期赋值。
 *    
 */
public class Cbl_Warrantyproduct_updateEquipment {
    //新建记录//恢复记录//更新记录//删除记录
    public void handleWp(list<Warrantyproduct__c> list_CO)
    {
    	set<Id> set_cid = new set<Id>();//业务机会Id
        for(Warrantyproduct__c co : list_CO)
        {
           if(!set_cid.contains(co.Equipment__c))
           {
               set_cid.add(co.Equipment__c);
           }
        }
        if(set_cid.size() > 0)
        {
            handleEQ(set_cid);
        }
    }
    //处理符合条件的设备，赋值
    public void handleEQ(set<Id> set_cid)
    {
    	//查询设备记录
        list<Equipment__c> list_cha = [select Id,newwarrantyEnd__c,warrantyEnd__c from Equipment__c where Id in:set_cid];
        //查询对应合约产品记录
        list<Warrantyproduct__c> list_co = [select Equipment__c,Warrantyenddate__c from Warrantyproduct__c where Equipment__c in:set_cid and Warrantyenddate__c != null order by Warrantyenddate__c desc];
        map<Id,Warrantyproduct__c> map_co = new map<Id,Warrantyproduct__c>();//存放最新的业务机会ID对应合约产品记录
        if(list_co != null && list_co.size()>0)
        {
            for(Warrantyproduct__c co : list_co)
            {
            	if(!map_co.containsKey(co.Equipment__c))
            	{
            	    map_co.put(co.Equipment__c,co);
            	}
            }
        }
        for(Equipment__c cha : list_cha)
        { 
           if(map_co.containsKey(cha.Id))
           {
               cha.newwarrantyEnd__c = map_co.get(cha.Id).Warrantyenddate__c;
           }
           else
           {
               cha.newwarrantyEnd__c = cha.warrantyEnd__c;
           }
        } 
        update list_cha;       
    }
}