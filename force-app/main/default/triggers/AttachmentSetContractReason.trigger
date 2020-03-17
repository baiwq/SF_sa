trigger AttachmentSetContractReason on attachment__c (after update) {
   
   for(attachment__c a:Trigger.new){
//如果批量更新附件
      if(trigger.new.size() > 100){
         System.Debug('Account Batch DMLs, ignore...');
         return;
      }
      
      if(a.contract__c != null&&a.isValid__c =='有效'){
         setContract(a.contract__c);
      }
   }
   
   public void setContract(String contractId){
      String str = '';
      List<AggregateResult> aList = [Select type__c t from attachment__c where isValid__c = :'有效' and attachmentURL__c != null and contract__c = :contractId group by type__c];
      if(aList.size() > 0){
         for(AggregateResult atemp:aList){
            str = str + atemp.get('t') + ';';
         }
         system.debug('str-----'+str);
         Contract__c c = [Select id, schedulingBasis__c from Contract__c where id =:contractId limit 1];
         c.schedulingBasis__c = str;
         update c;
      }
   }
}