/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class Ctrl078_CapacityCalendar {
    @RemoteAction
    global static List<ServiceResourceCapacity> deleteCapacities(List<Id> capacitiesIds) {
        return null;
    }
    @RemoteAction
    global static List<ServiceResourceCapacity> getMonthlyCapacities(String startDateString, String endDateString, Id resourceId) {
        return null;
    }
    @RemoteAction
    global static List<ServiceResourceCapacity> saveChangesToCapacity(Id capacityId, Id resourceId, String periodStart, Integer hoursCapacity, Integer servicesCapacity, String durationType, Integer daysDiff) {
        return null;
    }
    @RemoteAction
    global static List<ServiceResourceCapacity> updateMultipleCapacities(List<Id> capacitiesIds, Integer hoursCap, Integer servicesCap) {
        return null;
    }
}
