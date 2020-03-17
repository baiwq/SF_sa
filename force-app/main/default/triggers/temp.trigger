trigger temp on Product2 (before update) {
/*
   List<Contract__c> CList = [SELECT id, returnAmount__c from Contract__c where returnTempTest__c != 0 and returnProportion__c <=100 limit 31];
   if(CList.size() > 0){
      FuncPools fp = new FuncPools();
      for(Contract__c ctemp: CList){
         fp.SyncPayment(ctemp.id,ctemp.returnAmount__c);
      }
   }
   trigger.new[0].description__c = String.ValueOf(CList.size());
*/ 

/*

//定义合同数据范围
     List<Set<String>> LSet = new List<Set<String>>();
      Set<String> scontractName = new Set<String>();
      
      for(Integer i = 12001; i<= 17000; i++){
         if(Math.mod(i, 1000) == 0){ 
            LSet.add(scontractName);
            scontractName = new Set<String>();
            scontractName.add('SC200'+i);
         }else{
            scontractName.add('SC200'+i);
         }
         
      }
      
      
      
      for(Integer k = 0;k< LSet.size(); k++){
      
      
      
      Set<Id> scontractId = new Set<Id>();
      List<Contract__c> CList = [Select id from Contract__c where Name in :LSet[k]];
      for(Contract__c ctemp:CList){
         scontractId.add(ctemp.id);
      }
      
      System.Debug('scontractId:' + scontractId);
      
      
      //List<paymentTerm__c> PTlist = [Select id, paymentStageDate__c, percentage__c, contract__c from paymentTerm__c where ZBQMark__c = true and paymentStageDate__c != null order by LastModifiedDate desc limit 9000];
      List<paymentTerm__c> PTlist = [Select id, paymentStageDate__c, percentage__c, contract__c from paymentTerm__c where ZBQMark__c = true and paymentStageDate__c != null and percentage__c != null and contract__r.Name in :scontractId order by LastModifiedDate desc];
      Set<Id> cSet = new Set<Id>();
      Map<Id,Date> MDList = new Map<Id,Date>();
      for(paymentTerm__c p:PTlist){
         cSet.add(p.contract__c);
         MDList.put(p.contract__c,p.paymentStageDate__c);
      }
      
      List<paymentTerm__c> PTlist6 = [Select id, stageDate__c, contract__c, percentage__c, ZBQdays__c from paymentTerm__c where No__c = 6 and contract__c in :cSet];
      for(paymentTerm__c p6:PTlist6){
         p6.stageDate__c = MDList.get(p6.contract__c).addDays(Integer.valueOf(p6.ZBQdays__c));
      }
      
      update PTlist6;
      
      
      }
      
      
 */   
      
}