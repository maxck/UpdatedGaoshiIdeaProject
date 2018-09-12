trigger InstallReportEmail on installreport__c (after insert, after update) {
       if(trigger.isAfter){
      //状态为已完成，插入或者更新安装单时自动发送邮件附件
         for(installreport__c insta:trigger.new){ 
            if(insta.state__c=='已完成'){
         Cbl_CreateInstallPDF.createVF(insta.Id,UserInfo.getSessionId());  
         System.debug('触发器。。。。。。。。。。id'+insta.Id);
            }
         }
       }
}