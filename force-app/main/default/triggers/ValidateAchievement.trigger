trigger ValidateAchievement on commisionSplit__c (before update) {
 if(trigger.new.size()>100){
      return;
   }else{
      for(commisionSplit__c newCC:trigger.new){
            commisionSplit__c  oldCC = Trigger.oldMap.get(newCC.id);
           if(newCC.approvalStatus__c =='提交待审批' && newCC.approvalStatus__c!= oldCC.approvalStatus__c){
                
               AggregateResult IndustryProportionObj=[select sum(Allocation__c) Allocation_sum from IndustryProportion__c where commisionSplit__c = :newCC.id ];
               
               Decimal Allocation_sum = 0;
               if(IndustryProportionObj.get('Allocation_sum')!= null){
                 Allocation_sum = Decimal.valueOf(IndustryProportionObj.get('Allocation_sum')+'');
               }
               if(Allocation_sum>100){
                   
                    newCC.addError('行业业绩分配比例不能大于100%');

               }
              
          } 
      
      }     
  }
}