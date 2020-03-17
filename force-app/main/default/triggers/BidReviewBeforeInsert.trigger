trigger BidReviewBeforeInsert on bidReview__c (before insert) {
    for(bidReview__c br : Trigger.new){
        if(br.departmentmanager1__c!=null){
            br.departmentmanager__c=br.departmentmanager1__c;
        }else{
            br.departmentmanager__c=null;
        }
    }
}