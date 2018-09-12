public class OrderHelper {
	
    public static boolean isFirstRun = true;
    @future(callout=true)
    public static void syncOrderinfoByTrigger(String orderId)
    {
    	syncOrderinfo(orderId);
    }
	//
	public static Map<String, String> PublicPrivate2Code = new Map<String, String>{
		'公立' => '01',
		'民营' => '02'
	};
	
	public static Map<String, String> Classify12Code = new Map<String, String>{
		'直销' => '01',
		'渠道' => '02'
	};
	
	public static Map<String, String> Classify22Code = new Map<String, String>{
		'公立直销' => '01',
		'区域代理' => '02',
		'个案代理' => '03',
		'独立民营' => '04',
		'集团客户' => '05',
		'投资平台' => '06'

	};
	
	public static Map<String, String> Classify32Code = new Map<String, String>{
		'公立直销' => '01',
		'区域代理' => '02',
		'个案代理' => '03',
		'蓝海之略' => '04',
		'远程视界' => '05',
		'全科医疗' => '06',
		'独立民营' => '07',
		'爱尔集团' => '08',
		'华厦集团' => '08',
		'华正集团' => '10',
		'朝聚眼科' => '11',
		'新视界' => '12',
		'阿玛施集团' => '13',
		'普瑞集团' => '14'

	};
	
	public static Map<String, String> orderTypeName2Code = new Map<String, String>{
		'设备内贸销售' => '30-Cxx-01',
		'设备外贸销售' => '30-Cxx-02',
		'耗材销售' => '30-Cxx-03',
		'耗品销售' => '30-Cxx-04',
		'技术服务维修销售' => '30-Cxx-05',
		'技术服务保修销售' => '30-Cxx-06',
		'技术配件销售' => '30-Cxx-07',
		'技术耗材销售' => '30-Cxx-08',
		'寄存销售' => '30-Cxx-09',
		'技术服务延保销售' => '30-Cxx-10',
		'设备租赁' => '30-Cxx-11'
	};
	
	//NC 确认，不能修改。
	public static Map<String, String> unitTranslation = new Map<String, String>
	{
		'千克'=>'KGM',
		'克'=>'GRM',
		'吨'=>'TNE',
		'米'=>'MTR',
		'分米'=>'DMT',
		'厘米'=>'CMT',
		'升'=>'LTR',
		'个'=>'EA',
		'箱'=>'BOX',
		'台'=>'TAI'
		
	};
	
	//项目编码 
	public static Map<String, String> projectName2Code = new Map<String, String>
	{
			'光太' => '1004',
			'欧堡' => '1010',
			'瑞贝科' => '1011',
			'耗品' => '1012',
			'罗兰' => '1009',
			'歌德' => '1003',
			'KOWA' => '1001',
			'徕卡' => '1007',
			'海涅' => '1006',
			'飞白' => '1002',
			'海德堡' => '1005',
			'路视' => '1008',
			'准分子' => '1013',
			'Diopsys' => '1019',
			'雷蒙高新' => '1015',
			'VR Magic' => '1020',
			'高斯高新' => '1017',
			'高斯普通' => '1018',
			'其他' => '1014',
			'雷蒙普通' => '1016',
			'光太激光' => '1004',
			'光太超声' => '1004',
			'NeoMedix' => '1011',
			'OPTOS' => '1010',
			'SCHWIND' => '1013',
			'LENSAR' => '1002',
			'LUNEAU' => '1008',
			'HEINE' => '1006',
			'GI' => '1014',
			'Vrmagic' => '1020'
	};
	
	public static Map<String, String> salesProcessName2Code = new Map<String, String>
	{
		'高视普通销售' => 'SO01',
		'技术服务延保销售' => 'GS02',
		'技术服务维修销售' => 'GS04',
		'寄存销售' => 'Cxx-01',
		'技术服务保修销售' => 'GS03',
		'高视普通销售' => 'SO01'
				
	};
	
	public static Map<String, decimal> countryCode2Rate = new Map<String, decimal>();
	static
	{
		for (CurrencyType tempCurrencyType : [SELECT ISOCode, ConversionRate FROM CurrencyType WHERE IsActive=TRUE])
		{
			countryCode2Rate.put(tempCurrencyType.ISOCode, tempCurrencyType.ConversionRate);
		}
	}
	
	//未来替换到 custom setting中的内容。
	public Static Map<String, String> salesOrgName2Code = new Map<String, String>
	{
		'上海明望医疗器械有限公司' => '152',
		'天津高视晶品医疗技术有限公司' => '155',
		'Global Vision HongKong Limited' => '11',
		'上海高视医疗技术有限公司' => '153',
		'宁波高视精密医疗技术有限公司' => '154',
		'北京高视远望科技有限责任公司' => '151',
		'天津高视众望科技有限公司' => '156',
		'温州雷蒙光电科技有限公司' => '1571',
		'宁波高斯医疗科技有限公司' => '157'
	};
	
    public static orderhelper.ExecutionResult syncOrderinfo(String orderId)
    {	
    	
    	orderhelper.ExecutionResult result = new orderhelper.ExecutionResult();
        Order syncOrder = [select id, ordernumber,  
        					// 0 -> ....
        					MarketingOrganizing__c, 
							recordtype.name,
						    EffectiveDate, 
						    Account.name,
							Account.CRMCodingFormula__c,
							Belonger__r.NCNumber__c,// change from NCemploye__c to Belonger__r.NCNumber__c
							Amount__c,
							ContractAmount__c, 
							Introductions__c,
							PublicPrivate__c,
							Classify__c,
							ClassifyII__c,
							ClassifyIII__c,
							FinalCustomer__r.CRMCodingFormula__c,
							Merchandiser__r.NCNumber__c,
							Contract.ContractNumber,//ContractNO__c,
							WarrantyPeriod__c,
							WarrantyStartDate__c,
							WarrantyEndDate__c,
							Financing__c,
							ResponsiblePerson__c,
							ExportDate__c,
							createddate,
							BusinessProcess__c,
							CurrencyIsoCode
        					from order where id = :orderId];
        //0 -> max
        String salesOrgCode = (salesOrgCode2Name.containsKey(syncOrder.MarketingOrganizing__c) ? salesOrgCode2Name.get(syncOrder.MarketingOrganizing__c) : '');
        String accountCode = (syncOrder.Account.CRMCodingFormula__c == null ? '' : syncOrder.Account.CRMCodingFormula__c);
        String currencyCode = (syncOrder.CurrencyIsoCode);
        List<String> argumentsAboutOrder = new List<String>{
        					(salesOrgCode2Name.containsKey(syncOrder.MarketingOrganizing__c) ? salesOrgCode2Name.get(syncOrder.MarketingOrganizing__c) : ''), //0
        					(salesOrgCode2Name.containsKey(syncOrder.MarketingOrganizing__c) ? salesOrgCode2Name.get(syncOrder.MarketingOrganizing__c) : ''), //1
        					(orderTypeName2Code.containsKey(syncOrder.recordtype.name) ? orderTypeName2Code.get(syncOrder.recordtype.name) : ''), //2
        					(orderTypeName2Code.containsKey(syncOrder.recordtype.name) ? orderTypeName2Code.get(syncOrder.recordtype.name) : ''), //3
							convertDatetoString(syncOrder.EffectiveDate, '-'), //4
							(syncOrder.Account.CRMCodingFormula__c == null ? '' : syncOrder.Account.CRMCodingFormula__c),//5 syncOrder.Account.CRMCodingFormula__c
							(syncOrder.Belonger__r.NCNumber__c == null ? '' : syncOrder.Belonger__r.NCNumber__c),//6
							(syncOrder.Account.CRMCodingFormula__c == null ? '' : syncOrder.Account.CRMCodingFormula__c),//nc 确认修改为 客户编码  7
							String.valueof((syncOrder.Amount__c == null ? 0 : syncOrder.Amount__c)),//8
							String.valueof((syncOrder.ContractAmount__c == null ? 0 : syncOrder.ContractAmount__c)), //9
							syncOrder.Introductions__c,//10
							(PublicPrivate2Code.containsKey(syncOrder.PublicPrivate__c) ? PublicPrivate2Code.get(syncOrder.PublicPrivate__c) : ''),//11
							(Classify12Code.containsKey(syncOrder.Classify__c) ? Classify12Code.get(syncOrder.Classify__c) : ''),//12
							(Classify22Code.containsKey(syncOrder.ClassifyII__c) ? Classify22Code.get(syncOrder.ClassifyII__c) : ''),//13
							(Classify32Code.containsKey(syncOrder.ClassifyIII__c) ? Classify32Code.get(syncOrder.ClassifyIII__c) : ''),//14
							(syncOrder.FinalCustomer__r.CRMCodingFormula__c == null ? '151' : syncOrder.FinalCustomer__r.CRMCodingFormula__c),//syncOrder.FinalCustomer__r.CRMCodingFormula__c,//15
							(syncOrder.Merchandiser__r.NCNumber__c == null ? '000064' : syncOrder.Merchandiser__r.NCNumber__c),//16 syncOrder.Merchandiser__r.NCNumber__c
							(syncOrder.Contract.ContractNumber == null ? '' : syncOrder.Contract.ContractNumber),//17
							String.valueOf(syncOrder.WarrantyPeriod__c),//18
							convertDatetoString(syncOrder.WarrantyStartDate__c, '-'),//19
							convertDatetoString(syncOrder.WarrantyEndDate__c, '-'),//20
							syncOrder.Financing__c,//21
							syncOrder.ResponsiblePerson__c,//22
							convertDatetoString(syncOrder.ExportDate__c, '-'),//23
							(syncOrder.createddate.year() + '-' + syncOrder.createddate.month() + '-' + syncOrder.createddate.day()),//24
							syncOrder.ordernumber,//25
							(syncOrder.BusinessProcess__c != null && salesProcessName2Code.containsKey(syncOrder.BusinessProcess__c) ? salesProcessName2Code.get(syncOrder.BusinessProcess__c) : '')
        	
        			};
        /////************************************************************该xml的最大是 26， index从0 开始。 start
        String jsonTempalte = '<?xml version="1.0" encoding="UTF-8"?>' +
							'<ufinterface account="develop" billtype="30" filename="" groupcode="" isexchange="Y" replace="Y" roottag="" sender="default">' +
							    '<bill id="">' +
							        '<billhead>' +
							            //<!--集团,最大长度为20,类型为:String-->
							            '<pk_group>GSYL</pk_group>' +
							            //<!--销售组织,最大长度为20,类型为:String-->
							            '<pk_org>{0}</pk_org>' +//销售组织 MarketingOrganizing__c
							            //<!--销售组织版本,最大长度为20,类型为:String-->
							            '<pk_org_v>{1}</pk_org_v>' + //销售组织 MarketingOrganizing__c  =====
							            //<!--订单类型,最大长度为20,类型为:String-->
							            '<ctrantypeid>{2}</ctrantypeid>' +//订单类型 recordtype.name
							            //<!--订单类型编码,最大长度为20,类型为:String-->
							            '<vtrantypecode>{3}</vtrantypecode>' +
							            //<!--业务流程,最大长度为20,类型为:String-->
							            '<cbiztypeid>{26}</cbiztypeid>' +
							            //<!--单据日期,最大长度为19,类型为:UFDate-->
							            '<dbilldate>{4}</dbilldate>' + //单据日期
							            //<!--客户,最大长度为20,类型为:String-->
							            '<ccustomerid>{5}</ccustomerid>' +//客户 Account.name
							            //<!--是否散户,最大长度为1,类型为:UFBoolean-->
							            '<bfreecustflag>N</bfreecustflag>' +
							            //<!--部门,最大长度为20,类型为:String-->
							            '<cdeptvid>12000302</cdeptvid>' +
							            //<!--部门,最大长度为20,类型为:String-->
							            '<cdeptid>12000302</cdeptid>' +
							            //<!--员工编码 业务员,最大长度为20,类型为:String-->
							            '<cemployeeid>{6}</cemployeeid>' +//业务员, 员工编码 NCemploye__c
							            //<!--原币,最大长度为20,类型为:String-->
							            '<corigcurrencyid>CNY</corigcurrencyid>' +
							            //<!--开票客户,最大长度为20,类型为:String-->
							            '<cinvoicecustid>{7}</cinvoicecustid>' +/// nc确认修改为 客户编号
							            //<!--整单折扣,最大长度为28,类型为:UFDouble-->
							            '<ndiscountrate>100</ndiscountrate>' +
							            //<!--代垫运费,最大长度为1,类型为:UFBoolean-->
							            '<badvfeeflag>N</badvfeeflag>' +
							            //<!--收款限额控制预收,最大长度为1,类型为:UFBoolean-->
							            '<bpreceiveflag>N</bpreceiveflag>' +
							            //<!--总数量,最大长度为28,类型为:UFDouble-->
							            '<ntotalnum>{8}</ntotalnum>' +//总数量 Amount__c
							            //<!--总件数,最大长度为28,类型为:UFDouble-->
							            '<ntotalpiece>1</ntotalpiece>' +
							            //<!--价税合计,最大长度为28,类型为:UFDouble-->
							            '<ntotalorigmny>{9}</ntotalorigmny>' + //合同金额 ContractAmount__c
							            //<!--冲抵前金额,最大长度为28,类型为:UFDouble-->
							            '<ntotalmny>0</ntotalmny>' +
							            //<!--是否冲抵,最大长度为1,类型为:UFBoolean-->
							            '<boffsetflag>N</boffsetflag>' +
							            //<!--由采购订单协同生成,最大长度为1,类型为:UFBoolean-->
							            '<bpocooptomeflag>N</bpocooptomeflag>' +
							            //<!--已协同生成采购订单,最大长度为1,类型为:UFBoolean-->
							            '<bcooptopoflag>N</bcooptopoflag>' +
							            //<!--单据状态,最大长度为0,类型为:Integer-->
							            '<fstatusflag>1</fstatusflag>' +
							            //<!--审批流状态,最大长度为0,类型为:Integer-->
							            '<fpfstatusflag>0</fpfstatusflag>' +
							            //<!--备注,最大长度为181,类型为:String-->
           								'<vnote>{10}</vnote>' + //备注 Introductions__c
										//<!--自定义项1 公立/民营,最大长度为181,类型为:String-->
							            '<vdef1>{11}</vdef1>' + //自定义项1 PublicPrivate__c
										//<!--自定义项2 分类Ⅰ,最大长度为20,类型为:String-->
							            '<vdef2>{12}</vdef2>' + //自定义项2 Classify__c
										//<!--自定义项3 分类Ⅱ,最大长度为20,类型为:String-->
							            '<vdef3>{13}</vdef3>' +// 自定义项3 ClassifyII__c
										//<!--自定义项4 分类Ⅲ,最大长度为20,类型为:String-->
							            '<vdef4>{14}</vdef4>' +// 自定义项4 ClassifyIII__c
										//<!--自定义项5 终端客户,最大长度为20,类型为:String-->
							            '<vdef5>{15}</vdef5>' +	//终端客户  FinalCustomer__c
										//<!--自定义项9 归属人,最大长度为20,类型为:String-->
							            '<vdef9>{16}</vdef9>' + //自定义项9 Merchandiser__c
										//<!--销售合同号-->
							            '<vdef10>{17}</vdef10>' +//销售合同号 ContractNO__c => Contract.ContractNumber
										//<!--保修期限-->
										'<vdef11>{18}</vdef11>' +//保修期限  WarrantyPeriod__c
										//<!--保修起始时间-->
										'<vdef12>{19}</vdef12>' +//保修起始日期  WarrantyStartDate__c
										//<!--保修结束时间-->
										'<vdef13>{20}</vdef13>' + //  保修结束时间   WarrantyEndDate__c
										//<!--自定义项26,融资租赁,类型为:UFBoolean-->
										'<vdef26>{21}</vdef26>' + //融资租赁 Financing__c
										//<!--自定义项32,催款责任人,最大长度为101,类型为:String-->
										'<vdef32>{22}</vdef32>' +//自定义项32 ResponsiblePerson__c
							            //<!--制单人,最大长度为20,类型为:String-->
							            '<billmaker>1</billmaker>' +
							            //<!--制单日期,最大长度为19,类型为:UFDate-->
							            '<dmakedate>{23}</dmakedate>' +//制单日期
							            //<!--创建人,最大长度为20,类型为:String-->
							            '<creator>1</creator>' +      
							            //<!--审批人,最大长度为20,类型为:String-->
							            '<approver>1</approver>' +
							            //<!--审核日期,最大长度为19,类型为:UFDate-->
							            '<taudittime>{24}</taudittime>' +
										//<!--发货关闭,最大长度为1,类型为:UFBoolean-->
							            '<bsendendflag>N</bsendendflag>' +
							            //<!--出库关闭,最大长度为1,类型为:UFBoolean-->
							            '<boutendflag>N</boutendflag>' +
							            //<!--开票关闭,最大长度为1,类型为:UFBoolean-->
							            '<binvoicendflag>N</binvoicendflag>' +
							            //<!--成本结算关闭,最大长度为1,类型为:UFBoolean-->
							            '<bcostsettleflag>N</bcostsettleflag>' +
							            //<!--收入结算关闭,最大长度为1,类型为:UFBoolean-->
							            '<barsettleflag>N</barsettleflag>' +   
							            '<vbillcode>{25}</vbillcode>' +
							            '<so_saleorder_b>';
							                
		/////************************************************************该xml的最大是 26， index从0 开始。 end
		String orderEnd =  '</so_saleorder_b>' +
							        '</billhead>' +
							    '</bill>' +
							'</ufinterface>';
		String orderData = String.format(jsonTempalte, argumentsAboutOrder);	
		/////************************************************************该xml的最大是 42， index从0 开始。 start
        String OrderChildJsonTemplate = 	
        						'<item>' +
        							//<!--注册证号,最大长度为20,类型为:String-->
									'<vregistrationno_148>{0}</vregistrationno_148>' + //注册证号 RegistrationNumber__c
        							//<!--集团,最大长度为20,类型为:String-->
									'<pk_group>GSYL</pk_group>'+
									//<!--销售组织,最大长度为20,类型为:String-->
									'<pk_org>151</pk_org>'+ 
									//<!--单据日期,最大长度为19,类型为:UFDate-->
									'<dbilldate></dbilldate>'+//单据日期, 订单已经有了。=====
									//<!--行号,最大长度为20,类型为:String-->
                    				'<crowno></crowno>' +
									//<!--物料编码,最大长度为20,类型为:String-->
									'<cmaterialvid>{1}</cmaterialvid>'+ //物料编码 MaterialCoding__c => chagne to host's NewInventoryCode__c
									//<!--物料名称,最大长度为200,类型为:String-->
									'<cmaterialvid.name>{2}</cmaterialvid.name>'+//物料名称 name
									//<!--物料,最大长度为20,类型为:String-->
				                    '<cmaterialid>{3}</cmaterialid>'+
									//<!--物料型号,最大长度为400,类型为:String--> 
									'<cmaterialvid.materialtype>{4}</cmaterialvid.materialtype>'+ //物料型号  MaterialModel__c
									//<!--物料通用名称,通用名称,最大长度为50,类型为:String-->
									'<cmaterialvid.vcommonname_148>{5}</cmaterialvid.vcommonname_148>'+//通用名称 CommonName__c
				                    //<!--项目,项目信息,最大长度为20,类型为:String-->
									'<cprojectid>{6}</cprojectid>'+//项目信息 ProjectInformation__c， fuyue 确认修改为 cpx__c
									//<!--生产厂商,最大长度为20,类型为:String-->
									//<!--主单位,最大长度为20,类型为:String-->
									'<cunitid>{7}</cunitid>'+//单位/主单位 Unit__c
									//<!--单位,最大长度为20,类型为:String-->
									'<castunitid>{8}</castunitid>'+//单位/主单位 Unit__c
									//<!--主数量,最大长度为28,类型为:UFDouble-->
									'<nnum>{9}</nnum>'+//主数量   shuliang__c
									//<!--数量,最大长度为28,类型为:UFDouble-->
									'<nastnum>{10}</nastnum>'+//数量  shuliang__c
									//<!--换算率,最大长度为60,类型为:String-->
									'<vchangerate>1.00/1.00</vchangerate>'+
									//<!--报价单位,最大长度为20,类型为:String-->
									'<cqtunitid>{11}</cqtunitid>'+
									//<!--报价单位数量,最大长度为28,类型为:UFDouble-->
									'<nqtunitnum>1</nqtunitnum>'+
									//<!--报价换算率,最大长度为60,类型为:String-->
									'<vqtunitrate>1.00/1.00</vqtunitrate>'+
									//<!--整单折扣 折扣,最大长度为28,类型为:UFDouble-->
									'<ndiscountrate>{12}</ndiscountrate>'+//折扣 discount__c
									//<!--单品折扣,最大长度为28,类型为:UFDouble-->
									'<nitemdiscountrate>100</nitemdiscountrate>'+
									//<!--税码,最大长度为20,类型为:String-->
									'<ctaxcodeid>{13}</ctaxcodeid>'+//税码 TaxCode__c  CN01
									//<!--税率,最大长度为28,类型为:UFDouble-->
									'<ntaxrate>{14}</ntaxrate>'+//税率 TaxRate__c
									//<!--扣税类别,最大长度为0,类型为:Integer-->
									'<ftaxtypeflag>{15}</ftaxtypeflag>'+//扣税类别 DeductionCategory__c
									//<!--本位币,最大长度为20,类型为:String-->
									'<ccurrencyid>{44}</ccurrencyid>'+
									//<!--折本汇率,最大长度为28,类型为:UFDouble-->
									'<nexchangerate>{45}</nexchangerate>'+
								//计算内容开始=============================
									//<!--含税单价,最大长度为28,类型为:UFDouble-->
									'<nqtorigtaxprice>{16}</nqtorigtaxprice>'+//含税单价 TaxInclusive__c 
									//<!--无税单价,最大长度为28,类型为:UFDouble-->
									'<nqtorigprice>{17}</nqtorigprice>'+//无税单价 Taxfreeprice__c
									//<!--含税净价,最大长度为28,类型为:UFDouble-->
									'<nqtorigtaxnetprc>{18}</nqtorigtaxnetprc>'+
									//<!--无税净价,最大长度为28,类型为:UFDouble-->
									'<nqtorignetprice>{19}</nqtorignetprice>'+
									//<!--主含税单价,最大长度为28,类型为:UFDouble-->
									'<norigtaxprice>{20}</norigtaxprice>'+ 
									//<!--主无税单价,最大长度为28,类型为:UFDouble-->
									'<norigprice>{21}</norigprice>'+
									//<!--主含税净价,最大长度为28,类型为:UFDouble-->
									'<norigtaxnetprice>{22}</norigtaxnetprice>'+ 
									//<!--主无税净价,最大长度为28,类型为:UFDouble-->
									'<norignetprice>{23}</norignetprice>'+ 
									//<!--税额,最大长度为28,类型为:UFDouble-->
									'<ntax>{24}</ntax>'+//税额 tax__c 
									//<!--计税金额,最大长度为28,类型为:UFDouble-->
									'<ncaltaxmny>{25}</ncaltaxmny>'+
									//<!--无税金额,最大长度为28,类型为:UFDouble-->
									'<norigmny>{26}</norigmny>'+//无税金额  NoTaxAmount__c
									//<!--价税合计,最大长度为28,类型为:UFDouble-->
									'<norigtaxmny>{27}</norigtaxmny>'+//价税合计 TotalTaxAmount__c => change to host's TotalPriceOfOpenQuotation__c 
									//<!--折扣额,最大长度为28,类型为:UFDouble-->
									'<norigdiscount>0.00000000</norigdiscount>'+
									//<!--冲抵前金额,最大长度为28,类型为:UFDouble-->
									'<nbforigsubmny>0</nbforigsubmny>'+
									//<!--本币含税单价,最大长度为28,类型为:UFDouble-->
									'<nqttaxprice>{28}</nqttaxprice>'+//本币含税单价 LocalCurrencyTaxPrice__c 
									//<!--本币无税单价,最大长度为28,类型为:UFDouble-->
									'<nqtprice>{29}</nqtprice>'+ 
									//<!--本币含税净价,最大长度为28,类型为:UFDouble-->
									'<nqttaxnetprice>{30}</nqttaxnetprice>'+
									//<!--本币无税净价,最大长度为28,类型为:UFDouble-->
									'<nqtnetprice>{31}</nqtnetprice>'+
									//<!--主本币含税单价,最大长度为28,类型为:UFDouble-->
									'<ntaxprice>{32}</ntaxprice>'+//主本币含税单价 TheMainCurrencyTaxPrice__c
									//<!--主本币无税单价,最大长度为28,类型为:UFDouble-->
									'<nprice>{33}</nprice>'+
									//<!--主本币含税净价,最大长度为28,类型为:UFDouble-->
									'<ntaxnetprice>{34}</ntaxnetprice>'+
									//<!--主本币无税净价,最大长度为28,类型为:UFDouble-->
									'<nnetprice>{35}</nnetprice>'+ 
									//<!--本币无税金额,最大长度为28,类型为:UFDouble-->
									'<nmny>{36}</nmny>'+ 
									//<!--本币价税合计,最大长度为28,类型为:UFDouble-->
									'<ntaxmny>{37}</ntaxmny>'+//本币价税合计  TotalCurrencyTax__c 
									//<!--本币折扣额,最大长度为28,类型为:UFDouble-->
									'<ndiscount>0.00000000</ndiscount> '+
									//<!--服务类,最大长度为1,类型为:UFBoolean-->
									'<blaborflag>N</blaborflag>'+
									//<!--折扣类,最大长度为1,类型为:UFBoolean-->
									'<bdiscountflag>N</bdiscountflag>'+
									//<!--赠品,最大长度为1,类型为:UFBoolean-->
									'<blargessflag>N</blargessflag>'+
									//<!--捆绑存货,最大长度为1,类型为:UFBoolean-->
									'<bbindflag>N</bbindflag>'+
									//<!--要求发货日期,最大长度为19,类型为:UFDate-->
									'<dsenddate>{38}</dsenddate>'+// 和billdate一致
									//<!--计划到货日期,最大长度为19,类型为:UFDate-->
									'<dreceivedate>{39}</dreceivedate>'+//和billdate一致
									//<!--收货客户,最大长度为20,类型为:String-->
									'<creceivecustid>{43}</creceivecustid>'+ 
									//<!--发货库存组织,最大长度为20,类型为:String-->
									'<csendstockorgvid>151</csendstockorgvid>'+
									//<!--发货库存组织最新版本,最大长度为20,类型为:String-->
									'<csendstockorgid>151</csendstockorgid>'+
									//<!--物流组织,最大长度为20,类型为:String-->
				                    '<ctrafficorgvid>{40}</ctrafficorgvid>'+//物流组织 LogisticsOrganization__c
				                    //<!--物流组织,最大长度为20,类型为:String-->
				                    '<ctrafficorgid>{41}</ctrafficorgid>'+//物流组织 LogisticsOrganization__c
									//<!--结算财务组织,最大长度为20,类型为:String-->
									'<csettleorgvid>151</csettleorgvid>'+
									//<!--结算财务组织,最大长度为20,类型为:String-->
									'<csettleorgid>151</csettleorgid>'+
									//<!--收货国家/地区,最大长度为20,类型为:String-->
									'<crececountryid>{42}</crececountryid>'+//收货国家地区
									//<!--发货国家/地区,最大长度为20,类型为:String-->
									'<csendcountryid>CN</csendcountryid>'+
									//<!--报税国家/地区,最大长度为20,类型为:String-->
									'<ctaxcountryid>CN</ctaxcountryid>'+
									//<!--购销类型,最大长度为0,类型为:Integer-->
									'<fbuysellflag>1</fbuysellflag>'+
									//<!--三角贸易,最大长度为1,类型为:UFBoolean-->
									'<btriatradeflag>N</btriatradeflag>'+
									//<!--应收组织,最大长度为20,类型为:String-->
									'<carorgvid>151</carorgvid>'+
									//<!--应收组织最新版本,最大长度为20,类型为:String-->
									'<carorgid>151</carorgid>'+
									//<!--赠品价格分摊方式,最大长度为0,类型为:Integer-->
									'<flargesstypeflag></flargesstypeflag>'+       
									//<!--预订单行关闭,最大长度为1,类型为:UFBoolean-->
									'<bprerowcloseflag>N</bprerowcloseflag>'+
									//<!--发货关闭,最大长度为1,类型为:UFBoolean-->
									'<bbsendendflag>N</bbsendendflag>'+
									//<!--开票关闭,最大长度为1,类型为:UFBoolean-->
									'<bbinvoicendflag>N</bbinvoicendflag>'+
									//<!--出库关闭,最大长度为1,类型为:UFBoolean-->
									'<bboutendflag>N</bboutendflag>'+
									//<!--成本结算关闭,最大长度为1,类型为:UFBoolean-->
									'<bbcostsettleflag>N</bbcostsettleflag>'+
									//<!--收入结算关闭,最大长度为1,类型为:UFBoolean-->
									'<bbarsettleflag>N</bbarsettleflag>'+
									//<!--是否货源安排完毕,最大长度为1,类型为:UFBoolean-->
									'<barrangedflag>N</barrangedflag>'+
									//<!--结算关闭,最大长度为1,类型为:UFBoolean-->
									'<bbsettleendflag>N</bbsettleendflag>' +
									'</item>';
	    /////************************************************************该xml的最大是 45， index从0 开始。 end
        //订单子表
        String configlistString = '';
        for (ConfigurationList__c newConfigurationList : [select Id, Name,
        											RegistrationNumber__c,
        											
													MaterialModel__c,
													CommonName__c,
													cpx__c, //ProjectInformation__c, fuyue 确认修改为产品线
													Unit__c,
													//Unit__c,
													MainQuantity__c,
													Quantity__c,
													discount__c,
													TaxCode__c,
													TaxRate__c,
													DeductionCategory__c,
													TaxInclusive__c,
													Taxfreeprice__c,
													tax__c,
													NoTaxAmount__c,
													TotalTaxAmount__c,
													LocalCurrencyTaxPrice__c,
													TheMainCurrencyTaxPrice__c,
													TotalCurrencyTax__c,
													LogisticsOrganization__c,
													//LogisticsOrganization__c
													ReceiptCountry__c,
													shuliang__c,
													(select id, name, NewInventoryCode__c, unit__c, NumberTypeIN__c, TotalPriceOfOpenQuotation__c, SystemStandardPricePer__c, OpenQuotationUnitPrice__c, product__r.RegistrationNumber__c, product__r.TaxRate__c from ConfigurationList__r limit 1) 
													from ConfigurationList__c where order__c = :orderId and (recordtype.name = '配置单-大型' or recordtype.name = '配置单-常规')])
		{	
			Decimal standardPrice = (newConfigurationList.ConfigurationList__r.size() > 0 ? (newConfigurationList.ConfigurationList__r[0].SystemStandardPricePer__c == null ? 0 : newConfigurationList.ConfigurationList__r[0].SystemStandardPricePer__c) : 0);
			Decimal textRate = (newConfigurationList.ConfigurationList__r.size() > 0 ? (newConfigurationList.ConfigurationList__r[0].product__r.TaxRate__c == null ? 0 : newConfigurationList.ConfigurationList__r[0].product__r.TaxRate__c) : 0)/100;
			Decimal totalNUM = (newConfigurationList.shuliang__c == null ? 0 : newConfigurationList.shuliang__c);
			String originalUnit = (newConfigurationList.ConfigurationList__r.size() > 0 ? (newConfigurationList.ConfigurationList__r[0].unit__c == null ? '' : newConfigurationList.ConfigurationList__r[0].unit__c) : '');
			String translatedUnit = (String.isNotBlank(originalUnit) && unitTranslation.containsKey(originalUnit) ? unitTranslation.get(originalUnit) : '' );
			
			Decimal nqtorigtaxprice = 0;
			Decimal nqtorigprice = 0;
			Decimal nqtorigtaxnetprc = 0;
			Decimal nqtorignetprice = 0;
			Decimal norigtaxprice = 0;
			Decimal norigprice = 0;
			Decimal norigtaxnetprice = 0;
			Decimal norignetprice = 0;
			Decimal ntax = 0;
			Decimal ncaltaxmny = 0;
			Decimal norigmny = 0;
			Decimal norigtaxmny = 0;
			Decimal nqttaxprice = 0;
			Decimal nqtprice = 0;
			Decimal nqttaxnetprice = 0;
			Decimal nqtnetprice = 0;
			Decimal ntaxprice = 0;
			Decimal nprice = 0;
			Decimal ntaxnetprice = 0;
			Decimal nnetprice = 0;
			Decimal nmny = 0;
			Decimal ntaxmny = 0;
			
			Decimal zhebenhuilv = countryCode2Rate.get(currencyCode);//折本汇率
			
			/* 旧有的计算逻辑
			nqtorigtaxprice = standardPrice; //含税单价：字段（nqtorigtaxprice）物料单价（SF系统自己的单价）
			nqtorigprice = standardPrice * (1- textRate);//无税单价：字段（nqtorigprice）物料单价（SF系统自己的单价）-物料单价x税率
			nqtorigtaxnetprc = standardPrice;//含税净价：字段（nqtorigtaxnetprc）物料单价（SF系统自己的单价 
			nqtorignetprice = standardPrice * (1- textRate);//无税净价：字段（nqtorignetprice）物料单价（SF系统自己的单价）-物料单价x税率
			norigtaxprice = standardPrice;//主含税单价：字段（norigtaxprice）物料单价（SF系统自己的单价）
			norigprice = standardPrice * (1- textRate);//主无税单价：字段（norigprice）    物料单价（SF系统自己的单价）-物料单价x税率
			norigtaxnetprice = standardPrice;//主含税净价：字段（norigtaxnetprice） 物料单价（SF系统自己的单价
			norignetprice = standardPrice * (1- textRate);//主无税净价：字段（norignetprice）物料单价（SF系统自己的单价）-物料单价x税率
			ntax = standardPrice * textRate * totalNUM;//税额：字段（ntax）物料单价x税率x数量
			ncaltaxmny = standardPrice * (1 - textRate) * totalNUM;//计税金额：字段（ncaltaxmny） 物料单价（SF系统自己的单价）x数量-物料单价x税率x数量
			norigmny = standardPrice * (1 - textRate) * totalNUM;//无税金额：字段（norigmny）物料的单价x数量-税额 (物料单价x税率x数量)
			norigtaxmny = standardPrice * totalNUM;//价税合计：字段（norigtaxmny）物料的单价x数量
			nqttaxprice = standardPrice;//本币含税单价：字段（nqttaxprice） 物料单价（SF系统自己的单价）
			nqtprice = standardPrice * (1- textRate);//本币无税单价：字段（nqtprice）物料单价（SF系统自己的单价）-物料单价x税率
			nqttaxnetprice = standardPrice;//本币含税净价：字段（nqttaxnetprice）物料单价（SF系统自己的单价）
			nqtnetprice = standardPrice * (1- textRate);//本币无税净价：字段（nqtnetprice）物料单价（SF系统自己的单价）-物料单价x税率
			ntaxprice = standardPrice;//主本币含税单价：字段（ntaxprice）物料单价（SF系统自己的单价）
			nprice = standardPrice * (1- textRate);//主本币无税单价：字段（nprice）物料单价（SF系统自己的单价）-物料单价x税率
			ntaxnetprice = standardPrice;//主本币含税净价：字段（ntaxnetprice）物料单价（SF系统自己的单价）
			nnetprice = standardPrice * (1- textRate);//主本币无税净价：字段（nnetprice）物料单价（SF系统自己的单价）-物料单价x税率
			nmny = standardPrice * (1 - textRate) * totalNUM;//本币无税金额：字段（nmny）  物料单价（SF系统自己的单价）x数量-物料单价x税率x数量
			ntaxmny = nmny + ntax;//本币价税合计：字段（ntaxmny） 物料单价（SF系统自己的单价）x数量   => 价税合计<ntaxmny> = 本币无税金额<nmny>+税额<ntax>，再就是，税率这个值产品信息中有传过的
			*/
			nqtorigtaxprice = standardPrice; //含税单价：字段（nqtorigtaxprice）物料单价（SF系统自己的单价）
			nqtorigprice = standardPrice / (1 + textRate);//无税单价：字段（nqtorigprice）物料单价（SF系统自己的单价）/(1+税率)
			nqtorigtaxnetprc = standardPrice;//含税净价：字段（nqtorigtaxnetprc）物料单价（SF系统自己的单价
			nqtorignetprice = standardPrice / (1 + textRate);//无税净价：字段（nqtorignetprice）物料单价（SF系统自己的单价）/(1+税率)
			norigtaxprice = standardPrice;//主含税单价：字段（norigtaxprice）物料单价（SF系统自己的单价）
			norigprice = standardPrice / (1 + textRate);//主无税单价：字段（norigprice）    物料单价（SF系统自己的单价）/(1+税率)
			norigtaxnetprice = standardPrice;//主含税净价：字段（norigtaxnetprice） 物料单价（SF系统自己的单价）
			norignetprice = standardPrice / (1 + textRate);//主无税净价：字段（norignetprice）物料单价（SF系统自己的单价）/(1+税率)
			ntax = standardPrice * totalNUM * zhebenhuilv -  standardPrice / ((1 + textRate)) * totalNUM * zhebenhuilv;//税额：字段（ntax）物料单价（SF系统自己的单价）x数量x折本汇率-物料单价（SF系统自己的单价）/(1+税率)x数量x折本汇率
			ncaltaxmny = standardPrice / (1 + textRate) * totalNUM * zhebenhuilv;//计税金额：字段（ncaltaxmny） 物料单价（SF系统自己的单价）/(1+税率)x数量x折本汇率
			norigmny = standardPrice / (1 + textRate) * totalNUM;//无税金额：字段（norigmny） 物料单价（SF系统自己的单价）/(1+税率)x数量
			norigtaxmny = standardPrice * totalNUM;//价税合计：字段（norigtaxmny）物料的单价x数量
			nqttaxprice = standardPrice * zhebenhuilv;//本币含税单价：字段（nqttaxprice） 物料单价（SF系统自己的单价）x折本汇率
			nqtprice = standardPrice / (1 + textRate) * zhebenhuilv;//本币无税单价：字段（nqtprice）物料单价（SF系统自己的单价）/(1+税率)x折本汇率
			nqttaxnetprice = standardPrice * zhebenhuilv;//本币含税净价：字段（nqttaxnetprice）物料单价（SF系统自己的单价）x折本汇率
			nqtnetprice = standardPrice / (1 + textRate) * zhebenhuilv;//本币无税净价：字段（nqtnetprice）物料单价（SF系统自己的单价）/(1+税率)x折本汇率
			ntaxprice = standardPrice * zhebenhuilv;//主本币含税单价：字段（ntaxprice）物料单价（SF系统自己的单价）x折本汇率
			nprice = standardPrice / (1 + textRate) * zhebenhuilv;//主本币无税单价：字段（nprice）物料单价（SF系统自己的单价）/(1+税率)x折本汇率
			ntaxnetprice = standardPrice * zhebenhuilv;//主本币含税净价：字段（ntaxnetprice）物料单价（SF系统自己的单价）x折本汇率
			nnetprice = standardPrice / (1 + textRate) * zhebenhuilv;//主本币无税净价：字段（nnetprice）物料单价（SF系统自己的单价）/(1+税率)x折本汇率
			nmny = standardPrice / (1 + textRate) * totalNUM * zhebenhuilv;//本币无税金额：字段（nmny）  物料单价（SF系统自己的单价）/(1+税率)x数量x折本汇率
			ntaxmny = standardPrice * totalNUM * zhebenhuilv;//本币价税合计：字段（ntaxmny） 物料单价（SF系统自己的单价）x数量x折本汇率
			
			//set scal
			nqtorigtaxprice = setCustomScale(nqtorigtaxprice, 2);
			nqtorigprice = setCustomScale(nqtorigprice, 2);
			nqtorigtaxnetprc = setCustomScale(nqtorigtaxnetprc, 2);
			nqtorignetprice = setCustomScale(nqtorignetprice, 2);
			norigtaxprice = setCustomScale(norigtaxprice, 2);
			norigprice = setCustomScale(norigprice, 2);
			norigtaxnetprice = setCustomScale(norigtaxnetprice, 2);
			norignetprice = setCustomScale(norignetprice, 2);
			ntax = setCustomScale(ntax, 2);
			ncaltaxmny= setCustomScale(ncaltaxmny, 2);
			norigmny = setCustomScale(norigmny, 2);
			norigtaxmny = setCustomScale(norigtaxmny, 2);
			nqttaxprice = setCustomScale(nqttaxprice, 2);
			nqtprice = setCustomScale(nqtprice, 2);
			nqttaxnetprice = setCustomScale(nqttaxnetprice, 2);
			nqtnetprice = setCustomScale(nqtnetprice, 2);
			ntaxprice = setCustomScale(ntaxprice, 2);
			nprice = setCustomScale(nprice, 2);
			ntaxnetprice = setCustomScale(ntaxnetprice, 2);
			nnetprice = setCustomScale(nnetprice, 2);
			nmny = setCustomScale(nmny, 2);
			ntaxmny = setCustomScale(ntaxmny, 2);
			
			//String deliveryOrg = (newConfigurationList.LogisticsOrganization__c != null && AccountHelper.Name2Code.containsKey(newConfigurationList.LogisticsOrganization__c) ? AccountHelper.Name2Code.get(newConfigurationList.LogisticsOrganization__c) : '');
			String projectCode = (newConfigurationList.cpx__c != null && projectName2Code.containsKey(newConfigurationList.cpx__c) ? projectName2Code.get(newConfigurationList.cpx__c) : '');
			List<String> arguments = new List<String>{
													String.valueOf((newConfigurationList.ConfigurationList__r.size() > 0 ? newConfigurationList.ConfigurationList__r[0].product__r.RegistrationNumber__c : ' ')),//(newConfigurationList.RegistrationNumber__c == null ? '' : newConfigurationList.RegistrationNumber__c),,
													String.valueOf((newConfigurationList.ConfigurationList__r.size() > 0 ? newConfigurationList.ConfigurationList__r[0].NewInventoryCode__c : '0')),//String.valueOf(newConfigurationList.MaterialCoding__c),
													newConfigurationList.name,
													String.valueOf((newConfigurationList.ConfigurationList__r.size() > 0 ? newConfigurationList.ConfigurationList__r[0].NewInventoryCode__c : '0')),//3  String.valueOf(newConfigurationList.MaterialCoding__c),
													(newConfigurationList.MaterialModel__c == null ? '' : newConfigurationList.MaterialModel__c),
													(newConfigurationList.CommonName__c == null ? '' : newConfigurationList.CommonName__c),
													//(newConfigurationList.ProjectInformation__c == null ? '' : newConfigurationList.ProjectInformation__c),
													(projectCode),// 7
													(translatedUnit == null ? 'EA' : translatedUnit),//8
													(translatedUnit == null ? 'EA' : translatedUnit),//9
													String.valueOf((newConfigurationList.shuliang__c == null ? 0 : newConfigurationList.shuliang__c)),//10 String.valueOf(newConfigurationList.MainQuantity__c),
													String.valueOf((newConfigurationList.shuliang__c == null ? 0 : newConfigurationList.shuliang__c)),//11
													(translatedUnit == null ? 'EA' : translatedUnit),// 12
													String.valueOf((newConfigurationList.discount__c ==  null ? 0 : newConfigurationList.discount__c)),//13
													(newConfigurationList.TaxCode__c == null ? 'CN01' : newConfigurationList.TaxCode__c),//14
													String.valueOf(textRate * 100),//15
													(newConfigurationList.DeductionCategory__c == null ? '1' : newConfigurationList.DeductionCategory__c), //16
													String.valueOf(nqtorigtaxprice),//17
													String.valueOf(nqtorigprice),//18
													String.valueOf(nqtorigtaxnetprc),//19
													String.valueOf(nqtorignetprice),//20
													String.valueOf(norigtaxprice),//21
													String.valueOf(norigprice),//22
													String.valueOf(norigtaxnetprice),//23
													String.valueOf(norignetprice),//24
													String.valueOf(ntax),//25
													String.valueOf(ncaltaxmny),//26
													String.valueOf(norigmny),//27
													String.valueOf(norigtaxmny),//28
													String.valueOf(nqttaxprice),//29
													String.valueOf(nqtprice),//30
													String.valueOf(nqttaxnetprice),//31
													String.valueOf(nqtnetprice),//32
													String.valueOf(ntaxprice),//33
													String.valueOf(nprice),//34
													String.valueOf(ntaxnetprice),//35
													String.valueOf(nnetprice),//36
													String.valueOf(nmny),//37
													String.valueOf(ntaxmny),//38
													/*String.valueOf((newConfigurationList.TaxInclusive__c == null ? 0 : newConfigurationList.TaxInclusive__c)),//14
													String.valueOf((newConfigurationList.Taxfreeprice__c == null ? 0 : newConfigurationList.Taxfreeprice__c)),//15
													String.valueOf((newConfigurationList.tax__c == null ? 0 : newConfigurationList.tax__c)),//16
													String.valueOf((newConfigurationList.NoTaxAmount__c == null ? 0 : newConfigurationList.NoTaxAmount__c)),//17
													String.valueOf((newConfigurationList.ConfigurationList__r.size() > 0 ? String.valueOf(newConfigurationList.ConfigurationList__r[0].TotalPriceOfOpenQuotation__c) : '0')),//18String.valueOf(newConfigurationList.TotalTaxAmount__c),
													String.valueOf((newConfigurationList.LocalCurrencyTaxPrice__c == null ? 0 : newConfigurationList.LocalCurrencyTaxPrice__c)),//19
													String.valueOf((newConfigurationList.TheMainCurrencyTaxPrice__c == null ? 0 : newConfigurationList.TheMainCurrencyTaxPrice__c)),//20
													String.valueOf((newConfigurationList.TotalCurrencyTax__c == null ? 0 : newConfigurationList.TotalCurrencyTax__c)),//21*/
													convertDatetoString(syncOrder.EffectiveDate, '-'),//39
													convertDatetoString(syncOrder.EffectiveDate, '-'),//40
													(salesOrgCode),//41 
													(salesOrgCode),//42
													(newConfigurationList.ReceiptCountry__c == null ? 'CN' : newConfigurationList.ReceiptCountry__c ),//43
													accountCode,//44
													currencyCode,//45
													String.valueOf(zhebenhuilv)//46
													
			
										};
			configlistString = configlistString + String.format(OrderChildJsonTemplate, arguments);
		}
        
        orderData = orderData + configlistString + orderEnd;
        
		String json = orderData;//String.format(jsonTempalte, arguments);
        system.debug('[Custom Log]json is ' + json);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
		String requestURL = URLConfig__c.getValues('RequestURL').URL__c;
        request.setEndpoint(requestURL);
        request.setHeader('content-type', 'text/xml');
        request.setMethod('POST');
        request.setBody(json);

        try{ 
            HttpResponse response = http.send(request); 
            system.debug('[Custom Log]sync result is xml ' + response.getBody());
            //parse sync result xml
            orderhelper.ExecutionResult syncResult = new orderhelper.ExecutionResult();
            String resultStr = response.getBody().replaceAll('\'', '"');
            system.debug('[Custom Log]resultStr ' + resultStr);
            
            syncResult = OrderHelper.parseSyncResult(resultStr);
            
            System.debug('[customer log]sync method : ' + syncResult);
            update new Order( Id = orderId, SyncLog__c = response.getBody(), ExportedToNC__c = (syncResult.IsSuccess ? '是' : '否'), Reviewer__c = userinfo.getuserId(), ExportDate__c = date.today());
            result.IsSuccess = syncResult.IsSuccess;
            result.Message = syncResult.Message; 
            
        }catch(Exception e){
            System.debug('[customer log]Exception: ' + e);
            result.IsSuccess = false;
            result.Message = '同步过程出现异常, 请联系管理员分析同步日志！';
        }
        system.debug('[Custom Log]sync result is ' + result);
    	return result;
    
    }
    public static String convertDateTimetoString(Datetime tempDatetime)
    {
        TimeZone timeZone = UserInfo.getTimeZone();
        return tempDatetime.format('yyyy-MM-dd HH:mm:ss', timeZone.toString());
    }
    
    public static String convertDatetoString(Date tempDate, String flag)
    {   
    	String resutl = '';
    	if (tempDate != null)
    	{
    		resutl = tempDate.year() + flag + tempDate.month() + flag + tempDate.day();
    	}
        return resutl;
    }
    public class ExecutionResult 
    {   
        public boolean IsSuccess { get; set; }
        public String Message { get; set; }
        public ExecutionResult(){}
    }
    
    public static Map<String, String> salesOrgCode2Name = new Map<String, String>();
    static{
        
        for (SalesOrg2Code__c tempNameToCode : [select name, Code__c, SalesOrgName__c from SalesOrg2Code__c])
        {
            salesOrgCode2Name.put(tempNameToCode.SalesOrgName__c, tempNameToCode.Code__c);
            
        }
        
    }
    
    public static OrderHelper.ExecutionResult parseSyncResult(String resultXML)
    {	
      OrderHelper.ExecutionResult tempExecutionResult = new OrderHelper.ExecutionResult();	
      tempExecutionResult.IsSuccess = true;
      tempExecutionResult.Message = '';
      try {
          XmlStreamReader reader = new XmlStreamReader(resultXML);
          while(reader.hasNext())
          { 	
          	 system.debug('parse xm is' + reader.getLocalName());
             try
              {
                  if(reader.getLocalName() == 'resultcode')
                  {
                      reader.next();
                      String resultCode = reader.getText();
                      tempExecutionResult.IsSuccess = (resultCode.equals('1') ? true : false);
                      system.debug('[Custom Log] parseSyncResult sync result is ' +tempExecutionResult);
      				  return tempExecutionResult;
                  }
              }
              catch (Exception e) 
              {
                 system.debug('parse sync Result xml Exception info is' + e);
             }
             /*try
              {
                  if(reader.getLocalName() == 'resultdescription')
                  {
                      reader.next();
                      String resultDescription = reader.getText();
                      tempExecutionResult.Message = resultDescription;
                  }
              }
              catch (Exception e) 
              {
                  system.debug('parse sync Result xml Exception info is' + e);
             }*/
             reader.next();
          }
          
      }
      catch (Exception e) {
          system.debug('parse sync Result xml Exception info is' + e);
          tempExecutionResult.IsSuccess = false;
          tempExecutionResult.Message = '解析同步结果失败！';
      }
      system.debug('[Custom Log] parseSyncResult sync result is ' +tempExecutionResult);
      return tempExecutionResult;
    }
    
    public static Decimal setCustomScale(Decimal tempDecimal, Integer scale)
	{
		return tempDecimal.setScale(scale);
	}
    
}