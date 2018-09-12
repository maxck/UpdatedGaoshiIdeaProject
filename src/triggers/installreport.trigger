/**
*Create By:jmark
*TIME：2015年2月26日13:19:07
*Descripe:新机安装后进行的PMMA测试证书时间自动关联到设备基础信息下的保修开始时间
 */
trigger installreport on installreport__c (after insert, after update) {
     if(trigger.isAfter)
     {   
     	 Cbl_installreport_time cblinstime=new Cbl_installreport_time();
         if(trigger.isInsert)
         {
         	 system.debug('---------------------lllllllllllll');
             cblinstime.insertInstallreportTime(trigger.new);
         }
         if(trigger.isUpdate)
         {
         	 system.debug('----------------------gggggggggggggggg');
             cblinstime.updateInstallreportTime(trigger.new, trigger.oldMap);
         }
     }
}