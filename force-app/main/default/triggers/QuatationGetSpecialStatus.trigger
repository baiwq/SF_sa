trigger QuatationGetSpecialStatus on quatation__c (before insert,before update){
    for(quatation__c q:Trigger.new){
       Boolean flag = true;

       if(q.distributionSwitch__c && (q.distributionSwitchPrice__c <= 0 || q.distributionSwitchPrice__c == null))
          flag = false;
       else if(q.CYCUPS__c && (q.CYCUPSPrice__c <= 0 || q.CYCUPSPrice__c == null))
          flag = false;
       else if(q.SVG_STATCOM_APF__c && (q.SVG_STATCOM_APFPrice__c <= 0 || q.SVG_STATCOM_APFPrice__c == null))
          flag = false;
       else if(q.paidServiceProduct__c && (q.paidServiceProductPrice__c <= 0 || q.paidServiceProductPrice__c == null))
          flag = false;
       else if(q.paidTrainningProduct__c && (q.paidTrainningProductPrice__c <= 0 || q.paidTrainningProductPrice__c == null))
          flag = false;
       q.TSCPFlag__c = flag;
       if((q.SVG_STATCOM_APF__c==false && q.SVG_STATCOM_APFPrice__c>0)||
           (q.CYCUPS__c ==false && q.CYCUPSPrice__c >0)||
           (q.distributionSwitch__c ==false && q.distributionSwitchPrice__c >0)||
           (q.paidServiceProduct__c ==false && q.paidServiceProductPrice__c >0)||
           (q.paidTrainningProduct__c ==false && q.paidTrainningProductPrice__c >0)
       ){
           q.adderror('特殊产品未勾选，不能填写价格');
       }
    }

}