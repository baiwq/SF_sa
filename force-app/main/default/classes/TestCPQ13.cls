@isTest(seeAllData=true)
public class TestCPQ13 {
    @isTest static void testCPQ13Status(){
        Test.setMock(WebServiceMock.class, new TestMockCPQ013());
        String businessNodes='01';
        String contractNumber='SC20010110';
        String contractNumber2='CC-003320';
        String employeeNo='任艳新';
        String materialName='HT-00004484';
        String orderNumber='DD2017002830';
        String orderStauts='审批通过';
        String projectCode='';
        SOSPToCPQStageStatusClass.sendStageStatus(businessNodes, contractNumber, contractNumber2, employeeNo, materialName, orderNumber, orderStauts, projectCode);
    	SOSPToCPQStageStatusPublicClass.sendStageStatus(businessNodes, contractNumber, contractNumber2, employeeNo, materialName, orderNumber, orderStauts, projectCode);
    }
}