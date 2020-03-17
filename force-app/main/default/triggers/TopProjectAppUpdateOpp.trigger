trigger TopProjectAppUpdateOpp on TopProjectApp__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(TopProjectApp__c newCC:trigger.new){
          TopProjectApp__c oldCC = Trigger.oldMap.get(newCC.id);
          if(newCC.approvalStatus__c == '审批通过' && newCC.approvalStatus__c != oldCC.approvalStatus__c){
              	Opportunity opp = [select BusinessRecommends__c,Recommendedreasons__c,TechnicalScheme__c,ProductsInvolved__c,SpecialSign__c,ProfitModel__c,id from Opportunity where id =:newCC.Opportunity__c];
              	opp.BusinessRecommends__c = newCC.BusinessRecommends__c;
                opp.Recommendedreasons__c = newCC.Recommendedreasons__c;
                opp.TechnicalScheme__c = newCC.TechnicalScheme__c;
                opp.ProductsInvolved__c = newCC.ProductsInvolved__c;
                opp.SpecialSign__c = newCC.SpecialSign__c;
                opp.ProfitModel__c = newCC.ProfitModel__c;
              	opp.valueTopOpportunity__c = true; 
				update opp;
              
          }
      }        
   }
}