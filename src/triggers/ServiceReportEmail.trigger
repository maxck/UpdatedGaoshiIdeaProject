trigger ServiceReportEmail on servicereport__c (after insert, after update) {
      if(trigger.isAfter){
        //状态为关闭，插入或者更新技术服务报告报告时自动发送邮件附件
         for(servicereport__c ss:trigger.new){ 
          if(ss.state__c=='关闭'){
          Cbl_CreateServiceReportPDF.createVF(ss.Id,UserInfo.getSessionId());  
         System.debug('触发器。。。。。。。。。。id'+ss.Id);
            }
         }
       }
}