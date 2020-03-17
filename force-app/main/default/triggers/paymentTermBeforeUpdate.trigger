trigger paymentTermBeforeUpdate on paymentTerm__c (before update) {
   if(Trigger.new.size()>100){
       return;
   }else{
       for(paymentTerm__c newPT:Trigger.new){
           paymentTerm__c oldPT = Trigger.oldMap.get(newPT.id);
           if(newPT.collectionAmount__c == newPT.backMoney__c && newPT.backMoney__c != oldPT.backMoney__c ){
               newPT.fullBackDate__c = System.today();
           }
           
           if(newPT.No__c != oldPT.No__c || newPT.percentage__c != oldPT.percentage__c || newPT.stage__c != oldPT.stage__c){
               if(newPT.contractApprovalStatus__c == '审批通过'){
                   List<Profile> pL = [Select id, Name from Profile where (Name =:'A-合同管理员（运营）' or Name = '系统管理员' or Name= 'System Administrator' or Name = 'A-项目管理工程师(国际)' or Name = 'A-合同管理工程师(四方三伊)') and id = :Userinfo.getProfileId()];
                   if(PL.size() <= 0)
                       newPT.addError('合同已审批通过，您无权修改序号，百分比（%），阶段字段！');    
               }
           }
           
       }
   }
   
}