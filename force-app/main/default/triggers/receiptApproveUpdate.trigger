trigger receiptApproveUpdate on receipt__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
          for(receipt__c newCC:trigger.new){
            receipt__c  oldCC = Trigger.oldMap.get(newCC.id);
             
            ImpFindApprover  IFA = new ImpFindApprover();

            //销售组织BP  
            if(newCC.SalesOrganizationBP__c == null){
                newCC.SalesOrganizationBP__c = IFA.findSalesOrganizationBP(newCC.ownerCenter__c);
            }
			
        }
        
    }

}