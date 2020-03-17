/***
* 标书费用审批提交审批控制器
* 创建人：杨明
* 创建时间：2018-12-28
* sf-auto-tranzvision
***/

global class ApproveExpenseOfBidApplyCtrl{
  public string comts{get;set;}
  public boolean showButton{get;set;}
  public ID recordId;
  public ID submitId;
     public ApproveExpenseOfBidApplyCtrl(){
       recordId = ApexPages.currentPage().getParameters().get('id');
       submitId = UserInfo.getUserId();
    }
    
//保存按钮
    public PageReference confirm(){      
        try{
            expenseOfBidApply__c asd = [select id,ApproveComponent__c from expenseOfBidApply__c where id=:recordId];
            asd.ApproveComponent__c = '22222';
            update asd;
            
            
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();  
                        req1.setObjectId(recordId);// 当前记录ID
                        req1.setComments(comts);
                        //User u = [select id,center__c from User where id=:m.ownerId];
                        req1.setSubmitterId(submitId);// 初始提交人ID                             
                        req1.setSkipEntryCriteria(false);// 是否跳过标准   
                        Approval.ProcessResult result = Approval.process(req1); //提交审批
              ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, '已成功提交审批!'));
              return new PageReference('/' + recordId);
        }catch(Exception e){ 
              expenseOfBidApply__c asd1 = [select id,ApproveComponent__c from expenseOfBidApply__c where id=:recordId];
              asd1.ApproveComponent__c = '';
              update asd1;
              ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, '此记录不满足任何有效批准过程的项目条件或初始提交'));                          
              return null;
            
        }
    }
}