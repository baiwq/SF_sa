trigger GuaranteeLetterBigRMB on guaranteeLetter__c (before insert,before update) {
    for(guaranteeLetter__c gl : Trigger.new){
//获取大写保证金金额
        if(gl.amount__c != null)
        {        
            gl.remittanceAmount__c = new FuncPools().digitUppercase(String.valueOf(gl.amount__c));
        }
        if(Trigger.isInsert){
            gl.RecordTypeId = [Select id from RecordType where DeveloperName = :'RecordTypeSaved' and SobjectType = :'guaranteeLetter__c'].id;
            if(gl.accountName__c !=null){
                Account a = [Select id, billingAddress__c, billingPhone__c, bankAccount__c, bankBy__c from Account where Name=:gl.accountName__c limit 1];
                //if(a.billingAddress__c != null && e.invoiceAddress__c == null) e.invoiceAddress__c = a.billingAddress__c;
                //if(a.billingPhone__c != null && e.accountPhone__c == null) e.accountPhone__c = a.billingPhone__c;
                if(a.bankAccount__c != null && gl.bankNumber__c == null) gl.bankNumber__c = a.bankAccount__c;
                if(a.bankBy__c != null && gl.bankBy__c == null) gl.bankBy__c = a.bankBy__c;
            }
        }
        if(Trigger.isUpdate){
            guaranteeLetter__c oldGL =Trigger.oldMap.get(gl.Id);
            if(gl.contract__c!=null){
                if(gl.approvalStatus__c=='提交待审批'&&gl.approvalStatus__c!=oldGL.approvalStatus__c){
                    Contract__c con =[Select Id,approvalStatus__c from Contract__c where id=:gl.contract__c];
                    if(con.approvalStatus__c!='审批通过'){
                        gl.addError('合同管理未审批通过，不能提交履约保证金/保函申请');
                    }
                }
            }
        }
    }
}