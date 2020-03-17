trigger ContractCancelUpdateField on contractchange__c (before update) {
for(contractchange__c c:Trigger.new){
    contractchange__c oldc = Trigger.oldMap.get(c.id);
    //合同变更提交待审批，校验合同审批通过 2018-12-11 任艳新
    if(c.approvalStatus__c=='提交待审批'&&oldc.approvalStatus__c != c.approvalStatus__c){
        Contract__c con =[Select Id,approvalStatus__c from Contract__c where id=:c.contract__c];
        if(con.approvalStatus__c!='审批通过'){
            c.addError('合同管理未审批通过，不能提交合同变更申请');
        }
    }
    if(c.approvalStatus__c == '审批通过' && oldc.approvalStatus__c != c.approvalStatus__c && c.recordType__c == '合同取消'){ 
        System.debug(c.mergerOfContractIsExcited__c );
        if(c.mergerOfContractIsExcited__c == '是'){   
             Contract__c con = [select id,contractCancel__c,active__c,cancelMark__c from Contract__c where id =:c.contract__c];
             con.contractCancel__c = '合同合并取消';con.cancelMark__c = '是';con.active__c = '合同取消';
             update con;
             List<AchivementRecognization__c> arList = [select id from AchivementRecognization__c where contract__c =:con.id];
             for(AchivementRecognization__c ar:arList){
                 List<ContractAchievement__c> caList = [select active__c from ContractAchievement__c where AchivementRecognization__c =:ar.id];
                 for(ContractAchievement__c ca:caList){
                     ca.active__c = false;
                 }
                 update caList;           
             }
         }else{
             Contract__c con = [select id,contractCancel__c,active__c,cancelMark__c from Contract__c where id =:c.contract__c];
             con.contractCancel__c = '合同取消'; con.cancelMark__c = '是'; con.active__c = '合同取消';
             update con;
             List<AchivementRecognization__c> arList = [select id from AchivementRecognization__c where contract__c =:con.id];
             for(AchivementRecognization__c ar:arList){
                 List<ContractAchievement__c> caList = [select active__c from ContractAchievement__c where AchivementRecognization__c =:ar.id];
                 for(ContractAchievement__c ca:caList){
                     ca.active__c = false;
                 }
                 update caList;           
             }
         }  
         
         List<BusinessPerformance__c > BPList = [select Contract__c,isActive__c from BusinessPerformance__c where Contract__c =:c.contract__c];
         if(BPList.size()>0){
             	for(BusinessPerformance__c bp:BPList){
                     bp.isActive__c = '无效';
                 }
                 update BPList;   
            
         }
        
         List<IndustryPerformance__c > IPList = [select Contract__c,isActive__c from IndustryPerformance__c where Contract__c =:c.contract__c];
         if(IPList.size()>0){
             	for(IndustryPerformance__c IP:IPList){
                     IP.isActive__c = '无效';
                 }
                 update IPList;   
            
         }


     }
     }
}