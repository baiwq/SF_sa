trigger ARBeforeDelete on AchivementRecognization__c (before delete) {
    for(AchivementRecognization__c ar:trigger.old){
        List<ContractAchievement__c> caList = [Select id from ContractAchievement__c where AchivementRecognization__c=:ar.id];
        if(caList.size()>0){
            delete caList;
        }
    }
}