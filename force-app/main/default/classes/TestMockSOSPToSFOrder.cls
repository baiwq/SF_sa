@isTest
global class TestMockSOSPToSFOrder implements WebServiceMock{
    public String i;
    global TestMockSOSPToSFOrder (String i){
    
     this.i = i;
    }
    

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
            SFServiceExpressserviceIntegrationSfCo.sfexpressServiceResponse ssr = new SFServiceExpressserviceIntegrationSfCo.sfexpressServiceResponse();
            if(i=='a'){
            ssr.return_x='<?xml version="1.0" encoding="UTF-8"?><Response service="OrderService"><Head>OK</Head><Body><OrderResponse filter_result="3" destcode="024" mailno="601234460842" origincode="010" orderid="OID20171113130436ASLWh"/></Body></Response>';
           }else if(i=='b'){
           ssr.return_x='<?xml version="1.0" encoding="UTF-8"?><Response service="OrderService"><Head>OK</Head><Body><OrderResponse filter_result="2" mailno="601234460842" origincode="010" orderid="OID20171113130436ASLWh"/></Body></Response>';           
           }
           else if(i=='c'){
           ssr.return_x='<?xml version="1.0" encoding="UTF-8"?><Response service="OrderService"><Head>OK</Head><Body><OrderResponse filter_result="1" destcode="024" mailno="601234460842" origincode="010" orderid="OID20171113130436ASLWh"/></Body></Response>';           
           }else{    
           ssr.return_x='<?xml version="1.0" encoding="UTF-8"?><Response><Head>ERR</Head><ERROR code="传入格式错误,XML:BJSFJB"/></Response>';          
           }
            response.put('response_x',ssr);
        }
    
}