@isTest
global class TestMockCPQ01 implements WebServiceMock {
    global void doInvoke(
    	Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType
    ){
        wwwExampleOrgSospCpqCos001.SOSP_CPQ_COS_001Response_element respon = new wwwExampleOrgSospCpqCos001.SOSP_CPQ_COS_001Response_element();
        response.put('response_x ', respon);
    }
}