/**
*Create By:jmark
*TIME：2015年3月3日15:15:11
*Descripe: 巡检服务请求，在请求时间头10天发送邮件给所有人和第二责任人
 */
global class Schedulableservicerequest implements Schedulable{
     global void execute(SchedulableContext SC) {
     	 system.debug('--------------------进来了');
         ID batchprocessid = Database.executeBatch(new Cls_Schedulableservicerequest_batch(),50);
     }
}