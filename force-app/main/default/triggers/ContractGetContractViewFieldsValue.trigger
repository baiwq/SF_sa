/*
    功能：选择合同评审，将合同评审的9个字段带过来(接口用)
    创建人：霍东飞
    创建日期：2017-09-28
    
    修改人：任艳新
    修改日期：2018-09-17
    功能：创建时带出合同评审上的外购成本、财务成本
*/
trigger ContractGetContractViewFieldsValue on Contract__c (before insert) {
	if(trigger.new.size() > 100){
        System.Debug('Account Batch DMLs, ignore...');
    }else{
	    for(Contract__c c:Trigger.new){      
	        try{
	        if(c.reviewNumber__c != null){
		        contractreview__c cv = [select id, OutsourcingCostS__c, FinanceCost__c,technologyReviewContent__c,technologyReviewSuggestion__c,technologyReviewExpertName__c,technologyFinalReviewSuggestion__c,
		        outsourcingReviewContent__c,outsourcingReviewSuggestion__c,outsourcingReviewExpertName__c,outsourcingFinalReviewSuggestion__c,projectClassification__c from contractreview__c where id =:c.reviewNumber__c];
		        
		        //外购成本
		        if(cv.OutsourcingCostS__c!=null){
		            c.OutsourcingCost__c=cv.OutsourcingCostS__c;
		        }
		        //财务成本
		        if(cv.FinanceCost__c!=null){
		            c.FinanceCost__c = cv.FinanceCost__c;  
		        }
		         
		        if(cv.technologyReviewContent__c!= null){
		            c.technologyReviewContent__c = cv.technologyReviewContent__c;
		        }
		        
		        if(cv.technologyReviewSuggestion__c!= null){
		            c.technologyReviewSuggestion__c = cv.technologyReviewSuggestion__c;
		        }
		        if(cv.technologyReviewExpertName__c != null){
		            c.technologyReviewExpert__c = cv.technologyReviewExpertName__c;
		        }
		        if(cv.technologyFinalReviewSuggestion__c!= null){
		            c.technologyFinalReviewSuggestion__c = cv.technologyFinalReviewSuggestion__c;
		        }
		        if(cv.outsourcingReviewContent__c!= null){
		            c.outsourcingReviewContent__c = cv.outsourcingReviewContent__c;
		        }
		        if(cv.outsourcingReviewSuggestion__c!= null){
		            c.outsourcingReviewSuggestion__c = cv.outsourcingReviewSuggestion__c;
		        }
		        if(cv.outsourcingReviewExpertName__c!= null){
		            c.outsourcingReviewExpert__c = cv.outsourcingReviewExpertName__c;
		        }
		        if(cv.outsourcingFinalReviewSuggestion__c!= null){
		            c.outsourcingFinalReviewSuggestion__c = cv.outsourcingFinalReviewSuggestion__c;
		        }
		        if(cv.projectClassification__c != null){
		            c.projectClassification__c  = cv.projectClassification__c ;
		        }
	        }
	        }catch(exception e){
	            System.debug('未知错误，请联系管理员');
	        }
	        
	    }
	}
}