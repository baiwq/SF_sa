/*
 *   四方三伊、印度子公司的合同变更不推送到BPM
 */

trigger ContractChangeInterface on contractchange__c (before update) {
    for(contractchange__c c:Trigger.new){
        contractchange__c oldc = Trigger.oldMap.get(c.id);
        if(c.approvalStatus__c == '审批通过' && oldc.approvalStatus__c != c.approvalStatus__c){ 
            if(c.ownerDepartment__c !='感应加热业务' &&c.ownerDepartment__c !='印度子公司'){
                SOSPContractChangeToBPM.change(c.id);  
            }   
                             
        }  
    }
}