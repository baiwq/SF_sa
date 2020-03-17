trigger TbbaozhengjinBeforeInsert on tbbaozhengjin__c (before insert,before update) {
    for(tbbaozhengjin__c tb : Trigger.new){
        if(tb.remittanceNumber__c !=null && tb.rate__c !=null)
           tb.amount__c = (tb.remittanceNumber__c * tb.rate__c).setScale(2,RoundingMode.HALF_UP);
//获取大写
        if(tb.amount__c != null)
        {
            tb.remittanceAmount__c = new FuncPools().digitUppercase(String.valueOf(tb.amount__c));
        }
        tb.regionalDirector__c = tb.regionalDirectorFormula__c;
        if(trigger.isInsert){
        //更新记录类型
            tb.RecordTypeId = [Select id from RecordType where DeveloperName = :'RecordTypeSaved' and SobjectType = :'tbbaozhengjin__c'].id;
        //获取默认的客户信息      
            if(tb.account__c != null){
                Account a = [Select id, billingAddress__c, billingPhone__c, bankAccount__c, bankBy__c from Account where id=:tb.account__c limit 1];
                if(a.billingAddress__c != null && tb.invoiceAddress__c == null) tb.invoiceAddress__c = a.billingAddress__c;
                if(a.billingPhone__c != null && tb.accountPhone__c == null) tb.accountPhone__c = a.billingPhone__c;
                if(a.bankAccount__c != null && tb.bankNumber__c == null) tb.bankNumber__c = a.bankAccount__c;
                if(a.bankBy__c != null && tb.bank__c == null) tb.bank__c = a.bankBy__c;
             }
        }
    }
}