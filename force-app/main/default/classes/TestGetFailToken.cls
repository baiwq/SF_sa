@isTest
public class TestGetFailToken  implements HttpCalloutMock{
 public HTTPResponse respond(HTTPRequest req) {  
     	HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        String jsonBody = '{"status":"fail","msg":"","token":"3c334dcb20a34110b4e2ddf49409bd12","filePath":"123","resultUrl":"123"}';
        res.setBody(jsonBody);    
	 	return res;
    }
}