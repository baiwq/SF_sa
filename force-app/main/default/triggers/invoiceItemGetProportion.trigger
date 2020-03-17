trigger invoiceItemGetProportion on invoiceItem__c (before update,before insert) {
   for(invoiceItem__c i:trigger.new){
      i.preInvoiceIs__c = i.preInvoiceIsExisted__c;
      i.proportion__c = i.returnAmount__c/i.contractAmount__c*100;
      i.returnandinvoice1__c=i.returnandinvoice__c;
   }
}