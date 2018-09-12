/**
*Dis:适用于trigger服务技术报告，设备安装报告在关闭时，可以生成打印模板，并自动发送报告附件邮件到第一责任人邮箱中测试类需要
     trigger中不能使用Blob b = ref.getContentAsPDF(); 
*Time:2015年3月16日13:07:02
*Author:Somnus Wang
**/
@IsTest global class Stubby implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"foo":"bar"}');
        res.setStatusCode(200);
        return res;
    }
}