trigger PlanCreateMonth on Plan__c (after insert) {
    ID Id = [Select id from RecordType where Name =:'正常' and SobjectType = :'monthlyPlan__c'].id;
    List<monthlyPlan__c> MList = new List<monthlyPlan__c>{};
    for(Plan__c p:trigger.new){
       
       MList.add(new monthlyPlan__c(month__c = '一月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '二月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '三月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '四月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '五月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '六月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '七月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '八月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '九月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '十月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '十一月', Plan__c = p.id, RecordTypeId = Id));
       MList.add(new monthlyPlan__c(month__c = '十二月', Plan__c = p.id, RecordTypeId = Id));
       
    }
    insert MList;
}