/**
*Create By:jmark
*TIME：2015年2月26日10:35:25
*Descripe:设备参数更新
                        技术服务报告报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中  
 */
trigger servicereport on servicereport__c (after insert, after update) {
    if(trigger.isAfter)
    {
    	Cbl_servicereport_renew csr=new Cbl_servicereport_renew();
    	Cbl_CreateServiceReportPDF ccpdf=new Cbl_CreateServiceReportPDF(); 
        
       if(trigger.isInsert || trigger.isUpdate)
       {
           csr.insertRenewEquipment(trigger.new);//设备参数更新
           
     	/** for(servicereport__c service:trigger.new){ 
     	 	if(service.state__c=='关闭'){
     	 Cbl_CreateServiceReportPDF.createVF(service.Id,UserInfo.getSessionId());  
     	 System.debug('触发器。。。。。。。。。。id'+service.Id);
     	 	}
     	 }*/
       }
    }
}