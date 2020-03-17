@isTest(seeAllData = true)
public class TestChange{
    @isTest static void Change(){
        Test.setMock(WebServiceMock.class,new TestGetChange());
        ContractChange__c cc = [select id from ContractChange__c limit 1];
        SOSPContractChangeToBPM.change(cc.id);
    }
}