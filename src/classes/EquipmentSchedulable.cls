/**
*Create By:jmark
*TIME：2015年2月26日16:30:15
*Descripe:自动计算设备机龄
 */
global class EquipmentSchedulable implements Schedulable{
     global void execute(SchedulableContext SC) {
     	 system.debug('--------------------进来了');
         ID batchprocessid = Database.executeBatch(new Cls_EquipmentBatch(),50);
     }
}