public class OppLightningBar {
    public List<String> StageNames{get;set;}  //定义 全部StageNames
    public String CurrentStage{get;set;}      //定义 当前StageName
    public OppLightningBar(ApexPages.StandardController controller) {
    
      ID RecordId = ApexPages.currentPage().getParameters().get('id');
      Schema.DescribeFieldResult ordersStatus = Opportunity.StageName.getDescribe();
      List<Schema.PicklistEntry> ordersStatusValues = ordersStatus.getPicklistValues();
      CurrentStage = [Select toLabel(StageName) from Opportunity where id=:RecordId].StageName.trim();
      System.Debug('ordersStatus:' + ordersStatus);
      System.Debug('ordersStatusValues:' + ordersStatus);
      System.Debug('CurrentStage:' + CurrentStage);
      StageNames = new List<String>();
      for(Schema.PicklistEntry sp:ordersStatusValues){
          StageNames.add(sp.getLabel());
      }
    }

}