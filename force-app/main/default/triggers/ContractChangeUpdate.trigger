trigger ContractChangeUpdate on contractchange__c (before update) {
   for(contractchange__c cc :Trigger.new){
      contractchange__c oldCC = Trigger.oldMap.get(cc.id);
      //审批结果发送到CPQ
      if(cc.orderIdCPQ__c!=null&&cc.orderIdCPQ__c.trim()!=''){
          if(cc.approvalStatus__c!=oldCC.approvalStatus__c && (cc.approvalStatus__c == '审批通过'||cc.approvalStatus__c == '审批拒绝')){
            User lastMo=[Select Id,LastName,FirstName from User where Id=:cc.LastModifiedById limit 1][0];
            String employeeName=lastMo.LastName+lastMo.FirstName;
            SOSPToCPQStageStatusPublicClass.sendStageStatus('03',cc.contractNo__c,cc.Name,employeeName,null,cc.orderIdCPQ__c,cc.approvalStatus__c,cc.quatationName__c);
          } 
      }
       
//合同变更时审批通过日期是变更日期
      if(cc.approvalStatus__c == '审批通过' && oldCC.approvalStatus__c != cc.approvalStatus__c){
         cc.contractAmountBefore__c = cc.contractAmount__c;
         Contract__c c =[select changeDate__c, amount__c,orderIdCPQ__c,contractProjectGrossProfitMargin__c,contractProjectGrossProfit__c,
                                        standardProjectGrossProfitMarginContract__c,standardProjectGrossProfitContract__c from Contract__c where id=:cc.contract__c];
         c.changeDate__c=system.today();
         if(cc.totalDischarge__c = true){
            c.totalDischarge__c = '是';
         }
         if(cc.recordType__c=='合同金额变更'){
             c.amount__c=cc.contractAmountAfterChange__c;
         }
         if(cc.contractChangedProjectGrossProfitMargin__c!=null&&cc.contractChangedProjectGrossProfit__c!=null
                        &&cc.standardProjectGrossProfitMarginCtrChag__c!=null&&cc.standardProjectGrossProfitContractChange__c!=null){
                        //合同阶段合同价项目毛利率
                        c.contractProjectGrossProfitMargin__c =cc.contractChangedProjectGrossProfitMargin__c;
                    //合同阶段合同价项目毛利润
                        c.contractProjectGrossProfit__c=cc.contractChangedProjectGrossProfit__c;
                    //合同阶段标准价项目毛利率
                        c.standardProjectGrossProfitMarginContract__c=cc.standardProjectGrossProfitMarginCtrChag__c;
                    //合同阶段标准价项目毛利润
                        c.standardProjectGrossProfitContract__c = cc.standardProjectGrossProfitContractChange__c;
                    //订单号
                        c.orderIdCPQ__c = cc.orderIdCPQ__c;
         }
         update c;
/***
         if(cc.recordType__c=='供货范围变更'||(cc.recordType__c=='合同金额变更' && cc.scopeOfSupplyChangeIsExcited__c=='是')){
      
             List<attachment__c> attCList = [select id,isValid__c from attachment__c where contract__c=:cc.contract__c and type__c='供货范围清单'];
             if(attCList.size()>0){
                 for(attachment__c atta : attCList){
                 atta.isValid__c='无效';
                   
                 }
                 update attCList;
             }
             
             List<attachment__c> attList = [select id,type__c, contract__c from attachment__c where contractChange__c=:cc.id and type__c='供货范围清单'];
             if(attList.size()>0){
                 for(attachment__c att:attList){
                     att.contract__c=cc.contract__c;
                     att.isValid__c='有效';
                     
                 }
                 update attList;
             }
             
         } 
         
***/
      }  
   }
}