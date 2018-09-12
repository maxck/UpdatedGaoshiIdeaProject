/**
*Create By:jmark
*TIME：2015年2月27日13:10:13
*Descripe: 注册码在到期前两周自动发邮件提醒第一责任人、第二责任人、高级助理
 */
global class SchedulableRegistrationcode implements Schedulable{
     global void execute(SchedulableContext SC) {
     	 system.debug('--------------------进来了');
         ID batchprocessid = Database.executeBatch(new Cls_SchedulableRegistrationcodeBatch(),50);
     }
}