trigger ARBeforeInsert on AchivementRecognization__c (before insert) {
    for(AchivementRecognization__c ar :Trigger.new){
        //销售团队中心、部门、省区
       if(ar.centerWriting__c==null){
           ar.centerWriting__c=ar.departmentLevelcenter__c;
       }
       if(ar.departmentWriting__c==null){
           ar.departmentWriting__c=ar.departmentLevelDepartment__c;
       }
       if(ar.provinceWriting__c==null){
           ar.provinceWriting__c=ar.departmentLevelProvince__c;
       }
    }
}