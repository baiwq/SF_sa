trigger CheckAttachmentInfo on contractreview__c (after update) {
 for(contractreview__c c:Trigger.new){
  contractreview__c cOld = Trigger.oldMap.get(c.id);
  if(c.reviewStatus__c != cOld.reviewStatus__c && c.reviewStatus__c =='评审完成'){
   List<attachment__c> cList = [select id from attachment__c where contractReview__c = :c.id and isValid__c = '有效' and type__c = '供货范围清单' and attachmentURL__c != null];
   if(cList.size()<1){
       c.addError('合同评审未上传有效的供货范围清单，无法设置为“评审完成”');
   }
  }
 }
}