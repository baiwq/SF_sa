@isTest
global class TestSFService implements WebServiceMock{
    global void doInvoke(Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType){
       SFServiceExpressserviceIntegrationSfCo.sfexpressServiceResponse resp = new SFServiceExpressserviceIntegrationSfCo.sfexpressServiceResponse();
       response.put('response_x',resp);
    }
}