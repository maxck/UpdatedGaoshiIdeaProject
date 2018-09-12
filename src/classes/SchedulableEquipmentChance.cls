/**
*Create By:Jmark
*TIME：2016年8月26日10:04:44
*Descripe:设备保修到期后自动生成对应的新的业务机会，提前一年通知，并增加提醒功能
 */
global class SchedulableEquipmentChance implements Schedulable{
     global void execute(SchedulableContext SC) { 
         ID batchprocessid = Database.executeBatch(new Batch_Equipment_NewChance(),50);
     }
}