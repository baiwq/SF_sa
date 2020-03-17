trigger SchedulingUpdate on scheduling__c (before update) {
/*
    for(scheduling__c s: Trigger.new){
        scheduling__c o = Trigger.oldMap.get(s.id);
        Contract__c c =[select totalDischarge__c, approvalPsDate__c,incompleteReason__c from Contract__c where id=:s.contract__c];
//排产 完全排产 更新合同上的完全排产
        c.incompleteReason__c=s.notCompletelySchedulingExplain__c;
        
        if(s.totalDischarge__c==true){
           c.totalDischarge__c='是';
           //update c;
        }        
        if(s.approvalDate__c != null && s.approvalDate__c != o.approvalDate__c){
           c.approvalPsDate__c = s.approvalDate__c;
          // update c;
        }
        update c;
        if(s.salesMgr__c!=null){
            s.salesMgrlookup__c=s.salesMgr__c;
        }
        //得到大区经理
        if(s.departmentmanager__c!=null){
            s.departmentmanager1__c = s.departmentmanager__c;
        }else{
            s.departmentmanager1__c = null;
        }
 
    }
*/
}