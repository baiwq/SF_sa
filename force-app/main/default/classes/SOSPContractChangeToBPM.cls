global class SOSPContractChangeToBPM {
     
    public class performance{ //
        public String Contract;
        public String ProductGroup;
        public String Allocation;
        public String PerformanceAmount;
        public String contractAmountRMB;
    }
    
    @future(callout=true)   
    webService static void change(ID changeId){
        List<log__c> logList = new List<log__c>();       
        try{
            contractchange__c cc = [select contract__c,oldContractNumber__c,contractName__c,salesTeamCenter__c,salesTeamCenterCode__c,contractAmountAfterChange__c,
            contractAmount__c,Name,subCompany__c,subCompanyCode__c,signTeamDepartment__c,signTeamProvince__c,accountManager__c,accountManagerCode__c,
            signDate__c,recordType__c,scopeOfSupplyChangeIsExcited__c,mergerOfContractIsExcited__c,changeContent__c,ownerId,
            contractNameChanged__c,secondChanged__c,accountChanged__c,isfinalUserGroup__c,finalUserGroup__c,OwnerName__c,OwnerCode__c  from contractchange__c where id =:changeId];
            String contractName = [select name from contract__c where id =:cc.contract__c].name;            
            getApproveJson getj = new getApproveJson();
            String approvalJson = getj.getApproveString(changeId);            
                
            ContractChangeInterface.StartContractVariationSOAP ws = new ContractChangeInterface.StartContractVariationSOAP();              
            ContractChangeInterface.inputDataType inputDataType1 = new ContractChangeInterface.inputDataType();  
            List<ContractChangeInterface.attachmentType> attList = new List<ContractChangeInterface.attachmentType>();           
            
            ContractChangeInterface.outPutDataType cresponse = new ContractChangeInterface.outPutDataType();
            
                       
            List<attachment__c> aList = [select id,documentName__c,attachmentURL__c from attachment__c where contractChange__c =:changeId];
            if(aList.size()<1){               
                ContractChangeInterface.attachmentType a1 = new ContractChangeInterface.attachmentType();
                a1.FILE_NAME = null;
                a1.FILE_PATH = null;
                attList.add(a1);
            }else{
                for(attachment__c at:aList){
                    ContractChangeInterface.attachmentType a2 = new ContractChangeInterface.attachmentType();
                    a2.FILE_NAME = at.documentName__c;
                    a2.FILE_PATH = at.attachmentURL__c;
                    attList.add(a2);
                }
                
            }
            
            List<ContractChangePGScaling__c> perList = [select Allocation__c,PerformanceAmount__c,Contract__c,contractAmountRMB__c,ProductGroup__c,ContractName__c from ContractChangePGScaling__c where ContractChange__c =:changeId];

            List<performance> performanceList = new List<performance>(); 
            for(ContractChangePGScaling__c per:perList){
                performance performanceVo = new performance();
                performanceVo.Contract = per.ContractName__c+'';
                performanceVo.ProductGroup = per.ProductGroup__c+'';
                performanceVo.Allocation = per.Allocation__c+'';
                performanceVo.PerformanceAmount = per.PerformanceAmount__c+'';
                performanceVo.contractAmountRMB = per.contractAmountRMB__c+'';
                performanceList.add(performanceVo);
            }
            //参数赋值
            inputDataType1.performanceDesc =  JSON.serialize(performanceList);
              
            inputDataType1.attachment = attList;
            inputDataType1.sospContractNO = contractName;
            inputDataType1.contractNO = cc.oldContractNumber__c;              
            inputDataType1.contractName = cc.contractName__c;
            inputDataType1.salesTeamCenter = cc.salesTeamCenter__c;
            inputDataType1.salesTeamCenterCode = cc.salesTeamCenterCode__c;
            if(cc.recordType__c=='合同金额变更'){
                inputDataType1.amount = String.valueof(cc.contractAmountAfterChange__c);
            }else{
                inputDataType1.amount = String.valueof(cc.contractAmount__c);
            }          
            inputDataType1.variationNo = cc.Name;
            inputDataType1.signCompany = cc.subCompany__c;
            inputDataType1.signCompanyCode = cc.subCompanyCode__c;
            inputDataType1.signDistrict = cc.signTeamDepartment__c;
            inputDataType1.signProvincial = cc.signTeamProvince__c;
            inputDataType1.accountManager = cc.accountManager__c;
            inputDataType1.accountManagerCode = cc.accountManagerCode__c;
            if(cc.signDate__c == null){
                inputDataType1.signDate = null;
            }else{
                inputDataType1.signDate = String.valueof(cc.signDate__c).replace('T',' ').replace('.000Z','');
            }
            //1.26新加三个字段
            if(cc.recordType__c=='合同信息变更'){
                String variationType='';
                if(cc.secondChanged__c=='是'){
                    variationType=variationType+'合同信息变更-乙方变更,';
                }
                if(cc.contractNameChanged__c=='是'){
                    variationType=variationType+'合同信息变更-合同名称变更,';
                }
                if(cc.accountChanged__c=='是'){
                    variationType=variationType+'合同信息变更-客户变更,';
                }
                if(cc.isfinalUserGroup__c=='是'){
                    variationType=variationType+'合同信息变更-最终用户所属集团变更,';
                }
                if(cc.secondChanged__c=='否'&&cc.contractNameChanged__c=='否'&&cc.accountChanged__c=='否'&&cc.isfinalUserGroup__c=='否'){
                    variationType=cc.recordType__c+',';
                }
                inputDataType1.variationType = variationType.substring(0,variationType.length()-1);
            }else{
                inputDataType1.variationType = cc.recordType__c;
            }
            
            system.debug('variationType----'+inputDataType1.variationType);
            inputDataType1.variationTypeCode = null;  //记录类型编码
            inputDataType1.scopeOfSupply = cc.scopeOfSupplyChangeIsExcited__c;
            inputDataType1.contractMerge = cc.mergerOfContractIsExcited__c;             
            inputDataType1.variationContent = cc.changeContent__c;
            inputDataType1.variationHistory = approvalJson; //审批流展示         
            inputDataType1.applicant = cc.OwnerName__c;
            inputDataType1.applicantCode = cc.OwnerCode__c;            
            inputDataType1.source = 'sosp';  //来源系统    
            inputDataType1.AffiliatedGroup = cc.finalUserGroup__c;  //来源系统  
            System.debug('inputDataType1——————>'+ inputDataType1);       
            cresponse = ws.StartContractVariation(inputDataType1);   
            System.debug('cresponse——————>'+cresponse  ) ;
            String ss = cc.Name;
            if(cresponse.isSuccess == '1'){    
                             
                log__c log1 = LogClass.reLog('成功','已处理','【推送合同变更到BPM】推送成功，合同变更编号：'+ ss + cresponse.reason,'正常' );
                logList.add(log1); 
                cc.SynchronousFlag__c  ='成功';                              
                update cc;    
                                
            }else{
                log__c log2 = LogClass.reLog('失败','未处理','【推送合同变更到BPM】推送失败，BPM错误信息，合同变更编号：'+ ss + cresponse.reason,'重要' );
                logList.add(log2);
                cc.SynchronousFlag__c  ='失败';                              
                update cc;    
            }                                  
        }catch(exception e){                      
            log__c log3 = LogClass.reLog('失败','未处理','【推送合同变更到BPM】推送失败，SOSP错误信息，合同变更id：'+ changeId + e.getMessage(),'重要' ); 
            logList.add(log3);  
            contractchange__c updatecc = [select SynchronousFlag__c from contractchange__c where id =:changeId];
            updatecc.SynchronousFlag__c  ='失败';                              
            update updatecc;               
        }
        insert logList;
    }
    
}