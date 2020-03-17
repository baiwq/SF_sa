trigger checkApprove on contractreview__c (after update) {
//判断是否有供货范围附件
for(contractreview__c c:Trigger.new){
  contractreview__c  cOld = Trigger.oldMap.get(c.id);
  if(c.approvalStatus__c != cOld.approvalStatus__c && c.approvalStatus__c =='提交待审批'){
       List<attachment__c> cList = [select id from attachment__c where contractReview__c = :c.id and isValid__c = '有效' and type__c = '供货范围清单' and attachmentURL__c != null];
       if(cList.size()<1){
           c.addError('合同评审未上传有效的供货范围清单，无法提交审批');
       }
  }
 }
}