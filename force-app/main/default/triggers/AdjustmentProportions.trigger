trigger AdjustmentProportions on ContractReviewPGScaling__c (before update,before insert) {
    for(ContractReviewPGScaling__c newCC : Trigger.new){ 
        
        if(trigger.isInsert){
             if(newCC.Allocation__c !=null){
            	newCC.PerformanceAmount__c = newCC.Allocation__c*newCC.contractAmount__c/100;
             }else if(newCC.Allocation__c ==null && newCC.PerformanceAmount__c!= null){
                 newCC.Allocation__c = newCC.PerformanceAmount__c/newCC.contractAmount__c*100;
             }else if(newCC.Allocation__c ==null&&newCC.PerformanceAmount__c ==null){
                 newCC.addError('分配比例和分配金额，请至少选一项填写！');
             }  
        
        }else if(trigger.isUpdate){
            ContractReviewPGScaling__c oldCC = Trigger.oldMap.get(newCC.id);
            String flag = '1';
            //修改业绩比例，更新业绩金额
             if(oldCC.Allocation__c != newCC.Allocation__c ){
                newCC.PerformanceAmount__c = newCC.Allocation__c*newCC.contractAmount__c/100;
                flag = '2';
             }
            //修改业绩金额，更新业绩比例
            if(oldCC.PerformanceAmount__c != newCC.PerformanceAmount__c && flag == '1'){
                newCC.Allocation__c = newCC.PerformanceAmount__c/newCC.contractAmount__c*100;
            }   
            
        }
    }

}