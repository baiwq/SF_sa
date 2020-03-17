@isTest(seeAllData=true)
public class TestCPQ01 {
    @isTest static void testCPQOrder(){
        Test.setMock(WebServiceMock.class, new TestMockCPQ01());
        quatation__c qua = [select id from quatation__c limit 1][0];
        if(qua!=null){
            SOSPToCPQCreateOrderClass.setStandardPrice(qua.id);
        }
        
    }
}