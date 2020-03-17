trigger ReceiptValidationForSF on receipt__c (before update,before insert){
   Boolean flag  = false;
   for(receipt__c i:Trigger.new){
      if(Trigger.isInsert){
         if(i.postOrNotSF__c && i.kuaidi__c =='顺丰'){
            flag = true;
         }
         
      }
      if(Trigger.isUpdate){
         receipt__c iOld = Trigger.oldMap.get(i.id);
         if(iOld.postOrNotSF__c != i.postOrNotSF__c || iOld.kuaidi__c != i.kuaidi__c){
            if(i.postOrNotSF__c && i.kuaidi__c =='顺丰'){
               flag = true;
            }
         }
         if(i.approvalStatus__c=='审批通过' &&i.receiverCompany__c==null){
             i.receiverCompany__c=i.receiverSF__c;
         }
      }
   
      if(flag){
         if(i.shippingAddressSF__c == null || i.receiverSF__c == null || i.receiverPhoneSF__c == null){
            i.addError('需要顺丰邮寄时，收件人、收件电话、邮寄地址必需填写！');
         }
      }
   }
}