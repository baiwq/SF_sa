trigger checkatt on quatation__c (after update) {
//判断是否有供货范围附件
for(quatation__c c:Trigger.new){
  quatation__c cOld = Trigger.oldMap.get(c.id);
  if(c.approvalStatus__c != cOld.approvalStatus__c && c.approvalStatus__c =='提交待审批'){
   List<attachment__c> clist2 = [select id,type__c from attachment__c  where quatation__c = :c.id and type__c ='供货范围清单' and isValid__c = '有效'];
   if(cList2.size()>0){
       List<attachment__c> cList = [select id from attachment__c where quatation__c = :c.id and isValid__c = '有效' and type__c = '供货范围清单' and attachmentURL__c != null];
       if(cList.size()<1){
           c.addError('报价管理未上传有效的供货范围清单，无法提交审批');
       }
   }
  }
 }
}