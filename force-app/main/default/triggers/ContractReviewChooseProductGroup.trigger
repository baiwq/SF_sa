trigger ContractReviewChooseProductGroup on contractreview__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(contractreview__c newCC:trigger.new){
   
          contractreview__c  oldCC = Trigger.oldMap.get(newCC.id);
          if(oldCC.approvalStatus__c != newCC.approvalStatus__c && newCC.approvalStatus__c =='提交待审批'){
           List<ContractReviewPGScaling__c> ContractReviewPGScalingList = [select id from ContractReviewPGScaling__c where contractreview__c = :newCC.id];
            
           
           // if(newCC.ProductGroup__c!= null){
           //    String[] ProductGroupList = newCC.ProductGroup__c.split(';'); 
           //    if(ProductGroupList.size() > ContractReviewPGScalingList.size()){
    
           //          newCC.addError('事业部的业绩比例分配数量与涉及事业部数量不一致。请补充缺少的事业部的业绩比例!');
           //    }
                     
           // }

              
              
       
              if(ContractReviewPGScalingList.size() >0 ){
                  AggregateResult ReturnContractAmountObj=[select sum(Allocation__c) Allocation_sum,sum(PerformanceAmount__c) PerformanceAmount_sum  from ContractReviewPGScaling__c where contractreview__c = :newCC.id];
                  if(Decimal.valueOf(ReturnContractAmountObj.get('Allocation_sum')+'') != 100 && Decimal.valueOf(ReturnContractAmountObj.get('PerformanceAmount_sum')+'')!= newCC.contractAmountgs__c){
                      newCC.addError('事业部业绩必须满足业绩分配比例总和为100%或分配业绩金额总和等于合同签订金额，请修改！');
                  }
              }
              
              

              AggregateResult AllocationSumObj=[select sum(Allocation__c) Allocation_sum,count(Allocation__c)  Allocation_count from IndustryProportion__c  where  opportunity__c= :newCC.opportunity__c];
                 if(Decimal.valueOf(AllocationSumObj.get('Allocation_sum')+'') > 100){
                  newCC.addError('行业业绩分配比例大于100%，请在业务机会对应的业绩比例中修改！');
             
                 }
             
           }
             
        }       
  }
}