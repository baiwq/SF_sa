global class getContractFee {
    
    global class Response{
        webservice String flag;
        webservice String message;
    }

    global class ContractFeeVo{
         webservice String  Name;
         webservice String  RecordTypeName;
         webservice String  MainIndustrySales;
         webservice String  approveState;
         webservice String  OwnerName;
         webservice String  Field14;
         webservice String  AccountName;
         webservice String  number_c;
         webservice String  opportunityName;
         webservice String  purchaser;
         webservice String  contractNo;
         webservice String  contractName;
         webservice String  Field27;
         webservice String  ActualbudgetaryExpenditure_pass;
         webservice String  ActualbudgetaryExpenditure;
         webservice String  BudgetExpenditureSurplus;
         webservice String HAmount;//H订单金额
         webservice String Hnumber; //H订单编号
         webservice String MainProductGroup; //主责事业部
         webservice String costAmount;
         webservice String CostExpenditure_pass;
         webservice String CostExpenditure_pending;
         webservice String CostExpenditure_surplus;


    }
    
    global class ContractFeeInfo{
        webservice String Name;
        webservice String RecordTypeName;
        webservice String MainIndustrySales;
        webservice String approveState;
        webservice String OwnerName;
        webservice String Field10;
        webservice String othershoulders;
        webservice String Field9;
        webservice String Field11;
        webservice String subcenterFee;
        webservice String Field24;
        webservice String cetrefee;
        webservice String TNumber;
        webservice String Field14;
        webservice String AccountName;
        webservice String number_c;
        webservice String opportunityName;
        webservice String contractNo;
        webservice String purchaser;
        webservice String contractName;
        webservice String Field27;
        webservice String margin;
        webservice String margin1;
        webservice String quotation;
        webservice String contracreviwer;
        webservice String contractReceive;
        webservice String completelyDeliverDate;
        webservice String invoicePercent;
        webservice String returnProportion;
        webservice String ZONG;
        webservice String BudgetaryExpenditure;
        webservice String ActualbudgetaryExpenditure;
        webservice String  ActualbudgetaryExpenditure_pass;
        webservice String BudgetExpenditureSurplus;
        webservice String isQuotation;
        webservice String isContracreviwer;
        webservice String isContractReceive;
        webservice String isCompletelyDeliverDate;
        webservice String isInvoicePercent;
        webservice String isReturnProportion;
        webservice String CustomersCumulativeAmount;
        webservice String CumulativeAmount;
        webservice String CumulativeAmount_Pass;
        webservice String Accumulated_BudExpenditure;
        webservice String CumulativeCustomer;
        webservice String CumulativeCustomering;
        webservice String AccumulatedProject;
        webservice String AccumulatedProject_pass;
        webservice String AccumulatedProject_BudExpenditure;
        webservice String AccumulatedProject_CostExpenditure;
        webservice String CumulativeCustomer_pass;
        webservice String CumulativeCustomer_BudExpenditure;
        webservice String CumulativeCustomer_CostExpenditure;
        webservice String StageName;
        webservice String HAmount;//H订单金额
        webservice String Hnumber; //H订单编号
        webservice String MainProductGroup; //主责事业部
        webservice String CostExpenditure_pass;
        webservice String CostExpenditure_pending;
        webservice String CostExpenditure_surplus;
        webservice String costAmount;
    }
    
   
    
    
    //查询计划与考核
    webservice static Response getOwnerPlan(String UserId){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(UserId != ''){
                datetime myDateTime = datetime.now();
                integer years =  myDateTime.year();
                String years_s = String.valueOf(years);
                
                String query = 'SELECT name,contractGoal__c,returnGoal__c,summary_Contract__c,summary_Return__c,percentOfContract__c,percentOfReturn__c from  Plan__c where OwnerCode__c =:UserId and year__c =:years_s  ';

                List<Plan__c> conList = database.query(query);    
                //转化为JSON字符串  
                conJsonString =  JSON.serialize(conList);
                findv = 'true';
               
            }
            if( findv == 'true'){
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '获取计划与考核编号成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getOwnerPlan查新信息失败，未查询到相关数据','重要');
            }           
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','获取计划与考核编号异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
       
    //查询用户费用申请列表
    webservice static Response getContractFeeList(String ContractFeeName,String UserId){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(UserId != ''){
                String approveState = '审批通过';
                String query = 'SELECT  costAmount__c,MainProductGroup__c,Hnumber__c,HAmount__c,id,Name,RecordTypeName__c,contractNo__c,MainIndustrySales__c,approveState__c,OwnerName__c,Field14__c,AccountName__c,number__c,opportunityNamegs__c,contractName__c,purchaser__c,Field27__c from  contractFee__c where OwnerCode__c =:UserId and approveState__c =:approveState  ';

                if(ContractFeeName != ''){
                    String ContractFeeCode = '%'+ContractFeeName+'%';
                    query += ' and Name like :ContractFeeCode';
                }
                List<contractFee__c> conList = database.query(query); 
                List<ContractFeeVo> ContractFeelist = new List<ContractFeeVo>();
                if(conList.size() > 0 ){
                    ContractFeeVo  contractFeeVo = null;
                    String NumberId = '';
                    for(integer i=0; i<conList.size(); i++){
                         contractFeeVo = new ContractFeeVo();
                         contractFeeVo.Name =   conList.get(i).get('Name')+'';
                         contractFeeVo.RecordTypeName =      conList.get(i).get('RecordTypeName__c')+'';
                         contractFeeVo.MainIndustrySales =   conList.get(i).get('MainIndustrySales__c')+'';
                         contractFeeVo.approveState =    conList.get(i).get('approveState__c')+'';
                         contractFeeVo.OwnerName =   conList.get(i).get('OwnerName__c')+'';
                         contractFeeVo.Field14 =     conList.get(i).get('Field14__c')+'';
                         if( conList.get(i).get('Hnumber__c')!= null){
                            contractFeeVo.Field14 =   conList.get(i).get('HAmount__c')+'';
                         }
                         contractFeeVo.HAmount =  conList.get(i).get('HAmount__c')+''; //H订单金额
                         contractFeeVo.Hnumber = conList.get(i).get('Hnumber__c')+''; //H订单编号
                         contractFeeVo.MainProductGroup = conList.get(i).get('MainProductGroup__c')+''; //主责事业部
                         contractFeeVo.AccountName =     conList.get(i).get('AccountName__c')+'';
                         contractFeeVo.number_c =    conList.get(i).get('number__c')+'';
                         contractFeeVo.opportunityName =     conList.get(i).get('opportunityNamegs__c')+'';
                         contractFeeVo.purchaser =   conList.get(i).get('purchaser__c')+'';
                         contractFeeVo.contractName =    conList.get(i).get('contractName__c')+'';
                         contractFeeVo.Field27 =     conList.get(i).get('Field27__c')+'';
                         contractFeeVo.contractNo =      conList.get(i).get('contractNo__c')+'';
                         contractFeeVo.costAmount = conList.get(i).get('costAmount__c')+'';

                         NumberId = conList.get(i).get('id')+'';
                         List<CustomObject1__c > CustomObjectList  =[select Field8__c,Field10__c,Field9__c,Field11__c from CustomObject1__c where number__c =:NumberId];
                         if(CustomObjectList.size()>0){
                            contractFeeVo.ActualbudgetaryExpenditure_pass = '';
                            contractFeeVo.ActualbudgetaryExpenditure = CustomObjectList.get(0).get('Field8__c')+'';
                            contractFeeVo.BudgetExpenditureSurplus = CustomObjectList.get(0).get('Field10__c')+'';
                         	contractFeeVo.CostExpenditure_pass = CustomObjectList.get(0).get('Field9__c')+'';
                            contractFeeVo.CostExpenditure_surplus = CustomObjectList.get(0).get('Field11__c')+'';
                         }
                           ContractFeelist.add(contractFeeVo); 
                    }
                    
                }            
                
                //转化为JSON字符串  
                conJsonString =  JSON.serialize(ContractFeelist);
                findv = 'true';
                 
            }

            if( findv == 'true'){
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '获取费用申请列表成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getContractFeeList查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','获取费用申请列表接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }

    
     //查询费用详细信息
    webservice static Response getContractFeeInfo(String ContractFeeName){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
            if(ContractFeeName != ''){
                String query = 'SELECT  costAmount__c,MainProductGroup__c,Hnumber__c,HAmount__c,Name,RecordTypeName__c,StageName__c, MainIndustrySales__c, approveState__c,contractaccept__c, OwnerName__c, Field10__c, othershoulders__c, Field9__c, Field11__c, subcenterFee__c, Field24__c, cetrefee__c, TNumber__c, Field14__c, AccountName__c, number__c, opportunityNamegs__c, contractNo__c, purchaser__c, contractName__c, Field27__c, margin__c, margin1__c, quotation__c, contracreviwer__c, contractReceive__c, completelyDeliverDate__c, invoicePercent__c, returnProportion__c, ZONG__c, BudgetaryExpenditure__c, CustomersCumulativeAmount__c from  contractFee__c where Name =:ContractFeeName  ';
                
                List<contractFee__c> conList = database.query(query); 
                ContractFeeInfo  contractFeeInfo = null;
                if(conList.size() > 0 ){
                    String NumberId = '';
                    contractFeeInfo = new ContractFeeInfo();
                    
                    contractFeeInfo.costAmount =conList.get(0).get('costAmount__c')+'';

                    contractFeeInfo.Name = conList.get(0).get('Name')+'';
                    contractFeeInfo.RecordTypeName = conList.get(0).get('RecordTypeName__c')+'';
                    contractFeeInfo.MainIndustrySales = conList.get(0).get('MainIndustrySales__c')+'';
                    contractFeeInfo.approveState = conList.get(0).get('approveState__c')+'';
                    contractFeeInfo.OwnerName = conList.get(0).get('OwnerName__c')+'';
                    contractFeeInfo.Field10 = conList.get(0).get('Field10__c')+'';
                    contractFeeInfo.othershoulders = conList.get(0).get('othershoulders__c')+'';
                    contractFeeInfo.Field9 = conList.get(0).get('Field9__c')+'';
                    contractFeeInfo.Field11 = conList.get(0).get('Field11__c')+'';
                    contractFeeInfo.subcenterFee = conList.get(0).get('subcenterFee__c')+'';
                    contractFeeInfo.Field24 = conList.get(0).get('Field24__c')+'';
                    contractFeeInfo.cetrefee = conList.get(0).get('cetrefee__c')+'';
                    contractFeeInfo.TNumber = conList.get(0).get('TNumber__c')+'';
                    contractFeeInfo.Field14 =     conList.get(0).get('Field14__c')+'';
                    if( conList.get(0).get('Hnumber__c')!= null){
                        contractFeeInfo.Field14 =   conList.get(0).get('HAmount__c')+'';
                    }
                    contractFeeInfo.HAmount =  conList.get(0).get('HAmount__c')+''; //H订单金额
                    contractFeeInfo.Hnumber = conList.get(0).get('Hnumber__c')+''; //H订单编号
                    contractFeeInfo.MainProductGroup = conList.get(0).get('MainProductGroup__c')+''; //主责事业部
                    contractFeeInfo.number_c = conList.get(0).get('number__c')+'';
                    contractFeeInfo.opportunityName = conList.get(0).get('opportunityNamegs__c')+'';
                    contractFeeInfo.margin = conList.get(0).get('margin__c')+'';
                    contractFeeInfo.margin1 = conList.get(0).get('margin1__c')+'';
                    contractFeeInfo.quotation = conList.get(0).get('quotation__c')+'';
                    contractFeeInfo.contracreviwer = conList.get(0).get('contracreviwer__c')+'';
                    contractFeeInfo.contractReceive = conList.get(0).get('contractaccept__c')+'';
                    contractFeeInfo.completelyDeliverDate = conList.get(0).get('completelyDeliverDate__c')+'';
                    contractFeeInfo.ZONG = conList.get(0).get('ZONG__c')+'';
                    contractFeeInfo.BudgetaryExpenditure = conList.get(0).get('BudgetaryExpenditure__c')+'';
                    contractFeeInfo.CustomersCumulativeAmount = conList.get(0).get('CustomersCumulativeAmount__c')+'';
                    contractFeeInfo.CumulativeAmount = '';
                    contractFeeInfo.CumulativeAmount_Pass = '';
                    contractFeeInfo.Accumulated_BudExpenditure = '';
                    contractFeeInfo.CumulativeCustomer = '';
                    contractFeeInfo.CumulativeCustomering = '';
                    contractFeeInfo.AccumulatedProject = '';
                    contractFeeInfo.AccumulatedProject_pass = '';
                    contractFeeInfo.AccumulatedProject_BudExpenditure = '';
                    contractFeeInfo.AccumulatedProject_CostExpenditure = '';
                    contractFeeInfo.CumulativeCustomer_pass = '';
                    contractFeeInfo.CumulativeCustomer_BudExpenditure = '';
                    contractFeeInfo.CumulativeCustomer_CostExpenditure = '';

                    contractFeeInfo.StageName = conList.get(0).get('StageName__c')+'';


                    if(conList.get(0).get('RecordTypeName__c') == '客户关系建设'){
                        contractFeeInfo.AccountName = conList.get(0).get('AccountName__c')+'';
                    }else{
                        contractFeeInfo.AccountName = '';
                    }
                    
                    if(conList.get(0).get('RecordTypeName__c') == '已生成合同(无LTC过程)' || conList.get(0).get('RecordTypeName__c') == '已生成合同(有LTC过程)'||conList.get(0).get('RecordTypeName__c') == '已生成合同(无LTC过程-历史)' || conList.get(0).get('RecordTypeName__c') == '已生成合同(有LTC过程-历史)'){
                        contractFeeInfo.contractNo = conList.get(0).get('contractNo__c')+'';
                        contractFeeInfo.purchaser = conList.get(0).get('purchaser__c')+'';
                        contractFeeInfo.contractName = conList.get(0).get('contractName__c')+'';
                        contractFeeInfo.Field27 = conList.get(0).get('Field27__c')+'';
                        contractFeeInfo.returnProportion = conList.get(0).get('returnProportion__c')+'%';
                        contractFeeInfo.invoicePercent = conList.get(0).get('invoicePercent__c')+'%';

                            if(contractFeeInfo.quotation=='null' ){
                                contractFeeInfo.isQuotation = '0';
                            }else{
                                contractFeeInfo.isQuotation = '1';
                            }
                            
                            if(contractFeeInfo.contracreviwer =='null'){
                                contractFeeInfo.isContracreviwer = '0';
                            }else{
                                contractFeeInfo.isContracreviwer = '1';
                            }
                            
                            if(contractFeeInfo.contractReceive=='null'){
                                contractFeeInfo.isContractReceive = '0';
                            }else{
                                contractFeeInfo.isContractReceive = '1';
                            }

                            if(contractFeeInfo.completelyDeliverDate =='null'){
                                contractFeeInfo.isCompletelyDeliverDate = '0';
                            }else{
                                contractFeeInfo.isCompletelyDeliverDate = '1';
                            } 
                            
                            if(contractFeeInfo.invoicePercent !='null'){
                                contractFeeInfo.isInvoicePercent = '1';
                            }else{
                                contractFeeInfo.isInvoicePercent = '0';
                            } 
                            
                            if(contractFeeInfo.returnProportion !='null'){
                                contractFeeInfo.isReturnProportion = '1';
                            }else{
                                contractFeeInfo.isReturnProportion = '0';
                            }

                    }else{
                        contractFeeInfo.contractNo ='';
                        contractFeeInfo.purchaser = '';
                        contractFeeInfo.contractName = '';
                        contractFeeInfo.Field27 = '';
                        contractFeeInfo.returnProportion = '';
                        contractFeeInfo.invoicePercent = '';

                        contractFeeInfo.isQuotation = '0';
                        contractFeeInfo.isContracreviwer = '0';
                        contractFeeInfo.isContractReceive = '0';
                        contractFeeInfo.isCompletelyDeliverDate = '0';
                        contractFeeInfo.isInvoicePercent = '0';
                        contractFeeInfo.isReturnProportion = '0';

                    }


                    
                    NumberId = conList.get(0).get('id')+'';
                    List<CustomObject1__c > CustomObjectList  =[select Field8__c,Field10__c,Field9__c,Field11__c from CustomObject1__c where number__c =:NumberId];
                    if(CustomObjectList.size()>0){
                        contractFeeInfo.ActualbudgetaryExpenditure_pass = '';
                        contractFeeInfo.ActualbudgetaryExpenditure=CustomObjectList.get(0).get('Field8__c')+'';
                        contractFeeInfo.BudgetExpenditureSurplus = CustomObjectList.get(0).get('Field10__c')+'';
                        contractFeeInfo.CostExpenditure_pass = CustomObjectList.get(0).get('Field9__c')+'';
                        contractFeeInfo.CostExpenditure_surplus = CustomObjectList.get(0).get('Field11__c')+'';
                    }                    
                }            
                
                //转化为JSON字符串  
                conJsonString =  JSON.serialize(contractFeeInfo);
                findv = 'true';                
            }

            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '获取费用申请列表成功', '正常');
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getContractFeeInfo查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','获取费用申请列表接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
}