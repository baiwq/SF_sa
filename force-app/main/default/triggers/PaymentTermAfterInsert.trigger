trigger PaymentTermAfterInsert on paymentTerm__c (after insert) {
   if(Trigger.new.size() > 1){
      return;
   }else{
      AggregateResult[] groupedResults = [Select sum(percentage__c) from paymentTerm__c where contract__c=:trigger.new[0].contract__c];
      if(groupedResults.isEmpty()){
         System.Debug(System.Label.Payment_Stage);
      }
      Decimal avgAmount = (Decimal)groupedResults[0].get('expr0');
      if(avgAmount > 100){
         trigger.new[0].addError(System.Label.Payment_Over100);
      }
   }
}