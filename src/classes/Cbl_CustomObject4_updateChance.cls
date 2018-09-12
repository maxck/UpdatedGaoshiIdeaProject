/**
 * Creat By : Jmark
 * Time : 2016年8月25日10:15:36
 * Describe: 业务机会视图引用最新项目进展记录的信息：
 * A． 显示项目进展记录中的哪几个字段? 需显示5个字段：拜访日期，拜访人员，拜访方式，沟通内容，下一步方案
 * B． 最新项目进展记录最新的标准是什么？ 标准是：最后一次录入的一条项目进展记录（最新的创建时间）。
 * C． 项目进展记录创建后会不会修改更新，此时修改过内容是否再覆盖？，如最后一条记录创建后再更新，则以更新后的内容为准，即修改过的内容再覆盖。
 * D． 项目进展记录创建后会不会删除，此时怎么处理？如创建后删除，则自动修改成被删除记录的前一条记录。
 *    
 */
public class Cbl_CustomObject4_updateChance {
    //新建记录//恢复记录//更新记录//删除记录
    public void handleCO(list<CustomObject4__c> list_CO)
    {
    	set<Id> set_cid = new set<Id>();//业务机会Id
        for(CustomObject4__c co : list_CO)
        {
           if(!set_cid.contains(co.business_chance__c))
           {
               set_cid.add(co.business_chance__c);
           }
        }
        if(set_cid.size() > 0)
        {
            handleChance(set_cid);
        }
    }
    //处理符合条件的业务机会，赋值
    public void handleChance(set<Id> set_cid)
    {
    	//查询对应业务机会记录
        list<chance__c> list_cha = [select Id,Visit_way__c,Visit_member__c,Visit_date__c,next_step__c,communication_content__c from chance__c where Id in:set_cid];
        //查询对应项目进展记录
        list<CustomObject4__c> list_co = [select Field1__c,Visit_member__c,Visit_date__c,next_step__c,communication_content__c,business_chance__c from CustomObject4__c where business_chance__c in:set_cid order by CreatedDate desc];
        map<Id,CustomObject4__c> map_co = new map<Id,CustomObject4__c>();//存放最新的业务机会ID对应项目进展记录
        if(list_co != null && list_co.size()>0)
        {
            for(CustomObject4__c co : list_co)
            {
            	if(!map_co.containsKey(co.business_chance__c))
            	{
            	    map_co.put(co.business_chance__c,co);
            	}
            }
        }
        for(chance__c cha : list_cha)
        { 
           if(map_co.containsKey(cha.Id))
           {
               cha.Visit_way__c = map_co.get(cha.Id).Field1__c;
               cha.Visit_member__c = map_co.get(cha.Id).Visit_member__c;
               cha.Visit_date__c = map_co.get(cha.Id).Visit_date__c;
               cha.next_step__c = map_co.get(cha.Id).next_step__c;
               cha.communication_content__c = map_co.get(cha.Id).communication_content__c;
           }
           else
           {
               cha.Visit_way__c = null;
               cha.Visit_member__c = null;
               cha.Visit_date__c = null;
               cha.next_step__c = null;
               cha.communication_content__c = null;
           }
        } 
        update list_cha;       
    }
}