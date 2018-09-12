/*
*Function:重写知识库的新建和编辑页面
*Date:2013-01-29
*/
public class QAdetail 
{
	public String strTypeId { get; set;}//类型ID
	//public String strTypeIdNew {get;set;}//从列表新建时取类型Id
	public String strMode { get; set;}//编辑 or 新建状态
	public knowledgecontent__c obj_QA{ get; set;} 

	public QAdetail(ApexPages.standardController controller)
	{
		strTypeId=ApexPages.currentPage().getParameters().get('tid');
		//strTypeIdNew=ApexPages.currentPage().getParameters().get('CF00N90000004QCNe_lkid');//00NN0000000UWYk
		Id id=ApexPages.currentPage().getParameters().get('Id');
		strMode=ApexPages.currentPage().getParameters().get('mode');
		if((strMode=='new'||strMode==null)&&id==null)
		{
			obj_QA=new knowledgecontent__c();
			obj_QA.knowledgetype__c=strTypeId;
			obj_QA.OwnerId = Userinfo.getUserId();
			//IsUsed__c			需要设置
		}else if((strMode=='edit'||strMode=='view'||strMode==null)&&id!=null)
		{
			obj_QA=[Select q.keyword__c, q.describe__c, q.knowledgetype__c, q.OwnerId, q.Name, q.LastModifiedDate, 
					q.Is_published__c, q.Id,q.content__c, 
					q.CreatedDate From knowledgecontent__c q where q.id=:id];
		}
	} 

	public PageReference back() 
	{
		Id id=ApexPages.currentPage().getParameters().get('Id');
		PageReference pagereference = null;
		if(strMode=='new')
		{
			pagereference=new PageReference('https://'+ApexPages.currentPage().getHeaders().get('Host')+'/apex/QATree');
			pagereference.setRedirect(true);
		}else if(strMode==null)
		{
			if(id!=null)
			{
				pagereference=new PageReference('https://'+ApexPages.currentPage().getHeaders().get('Host')+'/'+id);
			}
		}
		return pagereference;
	}
	
	public PageReference save() 
	{
		upsert obj_QA;
		//PageReference pagereference=new PageReference('https://'+ApexPages.currentPage().getHeaders().get('Host')+'/apex/QAlist?tid='+obj_QA.QAType__c);
		
		PageReference pagereference=new PageReference('https://'+ApexPages.currentPage().getHeaders().get('Host')+'/'+obj_QA.Id);
		pagereference.setRedirect(true);
		return pagereference;
		
	}
	//测试类
	/*private static testMethod void myUnitTest() {
		knowledgetype__c qatype = new knowledgetype__c();
		qatype.Name = '珠宝';
		qatype.WhetherLowerType__c = true;
		insert qatype;
		knowledgecontent__c qa = new knowledgecontent__c();
		qa.Theme__c = 'test';
		qa.QAType__c = qatype.Id;
		qa.Description__c ='1222';
		insert qa;
		
		ApexPages.CurrentPage().getParameters().put('tid',qatype.Id);
		Apexpages.currentPage().getParameters().put('Id',qa.Id);
		Apexpages.currentPage().getParameters().put('mode','view');
		ApexPages.standardController controller= new Apexpages.standardController(qa);
		QAdetail qadetail = new QAdetail(controller);
		qadetail.save();
		qadetail.back();
		Apexpages.currentPage().getParameters().put('mode','new');
		ApexPages.standardController controller2= new Apexpages.standardController(qa);
		QAdetail qadetail2 = new QAdetail(controller2);
	}*/
}