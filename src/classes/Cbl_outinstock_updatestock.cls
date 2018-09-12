/*******************************************
**Create By: Arvin
**Time: ‎2015‎年‎2‎月‎26‎日17:18:50
**Describe: 自动增加修改库存数量，并产生出入库记录
********************************************/
public class Cbl_outinstock_updatestock 
{
	//新建出入库信息时
	public void insertStock(List<outinstock__c> list_newOutinstock)
	{
		
		set<String> set_Keys=new set<String>();//库存键值集合
		String strNewStockKey;
		
		for(outinstock__c o:list_newOutinstock)
		{
			if(o.state__c=='新品库')
			{
				//新创建的出入库需要修改库存数量
				strNewStockKey=o.ckplace__c+o.product__c+o.state__c;
				set_Keys.add(strNewStockKey);
			}

		}
		//当有符合条件的出入库记录的时候才进行接下来的修改库存数量
		if(set_Keys.size()>0)
		{
			//查找出入库纪录类型
			Map<id,RecordType> map_RecordType=new Map<id,RecordType>([Select r.SobjectType, r.Id, r.DeveloperName From RecordType r where r.SobjectType='outinstock__c']);
			List<stock__c> list_Stocks=[select id,xcnum__c,Stock_key__c,virtualnum__c from stock__c where Stock_key__c in:set_Keys];//根据#库存键值查找库存
			Map<String,stock__c> map_Stocks=new Map<String,stock__c>();//以#库存键值为Key，库存为value
			
			//组装map_Stocks
			if(list_Stocks!=null&&list_Stocks.size()>0)
			{
				for(stock__c s:list_Stocks)
				{
					map_Stocks.put(s.Stock_key__c,s);
				}
			}
			
			Decimal decCurrentTotal=0;
			Decimal decAvailableTotal=0;
			
			for(outinstock__c o:list_newOutinstock)
			{
				strNewStockKey=o.ckplace__c+o.product__c+o.state__c;
				//如果出入库找不到相应的库存报错提醒
				if(!map_Stocks.containsKey(strNewStockKey))
				{
					System.debug('请先创建库存再创建出入库单！');
					o.addError('请先创建库存再创建出入库单！');
				}
				else
				{
					//新创建的出入库需要修改库存数量

					if(map_RecordType!=null&&map_RecordType.containsKey(o.RecordTypeId))
					{
						o.stockNumber__c=map_Stocks.get(strNewStockKey).id;//给库存编号赋值
						
						if(map_RecordType.get(o.RecordTypeId).DeveloperName=='incangk'&&o.isquartify__c=='是')//入库增加库存
						{
							//更新现存数量
							decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)+o.number__c;
							map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
							system.debug('decCurrentTotal is:'+decCurrentTotal);
							//更新可用库存
							system.debug('map_Stocks.get(strNewStockKey).virtualnum__c is:'+map_Stocks.get(strNewStockKey).virtualnum__c);
							
							decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)+o.number__c;
							map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
							system.debug('decAvailableTotal is:'+decAvailableTotal);
						}
						if(map_RecordType.get(o.RecordTypeId).DeveloperName=='outcangk')//出库减少库存
						{
							//虚拟库存不足
							if(map_Stocks.get(strNewStockKey).virtualnum__c==null||map_Stocks.get(strNewStockKey).virtualnum__c==0)
							{
								o.addError('库存数量为0，无法出库');
							}
							else
							{
								decCurrentTotal=map_Stocks.get(strNewStockKey).xcnum__c-o.number__c;
								decAvailableTotal=map_Stocks.get(strNewStockKey).virtualnum__c-o.number__c;
								if(decAvailableTotal<0)
								{
									o.addError('库存不足，无法出库');
								}
								else
								{
									map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
									map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
								}
								
							}
							
						}
					}

				}
				
			}
			
			update map_Stocks.values();
		}
	
	}
	//更改出入库信息时
	public void updateStock(List<outinstock__c> list_newOutinstock,Map<ID,outinstock__c > map_oldOutinstock)
	{
		
		set<String> set_Keys=new set<String>();//库存键值集合
		String strNewStockKey;
		String strOldStockKey;
		
		for(outinstock__c o:list_newOutinstock)
		{
			strNewStockKey=o.ckplace__c+o.product__c+o.state__c;
			strOldStockKey=map_oldOutinstock.get(o.id).ckplace__c+map_oldOutinstock.get(o.id).product__c+map_oldOutinstock.get(o.id).state__c;
			if(
				o.product__c!=map_oldOutinstock.get(o.id).product__c//出入库上的产品变化需要修改变更前后库存数量
				||o.ckplace__c!=map_oldOutinstock.get(o.id).ckplace__c//出入库上的仓库地点变化需要修改变更前后库存数量
				||o.state__c!=map_oldOutinstock.get(o.id).state__c//出入库上的状态变化需要修改变更前后库存数量
				||o.number__c!=map_oldOutinstock.get(o.id).number__c//出入库上的数量变化需要修改库存数量
				||(o.isquartify__c=='是'&&o.isquartify__c!=map_oldOutinstock.get(o.id).isquartify__c)//是否确认入库值改变
				  )
			  {
			  	
			  	//添加变更之前的库存键值
			  	set_Keys.add(strOldStockKey);
			  	//添加变更之后的库存键值
			  	set_Keys.add(strNewStockKey);
			  }
			
			  
			
		
		}
		//当有符合条件的出入库记录的时候才进行接下来的修改库存数量
		if(set_Keys.size()>0)
		{
			Map<id,RecordType> map_RecordType=new Map<id,RecordType>([Select r.SobjectType, r.Id, r.DeveloperName From RecordType r where r.SobjectType='outinstock__c']);
			List<stock__c> list_Stocks=[select id,xcnum__c,Stock_key__c,virtualnum__c from stock__c where Stock_key__c in:set_Keys];//根据#库存键值查找库存
			Map<String,stock__c> map_Stocks=new Map<String,stock__c>();//以#库存键值为Key，库存为value
			
			//组装map_Stocks
			if(list_Stocks!=null&&list_Stocks.size()>0)
			{
				for(stock__c s:list_Stocks)
				{
					map_Stocks.put(s.Stock_key__c,s);
				}
			}
			
			Decimal decCurrentTotal=0;
			Decimal decAvailableTotal=0;
			
			for(outinstock__c o:list_newOutinstock)
			{
				strNewStockKey=o.ckplace__c+o.product__c+o.state__c;
				strOldStockKey=map_oldOutinstock.get(o.id).ckplace__c+map_oldOutinstock.get(o.id).product__c+map_oldOutinstock.get(o.id).state__c;
				//如果出入库找不到相应的库存报错提醒
				if(!map_Stocks.containsKey(strNewStockKey))
				{
					if(o.state__c=='新品库')
					{
						o.addError('请先创建库存再创建出入库单！');
					}
					
				}
				else
				{
					o.stockNumber__c=map_Stocks.get(strNewStockKey).id;//给库存编号赋值
					if(map_RecordType.get(o.RecordTypeId).DeveloperName=='incangk'&&o.isquartify__c=='是'&&o.isquartify__c!=map_oldOutinstock.get(o.id).isquartify__c)
					{
						if(o.state__c=='新品库')
						{
							decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)+o.number__c;
							decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)+o.number__c;
							
							map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
							map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
						}
					}
						
					if(
						o.product__c!=map_oldOutinstock.get(o.id).product__c//出入库上的产品变化需要修改变更前后库存数量
						||o.ckplace__c!=map_oldOutinstock.get(o.id).ckplace__c//出入库上的仓库地点变化需要修改变更前后库存数量
						||o.state__c!=map_oldOutinstock.get(o.id).state__c//出入库上的状态变化需要修改变更前后库存数量
				  	)
				  {
					  	
					  	
					  	/*
					  	if(map_RecordType.get(o.RecordTypeId).DeveloperName=='incangk')//入库
						{
							//减少原有库存数量
							
							if(map_oldOutinstock.get(o.id).state__c=='新品库')
							{
								if(map_Stocks.get(strOldStockKey).virtualnum__c==null||map_Stocks.get(strOldStockKey).virtualnum__c==0)
								{
									o.addError('库存数量为0，无法转移!');
								}
								else
								{
									decCurrentTotal=(map_Stocks.get(strOldStockKey).xcnum__c==null?0:map_Stocks.get(strOldStockKey).xcnum__c)-map_oldOutinstock.get(o.id).number__c;
									decAvailableTotal=(map_Stocks.get(strOldStockKey).virtualnum__c==null?0:map_Stocks.get(strOldStockKey).virtualnum__c)-map_oldOutinstock.get(o.id).number__c;
									if(decAvailableTotal<0)
									{
										o.addError('库存不足，无法转移!');
									}
									else
									{
										map_Stocks.get(strOldStockKey).xcnum__c=decCurrentTotal;
										map_Stocks.get(strOldStockKey).virtualnum__c=decAvailableTotal;
									}
									
								}
							}
							

							//增加新的库存数量
							if(o.state__c=='新品库')
							{
								decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)+o.number__c;
								decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)+o.number__c;
								
								map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
								map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
							}
							
							
						}*/
					  	if(map_RecordType.get(o.RecordTypeId).DeveloperName=='outcangk')//出库
					  	{
					  		//增加原有库存数量
					  		if(map_oldOutinstock.get(o.id).state__c=='新品库')
					  		{
					  			system.debug('map_Stocks.get(strOldStockKey) is:'+map_Stocks.get(strOldStockKey));
						  		decCurrentTotal=(map_Stocks.get(strOldStockKey).xcnum__c==null?0:map_Stocks.get(strOldStockKey).xcnum__c)+map_oldOutinstock.get(o.id).number__c;
								decAvailableTotal=(map_Stocks.get(strOldStockKey).virtualnum__c==null?0:map_Stocks.get(strOldStockKey).virtualnum__c)+map_oldOutinstock.get(o.id).number__c;
								
								map_Stocks.get(strOldStockKey).xcnum__c=decCurrentTotal;
								map_Stocks.get(strOldStockKey).virtualnum__c=decAvailableTotal;
					  		}
					  		
					  		
							
							//减少新的库存数量
							if(o.state__c=='新品库')
							{
								if(map_Stocks.get(strNewStockKey).virtualnum__c==null||map_Stocks.get(strNewStockKey).virtualnum__c==0)
								{
									o.addError('库存数量为0，无法转移!');
								}
								else
								{
									decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)-o.number__c;
									decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)-o.number__c;
									
									if(decAvailableTotal<0)
									{
										o.addError('库存不足，无法转移!');
									}
									else
									{
										map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
										map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
									}
									
								}
							}
							
					  	}
					  	
					  }
					  else if(o.number__c!=map_oldOutinstock.get(o.id).number__c)//出入库上的数量变化需要修改库存数量
					  {
					  	if(o.state__c=='新品库')
					  	{
					  		/*
					  		if(map_RecordType.get(o.RecordTypeId).DeveloperName=='incangk')//入库
							{
								//增加新的库存数量
								decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)+o.number__c-map_oldOutinstock.get(o.id).number__c;
								decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)+o.number__c-map_oldOutinstock.get(o.id).number__c;
								
								map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
								map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
								
							}
							*/
						  	if(map_RecordType.get(o.RecordTypeId).DeveloperName=='outcangk')//出库
						  	{
						  		//减少新的库存数量
								if(map_Stocks.get(strNewStockKey).virtualnum__c==null||map_Stocks.get(strNewStockKey).virtualnum__c==0)
								{
									o.addError('库存数量为0，无法出库!');
								}
								else
								{
									decCurrentTotal=(map_Stocks.get(strNewStockKey).xcnum__c==null?0:map_Stocks.get(strNewStockKey).xcnum__c)-o.number__c+map_oldOutinstock.get(o.id).number__c;
									decAvailableTotal=(map_Stocks.get(strNewStockKey).virtualnum__c==null?0:map_Stocks.get(strNewStockKey).virtualnum__c)-o.number__c+map_oldOutinstock.get(o.id).number__c;
									
									if(decAvailableTotal<0)
									{
										o.addError('库存不足，无法出库!');
									}
									else
									{
										map_Stocks.get(strNewStockKey).xcnum__c=decCurrentTotal;
										map_Stocks.get(strNewStockKey).virtualnum__c=decAvailableTotal;
									}
									
								}
						  	}
					  	}
					  	
					  	
				  }

				}
				
			}
			update map_Stocks.values();
		}
	
	}
	//删除出入库信息时
	public void deleteStock(List<outinstock__c> list_oldOutinstock)
	{

		set<String> set_Keys=new set<String>();//库存键值集合
		String strOldStockKey;
		Decimal decCurrentTotal=0;
		Decimal decAvailableTotal=0;
		
		for(outinstock__c o:list_oldOutinstock)
		{
			if(o.state__c=='新品库')
			{
				//删除出入库需要修改库存数量
				strOldStockKey=o.ckplace__c+o.product__c+o.state__c;
				set_Keys.add(strOldStockKey);
			}

		}
		//当有符合条件的出入库记录的时候才进行接下来的修改库存数量
		if(set_Keys.size()>0)
		{
			Map<id,RecordType> map_RecordType=new Map<id,RecordType>([Select r.SobjectType, r.Id, r.DeveloperName From RecordType r where r.SobjectType='outinstock__c']);
			List<stock__c> list_Stocks=[select id,xcnum__c,Stock_key__c,virtualnum__c from stock__c where Stock_key__c in:set_Keys];//根据#库存键值查找库存
			Map<String,stock__c> map_Stocks=new Map<String,stock__c>();//以#库存键值为Key，库存为value
			
			//组装map_Stocks
			if(list_Stocks!=null&&list_Stocks.size()>0)
			{
				for(stock__c s:list_Stocks)
				{
					map_Stocks.put(s.Stock_key__c,s);
				}
			}
			
			Decimal decTotal=0;
			
			for(outinstock__c o:list_oldOutinstock)
			{
				strOldStockKey=o.ckplace__c+o.product__c+o.state__c;
				//如果出入库找不到相应的库存报错提醒
				if(!map_Stocks.containsKey(strOldStockKey))
				{
					o.addError('请先创建库存再创建出入库单！');
				}
				else
				{
					//删除的出入库需要修改库存数量

					if(map_RecordType!=null&&map_RecordType.containsKey(o.RecordTypeId))
					{

						if(map_RecordType.get(o.RecordTypeId).DeveloperName=='incangk'&&o.isquartify__c=='是')//入库减少库存
						{
							//减少新的库存数量
							if(map_Stocks.get(strOldStockKey).virtualnum__c==null||map_Stocks.get(strOldStockKey).virtualnum__c==0)
							{
								o.addError('库存数量为0，无法删除!');
							}
							else
							{
								decCurrentTotal=(map_Stocks.get(strOldStockKey).xcnum__c==null?0:map_Stocks.get(strOldStockKey).xcnum__c)-o.number__c;
								decAvailableTotal=(map_Stocks.get(strOldStockKey).virtualnum__c==null?0:map_Stocks.get(strOldStockKey).virtualnum__c)-o.number__c;
								
								if(decAvailableTotal<0)
								{
									o.addError('库存不足，无法删除!');
								}
								else
								{
									map_Stocks.get(strOldStockKey).xcnum__c=decTotal;
									map_Stocks.get(strOldStockKey).virtualnum__c=decAvailableTotal;
								}
								
							}
							
						}
						if(map_RecordType.get(o.RecordTypeId).DeveloperName=='outcangk')//出库增加库存
						{
							decCurrentTotal=map_Stocks.get(strOldStockKey).xcnum__c+o.number__c;
							decAvailableTotal=map_Stocks.get(strOldStockKey).virtualnum__c+o.number__c;
							map_Stocks.get(strOldStockKey).xcnum__c=decCurrentTotal;
							map_Stocks.get(strOldStockKey).virtualnum__c=decAvailableTotal;

						}
					}

				}
				
			}
			update map_Stocks.values();
		}
	
	
	}

}