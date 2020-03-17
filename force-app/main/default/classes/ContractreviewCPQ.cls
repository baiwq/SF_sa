public class ContractreviewCPQ {

    @future(callout=true)
    public static void getApproval(String id,String opportunityName, String quatationName, String reviewNumber,String reviewStatus,String type,String contractAmount){
        SubmitCPQ Approvalinfo = new SubmitCPQ();
        Approvalinfo.getApprovalinfo(id, opportunityName, quatationName, reviewNumber,reviewStatus,type,contractAmount);
    }
    
    @future(callout=true)
    public static void getRate(String id,String reviewNumber,String contractAmount){
        CPQGetCurRate Rateinfo = new CPQGetCurRate();
        Rateinfo.GetCurRateInfo(id, reviewNumber, contractAmount);
    }
}