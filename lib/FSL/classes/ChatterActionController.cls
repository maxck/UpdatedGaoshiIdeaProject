/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class ChatterActionController {
    @RemoteAction
    global static void ChangeServiceToBeforeFormState(FSL.ChatterActionController.ServiceAppointmentChatter InputService, FSL.ChatterActionController.ChatterActionAdditionalData AdditionalData) {

    }
    @RemoteAction
    global static FSL.ChatterActionController.ServiceCreationResult CreateOrUpdateService(FSL.ChatterActionController.ServiceAppointmentChatter InputService, FSL.ChatterActionController.ChatterActionAdditionalData AdditionalData) {
        return null;
    }
    @RemoteAction
    global static FSL.ChatterActionController.ChatterActionFirstStageResult DoFirstStage(FSL.ChatterActionController.ServiceAppointmentChatter InputService, Boolean IsSLR, String ApexInterfaceFullName, FSL.ChatterActionController.ChatterActionAdditionalData AdditionalData) {
        return null;
    }
    @RemoteAction
    global static FSL.ChatterActionController.ChatterActionSecondStageResult DoSecondStage(FSL.ChatterActionController.ServiceAppointmentChatter InputService, Boolean IsSLR, String ApexInterfaceFullName, FSL.ChatterActionController.ChatterActionAdditionalData AdditionalData) {
        return null;
    }
    @RemoteAction
    global static FSL.ChatterActionController.ChatterActionData getChatterActionData(Id ObjectId) {
        return null;
    }
    @RemoteAction
    global static void updatePermissionSets() {

    }
    @RemoteAction
    global static Map<String,String> updatePermissionSetsWithTabAndRecordTypeReturned() {
        return null;
    }
global class ChatterActionAdditionalData {
    global ChatterActionAdditionalData() {

    }
}
global class ChatterActionData {
}
global class ChatterActionFirstStageResult extends FSL.ChatterActionController.ChatterActionStageResult {
    global ChatterActionFirstStageResult() {

    }
}
global class ChatterActionSecondStageResult extends FSL.ChatterActionController.ChatterActionStageResult {
    global ChatterActionSecondStageResult() {

    }
}
global abstract class ChatterActionStageResult {
    global ChatterActionStageResult() {

    }
}
global class ServiceAppointmentChatter {
    global ServiceAppointmentChatter() {

    }
}
global class ServiceCreationResult {
    global ServiceCreationResult() {

    }
}
}
