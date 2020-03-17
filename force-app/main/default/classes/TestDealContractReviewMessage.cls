@isTest(SeeAllData=true)
public class TestDealContractReviewMessage {
	   
  	public  static testMethod void ContractCPQ(){
	 
        DealContractReview.ContractReviewVo ContractReview = new  DealContractReview.ContractReviewVo();
        //ContractReview.ContractReviewID ='a0P0w000000ZKBY';
        ContractReview.ContractReviewID ='a0P0I0000102D7x';
        ContractReview.technologyReviewContent ='1234';
        ContractReview.TechnologyRiskWork ='1243';
        ContractReview.technologyReviewExpert ='0050w000000lTZ8';
        ContractReview.technologyFinalReviewSuggestion ='通过';
        ContractReview.technologyReviewSuggestion ='';
        ContractReview.ScopeOfSupplyChanged ='';
        ContractReview.file_Path ='124124';
        DealContractReview.getContractFeeInfo(ContractReview);
    }


}