@isTest
public class testCPQimpl {
   

   //成功的合同评审webtoCPQ接口测试
  @isTest(SeeAllData=true) static void SuccessWebContractreviewCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
     	cpqimpl.getToken();
      	cpqimpl.getTokeninfo();
      	cpqimpl.getSupplyInfo('a0P28000005kkz0', '', '', '', '3');
        //cpqimpl.getSupplyInfo('a0P0w000000ZKBY', '', '', '', '3');
        system.test.stopTest();
    }
   
    
    @isTest(SeeAllData=true) static void FailWebContractreviewCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetFailToken()); 
     	cpqimpl.getToken();
      	cpqimpl.getTokeninfo();
      	cpqimpl.getSupplyInfo('a0P28000005kkz0', '', '', '', '3');
        //cpqimpl.getSupplyInfo('a0P0w000000ZKBY', '', '', '', '3');
        system.test.stopTest();
    }
    
     //成功的合同评审webtoCPQ接口测试
  @isTest(SeeAllData=true) static void SuccessWebContractreviewCPQ1(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
     	cpqimpl.getToken();
      	cpqimpl.getTokeninfo();
      	cpqimpl.getSubmitinfo('a0P28000005kkz0','', '', '', '3');
        //cpqimpl.getSubmitinfo('a0P0w000000ZKBY', '', '', '', '3');
        system.test.stopTest();
    }
    
       //成功的合同评审webtoCPQ接口测试
  @isTest(SeeAllData=true) static void FailWebContractreviewCPQ1(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetFailToken()); 
     	cpqimpl.getToken();
      	cpqimpl.getTokeninfo();
      	cpqimpl.getSubmitinfo('a0P28000005kkz0','', '', '', '3');
       // cpqimpl.getSubmitinfo('a0P0w000000ZKBY', '', '', '', '3');
        system.test.stopTest();
    }

     //成功的合同webtoCPQ接口测试
  @isTest(SeeAllData=true) static void SuccessWebContractCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
      	cpqimpl.getContractTokeninfo();
        cpqimpl.getSchedulinginfo('a050I000012cPAc', '', '', '', '', '3');
      	//cpqimpl.getSchedulinginfo('a050w000001MKgC', '', '', '', '', '3');
        system.test.stopTest();
    }
    
    
        //成功的合同webtoCPQ接口测试
  @isTest(SeeAllData=true) static void FailWebContractCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetFailToken()); 
      	cpqimpl.getContractTokeninfo();
        cpqimpl.getSchedulinginfo('a050I000012cPAc', '', '', '', '', '3');
      	//cpqimpl.getSchedulinginfo('a050w000001MKgC', '', '', '', '', '3');
        system.test.stopTest();
    }
    
    
        //成功的合同webtoCPQ接口测试
  @isTest(SeeAllData=true) static void SuccessWebContractCPQ1(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
      	cpqimpl.getContractTokeninfo();
      	cpqimpl.getSubmitinfo('a050I000012cPAc', '', '', '3');
      	//cpqimpl.getSubmitinfo('a050w000001MKgC', '', '', '3');
        system.test.stopTest();
    }
    
    
      //成功的合同webtoCPQ接口测试
  @isTest(SeeAllData=true) static void FailWebContractCPQ1(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetFailToken()); 
      	cpqimpl.getContractTokeninfo();
      	cpqimpl.getSubmitinfo('a050I000012cPAc', '', '', '3');
      	//cpqimpl.getSubmitinfo('a050w000001MKgC', '', '', '3');
        system.test.stopTest();
    }
    
       //成功的合同webtoChangeCPQ接口测试
  	@isTest(SeeAllData=true) static void SuccessWebContractChangeCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
      	cpqimpl.getContractChangeTokeninfo();
        cpqimpl.getContractChangeinfo('a0O28000003nnZH', '', '', '3','','','','','','');
      	//cpqimpl.getContractChangeinfo('a0O0w000000HD8h', '', '', '3');
        system.test.stopTest();
    }
 
    
        //成功的合同webtoChangeCPQ接口测试
  	@isTest(SeeAllData=true) static void FailWebContractChangeCPQ(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetFailToken()); 
      	cpqimpl.getContractChangeTokeninfo();
        cpqimpl.getContractChangeinfo('a0O28000003nnZH', '', '', '3','','','','','','');
      	//cpqimpl.getContractChangeinfo('a0O0w000000HD8h', '', '', '3');
        system.test.stopTest();
    }
 
}