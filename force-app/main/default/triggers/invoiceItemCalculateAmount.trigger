trigger invoiceItemCalculateAmount on invoiceItem__c (after insert,after update, after delete) {
   if(Trigger.isDelete){
      for(invoiceItem__c i:Trigger.old){
         if(i.approvalStatus__c == '审批通过'){
            Contract__c con = [Select id, invoiceSumAmount__c from Contract__c where id =:i.contract__c ];
            con.invoiceSumAmount__c = con.invoiceSumAmount__c - i.ALL_SAP__c;
            update con;
         }
      }
   }else if(Trigger.isInsert){
      for(invoiceItem__c i:Trigger.new){
         if(i.approvalStatus__c == '审批通过'){
            Contract__c con = [Select id, invoiceSumAmount__c from Contract__c where id =:i.contract__c ];
            con.invoiceSumAmount__c = con.invoiceSumAmount__c + i.ALL_SAP__c;
            update con;
         }
      }
   } 
}