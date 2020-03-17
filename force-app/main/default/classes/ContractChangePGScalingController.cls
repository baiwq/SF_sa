public class ContractChangePGScalingController {

    public ContractChangePGScalingController(ApexPages.StandardSetController controller) {
       List<ContractChangePGScaling__c> PList = (List<ContractChangePGScaling__c>) controller.getSelected();
       PList.sort();
    }

}