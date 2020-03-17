trigger BidSectionCreatePake on BidSection__c (after insert) {
if(trigger.new.size()>100){
      return;
   }else{
      for(BidSection__c newCC:trigger.new){
          
          if(newCC.PackageNumber__c > 0){
              bidPackage__c  bidPackage = null;
              for(integer i = 0;i<newCC.PackageNumber__c;i++){
                  bidPackage = new bidPackage__c();
                  bidPackage.opportunity__c = newCC.opportunity__c;
                  bidPackage.BidSection__c = newCC.id;
                  bidPackage.name = '自动创建';
                  insert bidPackage;

              }
          }
      }
   }   
}