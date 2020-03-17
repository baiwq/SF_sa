trigger InvoiceItemBeforeInsert on invoiceItem__c (before insert) {
   for(invoiceItem__c ip : Trigger.new){
   
//判断有无合同,更新开票信息   
      invoice__c ic =[select approvalStatus__c,contractOrNot__c from invoice__c where id=:ip.invoice__c ];      
      if(ip.contractIsExist__c=='无'){
         ic.contractOrNot__c = '无';
         update ic;
      }
   }
}