@isTest
global class TestMockCPQ013 implements WebServiceMock {
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
        wwwExampleOrgSospCpqCos013.SOSP_CPQ_COS_013Response_element respon = new wwwExampleOrgSospCpqCos013.SOSP_CPQ_COS_013Response_element();
        response.put('response_x', respon);
    }
}