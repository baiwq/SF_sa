trigger RelationshipPlanBeforeUpdate on relationshipPlan__c (before update) {
    for(relationshipPlan__c rp : trigger.new){
        if(rp.contact__c!=null){
            Contact c = [select maturity__c,AccountId from Contact where id=:rp.contact__c];
            rp.account__c=c.AccountId;
        }
        
    }
}