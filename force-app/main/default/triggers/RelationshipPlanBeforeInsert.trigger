trigger RelationshipPlanBeforeInsert on relationshipPlan__c (before insert) {
    for(relationshipPlan__c rp : trigger.new){
        if(rp.contact__c!=null){
            Contact c =[select id, AccountId from Contact where id =:rp.contact__c ];
            rp.account__c=c.AccountId;
        }

    }
}