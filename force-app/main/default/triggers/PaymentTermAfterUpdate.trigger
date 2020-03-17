trigger PaymentTermAfterUpdate on paymentTerm__c (after update) {
    if(Trigger.new.size()>100){
        return;
    }else{
        AggregateResult[] groupedResults = [Select sum(percentage__c) from paymentTerm__c where contract__c=:trigger.new[0].contract__c];
        if(groupedResults.isEmpty()){
           System.Debug(System.Label.Payment_Stage);
        }
        Decimal avgAmount = (Decimal)groupedResults[0].get('expr0');
        if(avgAmount>100){
           trigger.new[0].addError(System.Label.Payment_Over100);
        }
        for(paymentTerm__c newPay :Trigger.new){
            paymentTerm__c oldPay = Trigger.oldMap.get(newPay.id);
            if(newPay.percentage__c!=oldPay.percentage__c){
                FuncPools fp = new FuncPools();
                fp.SyncPayment(newPay.contract__c,newPay.returnAmount__c);
            }
        }
    }
    
}