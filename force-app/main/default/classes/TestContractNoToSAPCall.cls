@isTest(seeAllData=true)
public class TestContractNoToSAPCall {
    @isTest static void testMethod1(){
        Test.setMock(WebServiceMock.class, new TestContractNoToSAPMock());
        Contract__c con = [select Name from Contract__c limit 1][0];
        if(con!=null){
            SOSPTriggerCallSAPFinancial.triggerCallMethod(con.Name);
        }
        
    }
}