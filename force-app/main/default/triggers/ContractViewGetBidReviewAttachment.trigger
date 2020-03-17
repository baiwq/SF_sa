/*
    功能：创建合同评审自动把投标评审附件带过来
    创建人：霍东飞
    创建日期：2017-09-28
*/
trigger ContractViewGetBidReviewAttachment on contractreview__c(after insert){
    for(contractreview__c cv:Trigger.new){  
        List<attachment__c> newList = new List<attachment__c>();     
        List<attachment__c> attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c from attachment__c where type__c = '招标文件' and documentName__c!=null and attachmentURL__c!=null and bidReview__c != null and bidReview__c =:cv.biddingApproval__c and isValid__c = '有效'];
        for(attachment__c att:attList){ 
            attachment__c newAtt = new attachment__c();  
            newAtt.contractReview__c = cv.id;           
            newAtt.type__c = att.type__c;
            newAtt.documentName__c = att.documentName__c;
            newAtt.isValid__c = att.isValid__c;
            newAtt.attachmentURL__c = att.attachmentURL__c;
            newAtt.notes__c = att.notes__c;                             
            newList.add(newAtt);                             
        }
            insert newList;                 
    }
}