trigger ContractNameNotNull  on Contract__c (before update) {
if(trigger.new.size() > 100){
      System.Debug('Contract Batch DMLs, ignore...');
}else{
   for(Contract__c newCC:trigger.new){
      Contract__c oldCC = trigger.oldMap.get(newCC.id);

       		if(newCC.approvalStatus__c == '提交待审批'&&oldCC.approvalStatus__c == '草稿'){
               if(newCC.contractName__c != null ){
                   
               }else{
                   newCC.addError('合同名称不能为空，请检查无误后，再提交!');
               }

           }
           if(oldCC.approvalStatus__c == '草稿' &&newCC.approvalStatus__c != oldCC.approvalStatus__c ){

        	   List<attachment__c> att_list = [select IsLastVersion__c,isValid__c,typeCode__c,attachmentURL__c from attachment__c where contract__c=:newCC.Id and type__c='合同文本' and isValid__c ='有效' ]; 
               if(att_list.size() > 1){
                   newCC.addError('合同附件中只能有一份有效的合同文本附件!');
               }
           }
       
           if(newCC.incomeConfirmDate__c != oldCC.incomeConfirmDate__c){
               ContractRevenueDate__c con = new ContractRevenueDate__c();
               con.Contract__c = newCC.Id;
               if(oldCC.incomeConfirmDate__c != null){
                   con.incomeConfirmDate_before__c = oldCC.incomeConfirmDate__c;
               }
               con.incomeConfirmDate_after__c = newCC.incomeConfirmDate__c;
               con.UpdateTime__c = System.now();
               insert con;
           }
   
      }
      
   }
}