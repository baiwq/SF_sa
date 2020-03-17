@isTest
public class TestCostProcessingSchedule {

  public static testMethod void testCostProcessingSchedule(){
    List<CostProcessingScheduleList.CostProcessingSchedule> testlist = new List<CostProcessingScheduleList.CostProcessingSchedule>();
    CostProcessingScheduleList.CostProcessingSchedule vo = new CostProcessingScheduleList.CostProcessingSchedule();
    vo.bt_no = '123';
    vo.name = 'F-00000000001';
    vo.invoice_amount =123.00;
    vo.status ='10';
    testlist.add(vo);
      
    //CostProcessingScheduleList test124124 =new CostProcessingScheduleList();
   
    CostProcessingScheduleList.UpdateCostProcessingScheduleList(testlist);
 }
    
}