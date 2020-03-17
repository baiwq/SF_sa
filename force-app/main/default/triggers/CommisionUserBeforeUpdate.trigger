trigger CommisionUserBeforeUpdate on commisionUser__c (before update) {
   for(commisionUser__c cu:Trigger.new){
      AggregateResult[] groupedResults =[select sum(performanceProportion__c) from commisionUser__c where commisionSplit__c=:trigger.new[0].commisionSplit__c];
      if(groupedResults.isEmpty()){
         trigger.new[0].addError(System.Label.CommisionUser_T);
      }
      
      if(cu.fatherApprovalStatus__c == '审批通过'){
         cu.addError(System.Label.CommisionMember_T_Approval);
      }
   }
}