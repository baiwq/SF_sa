@isTest
public class TestGetCPQ {
   
   //成功的合同CPQ接口测试
  @isTest(SeeAllData=true) static void SuccessContractCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractCPQ.getSchedulinginfo('a050I000012cPAc', '', '', '', '', '');
        ContractCPQ.getApproval('a050I000012cPAc', '', '', '', '3', '','100');
      	ContractCPQ.getRate('a050I000012cPAc', 'SC20133847', '123');
      
      	ContractToCPQ ContractToCPQ = new ContractToCPQ();
        ContractToCPQ.getApproval('a050I000012cPAc', '', '', '', '3', '','100');
        ContractToCPQ.getScheduling('a050I000012cPAc', '', '', '', '', '');
        system.test.stopTest();
    }
    
   
       //成功的合同CPQ接口测试
    @isTest(SeeAllData=true) static void SuccessContractreviewCPQRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractreviewCPQ.getRate('a0P28000005kkz0', 'HT-00000002', '100');
        system.test.stopTest();
    }
    
    //成功的合同评审CPQ接口测试
    @isTest(SeeAllData=true) static void SuccessContractreviewCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractreviewCPQ.getApproval('a0P28000005kkz0', '', '', '', '3', '','100');
        ContractreviewCPQ.getRate('a0P28000005kkz0', 'HT-00000002', '123');
        SubmitCPQ SubmitCPQ = new SubmitCPQ();
        SubmitCPQ.getApproval('a0P28000005kkz0', '', '', '', '3', '','100');
        system.test.stopTest();
    }
    
      //成功的合同评审CPQ接口测试 
    @isTest(SeeAllData=true) static void FailContractreviewCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractreviewCPQ.getApproval('a0P28000005kkz0', '', '', '', '3', '','100');
        system.test.stopTest();
    }
    
     @isTest(SeeAllData=true) static void SuccessContractChangeCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractChangeCPQ.getSubmitinfo('a0O28000003nnZH','' , '', '');
        ContractChangeCPQ.getContractChange('a0O28000003nnZH', '', '', '');
        ContractChangeCPQ.getApproval('a0O28000003nnZH', '', '', '3', '','100');
        ContractChangeCPQ.getRate('a0O28000003nnZH', 'CC-000002', '123');
         
         
        ContractChangeToCPQ ContractChangeToCPQ = new ContractChangeToCPQ();
        ContractChangeToCPQ.getApproval('a0O28000003nnZH', '', '', '3', '','100');
        ContractChangeToCPQ.getSubmitinfo('a0O28000003nnZH','' , '', '');
        ContractChangeToCPQ.getSubmit('a0O28000003nnZH','' , '', '');
        system.test.stopTest();
    }

     
 
}