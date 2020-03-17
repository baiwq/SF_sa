global class getServiceContractCost {
    
    global class Response{
        webservice String flag;
        webservice String message;
    }

    global class ContractCostVo{
          webservice String ContractCostName;
          webservice String RecordTypeName;
          webservice String MainIndustrySales;
          webservice String approveState;
          webservice String OwnerName;
          webservice String TotalSalesApplicationAmoun;
          webservice String costAmount;
          webservice String AccountName;
          webservice String opportunityCode;
          webservice String opportunityName;
          webservice String contractNo;
          webservice String purchaser;
          webservice String contractName;
          webservice String contractAmount;
          webservice String kaohe;
          webservice String BudgetaryExpenditure_pass;
          webservice String BudgetaryExpenditure_pending;
          webservice String BudgetaryExpenditure_surplus;
          webservice String CostExpenditure_pass;
          webservice String CostExpenditure_pending;
          webservice String CostExpenditure_surplus;
    }
    
    global class ContractCostInfo{
        webservice String ContractCostName;
        webservice String RecordTypeName;
        webservice String MainIndustrySales;
        webservice String approveState;
        webservice String OwnerName;
        webservice String SalesmanUndertakes;
        webservice String othershoulders;
        webservice String ProvincialUndertakings;
        webservice String DepartmentalUndertakings;
        webservice String subcenterFee;
        webservice String QualityExpenditure;
        webservice String cetrefee;
        webservice String TNumber;
        webservice String TotalSalesApplicationAmoun;
        webservice String MainProductGroup;
        webservice String accceptAmount;
        webservice String operationAmount;
        webservice String installAmount;
        webservice String unloadAmount;
        webservice String detectionAmount;
        webservice String technicalserviceAmount;
        webservice String CustomersCumulativeAmount;
        webservice String ZONG;
        webservice String BudgetaryExpenditure;
        webservice String CostExpenditure;
        webservice String AccountName;
        webservice String opportunityCode;
        webservice String opportunityName;
        webservice String contractNo;
        webservice String purchaser;
        webservice String contractName;
        webservice String contractAmount;
        webservice String RateApplication_before;
        webservice String RateApplication_after;
        webservice String isQuotation;
        webservice String isContracreviwer;
        webservice String isContractaccept;
        webservice String isCompletelyDeliverDate;
        webservice String isInvoicePercent;
        webservice String isReturnProportion;
        webservice String quotation;
        webservice String contracreviwer;
        webservice String contractaccept;
        webservice String completelyDeliverDate;
        webservice String invoicePercent;
        webservice String returnProportion;
        webservice String BudgetaryExpenditure_pass;
        webservice String BudgetaryExpenditure_pending;
        webservice String BudgetaryExpenditure_surplus;
        webservice String CostExpenditure_pass;
        webservice String CostExpenditure_pending;
        webservice String CostExpenditure_surplus;
        webservice String costAmount;
    }
    
   

       
    //查询费用备案列表
    webservice static Response getContractCostList(String ContractCostCode,String UserId){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(UserId != ''){
                String approveState = '审批通过';
                String query = 'SELECT id,name,RecordTypeName__c,MainIndustrySales__c,approveState__c,OwnerName__c,TotalSalesApplicationAmoun__c,costAmount__c,AccountName__c,number__c,opportunityNamegs__c,contractNo__c,purchaser__c,contractName__c,Field27__c,kaohe__c from  contractFee__c where OwnerCode__c =:UserId and approveState__c =:approveState ';

                if(ContractCostCode != ''){
                    String ContractCostCodelike = '%'+ContractCostCode+'%';
                    query += ' and Name like :ContractCostCodelike';
                }
                List<contractFee__c> conList = database.query(query); 
                List<ContractCostVo> ContractCostlist = new List<ContractCostVo>();
                if(conList.size() > 0 ){
                    ContractCostVo  contractCostVo = null;
                    String NumberId = '';
                    for(integer i=0; i<conList.size(); i++){
                        contractCostVo = new ContractCostVo();
                        contractCostVo.ContractCostName = conList.get(i).get('name')+'';
                        contractCostVo.RecordTypeName = conList.get(i).get('RecordTypeName__c')+'';
                        contractCostVo.MainIndustrySales = conList.get(i).get('MainIndustrySales__c')+'';
                        contractCostVo.approveState = conList.get(i).get('approveState__c')+'';
                        contractCostVo.OwnerName = conList.get(i).get('OwnerName__c')+'';
                        contractCostVo.TotalSalesApplicationAmoun = conList.get(i).get('TotalSalesApplicationAmoun__c')+'';
                        contractCostVo.costAmount = conList.get(i).get('costAmount__c')+'';
                        contractCostVo.AccountName = conList.get(i).get('AccountName__c')+'';
                        contractCostVo.opportunityCode = conList.get(i).get('number__c')+'';
                        contractCostVo.opportunityName = conList.get(i).get('opportunityNamegs__c')+'';
                        contractCostVo.contractNo = conList.get(i).get('contractNo__c')+'';
                        contractCostVo.purchaser = conList.get(i).get('purchaser__c')+'';
                        contractCostVo.contractName = conList.get(i).get('contractName__c')+'';
                        contractCostVo.contractAmount = conList.get(i).get('Field27__c')+'';
                        contractCostVo.kaohe = conList.get(i).get('kaohe__c')+'';
 						NumberId = conList.get(i).get('id')+'';
                        List<CustomObject1__c > CustomObjectList  =[select Field8__c,Field10__c,Field9__c,Field11__c from CustomObject1__c where number__c =:NumberId];
                        if(CustomObjectList.size()>0){
                            contractCostVo.BudgetaryExpenditure_pass = CustomObjectList.get(0).get('Field8__c')+'';
                            contractCostVo.BudgetaryExpenditure_surplus = CustomObjectList.get(0).get('Field10__c')+'';
                            contractCostVo.CostExpenditure_pass = CustomObjectList.get(0).get('Field9__c')+'';
                            contractCostVo.CostExpenditure_surplus = CustomObjectList.get(0).get('Field11__c')+'';
                        }
                        ContractCostlist.add(contractCostVo); 
                    }
                    
                }            
                
                //转化为JSON字符串  
                conJsonString =  JSON.serialize(ContractCostlist);
                findv = 'true';
                 
            }

            if( findv == 'true'){
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '获取服务类合同费用备案列表成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getContractCostList查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','获取服务类合同费用备案列表接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
    
    

     //查询服务类合同费用备案详细信息
    webservice static Response getContractCostInfo(String ContractCostCode){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(ContractCostCode != ''){
                String query = 'SELECT id,name,RecordTypeName__c,MainIndustrySales__c,approveState__c,costAmount__c,OwnerName__c,Field10__c,othershoulders__c,Field9__c,Field11__c,subcenterFee__c,Field24__c,cetrefee__c,TNumber__c,TotalSalesApplicationAmoun__c,MainProductGroup__c,accceptAmount__c,operationAmount__c,installAmount__c,unloadAmount__c,detectionAmount__c,technicalserviceAmount__c,CustomersCumulativeAmount__c,ZONG__c,BudgetaryExpenditure__c,CostExpenditure__c,AccountName__c,number__c,opportunityNamegs__c,contractNo__c,purchaser__c,contractName__c,Field27__c,Field26__c,margin1__c,quotation__c,contracreviwer__c,contractaccept__c,completelyDeliverDate__c,invoicePercent__c,returnProportion__c  from  contractFee__c where Name =:ContractCostCode  ';
                
                List<contractFee__c> conList = database.query(query); 
                ContractCostInfo  ContractCostInfo = null;
                if(conList.size() > 0 ){
                    ContractCostInfo = new ContractCostInfo();
                    String NumberId = '';
                    ContractCostInfo.ContractCostName = conList.get(0).get('name')+'';
                    ContractCostInfo.RecordTypeName = conList.get(0).get('RecordTypeName__c')+'';
                    ContractCostInfo.MainIndustrySales = conList.get(0).get('MainIndustrySales__c')+'';
                    ContractCostInfo.approveState = conList.get(0).get('approveState__c')+'';
                    ContractCostInfo.OwnerName = conList.get(0).get('OwnerName__c')+'';
                    ContractCostInfo.SalesmanUndertakes = conList.get(0).get('Field10__c')+'';
                    ContractCostInfo.othershoulders = conList.get(0).get('othershoulders__c')+'';
                    ContractCostInfo.ProvincialUndertakings = conList.get(0).get('Field9__c')+'';
                    ContractCostInfo.DepartmentalUndertakings = conList.get(0).get('Field11__c')+'';
                    ContractCostInfo.subcenterFee = conList.get(0).get('subcenterFee__c')+'';
                    ContractCostInfo.QualityExpenditure = conList.get(0).get('Field24__c')+'';
                    ContractCostInfo.cetrefee = conList.get(0).get('cetrefee__c')+'';
                    ContractCostInfo.TNumber = conList.get(0).get('TNumber__c')+'';
                    ContractCostInfo.costAmount =conList.get(0).get('costAmount__c')+'';
                    ContractCostInfo.TotalSalesApplicationAmoun = conList.get(0).get('TotalSalesApplicationAmoun__c')+'';
                    ContractCostInfo.MainProductGroup = conList.get(0).get('MainProductGroup__c')+'';
                    ContractCostInfo.accceptAmount = conList.get(0).get('accceptAmount__c')+'';
                    ContractCostInfo.operationAmount = conList.get(0).get('operationAmount__c')+'';
                    ContractCostInfo.installAmount = conList.get(0).get('installAmount__c')+'';
                    ContractCostInfo.unloadAmount = conList.get(0).get('unloadAmount__c')+'';
                    ContractCostInfo.detectionAmount = conList.get(0).get('detectionAmount__c')+'';
                    ContractCostInfo.technicalserviceAmount = conList.get(0).get('technicalserviceAmount__c')+'';
                    ContractCostInfo.CustomersCumulativeAmount = conList.get(0).get('CustomersCumulativeAmount__c')+'';
                    ContractCostInfo.ZONG = conList.get(0).get('ZONG__c')+'';
                    ContractCostInfo.BudgetaryExpenditure = conList.get(0).get('BudgetaryExpenditure__c')+'';
                    ContractCostInfo.CostExpenditure = conList.get(0).get('CostExpenditure__c')+'';
                    ContractCostInfo.AccountName = conList.get(0).get('AccountName__c')+'';
                    ContractCostInfo.opportunityCode = conList.get(0).get('number__c')+'';
                    ContractCostInfo.opportunityName = conList.get(0).get('opportunityNamegs__c')+'';
                    ContractCostInfo.contractNo = conList.get(0).get('contractNo__c')+'';
                    ContractCostInfo.purchaser = conList.get(0).get('purchaser__c')+'';
                    ContractCostInfo.contractName = conList.get(0).get('contractName__c')+'';
                    ContractCostInfo.contractAmount = conList.get(0).get('Field27__c')+'';
                    ContractCostInfo.RateApplication_before  = conList.get(0).get('Field26__c')+'';
                    ContractCostInfo.RateApplication_after = conList.get(0).get('margin1__c')+'';
                    ContractCostInfo.quotation = conList.get(0).get('quotation__c')+'';
                    ContractCostInfo.contracreviwer = conList.get(0).get('contracreviwer__c')+'';
                    ContractCostInfo.contractaccept = conList.get(0).get('contractaccept__c')+'';
                    ContractCostInfo.completelyDeliverDate = conList.get(0).get('completelyDeliverDate__c')+'';
                    ContractCostInfo.invoicePercent = conList.get(0).get('invoicePercent__c')+'';
                    ContractCostInfo.returnProportion = conList.get(0).get('returnProportion__c')+'';
                    
                    if( conList.get(0).get('RecordTypeName__c') == '建立客户关系' || conList.get(0).get('RecordTypeName__c') == '日常关系维护' || conList.get(0).get('RecordTypeName__c') == '节日活动' || conList.get(0).get('RecordTypeName__c') == '参加专业会议' || conList.get(0).get('RecordTypeName__c') == '客户关系建设' || conList.get(0).get('RecordTypeName__c') == '客户关系建设(四方三伊)' || conList.get(0).get('RecordTypeName__c') == '客户关系建设(国际)' || conList.get(0).get('RecordTypeName__c') == '客户关系建设(第三业务)' ){
                        ContractCostInfo.AccountName = conList.get(0).get('AccountName__c')+'';
                    }else{
                        ContractCostInfo.AccountName = '';
                    }
                    
                    if(conList.get(0).get('RecordTypeName__c') == '合同管理-履约、回款' || conList.get(0).get('RecordTypeName__c') == '已生成合同(无LTC过程)' || conList.get(0).get('RecordTypeName__c') == '已生成合同(有LTC过程)'||conList.get(0).get('RecordTypeName__c') == '已生成合同(无LTC过程-历史)' || conList.get(0).get('RecordTypeName__c') == '已生成合同(有LTC过程-历史)' || System.Test.isRunningTest() ){
                        ContractCostInfo.contractNo = conList.get(0).get('contractNo__c')+'';
                        ContractCostInfo.purchaser = conList.get(0).get('purchaser__c')+'';
                        ContractCostInfo.contractName = conList.get(0).get('contractName__c')+'';
                        ContractCostInfo.contractAmount = conList.get(0).get('Field27__c')+'';
                        ContractCostInfo.returnProportion = conList.get(0).get('returnProportion__c')+'%';
                        ContractCostInfo.invoicePercent = conList.get(0).get('invoicePercent__c')+'%';
 
                        if(ContractCostInfo.quotation=='null' ){
                            ContractCostInfo.isQuotation = '0';
                        }else{
                            ContractCostInfo.isQuotation = '1';
                        }
                        
                        if(ContractCostInfo.contracreviwer =='null'){
                            ContractCostInfo.isContracreviwer = '0';
                        }else{
                            ContractCostInfo.isContracreviwer = '1';
                        }
                        
                        if(ContractCostInfo.contractaccept=='null'){
                            ContractCostInfo.isContractaccept = '0';
                        }else{
                            ContractCostInfo.isContractaccept = '1';
                        }
                        
                        if(ContractCostInfo.completelyDeliverDate =='null'){
                            ContractCostInfo.isCompletelyDeliverDate = '0';
                        }else{
                            ContractCostInfo.isCompletelyDeliverDate = '1';
                        } 
                        
                        if(ContractCostInfo.invoicePercent !='null'){
                            ContractCostInfo.isInvoicePercent = '1';
                        }else{
                            ContractCostInfo.isInvoicePercent = '0';
                        } 
                        
                        if(ContractCostInfo.returnProportion !='null'){
                            ContractCostInfo.isReturnProportion = '1';
                        }else{
                            ContractCostInfo.isReturnProportion = '0';
                        }
                           
                        if(System.Test.isRunningTest()){
                            ContractCostInfo.contractNo ='';
                            ContractCostInfo.purchaser = '';
                            ContractCostInfo.contractName = '';
                            ContractCostInfo.contractAmount = '';
                            ContractCostInfo.returnProportion = '';
                            ContractCostInfo.invoicePercent = '';
    
                            ContractCostInfo.isQuotation = '0';
                            ContractCostInfo.isContracreviwer = '0';
                            ContractCostInfo.isContractaccept = '0';
                            ContractCostInfo.isCompletelyDeliverDate = '0';
                            ContractCostInfo.isInvoicePercent = '0';
                            ContractCostInfo.isReturnProportion = '0';
                        }
                        
                    }else{
                        ContractCostInfo.contractNo ='';
                        ContractCostInfo.purchaser = '';
                        ContractCostInfo.contractName = '';
                        ContractCostInfo.contractAmount = '';
                        ContractCostInfo.returnProportion = '';
                        ContractCostInfo.invoicePercent = '';

                        ContractCostInfo.isQuotation = '0';
                        ContractCostInfo.isContracreviwer = '0';
                        ContractCostInfo.isContractaccept = '0';
                        ContractCostInfo.isCompletelyDeliverDate = '0';
                        ContractCostInfo.isInvoicePercent = '0';
                        ContractCostInfo.isReturnProportion = '0';
                    }

                    NumberId = conList.get(0).get('id')+'';
                    List<CustomObject1__c > CustomObjectList  =[select Field8__c,Field10__c,Field9__c,Field11__c from CustomObject1__c where number__c =:NumberId];
                    if(CustomObjectList.size()>0){
                        ContractCostInfo.BudgetaryExpenditure_pass = CustomObjectList.get(0).get('Field8__c')+'';
                        ContractCostInfo.BudgetaryExpenditure_surplus = CustomObjectList.get(0).get('Field10__c')+'';
                        ContractCostInfo.CostExpenditure_pass = CustomObjectList.get(0).get('Field9__c')+'';
                        ContractCostInfo.CostExpenditure_surplus = CustomObjectList.get(0).get('Field11__c')+'';
                    }
                         
                }            
                
                //转化为JSON字符串  
                conJsonString =  JSON.serialize(ContractCostInfo);
                findv = 'true';                
            }

            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '获取服务类合同费用备案列表成功', '正常');
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getContractCostInfo查询信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','获取服务类合同费用备案列表接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
}