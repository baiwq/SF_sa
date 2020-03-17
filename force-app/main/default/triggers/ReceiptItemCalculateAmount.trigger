trigger ReceiptItemCalculateAmount on receiptItem__c (after insert,after update, after delete) {
   if(Trigger.isDelete){
      for(receiptItem__c i:Trigger.old){
         if(i.approvalStatus__c == '审批通过'){
            Contract__c con = [Select id, receiptTotalAmount__c from Contract__c where id =:i.contract__c ];
            con.receiptTotalAmount__c = con.receiptTotalAmount__c - i.receiptAmount__c;
            update con;
         }
      }
   }else if(Trigger.isInsert){
      for(receiptItem__c i:Trigger.new){
         if(i.approvalStatus__c == '审批通过'){
            Contract__c con = [Select id, receiptTotalAmount__c from Contract__c where id =:i.contract__c ];
            con.receiptTotalAmount__c = con.receiptTotalAmount__c + i.receiptAmount__c;
            update con;
         }
      }
   }else if(Trigger.isUpdate){
      for(receiptItem__c i:Trigger.new){
         receiptItem__c iold = Trigger.oldMap.get(i.id);
         if(i.approvalStatus__c == '审批通过'){
            Contract__c con = [Select id, receiptTotalAmount__c from Contract__c where id =:i.contract__c ];
            con.receiptTotalAmount__c = con.receiptTotalAmount__c + i.receiptAmount__c - iold.receiptAmount__c;
            update con;
         }
      }
   } 
}