trigger AttachmentCheck on contractchange__c (after update) {
  for(contractchange__c c:Trigger.new){
      contractchange__c cold = Trigger.oldMap.get(c.id);
      if(c.approvalStatus__c != cold.approvalStatus__c && c.approvalStatus__c == '提交待审批'){
           if(c.recordType__c == '供货范围变更' || (c.recordType__c  =='合同金额变更' && c.scopeOfSupplyChangeIsExcited__c == '是' )){
              List<attachment__c>  attList = [select id from attachment__c where contractChange__c =:c.id and isValid__c ='有效' and type__c ='供货范围清单' and (documentName__c = null or attachmentURL__c =null)];
              if(attList.size() >0){
               c.addError('请上传有效的附件文件');
              }
          }
      }
  }
}