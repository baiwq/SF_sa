global class ScheduleTempClass implements Schedulable {
    global void execute(SchedulableContext SC){
        ContractPayment();
    }
    
    global void ContractPayment(){
      List<Contract__c> CList = [SELECT id, returnAmount__c from Contract__c where returnTempTest__c > 0 limit 90];
      if(CList.size() > 0){
         FuncPools fp = new FuncPools();
         for(Contract__c ctemp: CList){
            fp.SyncPayment(ctemp.id,ctemp.returnAmount__c);
         }
      }
   }
}