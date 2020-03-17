trigger BidCostBeforeInsert on bidCost__c (before insert) {
    for(bidCost__c bc:Trigger.new){
        if(bc.recordType__c=='中标服务费-常规'){
            bc.RecordTypeId= [Select id from RecordType where DeveloperName = :'bidServiceFeeSaved' and SobjectType = :'bidCost__c'].id;
        }else if(bc.recordType__c=='中标服务费-补录'){
            bc.RecordTypeId= [Select id from RecordType where DeveloperName = :'RecordTypeblSaved' and SobjectType = :'bidCost__c'].id;
        }
        if(bc.account__c!=null){
            Account a = [Select id, billingAddress__c, billingPhone__c, bankAccount__c, bankBy__c from Account where id=:bc.account__c limit 1];
            //if(a.billingAddress__c != null && bc.invoiceAddress__c == null) bc.invoiceAddress__c = a.billingAddress__c;
            //if(a.billingPhone__c != null && bc.accountPhone__c == null) bc.accountPhone__c = a.billingPhone__c;
            if(a.bankAccount__c != null && bc.bankNumber__c == null) bc.bankNumber__c = a.bankAccount__c;
            if(a.bankBy__c != null && bc.bankBy__c == null) bc.bankBy__c = a.bankBy__c;
        }
    }
}