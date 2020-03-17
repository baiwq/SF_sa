trigger ContractAfterInsert on Contract__c (after insert) { 
   if(trigger.new.size() >100 ){ 

      
   }else{
      
   }
}