public class ContractCPQ {
   
    //获取合同管理供货范围清单
    @future(callout=true)
    public static void getSchedulinginfo(String id,String opportunity, String quatationName, String reviewNumber,String contract,String type){
        ContractToCPQ Schedulinginfo = new ContractToCPQ();
        Schedulinginfo.getSchedulinginfo(id, opportunity, quatationName, reviewNumber,contract,type);
    }
    
    
    //审批合同管理供货范围清单
    @future(callout=true)
    public static void getApproval(String id,String reviewNumber, String tempContract, String contract,String reviewStatus,String type,String ContractAmount ){
        ContractToCPQ Approvalinfo = new ContractToCPQ();
        Approvalinfo.getApprovalinfo(id, reviewNumber, tempContract, contract,reviewStatus,type,ContractAmount );
    }
    
    //获取合同阶段毛利率
    @future(callout=true)
    public static void getRate(String id,String contract,String contractAmount){
        ContractCPQGetCurRate Rateinfo = new ContractCPQGetCurRate();
        Rateinfo.GetCurRateInfo(id, contract, contractAmount);
    }
    
}