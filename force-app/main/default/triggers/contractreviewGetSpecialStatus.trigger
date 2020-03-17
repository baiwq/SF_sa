trigger contractreviewGetSpecialStatus on contractreview__c (before insert,before update) {
    for(contractreview__c cr:Trigger.new){
        Boolean flag = true;

       if(cr.distributionSwitch__c && (cr.distributionSwitchPrice__c <= 0 || cr.distributionSwitchPrice__c == null))
          flag = false;
       else if(cr.CYCUPS__c && (cr.CYCUPSPrice__c <= 0 || cr.CYCUPSPrice__c == null))
          flag = false;
       else if(cr.SVG_STATCOM_APF__c && (cr.SVG_STATCOM_APFPrice__c <= 0 || cr.SVG_STATCOM_APFPrice__c == null))
          flag = false;
       else if(cr.paidServiceProduct__c && (cr.paidServiceProductPrice__c <= 0 || cr.paidServiceProductPrice__c == null))
          flag = false;
       else if(cr.paidTrainningProduct__c && (cr.paidTrainningProductPrice__c <= 0 || cr.paidTrainningProductPrice__c == null))
          flag = false;
       cr.TSCPFlag__c = flag;
       if((cr.SVG_STATCOM_APF__c==false && cr.SVG_STATCOM_APFPrice__c>0)||
           (cr.CYCUPS__c ==false && cr.CYCUPSPrice__c >0)||
           (cr.distributionSwitch__c ==false && cr.distributionSwitchPrice__c >0)||
           (cr.paidServiceProduct__c ==false && cr.paidServiceProductPrice__c >0)||
           (cr.paidTrainningProduct__c ==false && cr.paidTrainningProductPrice__c >0)
       ){
           cr.adderror('特殊产品未勾选，不能填写价格');
       }
    }
}