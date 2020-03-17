trigger ContracUpdateProportion on Contract__c (after insert,before update) {
 for(Contract__c newCC : Trigger.new){         
        //if(Trigger.isUpdate){
        if(Trigger.isInsert){ //新增时创建，一定要改
            if(newCC.reviewNumber__c != null){ //有合同评审编号
                
                List<ContractReviewPGScaling__c> ContractReviewPGScalingList = [select contractAmount__c,id,Allocation__c,contractreview__c,ProductGroup__c,PerformanceAmount__c from ContractReviewPGScaling__c where contractreview__c = :newCC.reviewNumber__c];
                if(ContractReviewPGScalingList.size() > 0){   //若有合同评审事业部业绩信息，直接在合同中创建  
                    for(integer i=0;i<ContractReviewPGScalingList.size();i++){
                        if(newCC.contractAmountRMB__c == ContractReviewPGScalingList.get(i).contractAmount__c ){  //合同评审金额和合同金额相等。所有信息复制合同评审
                            ContractPGScaling__c ContractPGScalingVo = new ContractPGScaling__c();
                            ContractPGScalingVo.Allocation__c = ContractReviewPGScalingList.get(i).Allocation__c;
                            ContractPGScalingVo.ProductGroup__c = ContractReviewPGScalingList.get(i).ProductGroup__c;
                            ContractPGScalingVo.ContractReviewPGScaling__c = ContractReviewPGScalingList.get(i).id;
                            ContractPGScalingVo.PerformanceAmount__c  = ContractReviewPGScalingList.get(i).PerformanceAmount__c;
                            ContractPGScalingVo.Contract__c = newCC.id;    
                            insert ContractPGScalingVo;
                        }else{ //不相等，按合同评审分配比例计算业绩金额
                            ContractPGScaling__c ContractPGScalingVo = new ContractPGScaling__c();
                            ContractPGScalingVo.Allocation__c = ContractReviewPGScalingList.get(i).Allocation__c;
                            ContractPGScalingVo.ProductGroup__c = ContractReviewPGScalingList.get(i).ProductGroup__c;
                            ContractPGScalingVo.ContractReviewPGScaling__c = ContractReviewPGScalingList.get(i).id;
                           ContractPGScalingVo.PerformanceAmount__c  = ContractReviewPGScalingList.get(i).Allocation__c*newCC.contractAmountRMB__c;
                            ContractPGScalingVo.Contract__c = newCC.id;    
                            insert ContractPGScalingVo;    
                        }
                       
                    }   
                }else{ //如没有合同评审事业部业绩信息，默认创建主责事业部业绩100%
                    if(newCC.MainProductGroup__c!=null){
                        ContractPGScaling__c ContractPGScalingVo = new ContractPGScaling__c();
                        ContractPGScalingVo.Allocation__c = 100;
                        ContractPGScalingVo.ProductGroup__c = newCC.MainProductGroup__c;
                        ContractPGScalingVo.Contract__c = newCC.id;   
                        ContractPGScalingVo.PerformanceAmount__c  =newCC.contractAmountRMB__c;
                        insert ContractPGScalingVo;
                    }
                       
                }

            }else{//无合同评审编号，默认创建主责事业部业绩100%
                
                    if(newCC.MainProductGroup__c!=null){
                        ContractPGScaling__c ContractPGScalingVo = new ContractPGScaling__c();
                        ContractPGScalingVo.Allocation__c = 100;
                        ContractPGScalingVo.ProductGroup__c = newCC.MainProductGroup__c;
                        ContractPGScalingVo.Contract__c = newCC.id;  
                        ContractPGScalingVo.PerformanceAmount__c  =newCC.contractAmountRMB__c;
                        insert ContractPGScalingVo;
                    }
            }
            
        }
            
       if(Trigger.isUpdate){

           Contract__c  oldCC = Trigger.oldMap.get(newCC.id);
            // if(oldCC.approvalStatus__c != newCC.approvalStatus__c && newCC.approvalStatus__c =='提交待审批'){
//                 AggregateResult ReturnContractAmountObj=[select sum(Allocation__c) Allocation_sum  from ContractPGScaling__c where Contract__c = :newCC.id];
//                 if(Decimal.valueOf(ReturnContractAmountObj.get('Allocation_sum')+'')>100){
//                       newCC.addError('事业部业绩必须满足业绩分配比例总和为100%或分配业绩金额总和等于合同签订金额，请修改！');
//                 }
//             }
            

                      
            //如果合同填写了合同接收日期
            if(newCC.contractReceptDate__c != null && newCC.contractReceptDate__c != oldCC.contractReceptDate__c){  
                
                //事业部业绩
                List<ContractPGScaling__c> ContractPGScalingList=[select id,Allocation__c,Contract__c,PerformanceAmount__c,ContractReviewPGScaling__c,ProductGroup__c from ContractPGScaling__c where Contract__c = :newCC.id];
                if(ContractPGScalingList.size() > 0){
                    double AmountPerformance_sum = 0.0;
                    double Allocation_sum = 0.0;
          AggregateResult BusinessPerformanceObj=[select sum(AmountPerformance__c) AmountPerformancesum,sum(Allocation__c) Allocationsum,count(id) count_num from BusinessPerformance__c where Contract__c = :newCC.id and CreditType__c = '合同业绩' and isActive__c = '有效'];
                    if(Decimal.valueOf(BusinessPerformanceObj.get('count_num')+'') == 0 || Decimal.valueOf(BusinessPerformanceObj.get('Allocationsum')+'') == 0 ){
                            for(integer i=0;i<ContractPGScalingList.size();i++){
                                BusinessPerformance__c BusinessPerformanceVo = new BusinessPerformance__c();
                                BusinessPerformanceVo.Allocation__c =  ContractPGScalingList.get(i).Allocation__c;
                                BusinessPerformanceVo.AmountPerformance__c =  (ContractPGScalingList.get(i).Allocation__c*newCC.contractAmountRMB__c)/100;
                                BusinessPerformanceVo.PerformanceGenerationDate__c = Date.today();
                                BusinessPerformanceVo.CreditType__c = '合同业绩';
                                BusinessPerformanceVo.Contract__c = newCC.id;
                                BusinessPerformanceVo.ContractPGScaling__c = ContractPGScalingList.get(i).id;
                                BusinessPerformanceVo.ProductGroup__c = ContractPGScalingList.get(i).ProductGroup__c;
                                BusinessPerformanceVo.isActive__c = '有效';
                                insert BusinessPerformanceVo;
                                AmountPerformance_sum+= (ContractPGScalingList.get(i).Allocation__c*newCC.contractAmountRMB__c)/100;
                                Allocation_sum +=  ContractPGScalingList.get(i).Allocation__c;
                            }
                        
                        
                            if(AmountPerformance_sum != newCC.contractAmountRMB__c){
                                BusinessPerformance__c BusinessPerformanceVo = new BusinessPerformance__c();
                                BusinessPerformanceVo.AmountPerformance__c =  newCC.contractAmountRMB__c-AmountPerformance_sum;
                                BusinessPerformanceVo.PerformanceGenerationDate__c = Date.today();
                                BusinessPerformanceVo.CreditType__c = '合同业绩';
                                BusinessPerformanceVo.Contract__c = newCC.id;
                                BusinessPerformanceVo.Allocation__c =  100-Allocation_sum;
                                BusinessPerformanceVo.ProductGroup__c = newCC.MainProductGroup__c;
                                BusinessPerformanceVo.isActive__c = '有效';
                                insert BusinessPerformanceVo;    
                            }                    
                        }
                        
                }
        
                AggregateResult IndustryPerformanceObj=[select sum(AmountPerformance__c) IndAmountPerformancesum,sum(Allocation__c) IndAllocationsum,count(id) Indcount_num from IndustryPerformance__c where Contract__c = :newCC.id and CreditType__c = '合同业绩' and isActive__c = '有效'];
                if(Decimal.valueOf(IndustryPerformanceObj.get('Indcount_num')+'') == 0 ){

                    //行业业绩
                    List<IndustryProportion__c> IndustryProportionList = [select id,opportunity__c,commisionSplit__c,Allocation__c,MainIndustrySales__c  from IndustryProportion__c where opportunity__c  =:newCC.opportunityId__c];
                    if(IndustryProportionList.size() > 0){
                        for(integer i=0;i<IndustryProportionList.size();i++){
                            IndustryPerformance__c  IndustryPerformanceVo = new IndustryPerformance__c();
                            IndustryPerformanceVo.Allocation__c =  IndustryProportionList.get(i).Allocation__c;
                            IndustryPerformanceVo.PerformanceGenerationDate__c = Date.today();
                            IndustryPerformanceVo.CreditType__c = '合同业绩';
                            IndustryPerformanceVo.Contract__c = newCC.id;
                            IndustryPerformanceVo.IndustryProportion__c = IndustryProportionList.get(i).id;
                            IndustryPerformanceVo.MainIndustrySales__c  = IndustryProportionList.get(i).MainIndustrySales__c ;
                            IndustryPerformanceVo.isActive__c = '有效';
                            insert IndustryPerformanceVo;
                        }
                        
                    }else if(newCC.MainIndustrySales__c!=null){
                         	IndustryPerformance__c  IndustryPerformanceVo = new IndustryPerformance__c();
                            IndustryPerformanceVo.Allocation__c =  100;
                            IndustryPerformanceVo.PerformanceGenerationDate__c = Date.today();
                            IndustryPerformanceVo.CreditType__c = '合同业绩';
                            IndustryPerformanceVo.Contract__c = newCC.id;
                            IndustryPerformanceVo.MainIndustrySales__c  = newCC.MainIndustrySales__c;
                            IndustryPerformanceVo.isActive__c = '有效';
                            insert IndustryPerformanceVo;
                    }else{
                        newCC.addError('该合同未创建行业业绩比例，请在合同中选择"项目所属行业"！');
                    }
                }
                
            }
       }
    }
}