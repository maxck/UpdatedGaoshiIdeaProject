/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class AdvancedGapMatrix {
    global Id FSLOperationId {
        get;
        set;
    }
    global List<FSL.PartialResultsInfo> PartialResults {
        get;
        set;
    }
    global Map<Id,FSL.ResourceScheduleData> ResourceIDToScheduleData;
    global ServiceAppointment Service;
    global AdvancedGapMatrix() {

    }
}
