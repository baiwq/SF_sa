global class DealContractChange{
    
    global class Response{
        webservice String flag;
        webservice String message;
    }

    global class ContractChangeVo{
        webservice String  ContractChangeId;
        webservice String  InitiationChangeSupply;
        webservice String  AlterationBasis;
        webservice String  BOMChangeReasons;
        webservice String  BOMChangeFile;
   		webservice String  BOMchangeName;
    }

       
     //查询费用详细信息
    webservice static Response getContractChangeInfo(ContractChangeVo ContractChange){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(ContractChange.ContractChangeId != ''){
                String bomurl = '';
                String ContractChangeId = ContractChange.ContractChangeId ;
                List<contractchange__c> ContractChange_list = [ select id,InitiationChangeSupply__c,AlterationBasis__c,BOMChangeReasons__c,BOMChangeFile__c from contractchange__c where name =:ContractChange.ContractChangeId ]; 
                if(ContractChange_list.size() > 0){
                    if(ContractChange.InitiationChangeSupply != null){
                        ContractChange_list.get(0).InitiationChangeSupply__c = ContractChange.InitiationChangeSupply;
                    }
                    if(ContractChange.AlterationBasis != null){
                        ContractChange_list.get(0).AlterationBasis__c = ContractChange.AlterationBasis;
                    }
                    if(ContractChange.BOMChangeReasons != null){
                        ContractChange_list.get(0).BOMChangeReasons__c = ContractChange.BOMChangeReasons;
                    }
                    if(ContractChange.BOMChangeFile != null &&  ContractChange.BOMChangeFile!= ''){
                        ContractChange_list.get(0).BOMChangeFile__c = ContractChange.BOMChangeFile;
                        System.debug(ContractChange.BOMChangeFile);
                        String ContractChangetest = ContractChange.BOMChangeFile.substring(ContractChange.BOMChangeFile.lastIndexOf('\\')+1, ContractChange.BOMChangeFile.length());
                        System.debug(ContractChangetest);
                        bomurl = ContractChangetest;
                        ContractChange_list.get(0).BOMchangeName__c = bomurl;
                    }
               
                    update ContractChange_list.get(0);
                    
                    if(ContractChange.BOMChangeFile != null &&  ContractChange.BOMChangeFile!= ''){
                        List<attachment__c> listac = [select IsLastVersion__c,isValid__c,contractchange__c,typeCode__c,attachmentURL__c from attachment__c where contractchange__c=:ContractChange_list.get(0).id and type__c = '供货范围变更依据' and isValid__c ='有效' ]; 
                        for(attachment__c ac:listac){
                            ac.isValid__c = '无效';
                            ac.IsLastVersion__c = false;
                        }
                        update listac;
                        attachment__c attachment = new attachment__c();
                        attachment.attachmentURL__c =  ContractChange.BOMChangeFile;
                        attachment.contractchange__c = ContractChange_list.get(0).id;
                        attachment.type__c = '供货范围变更依据';
                        attachment.isValid__c ='有效';
                        attachment.IsLastVersion__c = true;
                        attachment.AttachmentCome__c = '合同变更';
                        attachment.documentName__c = bomurl;
                        attachment.OwnerId = '00528000005ATSv';
                        attachment.rbase__c = 'CPQ获取';
                        insert attachment;

                    }
                        //转化为JSON字符串  
                    	findv = 'true';  
                    
                }
                       
                   
                
            }

            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '更新ContractChange成功', '正常');
            }else{
                resp.flag='N';
                resp.message=ContractChange.ContractChangeId+'查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理',ContractChange.ContractChangeId+'ContractChange查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','更新ContractChange接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
}