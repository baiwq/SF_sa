@isTest
public class TestGetContractInfoSOAP {
    @isTest(SeeAllData=true)  static   void TestGetContractInfo(){        
  
        
      DateTime startDtime = datetime.valueOf('2016-01-01 00:00:00');
      DateTime endDtime = System.now();
        
      GetContractInfoSOAP.contractList slist= GetContractInfoSOAP.queryContract(startDtime,endDtime);

    }
}