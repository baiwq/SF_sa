public class MassPaymentController{

    public MassPaymentController(ApexPages.StandardSetController controller) {
       List<paymentTerm__c> PList = (List<paymentTerm__c>) controller.getSelected();
       PList.sort();
    }

}