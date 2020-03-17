trigger ReceiptGetBigRMB on receipt__c (before insert ,before update) {
    for(receipt__c r : Trigger.new){
    //得到大区经理
        if(r.departmentmanager__c!=null){
            r.departmentmanager1__c=r.departmentmanager__c;
        }else{
            r.departmentmanager1__c=null;
        }
//获取大写金额
        r.digitalCapital__c = new FuncPools().digitUppercase(String.valueOf(r.receiptAmount1__c));
    }
}