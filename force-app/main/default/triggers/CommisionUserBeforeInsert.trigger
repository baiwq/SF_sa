trigger CommisionUserBeforeInsert on commisionUser__c (before insert) {
    AggregateResult[] groupedResults =[select sum(performanceProportion__c) from commisionUser__c where commisionSplit__c=:trigger.new[0].commisionSplit__c];
    if(groupedResults.isEmpty()){
        trigger.new[0].addError(System.Label.CommisionUser_T);
    }
}