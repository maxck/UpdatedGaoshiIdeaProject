/**
*Dis: 设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中 
*Time:2015年3月4日10:55:46
*Author:Somnus Wang
**/
public  class Ctr_CreatePDF_InstallReport {
	public Wrapper wrapp{get;set;}
	public String pageId{get;set;}
	public  Ctr_CreatePDF_InstallReport(){
	  wrapp=new Wrapper();
	  
	  Set<ID> setrecordtype=new Set<ID>();//安装确认单记录类型
	  Set<ID> setowner=new Set<ID>();//所有人
	  
	  String msg=null;//安装确认单记录类型
	  String u=null;//所有人
	  
	  //获得页面id   
	  pageId=ApexPages.currentPage().getParameters().get('id');
	  List<installreport__c> listinstallreport=[select Name,Id,RecordTypeId,customer__c,address__c,postcode__c,
	  department__c,person__r.Name,landline__c,phone__c,Equipmentname__c,Equipmentunittype__c,
	  Equipment__c,temperature__c,hfnm__c,hfmj__c,lfnm__c,lfmj__c,	hvv__c,humidity__c,initialpressure__c,intracavitypressure__c,
	  traincase__c,servicereport__r.OwnerId,arrivaldate__c,completedate__c from installreport__c where id=:pageId];
	  
	  for(installreport__c insta:listinstallreport){
		  setowner.add(insta.servicereport__r.OwnerId);//所有人
		  setrecordtype.add(insta.RecordTypeId);//安装确认单记录类型
		  System.debug('培训情况。。。。。。。'+insta.traincase__c);
		}
		
     List<RecordType> listrecordtype=[select Name from RecordType where Id in:setrecordtype];//安装确认单记录类型
	 List<User> users=[select Name from User where Id in:setowner];//查询所有人
	 
	 for(User uu:users){
			u=uu.Name;
		}
	 for(RecordType re:listrecordtype){
		System.debug('记录类型。。。。。。。。。。'+re.Name);
			if(re.Name!=null){
		     msg=re.Name;
			}
		}
		
		
	  for(installreport__c install:listinstallreport){
	   System.debug('安装环境温度...'+install.temperature__c+'安装环境湿度....'+install.humidity__c);
	        wrapp.types=msg;//记录类型
		    wrapp.hospitalName=install.customer__c;//医院名称
		    wrapp.address=install.address__c;//地    址
		    wrapp.postCode=install.postcode__c;//邮编
		    wrapp.department=install.department__c;//使用科室
		    wrapp.contacts=install.person__r.Name;//联系人
		    wrapp.landline=install.landline__c;//座机
		    wrapp.phone=install.phone__c;//手机
		    wrapp.equipmentname=install.Equipmentname__c;//设备名称
		    wrapp.equipmentunittype=install.Equipmentunittype__c;//型号
		    wrapp.equipment=install.Equipment__c;//序列号
		    wrapp.temperature=install.temperature__c;//安装环境温度
		    wrapp.humidity=install.humidity__c;//安装环境湿度
		    wrapp.hfnm=install.hfnm__c;//能量测试HF（nm）
		    wrapp.hfmj=install.hfmj__c;//能量测试HF（mj）
		    wrapp.lfnm=install.lfnm__c;//能量测试LF（nm）
		    wrapp.lfmj=install.lfmj__c;//能量测试LF（mj）
		    wrapp.hvv=install.hvv__c;//能量测试LV（v）
		    wrapp.initialpressure=install.initialpressure__c;//气体参数/气瓶初始气压
		    wrapp.intracavitypressure=install.intracavitypressure__c;//腔内气压
		    wrapp.traincase=install.traincase__c;//设备培训情况
		    wrapp.installengnineer=u;////安装工程师
		    if(install.arrivaldate__c!=null){
		    wrapp.arrivaldate=install.arrivaldate__c.year()+'-'+install.arrivaldate__c.month()+'-'+install.arrivaldate__c.day();//完成日期
		    }
		    if(install.completedate__c!=null){
		    wrapp.completedate=install.completedate__c.year()+'-'+install.completedate__c.month()+'-'+install.completedate__c.day();//到达日期
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
	  public String temperature {get;set;}//安装环境温度
	  public String humidity {get;set;}//安装环境湿度
	  public Double hfnm {get;set;}//能量测试HF（nm）
	  public Double hfmj{get;set;}//能量测试HF（mj）
	  public Double lfnm{get;set;}//能量测试LF（nm）
	  public Double lfmj{get;set;}//能量测试LF（mj）
	  public Double hvv{get;set;}//能量测试LV（v）
	  public Double initialpressure {get;set;}//气体参数/气瓶初始气压
	  public Double intracavitypressure {get;set;}//腔内气压
	  public String traincase {get;set;}//设备培训情况
	  public String installengnineer {get;set;}//安装工程师
	  public String arrivaldate {get;set;}//到达日期
	  public String completedate {get;set;}//完成日期
	} 
}