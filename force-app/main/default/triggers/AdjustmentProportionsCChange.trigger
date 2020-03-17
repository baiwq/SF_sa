trigger AdjustmentProportionsCChange on ContractChangePGScaling__c (before update) {
    for(ContractChangePGScaling__c newCC : Trigger.new){ 
        ContractChangePGScaling__c oldCC = Trigger.oldMap.get(newCC.id);
        String flag = '1';
        //修改业绩比例，更新业绩金额
        if(oldCC.Allocation__c != newCC.Allocation__c ){
            if(newCC.Allocation__c!=null && newCC.contractAmountRMB__c != null){
                 newCC.PerformanceAmount__c = newCC.Allocation__c*newCC.contractAmountRMB__c/100;
            flag = '2';
            newCC.isChange__c = '是';
                
            }
           
        }
        //修改业绩金额，更新业绩比例
        if(oldCC.PerformanceAmount__c != newCC.PerformanceAmount__c && flag == '1'){
            newCC.Allocation__c = newCC.PerformanceAmount__c/newCC.contractAmountRMB__c*100;
            newCC.isChange__c = '是';

        }     
        
     
    }

}