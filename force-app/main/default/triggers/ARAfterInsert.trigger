trigger ARAfterInsert on AchivementRecognization__c (after insert) {
   Double Amount;
   String finishUserId;
   String ARId;
   String Year;
   String Month;
   List<ContractAchievement__c> CAList = new List<ContractAchievement__c>();

   for(AchivementRecognization__c ar:trigger.new){ 
//创建业绩表的时候自动创建到 合同完成情况表里
      Amount = ar.contractAmount__c * ar.performanceProportion__c/100;
      finishUserId = ar.achivementOwner__c;
      ARId = ar.id;
      Year = ar.year__c;
      Month = ar.month__c;
      
      condi(ar.achivementOwner18__c); 
   }
   
   if(CAList.size() > 0){
      insert CAList;
   }
   
   void condi(String UserId){
      FuncPools fpi = new FuncPools();
      Map<ID, String> MS = new Map<ID, String>();
      MS = fpi.findYearPlanByID(Year,Month,'合同',UserId);
      if(MS.isEmpty()){
         List<User> UList = [Select id,ManagerId from User where id =:UserId];
         if(UList[0].ManagerId != null ){
            condi(UList[0].ManagerId);
         }else{
            System.Debug('没找着这个人经理，数据有误，结束 @Error2!');
            return;
         }
      }else{
         for(Id id : MS.keySet()){
            String DepartName = MS.get(id).trim();
            System.Debug('Dp:' + DepartName);
            if(DepartName !='销售中心' && DepartName !='国际业务' && DepartName !='工业及公共业务'){
               Exec(id);
               List<User> UList = [Select id,ManagerId from User where id =:UserId];
               if(UList[0].ManagerId != null ){
                  condi(UList[0].ManagerId);
               }else{
                  System.Debug('没找着这个人经理，数据有误，结束 @Error1!');
                  return;
               }
            }else{
               Exec(id);
            }
         }
      }
   }
   
   void Exec(String FPId){
      ContractAchievement__c CA = new ContractAchievement__c();
      CA.amount__c = Amount;
      CA.finishUser__c = finishUserId;
      CA.AchivementRecognization__c = ARId;
      CA.finacialPlan__c = FPId;
      CA.active__c = true;
      CAList.add(CA);
   }
}