/*
    功能：新建/编辑 合同管理 根据合同评审编号，判断是否是重点工程项目
    创建人：霍东飞
*/
trigger ContractGetImportantProjectNumber on Contract__c (before insert) {
    if(trigger.new.size()>10){
        return;
    }else{
          for(Contract__c c:Trigger.new){
            if(c.reviewNumber__c != null){
                List<majorProjects__c> mList = [select id,Field1__c from majorProjects__c where Field1__c = '审批通过' and contractreview__c =:c.reviewNumber__c];
                if(mList.size()>0){
                    c.MPnumber__c = mList[0].id;
                    c.MP__c = true;
                }
            }
          }
    }
}