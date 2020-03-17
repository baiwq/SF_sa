trigger ReceiptAfterUpdate on receipt__c (after update) {
    for(receipt__c rNew:Trigger.new){
       receipt__c rOld = Trigger.oldMap.get(rNew.id);
       
//如果编辑了申请人 signedby__c
       if(rNew.applyBy__c != rOld.applyBy__c && rNew.applyBy__c != null){
          insert new receipt__share(RowCause =Schema.receipt__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = rNew.applyBy__c, ParentId = rNew.id);
          List<receipt__share> ccsList1 = [select id from receipt__share where UserOrGroupId =:rOld.applyBy__c and ParentId = :rNew.id];
          if(rOld.applyBy__c != rNew.OwnerId){
             delete ccsList1;
          }
       }
//如果编辑了收款人 signedby__c
       if(rNew.applyBy__c != rOld.payeeUser__c && rNew.payeeUser__c != null){
          insert new receipt__share(RowCause =Schema.receipt__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = rNew.payeeUser__c, ParentId = rNew.id);
          List<receipt__share> ccsList2 = [select id from receipt__share where UserOrGroupId =:rOld.payeeUser__c and ParentId = :rNew.id];
          if(rOld.payeeUser__c != rNew.OwnerId){
             delete ccsList2;
          }
       }
//如果审批状态变成了审批通过    
      if((rNew.approvalStatus__c != rOld.approvalStatus__c) && rNew.approvalStatus__c == '审批通过'){
         new FuncPools().SetContractReceipt(rNew.id);
      } 
       
       
    }
}