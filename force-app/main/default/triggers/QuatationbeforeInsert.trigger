trigger QuatationbeforeInsert on quatation__c (before insert) {
    for(quatation__c q : Trigger.new){
        if(q.departmentmanager__c!=null){
            q.departmentmanager1__c = q.departmentmanager__c;
            q.businessOwner__c=[select ManagerId from user where id=:q.departmentmanager__c limit 1][0].ManagerId;
        }else{
            q.departmentmanager1__c = null;
            q.businessOwner__c = null;
        }
    }
}