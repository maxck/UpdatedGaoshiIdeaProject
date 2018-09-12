/*
*Creat By : Arvin
*Email: arvinxiang@frensworkz.com
*Time : 2015年03月02日
*Describe :  备件申请判断审批状态，提交审批则虚拟库存减少
*     		审批拒绝或调回则虚拟库存加回
*/
public class Cbl_sparepart_spstate  
{
	//新建备件申请时
	public void insertsparepart(list<sparepart__c> list_sparepart)
	{
		/*set<String> set_sparepart = new set<String>();//备件申请集
		String strNewSparepart;//备件申请名称
		for(sparepart__c sp :list_sparepart)
		{
			//审批状态为'审批中'进行可用库存的减少，其他状态不用这一操作
			System.debug('审批状态==='+sp.spstate__c);
			if(sp.spstate__c == '审批中')
			{
				strNewSparepart=sp.Id;
				set_sparepart.add(strNewSparepart);
			}
		}
		if(set_sparepart.size()>0)
		{
			//备件明细list
			list<sparepartdetail__c> list_spdetail = [select id,partnum__c,number__c from sparepartdetail__c where sparepartdetail__c.sparepart__c in :set_sparepart];
			System.debug('******'+list_spdetail+'******');
			set<String> set_spdetail = new set<String>();//备件明细集
			String strNewSpdetail;//备件明细
			Map<ID,sparepartdetail__c> map_spdetail = new Map<ID,sparepartdetail__c>();
			if(list_spdetail!=null&&list_spdetail.size()>0)
			{	
				//组装map_spdetail
				for(sparepartdetail__c spd :list_spdetail)
				{
					strNewSpdetail = spd.partnum__c;//备件明细的查找库存字段
					set_spdetail.add(strNewSpdetail);
					map_spdetail.put(spd.Id,spd);
					System.debug(spd.Id+'的数量=='+spd.number__c);
				}
			}
			//备件明细产品库存list
			
			list<stock__c> list_stock = [select id,virtualnum__c from stock__c where stock__c.Id in:set_spdetail];
			System.debug('*****'+list_stock+'*****');
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
			for(sparepart__c sp:list_sparepart)
			{
				for(sparepartdetail__c spd:list_spdetail)
				{
					for(stock__c s:list_stock)
					{
						//如果找不到备件明细产品库存报错提醒
						if(!map_stock.containsKey(map_stock.get(s.Id).Id))
						{
							System.debug('请先创建库存再创建备件申请！');
							sp.addError('请先创建库存再创建备件申请！');
						}
						//找到库存
						else
						{
							//审批状态为审批中，可用库存减少
							System.debug('可用库存=='+map_stock.get(s.Id).virtualnum__c);
							if(map_stock.get(s.Id).virtualnum__c==null||map_stock.get(s.Id).virtualnum__c==0)
							{
								sp.addError('库存为0，不能申请！');
							}
							else
							{
								decVirtualTotal=map_stock.get(s.Id).virtualnum__c-map_spdetail.get(spd.Id).number__c;
								System.debug('可用库存=='+decVirtualTotal);
								if(decVirtualTotal<0)
								{
									sp.addError('库存不足，不能申请！');
								}
								else
								{
									map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
									System.debug('更新后可用库存=='+map_stock.get(s.id).virtualnum__c);
								}
							}
							
							
						}
					}
				}
			
			}
			update map_stock.values();
			
		}*/
		
	}
	//更新备件申请时
	public void updatesparepart(list<sparepart__c> list_sparepart , Map<ID,sparepart__c> map_oldSparepart)
	{
		/*set<String> set_sparepart = new set<String>();//备件申请集
		String strNewSparepart;//新备件申请名称
		String strOldSparepart;//旧备件申请名称
		
		for(sparepart__c sp :list_sparepart)
		{
		
			strNewSparepart=sp.Id;
			strOldSparepart=map_oldSparepart.get(sp.Id).Id;
			System.debug('新审批状态==='+sp.spstate__c);
			System.debug('更改前的审批状态==='+map_oldSparepart.get(sp.Id).spstate__c);
			if(sp.spstate__c!=map_oldSparepart.get(sp.Id).spstate__c)//审批状态改变
			{
				set_sparepart.add(strNewSparepart); 
				set_sparepart.add(strOldSparepart);
			}
		}
		if(set_sparepart.size()>0)
		{
			//备件明细list
			list<sparepartdetail__c> list_spdetail = [select id,partnum__c,number__c  from sparepartdetail__c where sparepartdetail__c.sparepart__c in :set_sparepart];
			System.debug('******'+list_spdetail+'******');
			set<String> set_spdetail = new set<String>();//备件明细集
			String strNewSpdetail;//备件明细
			Map<ID,sparepartdetail__c> map_spdetail = new Map<ID,sparepartdetail__c>();
			if(list_spdetail!=null&&list_spdetail.size()>0)
			{	
				//组装map_spdetail
				for(sparepartdetail__c spd :list_spdetail)
				{
					strNewSpdetail = spd.partnum__c;//备件明细的查找库存字段
					set_spdetail.add(strNewSpdetail);
					map_spdetail.put(spd.Id,spd);
					System.debug(spd.Id+'的数量=='+spd.number__c);
				}
			}
			//备件明细产品库存list
			list<stock__c> list_stock = [select id,virtualnum__c from stock__c where stock__c.Id in:set_spdetail];
			System.debug('*****'+list_stock+'*****');
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
			for(sparepart__c sp:list_sparepart)
			{
				strNewSparepart=sp.Id;
				strOldSparepart=map_oldSparepart.get(sp.Id).Id;
				for(sparepartdetail__c spd:list_spdetail)
				{
					for(stock__c s:list_stock)
					{
						
						//如果找不到备件明细产品库存报错提醒
						if(!map_stock.containsKey(map_stock.get(s.Id).Id))
						{
							System.debug('请先创建库存再创建备件申请！');
							sp.addError('请先创建库存再创建备件申请！');
						}
						//找到库存
						else
						{
							//审批状态为审批中，可用库存减少
							if(sp.spstate__c=='审批中')
							{
								System.debug('可用库存=='+map_stock.get(s.Id).virtualnum__c);
								if(map_stock.get(s.Id).virtualnum__c==null||map_stock.get(s.Id).virtualnum__c==0)
								{
									sp.addError('库存为0，不能申请！');
								}
								else
								{
									decVirtualTotal=map_stock.get(s.Id).virtualnum__c-map_spdetail.get(spd.Id).number__c;
									System.debug('新的可用库存=='+decVirtualTotal);
									if(decVirtualTotal<0)
									{
										sp.addError('库存不足，不能申请！');
									}
									else
									{
										map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
									}
								}
							}
							//非审批通过即审批拒绝，调回，草稿时可用库存加回
							else if(sp.spstate__c!='审批通过')
							{
								//加回可用库存
								decVirtualTotal=(map_stock.get(s.id).virtualnum__c==null?0:map_stock.get(s.id).virtualnum__c)+map_spdetail.get(spd.Id).number__c;
								System.debug('可用库存=='+decVirtualTotal);
								map_stock.get(s.id).virtualnum__c=decVirtualTotal;
								System.debug('更新后可用库存=='+map_stock.get(s.id).virtualnum__c);
							}
							
						}
					}
				}
			
			}
			update map_stock.values();
			
		}
		*/
	}
	//删除备件申请
	public void deletesparepart(list<sparepart__c> list_sparepart)
	{
		/*set<String> set_sparepart = new set<String>();//备件申请集
		String strOldSparepart;//备件申请名称
		for(sparepart__c sp :list_sparepart)
		{
			//审批状态为'审批中'进行可用库存的减少，其他状态不用这一操作
			System.debug('审批状态==='+sp.spstate__c);
			if(sp.spstate__c == '审批中')
			{
				strOldSparepart=sp.Id;
				set_sparepart.add(strOldSparepart);
			}
		}
		
		if(set_sparepart.size()>0)
		{
			System.debug('*****'+set_sparepart+'*****');
			//备件明细list
			list<sparepartdetail__c> list_spdetail = [select id,partnum__c,number__c  from sparepartdetail__c where sparepartdetail__c.sparepart__c in :set_sparepart];
			System.debug('******'+list_spdetail+'******');
			set<String> set_spdetail = new set<String>();//备件明细集
			String strNewSpdetail;//备件明细
			Map<ID,sparepartdetail__c> map_spdetail = new Map<ID,sparepartdetail__c>();
			if(list_spdetail!=null&&list_spdetail.size()>0)
			{	
				//组装map_spdetail
				for(sparepartdetail__c spd :list_spdetail)
				{
					strNewSpdetail = spd.partnum__c;//备件明细的查找库存字段
					set_spdetail.add(strNewSpdetail);
					map_spdetail.put(spd.Id,spd);
					System.debug(spd.Id+'的数量=='+spd.number__c);
				}
			}
			//备件明细产品库存list
			list<stock__c> list_stock = [select id,virtualnum__c from stock__c where stock__c.Id in:set_spdetail];
			System.debug('*****'+list_stock+'*****');
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
			for(sparepart__c sp:list_sparepart)
			{
				for(sparepartdetail__c spd:list_spdetail)
				{
					for(stock__c s:list_stock)
					{
						//如果找不到备件明细产品库存报错提醒
						if(!map_stock.containsKey(map_stock.get(s.Id).Id))
						{
							System.debug('请先创建库存再创建备件申请！');
							sp.addError('请先创建库存再创建备件申请！');
						}
						//找到库存
						else
						{
							//删除备件申请，可用库存加回
							System.debug('可用库存=='+map_stock.get(s.Id).virtualnum__c);
							decVirtualTotal=map_stock.get(s.Id).virtualnum__c+map_spdetail.get(spd.Id).number__c;
							map_stock.get(s.Id).virtualnum__c=decVirtualTotal;
							System.debug('更新后可用库存=='+map_stock.get(s.id).virtualnum__c);
						}
					}
				}
			}
			update map_stock.values();
		}
		*/
	}

}