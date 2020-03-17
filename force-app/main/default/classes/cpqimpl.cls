public class cpqimpl {
    //合同评审
    public static void getSupplyInfo(String tbid,String businessNo,String quotationNo, String reviewNumber,String type){
      RestClient.getSupplyInfo(tbid, businessNo, quotationNo, reviewNumber, type);
    }
    
    public static void getSubmitinfo(String tbid,String businessNo,String quotationNo, String reviewNumber,String type){
		RestClient.getSubmitinfo(tbid, businessNo, quotationNo, reviewNumber, type);
    }

 	public static void getToken(){
      RestClient.getToken();
    }
        
    public static void getTokeninfo(){
      RestClient.getTokeninfo();
    }
    
    
    //WebContractToCPQ
    public static void getSchedulinginfo(String tbid, String businessNo, String quotationNo, String reviewNumber,String contract, String type){
      WebContractToCPQ.getSchedulinginfo(tbid, businessNo, quotationNo, reviewNumber, contract, type);
    }
    
    
    public static void getSubmitinfo(String tbid, String reviewNumber,String contract, String type){
      WebContractToCPQ.getSubmitinfo(tbid, reviewNumber, contract, type);
    }
    public static void getContractTokeninfo(){
      WebContractToCPQ.getTokeninfo();
    }
    
    
    //WebContractChangeToCPQ
    public static void getContractChangeinfo(String tbid,String contract,String changenum,String type,String contractName,String BusinessChanceNumber,String BusinessChanceName,String controlMode,String caName,String designName){
      WebContractChangeToCPQ.getContractChangeinfo(tbid,contract,changenum,type,contractName,BusinessChanceNumber,BusinessChanceName,controlMode,caName,designName);
    }
    
    public static void getContractChangeTokeninfo(){
      WebContractChangeToCPQ.getTokeninfo();
    }
}