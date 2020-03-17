@isTest
public class TestEndPointInfo {
	@isTest static void testMethod1(){
        Test.startTest();
        EndPointInfo ep = new  EndPointInfo();
        ep.getEndpointUrl('ContractNOToSAP ');
        Test.stopTest();
    }

}