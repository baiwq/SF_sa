trigger QuatationAutoShare on quatation__c (after insert) {
   for(quatation__c q:Trigger.new){
      insert new quatation__share(RowCause = Schema.quatation__share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = q.CreatedById, ParentId = q.id);
   }   
}