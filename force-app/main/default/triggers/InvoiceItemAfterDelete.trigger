trigger InvoiceItemAfterDelete on invoiceItem__c (after delete) {
   for(invoiceItem__c ii: Trigger.old){    
      invoice__c ic =[select approvalStatus__c,contractOrNot__c from invoice__c where id=:ii.invoice__c ];

//删除后判断是否有合同        
      List<invoiceItem__c> iiList = [Select id, contractIsExist__c from invoiceItem__c where invoice__c =:ii.invoice__c and id !=:ii.id];
      if(iiList.size() == 0){
         ic.contractOrNot__c = '有';
      }else if(iiList.size() > 0){
         for(invoiceItem__c it:iiList){
            if(it.contractIsExist__c == '无'){
               ic.contractOrNot__c = '无';
               break;
            }
            ic.contractOrNot__c = '有';
         }
      }
      
      update ic;
     
//更改合同，更新合同号备注
        invoice__c invoice= [select id, commentsContract__c, comments__c,commentsInterface__c from invoice__c where id = :ii.invoice__c];
        String result=new FuncPools().updateComments(invoice.comments__c,invoice.commentsContract__c,invoice.Id);
        if(result.equals('字段长度大于220')){           
            ii.addError(System.Label.InvoiceItem_InterfaceComments);
        }
        if(result==null){
           result='';
       }
        invoice.commentsInterface__c=result;
        update invoice;
   }
}