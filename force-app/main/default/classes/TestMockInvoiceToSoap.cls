@isTest
global class TestMockInvoiceToSoap implements WebServiceMock{
    public String i;
    global TestMockInvoiceToSoap (String i){
        this.i=i;
    }
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
    
    OrgCurrencyZfiDocumentGeneral.CurrenyOutputRootType  saa = new  OrgCurrencyZfiDocumentGeneral.CurrenyOutputRootType();
    if(i == 'a'){
       saa.BELNR = '1111';
    }
    else{
    saa.BELNR = null;
    
    }
    OrgCurrencyZfiDocumentGeneral.ZFI_DOCUMENT_GENERALResponse_element respTest = new OrgCurrencyZfiDocumentGeneral.ZFI_DOCUMENT_GENERALResponse_element ();
    respTest.CurrenyOutputRoot = saa;
    response.put('response_x',respTest);

   }
 }