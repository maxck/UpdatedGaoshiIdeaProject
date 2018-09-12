/**
*Dis:技术服务报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 
*Time:2015年2月27日13:05:35
*Author:Somnus Wang
**/

public  class Ctr_CreatePDF_ServiceReport {
	public Wrapper wrapp{get;set;}
	public List<InnerClass> listinner{get;set;}
	public String pageId{get;set;}
   
	public Ctr_CreatePDF_ServiceReport(){
		
	 listinner=new List<InnerClass>();
	 wrapp=new Wrapper();
	 String equinfo=null;//设备报错信息内容
	 Integer limits=50;//表格设备报错信第一行显示字数限制
	 Integer seclimits=60;//表格设备报错信息，解决方案第二行开始显示的字数限制
     String solutiondatas=null;//解决方案内容
	 Integer fontnum=58;//解决方案第一行显示字数限制
	  
	  //获得页面id
		pageId=ApexPages.currentPage().getParameters().get('idss');
		
		Set<ID> setservicereport=new Set<ID>();//服务请求
		Set<ID> setsparepart=new Set<ID>();//备件申请
		Set<ID> setdetail=new Set<ID>();//备件明细
		Set<ID> setowner=new Set<ID>();//所有人
		Set<ID> setrecordtype=new Set<ID>();//技术服务报告记录类型
		Set<ID> setrequestrecordtype=new Set<ID>();//服务请求记录类型
		
		String msg=null;//技术服务报告记录类型
		String str=null;//服务请求记录类型
		String u=null;//所有人
		Double sum=0;//所有备件明细申请上的申请总金额总和
		String info=null;
		String equerr=null; 
		
		//查询技术服务报告
		List<servicereport__c> list_servicereport=[select state__c,Name,Id,RecordTypeId,customer__c,address__c,
		postcode__c,department__c,person__r.Name,landline__c,phone__c,Equipmentname__c,
		Equipmentunittype__c,Equipment__c,servicetype__c,reportdate__c,dotime__c,bugtype__r.Name,information__c,hfnm__c,
		nlvsmj__c,hfmj__c,zdnlvsmj__c,lfnm__c,lasernum__c,lfmj__c,firstpressure__c,hvv__c,otherpressure__c,
		hfnmend__c,nlvsmjend__c,hfmjend__c,zdnlvsmjend__c,lfnmend__c,lasernumend__c,lfmjend__c,firstpressureend__c,
		hvvend__c,otherpressureend__c,solution__c,acceptor__r.Name,completetime__c,receptiontime__c,
		servicerequest__c,servicerequest__r.OwnerId,jsfwjz__c,CreatedBy.Name,totleprice__c,sparepart__r.sqtotleprice__c from servicereport__c where Id =:pageId];
		
		//迭代技术服务报告
		for(servicereport__c report:list_servicereport){
		  setservicereport.add(report.servicerequest__c);
		  setowner.add(report.servicerequest__r.OwnerId);
		  setrecordtype.add(report.RecordTypeId);
		  equinfo=report.information__c;//设备报错信息
		  solutiondatas=report.solution__c;//解决方案
		}
		equerr=StrTool.wrapLine(equinfo,limits,seclimits);//设备报错信息在表格中每行显示的字数限制
		info=StrTool.wrapLine(solutiondatas,fontnum,seclimits);//解决方案在表格中每行显示的字数限制
		
		List<User> users=[select Name from User where Id in:setowner];//查询所有人
		List<servicerequest__c> listservicerequest=[select Name,Id,RecordTypeId from servicerequest__c where Id in:setservicereport];//查找服务请求
		List<RecordType> listrecordtype=[select Name from RecordType where Id in:setrecordtype];//查询技术服务报告记录类型
		List<sparepart__c> listsparepart=[select Id,Name,sqtotleprice__c from sparepart__c where servicerequest__c in:setservicereport];//查找备件申请
		
		for(User uu:users){
			u=uu.Name;
		}
		for(servicerequest__c requests:listservicerequest){
			setrequestrecordtype.add(requests.RecordTypeId);
		}
		for(RecordType re:listrecordtype){
			if(re.Name!=null){
		     msg=re.Name;
			}
		}
		//查询服务请求记录类型
		List<RecordType> listrrequestecordtype=[select Name from RecordType where Id in:setrequestrecordtype];//查询服务请求记录类型
		
		//服务请求记录类型
		for(RecordType requ:listrrequestecordtype){
			if(requ.Name!=null){
			 System.debug('服务请求记录类型。。。。。。。。。。。'+requ.Name);
		     str=requ.Name;
			}
		} 
		//迭代备件申请
		for(sparepart__c spa:listsparepart){
			setsparepart.add(spa.Id);
			sum=sum+spa.sqtotleprice__c;
			System.debug('备件申请里的总金额。。。。。。。。。。'+spa.sqtotleprice__c+'  ,总共等于：'+sum);
		}
		
		List<sparepartdetail__c> listsparepartdetail=[select Id,Name,Chinesename__c,partnum__c,partnum__r.Name,serialnumber__c,number__c from sparepartdetail__c where 	sparepart__c in:setsparepart];//查找备件明细
		//System.debug('查找备件明细。。。。。。。'+listsparepartdetail.size()+'.....'+listsparepartdetail);
		
		 
		//迭代技术服务报告    
		for(servicereport__c service:list_servicereport){
		    wrapp.types=msg;//types 记录类型
		    wrapp.hospitalName=service.customer__c;//医院名称
		    wrapp.address=service.address__c;//地    址
		    wrapp.postCode=service.postcode__c;//邮编
		    wrapp.department=service.department__c;//使用科室
		    wrapp.contacts=service.person__r.Name;//联系人
		    wrapp.landline=service.landline__c;//座机
		    wrapp.phone=service.phone__c;//手机
		    wrapp.equipmentname=service.Equipmentname__c;//设备名称
		    wrapp.equipmentunittype=service.Equipmentunittype__c;//型号
		    wrapp.equipment=service.Equipment__c;//序列号
		    wrapp.servicetype=str;//服务类型
		    if(service.reportdate__c!=null){
		    wrapp.reportdate=service.reportdate__c.year()+'-'+service.reportdate__c.month()+'-'+service.reportdate__c.day();//出故障日期
		    }
		    if(service.dotime__c!=null){
		    wrapp.dotime=service.dotime__c.year()+'-'+service.dotime__c.month()+'-'+service.dotime__c.day()+
		    '  '+service.dotime__c.hour()+':'+service.dotime__c.minute() ;//到达时间
		    }
		    wrapp.bugtype=service.bugtype__r.Name;//故障类别
		    wrapp.information=equerr;//设备报错信息
		    wrapp.hfnm=service.hfnm__c;//初始能量测试HF（nm）
		    wrapp.nlvsmj=service.nlvsmj__c;//初始最大能量950v10s下（mj）
		    wrapp.hfmj=service.hfmj__c;//初始能量测试HF（mj）
		    wrapp.zdnlvsmj=service.zdnlvsmj__c;//初始最大能量1400v10s下（mj）
		    wrapp.lfnm=service.lfnm__c;//初始能量测试LF（nm）
		    wrapp.lasernum=service.lasernum__c;//初始激光腔脉冲数
		    wrapp.lfmj=service.lfmj__c;//初始能量测试LF（mj）
		    wrapp.firstpressure=service.firstpressure__c;//初始初级气压
		    wrapp.hvv=service.hvv__c;//初始能量测试HV（V）
		    wrapp.otherpressure=service.otherpressure__c;//初始次级气压
		    wrapp.hfnmend=service.hfnmend__c;//最终能量测试HF（nm）
		    wrapp.nlvsmjend=service.nlvsmjend__c;//最终最大能量950v10s下（mj）
		    wrapp.hfmjend=service.hfmjend__c;//最终能量测试HF（mj）
		    wrapp.zdnlvsmjend=service.zdnlvsmjend__c;//最终最大能量1400v10s下（mj）
		    wrapp.lfnmend=service.lfnmend__c;//最终能量测试LF（nm）
		    wrapp.lasernumend=service.lasernumend__c;//最终激光腔脉冲数
		    wrapp.lfmjend=service.lfmjend__c;//最终能量测试LF（mj）
		    wrapp.firstpressureend=service.firstpressureend__c;//最终初级气压
		    wrapp.hvvend=service.hvvend__c;//最终次级气压
		    wrapp.otherpressureend=service.otherpressureend__c;//最终次级气压
		    wrapp.solution=info;//解决方案
		    Integer i=1;
		    for(sparepartdetail__c detail:listsparepartdetail){
		    	System.debug('进入for循环。。。备件明细');
		    	InnerClass  inners=new InnerClass();
		    	if(detail.Chinesename__c!=null && detail.partnum__r.Name!=null){
		    	inners.PNname=detail.Chinesename__c+detail.partnum__r.Name;//名称PN
		    	}
		    	inners.serialnumber=detail.serialnumber__c;//SN
		    	inners.numbers=detail.number__c;//数量
		    	inners.counts=i++;
		    	listinner.add(inners);
		    	System.debug('for循环。。结束。备件明细'+listinner.size()+'.........'+listinner);
		    }
		    if(service.jsfwjz__c!=null){
		    wrapp.jsfwjz=service.jsfwjz__c;//技术服务价值
		    System.debug('判断  技术服务价值为空 if'+wrapp.jsfwjz);
		    }else{
		    wrapp.jsfwjz=0;
		     System.debug('判断  技术服务价值else'+wrapp.jsfwjz);
		    }
		    wrapp.sqtotleprice=service.sparepart__r.sqtotleprice__c;//配件更换价值
		    wrapp.totals=service.totleprice__c;//总计
		    wrapp.serviceengnineer=service.CreatedBy.Name;//服务工程师
		    wrapp.acceptor=service.acceptor__r.Name;//客户签字
		    if(service.completetime__c!=null){
		    wrapp.completetime=service.completetime__c.year()+'-'+service.completetime__c.month()+'-'+service.completetime__c.day()+
		    '  '+service.completetime__c.hour()+':'+service.completetime__c.minute() ;//完成时间
		    }
		    if(service.receptiontime__c!=null){
		    wrapp.receptiontime=service.receptiontime__c.year()+'-'+service.receptiontime__c.month()+'-'+service.receptiontime__c.day();//验收时间
		    }
		    }
	}
	public class Wrapper{
		
	  public String types {get;set;}//记录类型
	  public String hospitalName {get;set;}//医院名称
	  public String address {get;set;}//地    址
	  public String postCode {get;set;}//邮编
	  public String department {get;set;}//使用科室
	  public String contacts {get;set;}//联系人
	  public String landline {get;set;}//座机
	  public String phone {get;set;}//手机
	  public String equipmentname {get;set;}//设备名称
	  public String equipmentunittype {get;set;}//型号
	  public String equipment {get;set;}//序列号
	  public String servicetype {get;set;}//服务类型
	  public String reportdate {get;set;}//出故障日期
	  public String dotime {get;set;}//到达时间
	  public String bugdescription {get;set;}//故障描述
	  public String bugtype {get;set;}//故障类别
	  public String information {get;set;}//设备报错信息
	  public String initialpara {get;set;}//初始参数
	  public Double hfnm {get;set;}//初始能量测试HF（nm）
	  public Double nlvsmj {get;set;}//初始最大能量950v10s下（mj）	
	  public Double hfmj {get;set;}//初始能量测试HF（mj）
	  public Double zdnlvsmj {get;set;}//初始最大能量1400v10s下（mj）
	  public Double lfnm {get;set;}//初始能量测试LF（nm）
	  public Double lasernum {get;set;}//初始激光腔脉冲数
	  public Double lfmj {get;set;}//初始能量测试LF（mj）
	  public Double firstpressure {get;set;}//初始初级气压
	  public Double hvv {get;set;}//初始能量测试HV（V）
	  public Double otherpressure {get;set;}//初始次级气压
	  public Double hfnmend {get;set;}//最终能量测试HF（nm）	
	  public Double nlvsmjend {get;set;}//最终最大能量950v10s下（mj）
	  public Double hfmjend {get;set;}//最终能量测试HF（mj）
	  public Double zdnlvsmjend {get;set;}//最终最大能量1400v10s下（mj）
	  public Double lfnmend {get;set;}//最终能量测试LF（nm）
	  public Double lasernumend {get;set;}//最终激光腔脉冲数
	  public Double lfmjend {get;set;}//最终能量测试LF（mj）
	  public Double firstpressureend {get;set;}//最终初级气压
	  public Double hvvend {get;set;}//最终能量测试HV（V）
	  public Double otherpressureend {get;set;}//最终次级气压
	  public String solution {get;set;}//解决方案
	 // public String finalpara {get;set;}//最终参数
	  public String result {get;set;}//结果
	  //public String PNname {get;set;}//名称PN
	  //public String serialnumber {get;set;}//SN
	  //public Double numbers {get;set;}//数量
	  public String advise {get;set;}//建议
	  public String clientadvice {get;set;}//客户意见
	  public Double jsfwjz {get;set;}//技术服务价值
	  public Double sqtotleprice {get;set;}//配件更换价值
	  public Double totals {get;set;}//总计
	  public String serviceengnineer {get;set;}//服务工程师
	  public String completetime {get;set;}//完成时间
	  public String acceptor {get;set;}//客户签字
	  public String receptiontime {get;set;}//验收时间
	  
	}
	public class InnerClass{
	  public String PNname {get;set;}//名称PN
	  public String serialnumber {get;set;}//SN
	  public Double numbers {get;set;}//数量
	  public Integer counts{get;set;}
	  
	}

}