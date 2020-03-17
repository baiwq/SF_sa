@isTest
global class TestMockImplFileServer implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
       FileServerToken.GetTokenResponse_element GTRE = new FileServerToken.GetTokenResponse_element();
       response.put('response_x',GTRE); 
   }
}