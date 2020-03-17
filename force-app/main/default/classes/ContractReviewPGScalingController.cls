public class ContractReviewPGScalingController{

    public ContractReviewPGScalingController(ApexPages.StandardSetController controller) {
       List<ContractReviewPGScaling__c> PList = (List<ContractReviewPGScaling__c>) controller.getSelected();
       PList.sort();
    }

}