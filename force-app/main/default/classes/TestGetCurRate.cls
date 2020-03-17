@isTest
public class TestGetCurRate implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {  
     	HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setStatus('OK');
        String jsonBody = '{"status":"success","msg":"","token":"3c334dcb20a34110b4e2ddf49409bd12","InvalidSum":"0.1","CustomerSpecified":"是","SalesDesignation":"是","NewBusiness":"是","Rate":"0","OwnTotalPrice":"0","OutsourcingTotalPrice":"0","OutsourcingServiceChargeTotalPrice":"0","ConstructionTechnologyTotalPrice":"0","InstallationCostTotalPrice":"0","DebuggingTotalPrice":"0","TestFeeTotalPrice":"0","JCCUCostTotalPrice":"0","FactoryAcceptanceTotalPrice":"0"}';
        res.setBody(jsonBody);    
	 	return res;
    }
}