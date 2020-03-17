trigger InvoiceAfterInsert on invoice__c (after insert) {
   List<invoice__share> IList = new List<invoice__share>();
   for(invoice__c i:Trigger.new){

//创建分享规则，分享给申请人          
      if(i.applyBy__c != null){
         IList.add(new invoice__share(RowCause = Schema.invoice__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = i.applyBy__c, ParentId = i.id));
      }
   }
   
   insert IList;
}