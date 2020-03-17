public class ContractChangeCPQ {

    //获取合同管理供货范围清单
    @future(callout=true)
    public static void getContractChange(String id,String contract,String changenum,String type){
        ContractChangeToCPQ ContractChange = new ContractChangeToCPQ();
        ContractChange.getContractChangeInfo(id, contract, changenum, type);
    }
    
    //提交合同管理供货范围清单
    @future(callout=true)
    public static void getSubmitinfo(String id,String contract,String changenum,String type){
        ContractChangeToCPQ ContractChange = new ContractChangeToCPQ();
        ContractChange.getSubmitinfo(id, contract, changenum,type);
    }
    

    //审批合同管理供货范围清单
    @future(callout=true)
    public static void getApproval(String id,String contract,String changenum,String changestatus,String type,String contractAmount){
        ContractChangeToCPQ Approvalinfo = new ContractChangeToCPQ();
        Approvalinfo.getApprovalinfo(id, contract, changenum, changestatus,type,contractAmount);
    }
    
    
    //获取合同变更阶段毛利率
    @future(callout=true)
    public static void getRate(String id,String changenum,String contractAmount){
        ContractChangeCPQGetCurRate Rateinfo = new ContractChangeCPQGetCurRate();
        Rateinfo.GetCurRateInfo(id, changenum, contractAmount);
    }
}