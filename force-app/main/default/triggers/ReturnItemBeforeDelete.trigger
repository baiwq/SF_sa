trigger ReturnItemBeforeDelete on returnItem__c (before delete) {
   for(returnItem__c ri:Trigger.old){  
//删除各单位回款业绩并插入到该人的年度计划上
      if(ri.recordTypeName__c == '合同回款'){
         List<ContractAchievement__c>  CAOldList = [Select id from ContractAchievement__c where returnItem__c =:ri.id];
         if(CAOldList.size() > 0){
            delete CAOldList;
         }
      }
   }
}