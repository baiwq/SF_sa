public class TBbaozhengjinLightningBar {
   public List<String> StageNames{get;set;}
   public String CurrentStage{get;set;}
   public tbbaozhengjinLightningBar(ApexPages.StandardController controller) {
      ID RecordId = ApexPages.currentPage().getParameters().get('id');
      Schema.DescribeFieldResult ordersStatus = tbbaozhengjin__c.approvalStatus__c.getDescribe();
      List<Schema.PicklistEntry> ordersStatusValues = ordersStatus.getPicklistValues();
      CurrentStage = [Select toLabel(approvalStatus__c) from tbbaozhengjin__c where id=:RecordId].approvalStatus__c.trim();
      StageNames = new List<String>();
      for(Schema.PicklistEntry sp:ordersStatusValues){
         StageNames.add(sp.getLabel());
      }
   }
}