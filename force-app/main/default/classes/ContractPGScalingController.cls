public class ContractPGScalingController{

    public ContractPGScalingController(ApexPages.StandardSetController controller) {
       List<ContractPGScaling__c> PList = (List<ContractPGScaling__c>) controller.getSelected();
       PList.sort();
    }

}