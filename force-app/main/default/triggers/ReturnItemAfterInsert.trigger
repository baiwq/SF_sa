trigger ReturnItemAfterInsert on returnItem__c (After insert) {
   for(returnItem__c ri:Trigger.new){
      Map<String,ContractAchievement__c> SC = new Map<String,ContractAchievement__c>();
//计算各单位回款业绩并插入到该人的年度计划上 
      if(ri.recordTypeName__c == '合同回款'){
         if(ri.center__c == null){
            ri.addError(System.Label.ReturnItem_CenterNull);
         }else if(ri.department__c == null){
            ri.addError(System.Label.ReturnItem_DeptNull);
         }else if(ri.province__c == null){
            ri.addError(System.Label.ReturnItem_ProvinceNull);
         }
         
         if(!System.Test.isRunningTest()){
   
              FuncPools FP = new FuncPools();
              List<ContractAchievement__c> CAList = new List<ContractAchievement__c>();
              
              ID idTemp1 = FP.findPlanItemID(ri.year__c, ri.month__c,'回款',ri.returnUser__c);
              if(idTemp1 != null){
                  ContractAchievement__c CA1 = new ContractAchievement__c();
                  CA1.amount__c = ri.amount__c;
                  CA1.finishUser__c = ri.returnUser__c;
                  CA1.active__c = true;
                  CA1.finacialPlan__c = idTemp1;
                  CA1.returnItem__c = ri.id;
                  SC.put(idTemp1,CA1);
                  //CAList.add(CA1);
              }else{
                  System.Debug('没找到 销售 年度回款计划');
              }
              
              ID idTemp2 = FP.findPlanItemIDDepart(ri.year__c, ri.month__c,'回款',ri.province__c);
              if(idTemp2 != null){
                  ContractAchievement__c CA1 = new ContractAchievement__c();
                  CA1.amount__c = ri.amount__c;
                  CA1.finishUser__c = ri.returnUser__c;
                  CA1.active__c = true;
                  CA1.finacialPlan__c = idTemp2;
                  CA1.returnItem__c = ri.id;
                  SC.put(idTemp2,CA1);
                  //CAList.add(CA1);
              }else{
                  System.Debug('没找到 省区经理 年度回款计划');
              }
              
              ID idTemp3 = FP.findPlanItemIDDepart(ri.year__c, ri.month__c,'回款',ri.department__c);
              if(idTemp3 != null){
                  ContractAchievement__c CA1 = new ContractAchievement__c();
                  CA1.amount__c = ri.amount__c;
                  CA1.finishUser__c = ri.returnUser__c;
                  CA1.active__c = true;
                  CA1.finacialPlan__c = idTemp3;
                  CA1.returnItem__c = ri.id;
                  SC.put(idTemp3,CA1);
                  //CAList.add(CA1);
              }else{
                  System.Debug('没找到 大区经理 年度回款计划');
              }
              
              ID idTemp4 = FP.findPlanItemIDDepart(ri.year__c, ri.month__c,'回款',ri.center__c);
              if(idTemp4 != null){
                  ContractAchievement__c CA1 = new ContractAchievement__c();
                  CA1.amount__c = ri.amount__c;
                  CA1.finishUser__c = ri.returnUser__c;
                  CA1.active__c = true;
                  CA1.finacialPlan__c = idTemp4;
                  CA1.returnItem__c = ri.id;
                  SC.put(idTemp4,CA1);
                  //CAList.add(CA1);
              }else{
                  System.Debug('没找到 中心领导 年度回款计划');
              }
              
              for(String id:SC.keyset()){
                  CAList.add(SC.get(id));
              }
              
              if(CAList.size() >0 ){
                  insert CAList;
              } 
              
       }
      }
      
   }
}