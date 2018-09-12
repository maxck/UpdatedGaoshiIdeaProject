/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
@RestResource(urlMapping='/OAASRestService/*')
global class OAASRestService {
    global OAASRestService() {

    }
    @HttpGet
    global static FSL.OAASRestService.GetDataResult getData() {
        return null;
    }
    @HttpPatch
    global static FSL.OAASRestService.UpdateStatusResult updateStatus(FSL.OAASRestService.UpdateStatusData data) {
        return null;
    }
    @HttpPut
    global static FSL.OAASRestService.WriteResultsResult writeResults(FSL.OAASRestService.WriteResultsData data) {
        return null;
    }
global class GetDataResult {
    global String Data {
        get;
        set;
    }
    global Integer NextIndex {
        get;
        set;
    }
    global GetDataResult() {

    }
}
global class UpdateStatusData {
    global String dataID {
        get;
        set;
    }
    global String failReason {
        get;
        set;
    }
    global String status {
        get;
        set;
    }
    global UpdateStatusData() {

    }
}
global class UpdateStatusResult {
    global UpdateStatusResult() {

    }
}
global class WriteResultsData {
    global Integer avgTravelTimeAfterRSO {
        get;
        set;
    }
    global Integer avgTravelTimePriorToRSO {
        get;
        set;
    }
    global Integer currIndex {
        get;
        set;
    }
    global String dataID {
        get;
        set;
    }
    global Boolean isLast {
        get;
        set;
    }
    global String jsonStr {
        get;
        set;
    }
    global Integer numberOfServicesScheduled {
        get;
        set;
    }
    global Integer numberOfServicesToSchedule {
        get;
        set;
    }
    global String resultsText {
        get;
        set;
    }
    global WriteResultsData() {

    }
}
global class WriteResultsResult {
    global WriteResultsResult() {

    }
}
}
