global class DealContractReview{
    
    global class Response{
        webservice String flag;
        webservice String message;
    }

    global class ContractReviewVo{
        webservice String ContractReviewID;
        webservice String technologyReviewContent;
        webservice String TechnologyRiskWork;
        webservice String technologyReviewExpert;
        webservice String technologyFinalReviewSuggestion;
        webservice String technologyReviewSuggestion;
        webservice String ScopeOfSupplyChanged;
        webservice String file_Path;

    }

       
     //查询费用详细信息
    webservice static Response getContractFeeInfo(ContractReviewVo ContractReview){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(ContractReview.ContractReviewID != ''){
                String ContractReviewID = ContractReview.ContractReviewID ;
                String file_Path = ContractReview.file_Path ;
                String ContractReviewName = '';
               // String query = 'select  technologyReviewContent__c,TechnologyRiskWork__c,technologyReviewExpert__c,technologyFinalReviewSuggestion__c,technologyReviewSuggestion__c,ScopeOfSupplyChanged__c from contractreview__c where id =:ContractReviewID ';
                List<contractreview__c> Contractreview_list = [ select  name,technologyReviewContent__c,TechnologyRiskWork__c,technologyReviewExpert__c,technologyFinalReviewSuggestion__c,technologyReviewSuggestion__c,ScopeOfSupplyChanged__c,OwnerId from contractreview__c where id =:ContractReviewID ]; 
                if(Contractreview_list.size() > 0){
                    ContractReviewName = Contractreview_list.get(0).name;
                    Contractreview_list.get(0).technologyReviewContent__c = ContractReview.technologyReviewContent;
                    Contractreview_list.get(0).TechnologyRiskWork__c = ContractReview.TechnologyRiskWork;
                    Contractreview_list.get(0).technologyReviewExpert__c = ContractReview.technologyReviewExpert;
                    Contractreview_list.get(0).technologyFinalReviewSuggestion__c = ContractReview.technologyFinalReviewSuggestion;
                    Contractreview_list.get(0).technologyReviewSuggestion__c = ContractReview.technologyReviewSuggestion;
                    Contractreview_list.get(0).ScopeOfSupplyChanged__c = ContractReview.ScopeOfSupplyChanged;

                    update Contractreview_list;

                     //转化为JSON字符串  
                    findv = 'true';  
                    
                    List<attachment__c> listac = [select OwnerId,contractreview__c,typeCode__c,attachmentURL__c from attachment__c where contractReview__c =:ContractReviewID and typeCode__c='1'  and isValid__c ='有效']; 
                    for(attachment__c ac:listac){
                        ac.isValid__c = '无效';
                        ac.IsLastVersion__c = false;
                    }
                    update listac;
                    if(file_Path!= null){
                        attachment__c attachment = new attachment__c();
                        attachment.attachmentURL__c = file_Path;
                        attachment.contractReview__c = ContractReviewID;
                        attachment.type__c = '供货范围清单';
                        attachment.isValid__c ='有效';
                        attachment.IsLastVersion__c = true;
                        attachment.documentName__c = ContractReviewName+'供货范围清单.xlsx';
                        attachment.OwnerId = Contractreview_list.get(0).OwnerId;
                        insert attachment; 
                    }
                }
                       
                       
                
            }

            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '更新ContractReview成功', '正常');
            }else{
                resp.flag='N';
                resp.message=ContractReview.ContractReviewID+'查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理',ContractReview.ContractReviewID+'ContractReview查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','更新ContractReview接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
}