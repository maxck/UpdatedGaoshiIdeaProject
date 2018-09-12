/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class OAASRequest {
    global Boolean AllTasksMode {
        get;
        set;
    }
    global String FilterFieldAPIName {
        get;
        set;
    }
    global Datetime Finish {
        get;
        set;
    }
    global Boolean IncludeServicesWithEmptyLocation {
        get;
        set;
    }
    global List<Id> Locations {
        get;
        set;
    }
    global Integer NumberOfServicesToSchedule {
        get;
        set;
    }
    global Id SchedulingPolicyID {
        get;
        set;
    }
    global Datetime Start {
        get;
        set;
    }
    global OAASRequest() {

    }
}
