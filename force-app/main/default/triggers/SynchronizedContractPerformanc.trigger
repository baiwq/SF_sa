trigger SynchronizedContractPerformanc on contractchange__c (after insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(contractchange__c newCC:trigger.new){
          if(Trigger.isInsert){
              
               if(newCC.recordType__c =='事业部业绩调整变更'){
                   if(newCC.contract__c != null){
                       //事业部业绩
                       List<ContractPGScaling__c> ContractPGScalingList=[select id,Allocation__c,PerformanceAmount__c,Contract__c,ProductGroup__c from ContractPGScaling__c where Contract__c = :newCC.contract__c];
                       if(ContractPGScalingList.size() > 0){
                           for(integer i=0;i<ContractPGScalingList.size();i++){
                               ContractChangePGScaling__c ContractChangePGScalingVo = new ContractChangePGScaling__c();
                               ContractChangePGScalingVo.Allocation__c = ContractPGScalingList.get(i).Allocation__c;
                               ContractChangePGScalingVo.PerformanceAmount__c = ContractPGScalingList.get(i).PerformanceAmount__c;
                               ContractChangePGScalingVo.ContractChange__c = newCC.id;
                               ContractChangePGScalingVo.Contract__c = newCC.Contract__c;
                               ContractChangePGScalingVo.ProductGroup__c = ContractPGScalingList.get(i).ProductGroup__c;
                               ContractChangePGScalingVo.ContractPGScaling__c = ContractPGScalingList.get(i).id; 
                               insert ContractChangePGScalingVo;
                           }
                       }
                   }
                }
              
          }
          
          
          if(Trigger.isUpdate){
                contractchange__c  oldCC = Trigger.oldMap.get(newCC.id);

               if(newCC.recordType__c =='事业部业绩调整变更'){
               
                   if(newCC.approvalStatus__c =='审批通过' && newCC.approvalStatus__c!= oldCC.approvalStatus__c ){
                       List<ContractChangePGScaling__c> ContractChangePGScalingList=[select id,Allocation__c,PerformanceAmount__c,Contract__c,ContractPGScaling__c,ProductGroup__c from ContractChangePGScaling__c where Contractchange__c = :newCC.id and isChange__c = '是'];
                       if(ContractChangePGScalingList.size() > 0){
                           for(Integer i=0;i<ContractChangePGScalingList.size();i++){
                               if(ContractChangePGScalingList.get(i).ContractPGScaling__c != null){
                                   ContractPGScaling__c ContractPGScalingVo =[select id,Allocation__c,PerformanceAmount__c,Contract__c,ProductGroup__c from ContractPGScaling__c where id = :ContractChangePGScalingList.get(i).ContractPGScaling__c];
                                   ContractPGScalingVo.Allocation__c = ContractChangePGScalingList.get(i).Allocation__c;
                                   ContractPGScalingVo.PerformanceAmount__c = ContractChangePGScalingList.get(i).PerformanceAmount__c;
                                   ContractPGScalingVo.ProductGroup__c = ContractChangePGScalingList.get(i).ProductGroup__c;
                                   update ContractPGScalingVo;
                               }else{
                                   ContractPGScaling__c newContractPGScaling = new ContractPGScaling__c();
                                   newContractPGScaling.Allocation__c = ContractChangePGScalingList.get(i).Allocation__c;
                                   newContractPGScaling.PerformanceAmount__c = ContractChangePGScalingList.get(i).PerformanceAmount__c;
                                   newContractPGScaling.ProductGroup__c = ContractChangePGScalingList.get(i).ProductGroup__c;
                                   newContractPGScaling.Contract__c = ContractChangePGScalingList.get(i).Contract__c;  
                                   insert newContractPGScaling;
                               }
                           }                  
                       } 
                   }
                   
               }
              
          }
         
             
      }       
  }
}