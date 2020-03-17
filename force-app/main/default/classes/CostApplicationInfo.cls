global class CostApplicationInfo {
 global class CostApplication{
     
        webservice String contractFeeId;       //费用申请ID
        webservice String contractCode;     //费用申请编号
     	webservice Decimal costAmount;     //本次申请总金额
 		webservice String contractNo;     //合同编号
 		webservice String margin1;     //费用后毛利率
 		webservice String margin;     //费用前毛利率
        webservice String contractId;  //合同管理ID
     	webservice String accountId; //客户ID
     
   		webservice Decimal amount;  // 合同金额
        webservice String MainProductGroup;  // 合同隶属事业部
        webservice String signTeamProvince;  // 合同隶属部门/省区
        webservice String signDate;  // 合同签订时间
        webservice String signedbyName;  // 合同签订人
        webservice String MainIndustrySales;  // 合同隶属业务
        webservice String contractReceptDate;  // 合同接收时间
        webservice Decimal returnProportion;  // 回款比列
        webservice Decimal returnAmount;  // 本合同回款信息（总金额）
     
     	webservice String  AccountName;   //客户名称
        webservice String  creditLevel;   //客户信用等级
        webservice Decimal  TotalAccountsReceivable;   //应收账款信息（总金额）
		webservice String  category;   //客户分类

        webservice Decimal performanceProportion;     //业绩分配比例

     	webservice String OwnerCode; //备案人员工编号
     
        webservice String ContractCostAmount; //本合同累计申请金额
        
        webservice String ContractAmount; //客户目前已签订合同（所签订的总金额）

        webservice Decimal summaryContract;      //备案申请人当年业绩信息

        webservice Decimal summaryReturn;    //备案申请人当年回款信息
     
     	webservice Decimal percentOfContract;  //备案申请人当年已完成合同额比
     
        webservice Decimal percentOfReturn;  //备案申请人当年已完成回款比

      	webservice Decimal deptsummaryContract;      //申请人部门当年业绩信息

        webservice Decimal deptsummaryReturn;    //申请人部门当年回款信息
     
     	webservice Decimal deptpercentOfContract;  //申请人部门当年已完成合同额比
     
        webservice Decimal deptpercentOfReturn;  //申请人部门当年已完成回款比
     
        //成本化分类
     	webservice String goodContract;   //优质合同
        webservice String goodContractAmount;   //优质合同支出金额
        webservice String SL;   //设联会
        webservice String SLF;   //设联会支出金额
        webservice String accept;   //出厂 验收
        webservice String accceptAmount;   //出厂验收支出金额
        webservice String operation;   //施工
        webservice String operationAmount;   //施工支出金额
        webservice String install;   //安装
        webservice String installAmount;   //安装支出金额
        webservice String unload;   //卸车
        webservice String unloadAmount;   //卸车支出金额
        webservice String detection;   //检测
        webservice String detectionAmount;   //检测支出金额
        webservice String technicalservices;   //技术服务
        webservice String technicalserviceAmount;   //技术服务支出金额
     
     
     	webservice String contractName; //合同名称
    }
   
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response getCostApplicationInfo(String ContractFeeName){
        Response resp = new Response();

        CostApplication costApplication = new CostApplication();
        String findv = 'false';
        try{

            if(ContractFeeName != 'null' ){
                List<contractFee__c> contractFee_list  = [select contractName__c,goodContract__c,goodContractAmount__c,SL__c,SLF__c,accept__c,accceptAmount__c,operation__c,operationAmount__c,install__c,installAmount__c,unload__c,unloadAmount__c,detection__c,detectionAmount__c,technicalservices__c,technicalserviceAmount__c,department__c,Provice__c,id,name,costAmount__c,contractNo__c,margin1__c,margin__c,contract__c,account__c,OwnerCode__c  from contractFee__c where name = :ContractFeeName and approveState__c = '审批通过'  order by CreatedDate desc];
                if(contractFee_list.size()>0){
                    findv = 'true';
                   	CostApplication.contractFeeId = contractFee_list.get(0).id;
                    CostApplication.contractCode = contractFee_list.get(0).name;
                    CostApplication.costAmount = contractFee_list.get(0).costAmount__c;
                    CostApplication.contractNo = contractFee_list.get(0).contractNo__c;
                    CostApplication.margin1 = contractFee_list.get(0).margin1__c;
                    CostApplication.margin = contractFee_list.get(0).margin__c;
                    CostApplication.contractId = contractFee_list.get(0).contract__c;
					CostApplication.accountId = contractFee_list.get(0).account__c ;
                    CostApplication.OwnerCode = contractFee_list.get(0).OwnerCode__c ;
                    
                    CostApplication.contractName = contractFee_list.get(0).contractName__c ;

                    
                  	CostApplication.goodContract  =  contractFee_list.get(0).goodContract__c+'';
                    CostApplication.goodContractAmount  =  contractFee_list.get(0).goodContractAmount__c+'';
                    CostApplication.SL  =  contractFee_list.get(0).SL__c+'';
                    CostApplication.SLF  =  contractFee_list.get(0).SLF__c+'';
                    CostApplication.accept  =  contractFee_list.get(0).accept__c+'';
                    CostApplication.accceptAmount  =  contractFee_list.get(0).accceptAmount__c+'';
                    CostApplication.operation  =  contractFee_list.get(0).operation__c+'';
                    CostApplication.operationAmount  =  contractFee_list.get(0).operationAmount__c+'';
                    CostApplication.install  =  contractFee_list.get(0).install__c+'';
                    CostApplication.installAmount  =  contractFee_list.get(0).installAmount__c+'';
                    CostApplication.unload  =  contractFee_list.get(0).unload__c+'';
                    CostApplication.unloadAmount  =  contractFee_list.get(0).unloadAmount__c+'';
                    CostApplication.detection  =  contractFee_list.get(0).detection__c+'';
                    CostApplication.detectionAmount  =  contractFee_list.get(0).detectionAmount__c+'';
                    CostApplication.technicalservices  =  contractFee_list.get(0).technicalservices__c+'';
                    CostApplication.technicalserviceAmount  =  contractFee_list.get(0).technicalserviceAmount__c+'';
                    
                    if(contractFee_list.get(0).contract__c != null){
                        Contract__c Contract_obj  = [select amount__c,MainProductGroup__c,signTeamProvince__c,signDate__c,signedbyName__c,MainIndustrySales__c,contractReceptDate__c,returnProportion__c,returnAmount__c from Contract__c where id =:contractFee_list.get(0).contract__c];
						CostApplication.amount= Contract_obj.amount__c;
                        CostApplication.MainProductGroup = Contract_obj.MainProductGroup__c;
                        CostApplication.signTeamProvince = Contract_obj.signTeamProvince__c;
                        CostApplication.signDate = Contract_obj.signDate__c+'';
                        CostApplication.signedbyName = Contract_obj.signedbyName__c;
                        CostApplication.MainIndustrySales = Contract_obj.MainIndustrySales__c;
                        CostApplication.contractReceptDate = Contract_obj.contractReceptDate__c+'';
                        CostApplication.returnProportion = Contract_obj.returnProportion__c;
                        CostApplication.returnAmount = Contract_obj.returnAmount__c;
                        
                        
                        //本合同累计申请金额
                        AggregateResult ReturnContractAmountObj=[SELECT sum(costAmount__c) ContractCostAmount from contractFee__c where contract__c =:contractFee_list.get(0).contract__c and approveState__c  = '审批通过'];
                        CostApplication.ContractCostAmount  = String.valueOf(ReturnContractAmountObj.get('ContractCostAmount'));
    
                        
                        //客户目前已签订合同（所签订的总金额）
                        AggregateResult ContractAmountObj=[SELECT sum(contractAmountRMB__c) ContractAmount from Contract__c where account__c =:contractFee_list.get(0).account__c and approvalStatus__c  = '审批通过'];
                        CostApplication.ContractAmount = String.valueOf(ContractAmountObj.get('ContractAmount'));

                    }
                    
                    if(contractFee_list.get(0).account__c != null){
                        Account account_obj = [select name,creditLevel__c,TotalAccountsReceivable__c,category__c from Account where id =:contractFee_list.get(0).account__c ];
                        CostApplication.AccountName = account_obj.name;
                        CostApplication.creditLevel = account_obj.creditLevel__c;
                        CostApplication.TotalAccountsReceivable = account_obj.TotalAccountsReceivable__c;
                        CostApplication.category = account_obj.category__c;                                                
                    }
                    
                    //业绩分配比例
                    list<AchivementRecognization__c>  performanceProportion_list = [ select performanceProportion__c  from AchivementRecognization__c where OwnerCode__c = :contractFee_list.get(0).OwnerCode__c and contract__c = :contractFee_list.get(0).contract__c];
                    if(performanceProportion_list.size() > 0 ){
                        CostApplication.performanceProportion = performanceProportion_list.get(0).performanceProportion__c;
                    }
                    
                    
                    
                    DateTime myDateTime = DateTime.now();
                    String new_year = myDateTime.format('yyyy');
                    list<Plan__c>  OwnerPlan  = [ select summary_Contract__c,summary_Return__c,percentOfContract__c,percentOfReturn__c  from Plan__c where OwnerCode__c = :contractFee_list.get(0).OwnerCode__c  and year__c = :new_year];
                    if(OwnerPlan.size() > 0 ){
                        CostApplication.summaryContract = OwnerPlan.get(0).summary_Contract__c;
                        CostApplication.summaryReturn = OwnerPlan.get(0).summary_Return__c;
                        CostApplication.percentOfContract = OwnerPlan.get(0).percentOfContract__c;
                        CostApplication.percentOfReturn = OwnerPlan.get(0).percentOfReturn__c;
                    }
                    
                    String dept =  contractFee_list.get(0).Provice__c;
                    if(contractFee_list.get(0).Provice__c != null){
                        
                    }else{
                        dept = contractFee_list.get(0).department__c;
                    }
                    
                    list<Plan__c>  deptOwnerPlan  = [ select summary_Contract__c,summary_Return__c,percentOfContract__c,percentOfReturn__c  from Plan__c where departmentName__c  =:dept  and year__c = :new_year];
                    if(deptOwnerPlan.size() > 0 ){
                        CostApplication.deptsummaryContract = deptOwnerPlan.get(0).summary_Contract__c;
                        CostApplication.deptsummaryReturn = deptOwnerPlan.get(0).summary_Return__c;
                        CostApplication.deptpercentOfContract = deptOwnerPlan.get(0).percentOfContract__c;
                        CostApplication.deptpercentOfReturn = deptOwnerPlan.get(0).percentOfReturn__c;
                    }
                    
                }	
            }

            if( findv == 'true'){
                resp.message = SYSTEM.JSON.serialize(costApplication);
                logClass.returnLog('成功', '已处理', ContractFeeName+'获取成本化费用信息成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message=ContractFeeName+'查询信息失败，未查询到相关数据！';
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
        }
        return resp;
    }
}