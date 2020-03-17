/***
*合同变更附件传递
*创建人：任艳新、杨明
*创建时间：2019-01-10
*sf-auto-tranzvision

*修改时间：2019-12-12
*修改人 Mark 柏文强 Celnet
 测试类 AttenmentUpdateContract_test
***/
trigger AttachmentUpdateContract on attachment__c (before update,before insert) {

    System.Debug('=====i=====');
    Set<String> strSet = new Set<String>();
    /*if(strSet.contains('AttachmentUpdateContract'))
    {
        return;
    }
    else
    {
        strSet.add('AttachmentUpdateContract');
    }*/
if(trigger.new.size() > 100){
      System.Debug('Account Batch DMLs, ignore...');
}else{
    String currentUser = [select Profile.Name from User where id=:UserInfo.getUserId()][0].Profile.Name;
    Set<Id> contractIdSet = new Set<Id>();
    Set<Id> oppIdSet = new Set<Id>();
    List<Contract__c> conList = new List<Contract__c>();
    Map<Id,Contract__c> conMap = new Map<Id,Contract__c>();
    Map<Id,Contract__c> conInsertMap = new Map<Id,Contract__c>();
    Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
    for(attachment__c a:Trigger.new)
    {
      if(null!= a.contract__c)
      {
        contractIdSet.add(a.contract__c);
      }
    }
    // if(!System.Test.isRunningTest()){
      conMap = new Map<Id,Contract__c>([Select id,attachmentLastTime__c,opportunity__c from Contract__c where id IN:contractIdSet]);
      for (Contract__c con : conMap.values()) 
      {
        if(null!=con.opportunity__c)
        {
          oppIdSet.add(con.opportunity__c);
        }
      }
      oppMap = new Map<Id,Opportunity>([Select id,RecordType.DeveloperName from Opportunity where id IN:oppIdSet]);
    // }
    for(attachment__c a:Trigger.new){ 
      if(a.contract__c != null && conMap.containsKey(a.contract__c)){
          //List<attachment__c> firstList = [Select id from attachment__c where contract__c=:a.contract__c];
          //if(firstList.size()!=0){
              // if(!System.Test.isRunningTest()){
                  Contract__c con = conMap.get(a.contract__c);
                  con.attachmentLastTime__c = System.now();
                  // conList.add(con); 
                  conInsertMap.put(a.contract__c, con);                 
              // }
          //}
      }
      if(Trigger.isInsert){
          //2019-01-02 审批中和审批通过后，销售无法修改创建附件
          //2019-01-02 投标评审
          if(a.bidReview__c!=null){
              if(a.BidReviewApprovalStatus__c!='草稿'&&a.BidReviewApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('投标评审已提交了审批不能创建附件');
                  }
              }
          }
          //2019-01-02 非常用外购申请
          if(a.notCommonOutsourcing__c!=null){
              if(a.OutSouringApprovalStatus__c!='草稿'&&a.OutSouringApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('非常用外购申请已提交了审批不能创建附件');
                  }
              }
          }
          //2019-01-02 发货
          if(a.shipping__c!=null){
              if(a.ShippingApprovalStatus__c!='草稿'&&a.ShippingApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('发货已提交了审批不能创建附件');
                  }
              }
          }
          //2019-01-09 报价管理
            if(a.quatation__c!=null && a.IsLastVersion__c == true){
              if(a.quatationApproveStatus__c!='草稿'&&a.quatationApproveStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                          a.addError('报价已提交了审批不能创建附件');
                  }
              }
          }
          //2109-01-09 合同评审
          if(a.contractReview__c != null){
              if(a.contractrevieApproveStatus__c != '草稿' && a.contractrevieApproveStatus__c != '审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                      a.addError('合同评审已提交审批不能创建附件');
                  }
              }
          }
          //2019-01-10 合同管理
          if(a.contract__c != null && a.contractChange__c == null){
              Contract__c cont = conMap.get(a.contract__c);
              opportunity opp;
              if(cont.opportunity__c!= null){
                  opp=oppMap.get(cont.opportunity__c);
              }
               
              if(a.ContractApproveStatus__c != '草稿' && a.ContractApproveStatus__c  != '审批拒绝' && a.AttachmentCome__c != '合同变更')    {
                 if(a.type__c =='供货范围清单'){
                     if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                         a.addError('合同管理已提交审批不能创建供货范围附件');
                     } 
                 } 
              }
// 非南网，国网不可上传供货范围清单
              if(opp!=null && a.rbase__c == null){
                  if(opp.RecordType.DeveloperName != 'collect'&& opp.RecordType.DeveloperName != 'ChildOpportunity' && a.type__c =='供货范围清单'&& a.AttachmentCome__c == '合同管理'){
                   if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                         a.addError('除集招类项目外不允许上传供货范围清单，请联系CA处理');
                   }                      
                 }
              }                
          }
          //合同变更审批通过之前无法更新合同附件
          if(a.contract__c != null && a.contractChange__c != null && a.ContractChangeStatus__c != '审批通过' ){
                 if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                     a.addError('合同管理已提交审批，合同变更未审批通过，不能创建附件到合同');
                 }                
          }
          //2019-01-10 合同变更
          if(a.contractChange__c != null && a.IsLastVersion__c ==true){
              if(a.ContractChangeStatus__c !='草稿'&&a.ContractChangeStatus__c !='审批拒绝'){
                   if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                      a.addError('合同变更已提交审批不能创建附件');
                  }
              }
          }
          /*
          if(a.type__c=='供货范围清单'){
              if(a.approvalStatus__c=='审批通过'&& a.contractChange__c==null){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('合同审批通过销售经理不能创建附件');
                  }
              }
              if(a.contractChange__c!=null && a.contractChangeApprovalStatus__c=='审批通过'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('合同变更审批通过销售经理不能创建附件');
                  }
              }
          }
          */
      }
      else{
          attachment__c aOld = Trigger.oldMap.get(a.id);
          //2019-01-02 审批中和审批通过后，销售无法修改创建附件
          //2019-01-02 投标评审
          if(a.bidReview__c!=null){
              if(a.BidReviewApprovalStatus__c!='草稿'&&a.BidReviewApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                         a.addError('投标评审已提交了审批不能修改附件');                     
                  }
              }
          }
          //2019-01-02 非常用外购申请
          if(a.notCommonOutsourcing__c!=null){
              if(a.OutSouringApprovalStatus__c!='草稿'&&a.OutSouringApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                          a.addError('非常用外购申请已提交了审批不能修改附件');                   
                  }
              }
          }
          //2019-01-02 发货
          if(a.shipping__c!=null){
              if(a.ShippingApprovalStatus__c!='草稿'&&a.ShippingApprovalStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                          a.addError('发货已提交了审批不能修改附件');
                  }
              }
          }
          //2019-01-09 报价管理
            if(a.quatation__c!=null &&a.contractReview__c == null && a.contract__c == null && a.contractChange__c == null && a.ChangeNum__c == aOld.ChangeNum__c){
              if(a.quatationApproveStatus__c!='草稿'&&a.quatationApproveStatus__c!='审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                          a.addError('报价已提交了审批不能修改附件');
                  }
              }
          }
          //2019-01-09 合同评审
           if(a.contractReview__c != null && a.contract__c == null && a.contractChange__c == null && a.ChangeNum__c == aOld.ChangeNum__c){
              if(a.contractrevieApproveStatus__c != '草稿' && a.contractrevieApproveStatus__c != '审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                       
                          a.addError('合同评审已提交审批不能修改附件');
                         
                  }
              }
          }
          //2019-01-09 合同管理 
            if(a.contract__c != null && a.contractChange__c == null && a.ChangeNum__c == aOld.ChangeNum__c){
              if(a.ContractApproveStatus__c!= '草稿' && a.ContractApproveStatus__c != '审批拒绝' ){
                 if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    if(a.type__c =='供货范围清单'){
                         a.addError('合同管理已提交审批不能修改供货范围附件');
                     }
                 }  
              }                         
          }
          //2019-01-10 合同变更
          if(a.contractChange__c != null && a.ChangeNum__c == aOld.ChangeNum__c){
              if(a.ContractChangeStatus__c  != '草稿' && a.ContractChangeStatus__c  != '审批拒绝'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){                      
                          a.addError('合同变更已提交审批不能修改附件');
                  }
              }
          }        
          /*
          if(a.type__c=='供货范围清单'||aOld.type__c=='供货范围清单'){
              if(a.approvalStatus__c=='审批通过'&& a.contractChange__c==null){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('合同审批通过销售经理不能修改附件');
                  }
              }
              if(a.contractChange__c!=null && a.contractChangeApprovalStatus__c=='审批通过'){
                  if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                      a.addError('合同变更审批通过销售经理不能修改附件');
                  }
              }
          }
          */
      }
    }
    if(!System.Test.isRunningTest())
    {
      conList = conInsertMap.values();
      if(null!=conList && conList.size()!=0)
      {
        update conList;
      }
    }
    
  }
}