public class BillandReceiptLightningBar {
   public List<String> StageNames{get;set;}//声明一个String类型的List对象 StageName
   public String CurrentStage{get;set;} //声明一个String类型的 对象 CurrentStage
   public BillandreceiptLightningBar(ApexPages.StandardController controller) { //构造方法 参数为一个页面的标准控制器
      ID RecordId = ApexPages.currentPage().getParameters().get('id');//取当前页面记录的id赋给 RecordId
      Schema.DescribeFieldResult ordersStatus = invoice__c.approvalStatus__c.getDescribe();//将审批状态字段值赋给orderStatus
      List<Schema.PicklistEntry> ordersStatusValues = ordersStatus.getPicklistValues();//把ordersStatus取的值 放在List中
      CurrentStage = [Select toLabel(approvalStatus__c) from invoice__c where id=:RecordId].approvalStatus__c.trim();//通过id查询当前记录的审批状态 将值赋给CurrentStage
      StageNames = new List<String>();
      for(Schema.PicklistEntry sp:ordersStatusValues){
         StageNames.add(sp.getLabel());
      }
   }
}