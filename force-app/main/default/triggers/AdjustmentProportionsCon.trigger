trigger AdjustmentProportionsCon on ContractPGScaling__c (before update) {
    for(ContractPGScaling__c newCC : Trigger.new){ 
        ContractPGScaling__c oldCC = Trigger.oldMap.get(newCC.id);
        String flag = '1';
        //修改业绩比例，更新业绩金额
         if(oldCC.Allocation__c != newCC.Allocation__c ){
            newCC.PerformanceAmount__c = newCC.Allocation__c*newCC.contractAmountRMB__c/100;
            flag = '2';
         }
        //修改业绩金额，更新业绩比例
        if(oldCC.PerformanceAmount__c != newCC.PerformanceAmount__c && flag == '1'){
            newCC.Allocation__c = newCC.PerformanceAmount__c/newCC.contractAmountRMB__c*100;
        }     
    }

}