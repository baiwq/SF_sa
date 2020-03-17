trigger InvoiceBeforeInsert on invoice__c (before insert) {
   for(invoice__c i:Trigger.new){
      i.commentsInterface__c = i.comments__c;
      
//获取默认的客户信息      
      if(i.account__c != null){
         Account a = [Select id,taxpayerNumber__c, billingAddress__c, billingPhone__c, bankAccount__c, bankBy__c from Account where id=:i.account__c limit 1];
         if(a.billingAddress__c != null && i.invoiceAddress__c == null) i.invoiceAddress__c = a.billingAddress__c;
         if(a.billingPhone__c != null && i.accountPhone__c == null) i.accountPhone__c = a.billingPhone__c;
         if(a.bankAccount__c != null && i.bankAccount__c == null) i.bankAccount__c = a.bankAccount__c;
         if(a.bankBy__c != null && i.bank__c == null) i.bank__c = a.bankBy__c;
         if(a.taxpayerNumber__c != null && i.taxpayerCode__c == null){
             if(a.taxpayerNumber__c.length() != 15 && a.taxpayerNumber__c.length() != 18 && a.taxpayerNumber__c.length() != 20){ 
                 i.addError('所选客户统一信用代码长度必须为15位，18位，20位，请前往客户修改。');       
             }else{
                 i.taxpayerCode__c = a.taxpayerNumber__c;  //新增创建开票自动带出客户的纳税人识别号
             }
         }
          
         
      }
      //得到大区经理
      if(i.departmentmanager__c != null){
          i.departmentmanager1__c = i.departmentmanager__c;
      }else{
          i.departmentmanager1__c = null;
      }
   } 
}