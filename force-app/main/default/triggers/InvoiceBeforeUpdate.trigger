trigger InvoiceBeforeUpdate on invoice__c (before update) {
    if(trigger.new.size()>25){
        System.debug('大于25条');
        return;
    }else{
    for(invoice__c iNew:Trigger.new){
       invoice__c iOld = Trigger.oldMap.get(iNew.id);
      //得到大区经理
       if(iNew.departmentmanager__c != null){
           iNew.departmentmanager1__c = iNew.departmentmanager__c;
       }else{
           iNew.departmentmanager1__c = null;
       }
//如果编辑了申请人 signedby__c
       if(iNew.applyBy__c != iOld.applyBy__c && iNew.applyBy__c != null){
          insert new invoice__share(RowCause = Schema.invoice__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = iNew.applyBy__c, ParentId = iNew.id);
          List<invoice__share> ccsList = [select id from invoice__share where UserOrGroupId =:iOld.applyBy__c and ParentId = :iNew.id];
          if(iOld.applyBy__c != iNew.OwnerId){
             delete ccsList;
          }
       }
       
//校验开票项的总金额与应税货物名称总金额是否一致,验证规则无法做到
       if((iOld.approvalStatus__c != iNew.approvalStatus__c) && (iNew.goodsAmount__c != iNew.invoiceAmountSum__c)){
          iNew.addError(System.Label.Invoice_AmountNotEqual);
       }
       
//如果审批状态变成了提交待审批状态
       if((iNew.approvalStatus__c != iOld.approvalStatus__c)&&iNew.approvalStatus__c == '提交待审批'){
          List<invoiceItem__c> iiList= [Select id from invoiceItem__c where invoice__c=:iNew.id];
          if(iiList.size() > 0){
             ID RecordTypeId = [Select id from RecordType where SobjectType = 'invoiceItem__c' and DeveloperName = 'ReadOnly'].Id;
          }
       } 
       
//如果审批状态变成了审批拒绝
       if((iNew.approvalStatus__c != iOld.approvalStatus__c)&&iNew.approvalStatus__c == '审批拒绝'){
          List<invoiceItem__c> iiList= [Select id from invoiceItem__c where invoice__c=:iNew.id];
          if(iiList.size() > 0){
             ID RecordTypeId = [Select id from RecordType where SobjectType = 'invoiceItem__c' and DeveloperName = 'Normal'].Id;
          }
       }   
       
//如果审批状态变成了审批通过,调用接口传输客户信息(SAP接口)
      if((iNew.approvalStatus__c != iOld.approvalStatus__c)&&iNew.approvalStatus__c == '审批通过'){
         new FuncPools().SetContractInvoice(iNew.id);
         //2018-11-26 任艳新 修改：四方三伊的开票不推送到税控机
         if(iNew.ownerDepartment__c !='四方三伊销售部'){
             SospInsertInvoice.SospInsertInvoice(iNew.Id);
         }
         
         SoapSendAccountToSap.soapSendAccountToSap('开票审批通过',iNew.account__c,'C',iNew.invoiceCompanyCode__c,null);
      } 
      
      if((iNew.invoiceIsValid__c != iOld.invoiceIsValid__c) && (iNew.approvalStatus__c == '审批通过') && (iNew.invoiceIsValid__c == '是')){
         new FuncPools().SetContractInvoiceZF(iNew.id);
      }
       
      if(iNew.comments__c == null){
         iNew.comments__c='';
      } 
      
      String result= new FuncPools().updateComments(iNew.comments__c,iNew.commentsContract__c,iNew.id);
      if(result.equals('字段长度大于220')){
         iNew.addError(System.Label.InvoiceItem_InterfaceComments);
      }
      
      iNew.commentsInterface__c = result;
        
    }
    }
}