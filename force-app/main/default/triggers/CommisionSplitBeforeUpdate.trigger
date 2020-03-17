trigger CommisionSplitBeforeUpdate on commisionSplit__c (before update) {
    for(commisionSplit__c CS:trigger.new){
        if(CS.approvalStatus__c=='审批通过'){
            List<AggregateResult> ARList =[Select sum(performanceProportion__c) from commisionUser__c where commisionSplit__c=:CS.id];
            if(ARList.size()>0){
                Double sumPerformance = Double.valueOf(ARList[0].get('expr0'));
                if(sumPerformance>100){
                    CS.addError('业绩分配比例大于100%');
                }
            }
        }
    }
}