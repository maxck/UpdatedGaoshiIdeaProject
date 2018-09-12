/*
*Author:Jieme
*Created on:2012-1-12
*Description：QA知识树
*Author Email:jiemexu@frensworkz.com
*/
global class QATree { 
	//拼接xml文件格式字符串的变量
	public static String startStr = '<tree id=\'0\'>';
	//public static String startStr = '<tree ';
	public static String endStr = '</tree>';
	public static String conStr = '\''; 
	public static String itemStart = '<item';
	public static String itemStartEnd = '>';
	public static String id = ' id=';
	public static String text = ' text=';
	public static String itemEnd = '</item>';
	public static String itemEndend = ' />';
	public static String outStr = '';
	public static List<knowledgetype__c> kList;
	public String qid{get;set;}
	public String nodeIds{get;set;}
	public String strurl{get;set;}
	
	public String lxrinfo { get; set; }
	public String proTypeId { get; set;}
	//public List<Product__c> keyDataList{get;set;}
	public Boolean showPageBlock{get;set;}
	public Boolean showMess{get;set;}
	public String showDetail{get;set;}
	public knowledgecontent__c obj_QA{get;set;}
	public Boolean blnIsDetailShow{get;set;}
	
	//系统构造函数
	public QATree(){
		//页面渲染时 ，隐藏  显示结果,待搜索出结果后显示
		//showPageBlock = false;
		//搜索不到产品，页面进行提示
		//showMess = false;
	}
  	 
    webService static String getKnowLedgeTreeStr(){
		//System.debug('startLoading.............');
		kList = [Select Id,Name,father_type__c from knowledgetype__c order by sort__c asc];
		List<knowledgetype__c> pList = new List<knowledgetype__c>();
		for(Integer i =0;i<kList.size();i++){
			if(kList[i].father_type__c == null){
				pList.add(kList[i]);
				kList.remove(i);
				i--;
			}
		}
		outStr += startStr;
		
		for(knowledgetype__c know : pList){
			
			outStr +=itemStart + text + conStr + know.Name + conStr + id + conStr + know.Id + conStr + 
			' call=\'0\' ' + itemStartEnd + getChildStr(know.Id) + itemEnd ;	
		}
		outStr += endStr;
		//System.debug('EndLoading.............');
		//System.debug('endStr.............'+outStr);
		return outStr;
	}
    webService static String getParent(){
		List<knowledgetype__c > pList = [Select Id,Name,father_type__c from knowledgetype__c 
									     where  father_type__c = null order by sort__c asc];
		outStr += startStr;
		for(knowledgetype__c know : pList){
			outStr += id + conStr + know.Id + conStr + itemStart + text + conStr + know.Name + conStr + id + conStr + know.Id + conStr + 
			' call=\'0\' ' + itemStartEnd + itemEnd ;	
		}
		outStr += endStr;
		return outStr;
	}
	//获得每个节点的所有子节点,无限递归
	public static String getChildStr(ID pid){
		//System.debug('start.............');
		String cStr = '';
		List<knowledgetype__c> cKnow = new List<knowledgetype__c>();
		for(knowledgetype__c know : kList){
			if(know.father_type__c == pid){
				cKnow.add(know);
			}
		}
		for(knowledgetype__c know : cKnow){
			cStr +=itemStart + text + conStr + know.Name + conStr + id + conStr + know.Id + conStr + itemStartEnd + getChildStr(know.Id)+ itemEnd;	
		}
		//System.debug('end.............');
		return cStr;
	}
	
	public void queryData(){
		 
			keySearch('typeSearch');
		
	} 
	
	public void keyQueryData(){
			
      		keySearch('keySearch');
		
	} 
	public void keySearch(String strtype){
		/*
		if(lxrinfo == null||lxrinfo =='')
			es= new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Name,QAType__r.Name,Theme__c,Description__c from Q_A__c where QAType__c =: proTypeId and IsUsed__c = true]));
		else{
			lxrinfo = '%'+lxrinfo+'%';
			//system.debug('ss'+lxrinfo);
			es= new ApexPages.StandardSetController(Database.getQueryLocator([select QAType__r.Name,Theme__c,Description__c from Q_A__c where Theme__c LIKE :lxrinfo and IsUsed__c = true]));
			 
		}*/
		//String sql='select Id,Name,QAType__r.Name,Theme__c,Description__c from Q_A__c where  IsUsed__c = true';
		if(strtype!=null&&strtype=='typeSearch'&&proTypeId!=null&&proTypeId!='')
		{
			//sql=sql+' and QAType__c =: proTypeId';
			es= new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Name,knowledgetype__r.Name,keyword__c,describe__c from knowledgecontent__c where knowledgetype__c =: proTypeId and Is_published__c = true]));
			
		}
		if(strtype!=null&&strtype=='keySearch'&&lxrinfo != null&&lxrinfo !='')
		{
			lxrinfo = '%'+lxrinfo+'%';
			//sql=sql+' and Theme__c like :lxrinfo';
			es= new ApexPages.StandardSetController(Database.getQueryLocator([select knowledgetype__r.Name,keyword__c,describe__c from knowledgecontent__c where keyword__c LIKE :lxrinfo and Is_published__c = true]));
			
		}
		//es= new ApexPages.StandardSetController(Database.getQueryLocator(sql));
		
		if(this.es!= null){
	       lxrPageCount = es.getResultSize();
	        
	    }
		if(lxrPageCount>0){
			
			showPageBlock = true;
			showMess = false;
		}
		else{
			showPageBlock = false;
			showMess = true;
			showDetail = '没有找到符合条件的记录.';
		}
		 
	} 
	ApexPages.StandardSetController es;
    //总页数
    public Integer lxrTotalPage{get;set;}
    //当前页
    public Integer lxrPageNumber{get;set;}
    //总记录数
    public Integer lxrPageCount{get;set;} 
    
    //页大小
    public Integer pageSize =15;
    public Integer getPageSize(){
    	return pageSize;
    }
    //存放当前页记录数
    public List<knowledgecontent__c> lxrlist = new List<knowledgecontent__c>();
    
	public static long MySum(long n)
	{
		if(n<=1)
		{
			return 1;
		}
		else
		{
			return n*MySum(n-1);
		}
	}
	
	public List<knowledgecontent__c> getLxrlist(){
        if(this.es!= null){
        	//每页显示10条
            es.setPageSize(pageSize);
            lxrlist = (List<knowledgecontent__c>) es.getRecords();
            //lxrPageCount = es.getResultSize();
            Integer remainder = math.mod(lxrPageCount, pageSize);
	        if(remainder==0){
	            lxrTotalPage = lxrPageCount/pageSize;
	        }
	        else{
	            lxrTotalPage = (lxrPageCount/pageSize)+1;
	        }
	        lxrPageNumber = es.getPageNumber();
	    }
        return lxrlist;
    } 
    
    
    //第一页
    public PageReference lxrFirst(){
        if(es != null){
           es.first();
        }
        return null;
    }
        //前一页
    public PageReference lxrPrevious(){
        if(es != null){
            es.previous();
        }
        return null;
    }
      //下一页
    public PageReference lxrNext(){
        if(es != null){
            es.next();
        }
        return null;
    }
        
        //最后一页
    public PageReference lxrLast(){
        if(es != null){
            es.last();
        }
        return null;
    }
    
   /* public void deleteItem() 
    {
    	Q_A__c q=[select id from Q_A__c where id =:qid];
    	delete q;
		
	}*/
	
	public PageReference CreateQa() 
    {
    	if(proTypeId != null&&proTypeId!=''){
			PageReference pagereference=new PageReference('https://'+ApexPages.currentPage().getHeaders().get('Host')+'/apex/QAdetail?tid='+proTypeId+'&mode=new');
			pagereference.setRedirect(true);
			return pagereference;
    	}
		else{
		 
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, '请选择Q&A类型！','请选择Q&A类型！');
 
        	ApexPages.addMessage(myMsg);
                
			return null;

		}
	}
	
}