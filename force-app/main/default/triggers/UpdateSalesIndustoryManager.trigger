trigger UpdateSalesIndustoryManager on commisionSplit__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(commisionSplit__c newCC:trigger.new){
       if(newCC.SalesIndustoryManagergs__c != null){
            newCC.SalesIndustoryManager__c = newCC.SalesIndustoryManagergs__c;
       }
     }
  }
 }