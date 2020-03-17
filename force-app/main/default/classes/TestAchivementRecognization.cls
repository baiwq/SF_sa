@isTest
public class TestAchivementRecognization {
   //成功的合同CPQ接口测试
  @isTest(SeeAllData=true) static void SuccessContractCPQ(){
      AchivementRecognization__c ar = [Select id, comments__c from AchivementRecognization__c limit 1];
      ar.comments__c = '备注';
      update ar;
    }
    
   
   
     
 
}