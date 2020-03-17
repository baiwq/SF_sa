trigger BidReviewChangeOpp on bidReview__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(bidReview__c newCC:trigger.new){       
         bidReview__c  oldCC = Trigger.oldMap.get(newCC.id);
		 if(newCC.approvalStatus__c != oldCC.approvalStatus__c  && newCC.approvalStatus__c == '审批通过'){
             if(newCC.opportunity__c != null){
                 Opportunity oppt = [select StageName  from Opportunity where id = :newCC.opportunity__c];
                 oppt.StageName = '制定并提交解决方案';
         		 update oppt;
             }
           
         }
              
      }
  }
}