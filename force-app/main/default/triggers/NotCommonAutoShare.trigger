trigger NotCommonAutoShare on notCommonOutsourcing__c (after insert,after update) {
   if(Trigger.isInsert){
      for(notCommonOutsourcing__c n:Trigger.new){
      	 if(n.salesManager__c != null){
            insert new notCommonOutsourcing__share(RowCause = Schema.notCommonOutsourcing__share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = n.salesManager__c, ParentId = n.id);
      	 }
      }   
   }else if(Trigger.isUpdate){
      for(notCommonOutsourcing__c n:Trigger.new){
         notCommonOutsourcing__c oldN = Trigger.oldMap.get(n.id);
         if(n.salesManager__c != oldN.salesManager__c && n.salesManager__c != null){ //自动分享个销售经理查看及编辑权限
            insert new notCommonOutsourcing__share(RowCause = Schema.notCommonOutsourcing__share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = n.salesManager__c, ParentId = n.id);
            List<notCommonOutsourcing__share>  ccsList = [select id from notCommonOutsourcing__share where UserOrGroupId =:oldN.salesManager__c and ParentId = :n.id];
            if(oldN.salesManager__c != n.OwnerId){
               delete ccsList;
            }
         }
      }
   }
}