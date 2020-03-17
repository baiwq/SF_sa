trigger QuatationBeforeUpdate on quatation__c (before update) {
    for(quatation__c q : Trigger.new ){
        if(q.departmentmanager__c!=null){
            q.departmentmanager1__c = q.departmentmanager__c;
            q.businessOwner__c=[select ManagerId from user where id=:q.departmentmanager__c limit 1][0].ManagerId;
        }else{
            q.departmentmanager1__c = null;
        }
        quatation__c oldQ = Trigger.oldMap.get(q.id);
        if(q.orderIdCPQ__c!=null&&q.orderIdCPQ__c.trim()!=''){
            if(q.approvalStatus__c!=oldQ.approvalStatus__c && (q.approvalStatus__c == '审批通过'||q.approvalStatus__c == '审批拒绝')){
                User lastMo=[Select Id,LastName,FirstName from User where Id=:q.LastModifiedById limit 1][0];
                String employeeName=lastMo.LastName+lastMo.FirstName;
                SOSPToCPQStageStatusPublicClass.sendStageStatus('01',null,null,employeeName,null,q.orderIdCPQ__c,q.approvalStatus__c,q.Name);
            }
        }
        
        if(q.OwnerId!=oldQ.OwnerId){
            if(q.TSCPFlag__c){
                
            }else{
                q.addError('特殊产品专家需填写完所有已勾选的特殊产品后才能修改所有人');
            }
        }
    }
}