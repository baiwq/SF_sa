trigger OpportunityAmount on Opportunity (before insert,before update) {
   for(Opportunity o:Trigger.new){
      o.Amount = o.expectAmount__c;
   }
}