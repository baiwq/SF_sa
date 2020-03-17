trigger PerformanceInterface on Contract__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(Contract__c newCC:trigger.new){
         Contract__c oldcc = Trigger.oldMap.get(newCC.id);

         if(newCC.approvalStatus__c == '审批通过' && oldcc.approvalStatus__c != newCC.approvalStatus__c){
             List<ContractPGScaling__c>  ContractList = [select id,name,ProductGroup__c,Allocation__c,PerformanceAmount__c from  ContractPGScaling__c where Contract__c =:newCC.id];
             for(ContractPGScaling__c con:ContractList){
                 PerformanceInterface.SaveAchievementinfo(con.id,con.Name,con.ProductGroup__c,newCC.Name,con.Allocation__c+'',con.PerformanceAmount__c +'','合同业绩',Date.today()+'');
                //PerformanceInterface.SaveAchievementinfo(con.id,'SC20059',con.ProductGroup__c,newCC.Name,con.Allocation__c+'',con.PerformanceAmount__c +'','合同业绩',Date.today()+'');

             }
            
            //PerformanceInterface.SaveAchievementinfo(newCC.id,newCC.Name,newCC.ProductGroup__c,newCC.ContractName__c,newCC.Allocation__c+'',newCC.AmountPerformance__c+'',newCC.CreditType__c+'',newCC.PerformanceGenerationDate__c+'');

         }
             
      }       
  }
}