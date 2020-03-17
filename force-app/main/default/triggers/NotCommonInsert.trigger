trigger NotCommonInsert on notCommonOutsourcing__c (before insert,before update) {
   for(notCommonOutsourcing__c nco:trigger.new){
      if(nco.contract__c != null){
         if(Trigger.IsUpdate){
             notCommonOutsourcing__c oldNCO =Trigger.oldMap.get(nco.Id);
             if(nco.approvalStatus__c=='提交待审批'&&nco.approvalStatus__c!=oldNCO.approvalStatus__c){
                 Contract__c con =[Select Id,approvalStatus__c from Contract__c where id=:nco.contract__c];
                 if(con.approvalStatus__c!='审批通过'){
                     nco.addError('合同管理未审批通过，不能提交非常用外购申请');
                 }
             }
         } 
      
//获取销售项目主责人
         try{
            Contract__c cc = [Select id, accountManager__c,accountManager__r.Manager.Id,accountManager__r.Manager.Manager.Id,accountManager__r.Manager.Manager.Manager.Id,accountManager__r.Manager.Manager.Manager.Manager.Id from Contract__c where id=:nco.contract__c];
            nco.salesManager__c = cc.accountManager__c;
            nco.provinceManager__c = cc.accountManager__r.Manager.Id;
            nco.departmentManager__c = cc.accountManager__r.Manager.Manager.Id;
            nco.viceManager__c = cc.accountManager__r.Manager.Manager.Manager.Id;
            nco.centerManager__c = cc.accountManager__r.Manager.Manager.Manager.Manager.Id;
         }catch(Exception e){
         
         }
                     
      }
   }
}