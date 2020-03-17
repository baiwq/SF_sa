@isTest
global  class TestContractNoToSAPMock implements WebServiceMock {
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
        wwwExampleOrgSapZsdSaleorderAbgru.SAP_ZSD_SALEORDER_ABGRUResponse_element  respon = new wwwExampleOrgSapZsdSaleorderAbgru.SAP_ZSD_SALEORDER_ABGRUResponse_element ();
        response.put('response_x ', respon);
    }
}