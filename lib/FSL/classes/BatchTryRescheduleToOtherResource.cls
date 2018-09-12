/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class BatchTryRescheduleToOtherResource implements Database.AllowsCallouts, Database.Batchable<SObject>, Database.Stateful {
    global void execute(Database.BatchableContext BC, List<ServiceAppointment> services) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global List<ServiceAppointment> start(Database.BatchableContext bc) {
        return null;
    }
}
