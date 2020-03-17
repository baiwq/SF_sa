trigger ContractViewGetTBFather on contractreview__c (before insert, before update) {
    for(contractreview__c cr : trigger.new){
        if(cr.departmentmanager__c != null){
            cr.departmentmanager1__c=cr.departmentmanager__c;
        }else{
            cr.departmentmanager1__c=null;
        }
        
    }
    
}