trigger InvoiceItemRewriteComments on invoiceItem__c (after update,after insert) {
if(trigger.new.size() > 25){
      System.Debug('InvoiceItem Batch DMLs, ignore...');
}else{
   for(invoiceItem__c iiNew:Trigger.new){
//更改合同，更新合同号备注
      invoice__c invoice= [select id, commentsContract__c, comments__c,commentsInterface__c from invoice__c where id = :iiNew.invoice__c];
      String result=new FuncPools().updateComments(invoice.comments__c,invoice.commentsContract__c,invoice.Id);
      if(result.equals('字段长度大于255')){           
         iiNew.addError(System.Label.InvoiceItem_InterfaceComments);
      }
      
      invoice.commentsInterface__c=result;
      update invoice;
   }
}
}