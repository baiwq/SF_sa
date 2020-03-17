trigger ReceiptAfterInsert on receipt__c (after insert) {
   List<receipt__share> IList = new List<receipt__share>();
   for(receipt__c i:Trigger.new){
//创建分享规则，分享给申请人          
      if(i.applyBy__c != null){
         IList.add(new receipt__share(RowCause = Schema.receipt__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = i.applyBy__c, ParentId = i.id));
      }
//创建分享规则，分享给收款人     
      if(i.payeeUser__c != null){
         IList.add(new receipt__share(RowCause = Schema.receipt__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = i.payeeUser__c, ParentId = i.id));
      }
      
      if(IList.size() > 0){
         insert IList;
      }
      
   }
}