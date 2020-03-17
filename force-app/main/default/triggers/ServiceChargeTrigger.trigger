trigger ServiceChargeTrigger on ServiceCharge__c(before insert,after insert,before update ,after update) {
    for(ServiceCharge__c sc : Trigger.new){
    	if(Trigger.isAfter&&Trigger.isUpdate){
            if(sc.CostType__c=='报警服务费'&&sc.ApprovalStatus__c=='审批通过'&&sc.ApprovalStatus__c!=Trigger.oldMap.get(sc.Id).ApprovalStatus__c){
                SOSPTriggerCallSAPFinancial.triggerCallMethod(sc.contractNo__c);
            }
    		
    	}
    }
}