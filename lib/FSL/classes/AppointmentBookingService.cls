/*
系统会生成此文件，且不是此托管全局类的
实际源代码。
此只读文件显示显示类的全局构造器、
方法、变量和属性。
要启动代码编译，所有方法会返回空。
*/
global class AppointmentBookingService {
    global AppointmentBookingService() {

    }
    global static FSL.ABSlotsResponse GetABSlots(Id serviceID, Id policyId, OperatingHours calendar, System.TimeZone tz, String sortBy, Boolean exactAppointment) {
        return null;
    }
    @InvocableMethod(label='AppointmentBooking GetSlots' description='Get appointment booking slots')
    global static List<FSL.AppointmentBookingService.AppointmentBookingSlotWrapper> GetSlots(List<FSL.AppointmentBookingService.AppointmentBookingParamsWrapper> ABParams) {
        return null;
    }
    global static List<FSL.AppointmentBookingSlot> GetSlots(Id serviceID, Id policyId, OperatingHours calendar, System.TimeZone tz, Boolean exactAppointment) {
        return null;
    }
    global static List<FSL.AppointmentBookingSlot> GetSlots(Id serviceID, Id policyId, OperatingHours calendar, System.TimeZone tz, FSL.AppointmentBookingService.SortResultsBy sortResults, Boolean exactAppointment) {
        return null;
    }
    global static List<FSL.AppointmentBookingSlot> GetSlots(Id serviceID, Id policyId, OperatingHours calendar, System.TimeZone tz, String sortBy, Boolean exactAppointment) {
        return null;
    }
global class AppointmentBookingParamsWrapper {
    @InvocableVariable( required=true)
    global Id calendarId;
    @InvocableVariable( required=false)
    global Boolean exactAppointment;
    @InvocableVariable( required=true)
    global Id policyId;
    @InvocableVariable( required=true)
    global Id serviceID;
    @InvocableVariable( required=false)
    global String sortBy;
    @InvocableVariable( required=true)
    global String tz;
    global AppointmentBookingParamsWrapper() {

    }
}
global class AppointmentBookingSlotWrapper {
    @InvocableVariable( required=false)
    global List<Decimal> Grade;
    @InvocableVariable( required=false)
    global List<Datetime> SlotFinish;
    @InvocableVariable( required=false)
    global List<Datetime> SlotStart;
}
global enum SortResultsBy {Grade, NoSort, SLotDateTime}
}
