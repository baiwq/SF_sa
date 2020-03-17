trigger ReturnItemAchievement on returnItem__c (before insert,before update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(returnItem__c newCC:trigger.new){
         if(Trigger.isInsert){
           //if(Trigger.isUpdate){
                    
              if(newCC.contracts__c != null){
                    //事业部业绩
                    List<ContractPGScaling__c> ContractPGScalingList=[select id,NewAllocation__c,Allocation__c,Contract__c,ContractReviewPGScaling__c,contractAmountRMB__c ,ProductGroup__c from ContractPGScaling__c where Contract__c = :newCC.contracts__c];
                    if(ContractPGScalingList.size() > 0){
                        for(integer i=0;i<ContractPGScalingList.size();i++){
                            BusinessPerformance__c BusinessPerformanceVo = new BusinessPerformance__c();
                            BusinessPerformanceVo.returnItem__c = newCC.id;
                            BusinessPerformanceVo.Allocation__c =  ContractPGScalingList.get(i).Allocation__c;
                            BusinessPerformanceVo.PerformanceGenerationDate__c = Date.today();
                            BusinessPerformanceVo.CreditType__c = '回款业绩';
                            BusinessPerformanceVo.Contract__c = newCC.contracts__c;
                            BusinessPerformanceVo.ContractPGScaling__c = ContractPGScalingList.get(i).id;
                            BusinessPerformanceVo.ProductGroup__c = ContractPGScalingList.get(i).ProductGroup__c;
                            BusinessPerformanceVo.AmountPerformance__c =  ContractPGScalingList.get(i).Allocation__c*ContractPGScalingList.get(i).contractAmountRMB__c /100;
                            BusinessPerformanceVo.isActive__c = '有效';
                            insert BusinessPerformanceVo;
                        }
                        if(newCC.returnContract__c == 100.00 &&newCC.isReckon__c != '是') {
          					 newCC.isReckon__c = '是';
                             AggregateResult BusinessPerformanceObj=[select sum(AmountPerformance__c) AmountPerformance_sum, sum(Allocation__c) Allocation_sum from BusinessPerformance__c where Contract__c = :newCC.contracts__c and CreditType__c = '回款业绩'];
                             double AmountPerformance_sum = 0.0;
                             double Allocation_sum = 0.0;
                             if(BusinessPerformanceObj.get('AmountPerformance_sum')!=null){
                               AmountPerformance_sum = Decimal.valueOf(BusinessPerformanceObj.get('AmountPerformance_sum')+'');
                             }
                             
                              if(BusinessPerformanceObj.get('Allocation_sum')!=null){
                               Allocation_sum = Decimal.valueOf(BusinessPerformanceObj.get('Allocation_sum')+'');
                             }
                             
                             if(AmountPerformance_sum != newCC.contractAmount__c){
                                    BusinessPerformance__c BusinessPerformanceVo = new BusinessPerformance__c();
                                    BusinessPerformanceVo.AmountPerformance__c =  newCC.contractAmount__c-AmountPerformance_sum;
                                    BusinessPerformanceVo.PerformanceGenerationDate__c = Date.today();
                                    BusinessPerformanceVo.Allocation__c =  100-Allocation_sum;
                                    BusinessPerformanceVo.CreditType__c = '回款业绩';
                                    BusinessPerformanceVo.Contract__c = newCC.contracts__c;
                                    BusinessPerformanceVo.ProductGroup__c = newCC.MainProductGroup__c;
                                    BusinessPerformanceVo.returnItem__c = newCC.id;
                                    BusinessPerformanceVo.isActive__c = '有效';
                                    insert BusinessPerformanceVo;    
                             }     
                          }

                    }
                      
                                       
                     //行业业绩
                    List<IndustryProportion__c> IndustryProportionList = [select id,opportunity__c,commisionSplit__c,Allocation__c,MainIndustrySales__c  from IndustryProportion__c where opportunity__c  =:newCC.opportunity__c];
                    if(IndustryProportionList.size() > 0){
                        for(integer i=0;i<IndustryProportionList.size();i++){
                            IndustryPerformance__c  IndustryPerformanceVo = new IndustryPerformance__c();
                            IndustryPerformanceVo.Allocation__c =  IndustryProportionList.get(i).Allocation__c;
                            IndustryPerformanceVo.PerformanceGenerationDate__c = Date.today();
                            IndustryPerformanceVo.CreditType__c = '回款业绩';
                            IndustryPerformanceVo.Contract__c = newCC.contracts__c;
                            IndustryPerformanceVo.IndustryProportion__c = IndustryProportionList.get(i).id;
                            IndustryPerformanceVo.MainIndustrySales__c  = IndustryProportionList.get(i).MainIndustrySales__c ;
                            IndustryPerformanceVo.returnItem__c  = newCC.id ;
                            IndustryPerformanceVo.isActive__c = '有效';

                            insert IndustryPerformanceVo;
                        }
                        
                    }
                  
              }     
          } 
          
          if(Trigger.isUpdate){
                 returnItem__c  oldCC = Trigger.oldMap.get(newCC.id);
                 if(newCC.contracts__c != oldCC.contracts__c){
                    
                    // List<BusinessPerformance__c> BusinessPerformanceList=[select id,Contract__c from BusinessPerformance__c where returnItem__c = :newCC.id];
                    //  if(BusinessPerformanceList.size() > 0){
                    //     for(integer i=0;i<BusinessPerformanceList.size();i++){
                    //         BusinessPerformanceList.get(i).Contract__c = newCC.contracts__c;
                    //         update BusinessPerformanceList.get(i);
                    //     }
                    // }
                     
                    
                    List<IndustryPerformance__c> IndustryPerformanceList=[select id,Contract__c  from IndustryPerformance__c where returnItem__c  =:newCC.id];
                     if(IndustryPerformanceList.size() > 0){
                        for(integer i=0;i<IndustryPerformanceList.size();i++){
                            IndustryPerformanceList.get(i).Contract__c = newCC.contracts__c;
                            update IndustryPerformanceList.get(i);
                        }
                        
                    }
                       
                       
                 }
          }
      
      }     
  }
}