@isTest
global class TestMockGetInvoiceInfo implements WebServiceMock{

 public invoiceItem__c invo;
    global TestMockGetInvoiceInfo (invoiceItem__c invo){
        this.invo=invo;
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
      if(invo!= null){
        List<EsbMossGetcontractinvo.OutputCiType> outtypes =new list<EsbMossGetcontractinvo.OutputCiType>();
        EsbMossGetcontractinvo.OutputCiType outtype = new EsbMossGetcontractinvo.OutputCiType();
        outtype.ID=invo.invoiceUUID__c;
        
        
        outtype.ApplicationID=invo.invoiceUUID__c;
        outtype.CustomerName='123';
        outtype.SumAmount='123';
        outtype.InvoiceStatus='123';
        outtype.SendBackTime='2017/1/1 1:1:1';
        outtype.ImportTime='2017/1/1 1:1:1';
        outtype.Tax='123';
        outtype.CombineFlag='123';
        outtype.InvoiceType='s';
        outtype.InvoiceCode='123';
        outtype.InvoiceNumber='123';
        outtypes.add(outtype);
        EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceResponse_element respElement= 
            new EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceResponse_element();
        EsbMossGetcontractinvo.GetContractInvoiceOutPutType output = new EsbMossGetcontractinvo.GetContractInvoiceOutPutType();
        output.OutputCi=outtypes;
        respElement.GetContractInvoiceOutPut=output;
        response.put('response_x', respElement);
        }
        else{
        
        EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceResponse_element respElement= 
            new EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceResponse_element();
        response.put('response_x', respElement);         
        }
        
        
        
    }
}