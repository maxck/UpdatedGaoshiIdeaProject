@RestResource(urlMapping='/SyncProductInfoRestService/*')
global class SyncProductInfoRestService {
	
    @HttpPost  
    global static void createProduct(){

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String productRequest = req.requestBody.toString();
        String responseMsg = '';
        System.debug('get first account rest service request xml info is'+  productRequest );
        
        RestServiceUtil.ProductRequestParam tempRequestParam = null;
        tempRequestParam = RestServiceUtil.parseProductRequest(productRequest);
        if(tempRequestParam != null)
        {   
            //param error response
            if(tempRequestParam.result.success == false)
            {   
                responseMsg = tempRequestParam.result.message;
                XmlStreamWriter w = new XmlStreamWriter();
                w.writeStartDocument('UTF-8', '1.0');

                w.writeStartElement(null, 'response', null);
                w.writeStartElement(null, 'result', null);
                w.writeStartElement(null, 'success', null);
                w.writeCharacters(String.valueOf(tempRequestParam.result.success));
                w.writeEndElement(); //end success
                w.writeStartElement(null, 'message', null);
                w.writeCharacters(tempRequestParam.result.message);
                w.writeEndElement(); //end message
                w.writeEndElement(); //end result
                w.writeEndElement(); //end response
                
                w.writeEndDocument();
                responseMsg = w.getXmlString();
            }
            else
            {   
                long startCurrentTime = Datetime.now().getTime();
                RestServiceUtil.Result result = RestServiceCoreLogic.createProduct(tempRequestParam);
                long endCurrentTime = Datetime.now().getTime();
                System.debug('request object info is ' + tempRequestParam);
                system.debug('excute time is ##############' + (endCurrentTime - startCurrentTime));
                responseMsg = tempRequestParam.result.message;
                XmlStreamWriter w = new XmlStreamWriter();
                w.writeStartDocument('UTF-8', '1.0');

                w.writeStartElement(null, 'response', null);
                w.writeStartElement(null, 'result', null);
                w.writeStartElement(null, 'success', null);
                w.writeCharacters(String.valueOf(result.success));
                w.writeEndElement(); //end success
                w.writeStartElement(null, 'message', null);
                w.writeCharacters(result.message);
                w.writeEndElement(); //end message
                w.writeEndElement(); //end result
                w.writeEndElement(); //end response
                
                w.writeEndDocument();
                responseMsg = w.getXmlString();
            }
        }
        else
        {   
            System.debug('request object info is ' + tempRequestParam);
            responseMsg = '<?xml version="1.0" encoding="UTF-8"?>' +
            			  '<response><result><success>false</success><message>请求内容异常，请发送正确请求！</message></result></response>';

        }
        System.debug('responseMsg info is'+  responseMsg );
        res.addHeader('Content-Type', 'application/xml');
        res.responseBody = Blob.valueOf(responseMsg);
    
		
    }
	
    
}