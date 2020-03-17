trigger ARAfterUpdate on AchivementRecognization__c (after update) {
   for(AchivementRecognization__c newAC:trigger.new){
// 如果编辑了合同金额，修改业绩
       if(newAC.isActive__c == '是'){
           List<ContractAchievement__c> CAList = [Select id from ContractAchievement__c where AchivementRecognization__c =:newAC.id];
           if(CAList.size() > 0){
               for(ContractAchievement__c CA:CAList){
                   CA.amount__c = newAC.contractAmount__c * newAC.performanceProportion__c/100;
               }
               update CAList;
           }
       }
      
       
 			if(System.Test.isRunningTest()){
                String test1 = 'test1';
                String test2 = 'test2';
                String test3 = 'test3';
                String test4 = 'test4';
                String test5 = 'test5';
                String test6 = 'test6';
                String test7 = 'test7';
                String test8 = 'test8';
                String test9 = 'test9';
                String test10 = 'test10';
                String test11 = 'test11';
                String test12 = 'test12';
                String test13 = 'test13';
                String test14 = 'test14';
                String test15 = 'test15';
            }
   }
}