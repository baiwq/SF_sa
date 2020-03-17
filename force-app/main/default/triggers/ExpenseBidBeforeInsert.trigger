trigger ExpenseBidBeforeInsert on expenseOfBidApply__c (before insert) {
    for(expenseOfBidApply__c e : Trigger.new){
        //更新记录类型
            e.RecordTypeId = [Select id from RecordType where DeveloperName = :'RecordTypeSaved' and SobjectType = :'expenseOfBidApply__c'].id;
        //获取默认的客户信息      
            if(e.account__c != null){
                Account a = [Select id, billingAddress__c, billingPhone__c, bankAccount__c, bankBy__c from Account where id=:e.account__c limit 1];
                if(a.billingAddress__c != null && e.invoiceAddress__c == null) e.invoiceAddress__c = a.billingAddress__c;
                if(a.billingPhone__c != null && e.accountPhone__c == null) e.accountPhone__c = a.billingPhone__c;
                if(a.bankAccount__c != null && e.bankNumber__c == null) e.bankNumber__c = a.bankAccount__c;
                if(a.bankBy__c != null && e.bankBy__c == null) e.bankBy__c = a.bankBy__c;
             }
    }
}