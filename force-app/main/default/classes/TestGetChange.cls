@isTest
global class TestGetChange implements WebServiceMock{
    global void doInvoke(
        Object stub,
        Object request,
        Map<String,Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType){
            ContractChangeInterface.outPutDataType OPDT = new ContractChangeInterface.outPutDataType();
            response.put('response_x',OPDT);
        }
    
}