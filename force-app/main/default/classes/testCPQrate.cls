@isTest
public class testCPQrate {

     
 	@isTest(SeeAllData=true) static void testWebCPQGetCurRate(){
        system.test.startTest();
         
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
     	WebCPQGetCurRate.GetCurRateInfo('a0P0I00001KmTjy', 'HT-00029968', '100'); //正式
     	//WebCPQGetCurRate.GetCurRateInfo('a0P0w000000fcKn', 'HT-00024525', '100');  //测试
        system.test.stopTest();
    }
    
    
    @isTest(SeeAllData=true) static void testCPQGetCurRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        CPQGetCurRate CPQGetCurRate  = new CPQGetCurRate();
		CPQGetCurRate.GetCurRateInfo('a0P0I00001KmTjy', 'HT-00029968', '100');  //正式
        //CPQGetCurRate.GetCurRateInfo('a0P0w000000fcKn', 'HT-00024525', '100');//测试
        system.test.stopTest();
    }

    
    @isTest(SeeAllData=true) static void testContractCPQGetCurRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractCPQGetCurRate ContractCPQGetCurRate  = new ContractCPQGetCurRate();
        //ContractCPQGetCurRate.GetCurRateInfo('a050w000001gfCk', 'SC20133898', '100');//测试
        ContractCPQGetCurRate.GetCurRateInfo('a050I000015q8Sy', 'SC20142313', '100');
        system.test.stopTest();
    }
    
    @isTest(SeeAllData=true) static void testContractWebCPQGetCurRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        //ContractWebCPQGetCurRate.GetCurRateInfo('a050w000001gfCk', 'SC20133898', '100'); //测试     
        ContractWebCPQGetCurRate.GetCurRateInfo('a050I000015q8Sy', 'SC20142313', '100');
        system.test.stopTest();
    }
    
    
    
    @isTest(SeeAllData=true) static void testContractChangeCPQGetCurRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
        ContractChangeCPQGetCurRate ContractChangeCPQGetCurRate  = new ContractChangeCPQGetCurRate();
        //ContractChangeCPQGetCurRate.GetCurRateInfo('a0O0w000000PMEf', 'CC-026975', '100');//测试
        ContractChangeCPQGetCurRate.GetCurRateInfo('a0O0I00000q2qoC', 'CC-034363', '100');
        
        system.test.stopTest();
    }
    
    @isTest(SeeAllData=true) static void testContractchangeWebCPQGetCurRate(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
       // ContractchangeWebCPQGetCurRate.GetCurRateInfo('a0O0w000000PMEf', 'CC-026975', '100'); //测试
        ContractchangeWebCPQGetCurRate.GetCurRateInfo('a0O0I00000q2qoC', 'CC-034363', '100');      
        system.test.stopTest();
    }

}