public class relationshipLightningBar {
   public List<String> StageNames{get;set;}
   public String CurrentStage{get;set;}
   public relationshipLightningBar(ApexPages.StandardController controller) {
      ID RecordId = ApexPages.currentPage().getParameters().get('id');
      Schema.DescribeFieldResult ordersStatus = relationshipPlan__c.approvalStatus__c.getDescribe();
      List<Schema.PicklistEntry> ordersStatusValues = ordersStatus.getPicklistValues();
      CurrentStage = [Select toLabel(approvalStatus__c) from relationshipPlan__c where id=:RecordId].approvalStatus__c.trim();
      StageNames = new List<String>();
      for(Schema.PicklistEntry sp:ordersStatusValues){
         StageNames.add(sp.getLabel());
      }
   }
}