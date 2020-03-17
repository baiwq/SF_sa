@isTest
public class TestAdjustmentProportionsController {
   
  @isTest(SeeAllData=true) static void CreateBaseData(){
    
    
          
      ContractReviewPGScaling__c abc = new ContractReviewPGScaling__c(PerformanceAmount__c = 100, Allocation__c = 90, contractreview__c = 'a0P28000003ErgO', ProductGroup__c = '输变电业务单元-电网保护自动化事业部');
      insert abc;
      abc.Allocation__c = 100;
      update abc;
      
      
     //创建合同比例
      ContractPGScaling__c a = new ContractPGScaling__c(NewAllocation__c = 100, PerformanceAmount__c = 100, Allocation__c = 90, Contract__c = 'a052800000C5Oy0', ProductGroup__c = '输变电业务单元-电网保护自动化事业部');
      insert a;
      a.Allocation__c = 100;
      update a;
      
       //创建变更比例
      ContractChangePGScaling__c ab = new ContractChangePGScaling__c(Allocation__c = 90, PerformanceAmount__c = 100, ContractChange__c = 'a0O0I00000gnYvQ', ProductGroup__c = '输变电业务单元-电网保护自动化事业部', isChange__c = '是');
      insert ab;
      ab.Allocation__c = 100;
      update ab;
      

      
      
  } 


}