/**
 * Creat By : Jmark
 * Time : 2016年8月26日15:14:44
 * Describe: 【业务机会】中的最终成交价=【保修合约】的保修价格。   
*/
public class Cbl_Warranty_updateChance {
    //新建记录//恢复记录//更新记录
    public void insertWar(list<Warranty__c> list_war)
    {
    	set<Id> set_cid = new set<Id>();//业务机会Id
    	map<Id,Warranty__c> map_war = new map<Id,Warranty__c>();
        for(Warranty__c war : list_war)
        {
           if(war.chance__c != null &&!set_cid.contains(war.chance__c))
           {
               set_cid.add(war.chance__c);
           }
           if(war.chance__c != null &&!map_war.containsKey(war.chance__c))
           {
              map_war.put(war.chance__c,war);
           }
        }
        if(set_cid.size() > 0)
        {
            list<chance__c> list_cha = [select Id,Final_sale_price_del__c from chance__c where Id in:set_cid];
            for(chance__c cha : list_cha)
            {
                cha.Final_sale_price_del__c = map_war.get(cha.Id).prince__c;
            }
            update list_cha;
        }
    }
    //删除记录
    public void deleteWar(list<Warranty__c> list_war)
    {
    	set<Id> set_cid = new set<Id>();//业务机会Id
        for(Warranty__c war : list_war)
        {
           if(war.chance__c != null &&!set_cid.contains(war.chance__c))
           {
               set_cid.add(war.chance__c);
           }
        }
        if(set_cid.size() > 0)
        {
            list<chance__c> list_cha = [select Id,Final_sale_price_del__c from chance__c where Id in:set_cid];
            for(chance__c cha : list_cha)
            {
                cha.Final_sale_price_del__c = null;
            }
            update list_cha;
        }
    }
}