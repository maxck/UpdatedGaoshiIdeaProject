/**
*Create By:jmark
*TIME：2015年2月28日09:32:41
*Descripe:设备及保修合约在保修到期前3个月，自动生成业务机会。并邮件发给：武总、陈经理、主管、高级助理
                              设备合约产品在保修到期前3个月，自动生成业务机会。并邮件发给：武总、陈经理、主管、高级助理
 */
global class SchedulableEquipmentWarrantyproduct implements Schedulable{
     global void execute(SchedulableContext SC) {
     	 system.debug('--------------------进来了');
         ID batchprocessid = Database.executeBatch(new Cls_SchedulEquipmentWarrantyproductBatch(),50);
         ID batchprocessid1 = Database.executeBatch(new Cls_SchedulWarrantyproductBatch(),50);
     }
}