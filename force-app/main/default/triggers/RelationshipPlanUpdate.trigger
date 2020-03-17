trigger RelationshipPlanUpdate on relationshipPlan__c (after update) {
    for(relationshipPlan__c rp : Trigger.new){    
        if(rp.recordType__c=='提升 普遍客户关系现状'&&rp.improveStatus__c=='确认完成'&&rp.approvalStatus__c=='审批通过'){
            Account a = [select currentRelationship__c, orgRelationship__c from Account where id=:rp.account__c];
            a.currentRelationship__c=rp.currentRelationship__c;
            update a;
        }
		if(rp.recordType__c=='提升 组织客户关系现状'&&rp.improveStatus__c=='确认完成'&&rp.approvalStatus__c=='审批通过'){
            Account a = [select currentRelationship__c, orgRelationship__c from Account where id=:rp.account__c];
            a.orgRelationship__c=rp.orgRelationship__c;
            update a;
        }
		if(rp.recordType__c=='提升联系人 成熟度'&&rp.improveStatus__c=='确认完成'&&rp.approvalStatus__c=='审批通过'){
            Contact c = [select maturity__c from Contact where id=:rp.contact__c];
            c.maturity__c=rp.improveTo__c;
            update c;
        }        
    }
}