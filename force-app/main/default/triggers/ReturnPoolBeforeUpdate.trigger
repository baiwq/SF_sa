trigger ReturnPoolBeforeUpdate on returnPool__c (before update) {
   for(returnPool__c rp:trigger.new){
      returnPool__c rpold = Trigger.oldMap.get(rp.id);
      
//如果清分完成确认，设置清分确认时间
      if(rp.finishedConfirm__c == true & rp.finishedConfirm__c != rpold.finishedConfirm__c){
         rp.ConfirmTime__c = System.now();
      }
      
//如果清分完成，设置清分完成时间      
      if((rp.amount__c != rpold.amount__c|| rp.finishedAmount__c != rpold.finishedAmount__c)&&rp.finishedAmount__c >= rp.amount__c){
         rp.finishedTime__c = System.now();
      }
      
//如果清分完成，设置清分完成时间  
      if(rp.temporaryIsExcited__c == true & rp.temporaryIsExcited__c != rpold.temporaryIsExcited__c){
         rp.confirmTemporaryTime__c = System.now();
      }

   }
}