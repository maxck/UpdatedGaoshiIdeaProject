/*
*Creat By : Arvin
*Email: arvinxiang@frensworkz.com
*Time : 2015年03月02日
*Describe :  备件明细申请审批通过并状态为已发货 自动创建出库记录，通过出库记录做库存减少
*/
public class Cbl_sparepartdetail_state 
{
    //新建备件明细
    public void insertspdetail(list<sparepartdetail__c> list_spdetail)
    {
        set<String> set_spdetail = new set<String>();//备件明细集
        String strNewSpdetail;
        product__c pro = new product__c();
        for(sparepartdetail__c spd:list_spdetail)
        {
            //当新建的备件明细状态为‘已发货’，创建出库单
            //状态为‘未发货’，不需要创建出库单
            //if(spd.state__c=='已发货')
            //{
                strNewSpdetail=spd.partnum__c;
                set_spdetail.add(strNewSpdetail);
            //}
        }
        //满足已发货状态的备件明细
        if(set_spdetail.size()>0)
        {
            
            list<stock__c> list_stock = [select id,warehouse__c,state__c,ProductCName__c,ProductNumber__c,virtualnum__c from stock__c where stock__c.Id in:set_spdetail];
            Map<ID,stock__c> map_stock = new Map<ID,stock__c>();//以库存ID为键值，备件明细产品库存为value
            if(list_stock!=null&&list_stock.size()>0)
            {
                //组装map_stock
                for(stock__c s:list_stock)
                {
                    map_stock.put(s.Id,s);
                }
            }
            Decimal decVirtualTotal=0;//备件明细产品可用库存
            list<outinstock__c> list_ois = new list<outinstock__c>();
            for(sparepartdetail__c spd:list_spdetail)
            {
                for(stock__c s:list_stock)
                {
                    System.debug('--------产品编号------'+s.ProductNumber__c);
                    //如果找不到备件明细产品库存报错提醒
                    if(!map_stock.containsKey(map_stock.get(s.Id).Id))
                    {
                        System.debug('请先创建库存再创建备件明细！');
                        spd.addError('请先创建库存再创建备件明细！');
                    }
                    //找到库存
                    else
                    {
                        String strName=s.ProductNumber__c;
                        pro = [select id,Name,Cname__c,Ename__c from product__c where product__c.Id =:strName];
                        System.debug('======='+pro.Id+'=======');
                        spd.KCBH__c=spd.partnum__c;
                        spd.productname__c=pro.Id;
                        
                        decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)-spd.number__c;
                        /*if(decVirtualTotal<0)//2016.08.24去除当虚拟库存为0时不能提交备件申请（具体为不能创建备件明细，去除限制条件
                        {
                            spd.addError('库存不足，不能创建备件明细！');
                        }
                        else
                        {*/
                            //map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                            //当新建的备件明细状态为‘已发货’，创建出库单
                            //状态为‘未发货’，不需要创建出库单
                            if(spd.state__c=='已发货')
                            {
                                //可用库存加回
                                decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+spd.number__c;
                                System.debug('可用库存=='+decVirtualTotal);
                                map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                                System.debug('更新后可用库存=='+map_stock.get(s.Id).virtualnum__c);
                                //创建出库单
                                RecordType RecordOutcangk=[Select r.SobjectType, r.Id, r.DeveloperName 
                                        From RecordType r 
                                        where r.SobjectType='outinstock__c'
                                        and r.DeveloperName='outcangk'];//设定出入库类型为出库
                                //出库单内容填写
                                outinstock__c outs = new outinstock__c();
                                outs.product__c =s.ProductNumber__c;//产品
                                outs.ckplace__c =s.warehouse__c;//仓库地点
                                outs.state__c =s.state__c;//状态库
                                outs.number__c =spd.number__c;//数量
                                outs.RecordTypeId=RecordOutcangk.id;//出库
                                list_ois.add(outs);
                            }
                        //}
                    }
                    System.debug('*****'+list_ois+'*****');
                }
                
            }
            update map_stock.values();
            insert list_ois;
                
        }
        
    }
    
    //更改备件明细
    public void updatespdetail(list<sparepartdetail__c> list_spdetail,Map<ID,sparepartdetail__c> map_OldSpdetail)
    {
        
        //备件明细集
        set<String> set_spdetail = new set<String>();
        String strNewSpdetail;//新的备件明细集
        String strOldSpdetail;//旧的备件明细集
        product__c pro = new product__c();
        for(sparepartdetail__c spd:list_spdetail)
        {
            strNewSpdetail=spd.partnum__c;
            strOldSpdetail=map_OldSpdetail.get(spd.Id).partnum__c;
            System.debug('新状态==='+spd.state__c);
            System.debug('更改前的状态==='+map_OldSpdetail.get(spd.Id).state__c);
            /*
            if(map_OldSpdetail.get(spd.Id).state__c=='未发货')//状态改变
            {
                set_spdetail.add(strNewSpdetail);
                set_spdetail.add(strOldSpdetail);
            }
            else if(map_OldSpdetail.get(spd.Id).state__c=='已发货')//状态为已发货
            {
                spd.addError('产品已发货，不能修改！');
            }*/
            //取消已发货不可修改的逻辑
            if(map_OldSpdetail.get(spd.Id).state__c=='未发货')//状态改变
            {
                set_spdetail.add(strNewSpdetail);
                set_spdetail.add(strOldSpdetail);
            }
            
        }
        
        //满足条件的备件明细
        if(set_spdetail.size()>0)
        {
            
            list<stock__c> list_stock = [select id,warehouse__c,state__c,ProductCName__c,ProductNumber__c,virtualnum__c from stock__c where Id in:set_spdetail];
            System.debug('****'+list_stock+'****');
            Map<ID,stock__c> map_stock = new Map<ID,stock__c>();//以库存ID为键值，备件明细产品库存为value
            if(list_stock!=null&&list_stock.size()>0)
            {
                //组装map_stock
                for(stock__c s:list_stock)
                {
                    map_stock.put(s.Id,s);
                }
            }
            Decimal decVirtualTotal=0;//备件明细产品可用库存
            list<outinstock__c> list_ois = new list<outinstock__c>();
            RecordType RecordOutcangk=[Select r.SobjectType, r.Id, r.DeveloperName 
                            From RecordType r 
                            where r.SobjectType='outinstock__c'
                            and r.DeveloperName='outcangk'];//设定出入库类型为出库
            for(sparepartdetail__c spd:list_spdetail)
            {
                strNewSpdetail=spd.partnum__c;
                strOldSpdetail=map_OldSpdetail.get(spd.Id).partnum__c;
                System.debug('New==='+spd.partnum__c);
                System.debug('Old==='+map_OldSpdetail.get(spd.Id).partnum__c);
                for(stock__c s:list_stock)
                {
                    //如果找不到备件明细产品库存报错提醒
                    if(!map_stock.containsKey(map_stock.get(s.Id).Id))
                    {
                        System.debug('请先创建库存再创建备件明细！');
                        spd.addError('请先创建库存再创建备件明细！');
                    }
                    //找到库存
                    else
                    {
                        String strName=s.ProductNumber__c;
                        pro = [select id,Name,Cname__c,Ename__c from product__c where product__c.Id =:strName];
                        System.debug('======='+pro.Id+'=======');
                        spd.KCBH__c=spd.partnum__c;
                        spd.productname__c=pro.Id;
                        //当状态从未发货改成已发货,数量未改变
                        if(spd.state__c=='已发货'
                            &&map_OldSpdetail.get(spd.Id).state__c=='未发货'
                            &&spd.number__c==map_OldSpdetail.get(spd.Id).number__c)
                        {
                            //可用库存加回
                            System.debug('数量未变的可用库存=='+map_stock.get(s.Id).virtualnum__c);
                            decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+spd.number__c;
                            
                            map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                            System.debug('数量未变的更新后可用库存=='+map_stock.get(s.Id).virtualnum__c);
                            System.debug(s.warehouse__c+    +s.state__c);
                            //创建出库单
                            //出库单内容填写
                            outinstock__c outs = new outinstock__c();
                            outs.product__c =s.ProductNumber__c;//产品
                            outs.ckplace__c =s.warehouse__c;//仓库地点
                            outs.state__c =s.state__c;//状态库
                            outs.number__c =spd.number__c;//数量
                            outs.RecordTypeId=RecordOutcangk.id;//出库
                            list_ois.add(outs);
                            system.debug('list_oislist_oislist_ois11111111'+list_ois);
                        }
                        //状态和数量都改变
                        else if(spd.number__c!=map_OldSpdetail.get(spd.Id).number__c
                                    &&spd.state__c=='已发货'
                                    &&map_OldSpdetail.get(spd.Id).state__c=='未发货')
                        {
                            //原先可用库存加回
                            decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+map_OldSpdetail.get(spd.Id).number__c;
                            System.debug('可用库存=='+decVirtualTotal);
                            map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                            //新的可用库存减少
                            decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)-spd.number__c;
                            /*if(decVirtualTotal<0)//如果更改后的数量导致可用库存不足报错//2016.10.25去除当虚拟库存为0时不能提交备件申请（具体为不能创建备件明细，去除限制条件
                            {
                                spd.addError('库存不足，无法修改！');
                            }
                            else
                            {*/
                                map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                                //可用库存加回
                                decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+spd.number__c;
                                System.debug('数量改变的可用库存=='+decVirtualTotal);
                                map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                                System.debug('数量改变的更新后可用库存=='+map_stock.get(s.Id).virtualnum__c);
                                //出库单内容填写
                                outinstock__c outs = new outinstock__c();
                                outs.product__c =s.ProductCName__c;//产品
                                outs.ckplace__c =s.warehouse__c;//仓库地点
                                outs.state__c =s.state__c;//状态库
                                outs.number__c =spd.number__c;//数量
                                outs.RecordTypeId=RecordOutcangk.id;//出库
                                list_ois.add(outs);
                                system.debug('list_oislist_oislist_ois2222222'+list_ois);
                            //}
                            //创建出库单
                            
                            
                        }
                        
                        //数量改变
                        else
                        {
                            if(spd.state__c=='未发货'&&map_OldSpdetail.get(spd.Id).state__c=='未发货')
                            {
                                //原先可用库存加回
                                decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+
                                               (map_OldSpdetail.get(spd.Id).number__c==null?0:map_OldSpdetail.get(spd.Id).number__c);
                                System.debug('可用库存=='+decVirtualTotal);
                                map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                                //新的可用库存减少
                                decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)-spd.number__c;
                                /*if(decVirtualTotal<0)//如果更改后的数量导致可用库存不足报错
                                {
                                    spd.addError('库存不足，无法修改！');
                                }
                                else
                                {*/
                                    map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                                //}
                            }
                            /*else if(map_OldSpdetail.get(spd.Id).state__c=='已发货')//状态为已发货
                            {
                                spd.addError('产品已发货，不能修改！');
                            }*/
                        }
                    }
                    System.debug('*****'+list_ois+'*****');
                    
                }
                
            }
            update map_stock.values();
            insert list_ois;
                
        }
    }
    
    //删除备件明细
    public void deletespdetail(list<sparepartdetail__c> list_spdetail)
    {
        set<String> set_spdetail = new set<String>();//备件明细集
        String strNewSpdetail;
        for(sparepartdetail__c spd:list_spdetail)
        {
            //当新建的备件明细状态为‘未发货’
            //状态为‘已发货’，不能删除
            if(spd.state__c=='未发货')
            {
                strNewSpdetail=spd.partnum__c;
                set_spdetail.add(strNewSpdetail);
            }
            else
            {
                spd.addError('产品已发货');  
            }
        }
        //满足已发货状态的备件明细
        if(set_spdetail.size()>0)
        {
            
            list<stock__c> list_stock = [select id,warehouse__c,state__c,ProductCName__c,ProductNumber__c,virtualnum__c from stock__c where stock__c.Id in:set_spdetail];
            Map<ID,stock__c> map_stock = new Map<ID,stock__c>();//以库存ID为键值，备件明细产品库存为value
            if(list_stock!=null&&list_stock.size()>0)
            {
                //组装map_stock
                for(stock__c s:list_stock)
                {
                    map_stock.put(s.Id,s);
                }
            }
            Decimal decVirtualTotal=0;//备件明细产品可用库存
            
            for(sparepartdetail__c spd:list_spdetail)
            {
                for(stock__c s:list_stock)
                {
                    //如果找不到备件明细产品库存报错提醒
                    if(!map_stock.containsKey(map_stock.get(s.Id).Id))
                    {
                        System.debug('请先创建库存再删除备件明细！');
                        spd.addError('请先创建库存再删除备件明细！');
                    }
                    //找到库存
                    else
                    {
                        //可用库存加回
                        decVirtualTotal=(map_stock.get(s.Id).virtualnum__c==null?0:map_stock.get(s.Id).virtualnum__c)+spd.number__c;
                        System.debug('可用库存=='+decVirtualTotal);
                        map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
                        System.debug('更新后可用库存=='+map_stock.get(s.Id).virtualnum__c);
                        
                    }
                }
                
            }
            update map_stock.values();
                
        }
    }
}