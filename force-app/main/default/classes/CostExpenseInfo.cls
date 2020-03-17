global class CostExpenseInfo {
    global class CostExpense{

        webservice String contractFeeId;       //费用申请ID

        webservice String contractCode;     //费用申请编号

        webservice String marginBefore;     //对应费用前毛利率

        webservice String marginAfter;      //对应费用后毛利率

        webservice String productType;      //涉及产品事业部

        webservice String accountId;    //客户ID

        webservice String accountName;      //客户名称

        webservice String category;     //客户分类

        webservice String creditLevel;      //客户信用等级

        webservice String accounttotalsum;      //累计汇总审批通过的合同总金额

        webservice String accountsreceivable;       //合同总金额减去已回款总金额

        webservice Decimal returnProportion;     //本合同回款比例

        webservice Decimal summaryContract;      //备案申请人当年业绩信息

        webservice Decimal summaryReturn;    //备案申请人当年回款信息

        webservice Decimal performanceProportion;     //本合同的业绩比例
          
        webservice String incomeConfirmDate;        //收入确认日期

        webservice String incomeConfirmAmount;        //收入确认金额


    }
   
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response getCostExpenseInfo(String ContractId,String UserId){
        Response resp = new Response();

        CostExpense costexpense = new CostExpense();
        String findv = 'false';
        try{

            if(ContractId != 'null' && ContractId !=''){

                    //合同付款比例
                    List<Contract__c>  ContractObj = [select returnProportion__c,account__c,id,incomeConfirmAmount__c,incomeConfirmDate__c from Contract__c where  contractNO__c = :ContractId ];
                    if(ContractObj.size() > 0){
                        costexpense.returnProportion = ContractObj.get(0).returnProportion__c;
                        costexpense.incomeConfirmDate = ContractObj.get(0).incomeConfirmDate__c+'';
                        costexpense.incomeConfirmAmount = ContractObj.get(0).incomeConfirmAmount__c+'';
                        findv = 'true';
                         
                         // 费用申请编号、 申请(费用)前毛利率、 申请(费用)后毛利率、 涉及产品事业部、
                        List<contractFee__c> contractFee_list  = [select Name , margin__c , margin1__c  , productType__c  from contractFee__c where contract__c = :ContractObj.get(0).id and approveState__c = '审批通过'  order by CreatedDate desc];
                        if(contractFee_list.size() > 0){
                            costexpense.contractCode = contractFee_list.get(0).Name;
                            costexpense.marginBefore = contractFee_list.get(0).margin__c;
                            costexpense.marginAfter = contractFee_list.get(0).margin1__c;
                            costexpense.productType = contractFee_list.get(0).productType__c;
                            findv = 'true';

                        }
                        
                         Account accountObj = [select  Name , category__c , creditLevel__c  from Account where id = :ContractObj.get(0).account__c];
                        if(accountObj != null){
                            costexpense.accountName = accountObj.Name;
                            costexpense.category = accountObj.category__c;
                            costexpense.creditLevel = accountObj.creditLevel__c;
                            findv = 'true';
    
                            
                              AggregateResult accounttotalsumObj=[SELECT sum(amount__c)  countamount from Contract__c where account__c = :ContractObj.get(0).account__c and approvalStatus__c = '审批通过'];
                              costexpense.accounttotalsum  = String.valueOf(accounttotalsumObj.get('countamount'));
    
    
                              AggregateResult ReturnContractAmountObj=[SELECT sum(noReturnContractAmount__c)  countnoReturnContractAmount from Contract__c where account__c = :ContractObj.get(0).account__c and approvalStatus__c = '审批通过'];
                              costexpense.accountsreceivable  = String.valueOf(ReturnContractAmountObj.get('countnoReturnContractAmount'));
    
    
                        }


                        if(UserId != 'null' && UserId !=''){
                           
                            list<AchivementRecognization__c>  performanceProportion_list = [ select performanceProportion__c  from AchivementRecognization__c where OwnerCode__c = :UserId and contract__c = :ContractObj.get(0).id];
                            if(performanceProportion_list.size() > 0 ){
                                costexpense.performanceProportion = performanceProportion_list.get(0).performanceProportion__c;
                                findv = 'true';

                            }
                        }


    
                    }


            }

            if(UserId != 'null' && UserId !=''){
                    DateTime myDateTime = DateTime.now();
                    String new_year = myDateTime.format('yyyy');


                    list<Plan__c>  OwnerPlan  = [ select summary_Contract__c , summary_Return__c  from Plan__c where OwnerCode__c = :UserId and year__c = :new_year];
                    if(OwnerPlan.size() > 0 ){
                        costexpense.summaryContract = OwnerPlan.get(0).summary_Contract__c;
                        costexpense.summaryReturn = OwnerPlan.get(0).summary_Return__c;
                        findv = 'true';

                    }
            }
          


            if( findv == 'true'){
                resp.message = SYSTEM.JSON.serialize(costexpense);
                logClass.returnLog('成功', '已处理', '获取成本化费用信息成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
        }
        return resp;
    }
}