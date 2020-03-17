trigger ChangeSalesLeads on Opportunity (before update) {
    for(Opportunity op:Trigger.new){
        if(op.opportunityRecordType__c != '子业务机会'){
            Opportunity old_op = Trigger.oldMap.get(op.id);
            if(old_op.Name != op.Name && old_op.Name != null && op.Name != null){
                salesLeads__c sl = [select name from  salesLeads__c where id =:op.leadSource__c ];
                sl.name = op.Name;
                update sl;
                
            }       
        }      
    } 
    
}