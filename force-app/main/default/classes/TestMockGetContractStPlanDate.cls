@isTest
global class TestMockGetContractStPlanDate implements WebServiceMock{
   public statusTracking__c invo;
    global TestMockGetContractStPlanDate (statusTracking__c invo){
        this.invo=invo;
        system.debug('------------------'+invo);
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
        String responseType
    ){
       List<EspFindbytime.contractListType>  conList = new List<EspFindbytime.contractListType>();
       EspFindbytime.contractListType con = new EspFindbytime.contractListType();
     
        System.debug('rrrrrrrrrrrrrrrrrrrr'+invo.contractNumber__c);
       con.contractNumber = invo.contractNumber__c;
        con.debugFinishDate = '2016-09-02';
        con.debugStartDate = '2016-09-01';
        con.expectEndDate = '2017-11-01';
        con.expectStartDate = '2017-11-01';
        con.runDate = '2017-11-01';
        conList.add(con);
                
        EspFindbytime.ESP_findByTimeResponse_element  abcd = new EspFindbytime.ESP_findByTimeResponse_element();
        EspFindbytime.SmcOutputRootTYpe stp = new  EspFindbytime.SmcOutputRootTYpe();      
        stp.contractList = conList;     
        stp.resultFlag = 'S';
        abcd.SmcOutputRoot = stp;        
        response.put('response_x', abcd);
    }
}