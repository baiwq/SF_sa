/***
* 合同管理审批提交审批控制器
* 创建人：杨明
* 创建时间：2018-12-27
* sf-auto-tranzvision
***/

global class ApproveContractCtrl{
  public string comts{get;set;}
  public boolean showButton{get;set;}
  public ID recordId;
  public ID submitId;
     public ApproveContractCtrl(){
       recordId = ApexPages.currentPage().getParameters().get('id');
       submitId = UserInfo.getUserId();
    }
    
//保存按钮
    public PageReference confirm(){      
        try{
                Contract__c asd = [select id,ApproveComponent__c,Submitcpq__c,StartId__c,isfindSupply__c,ownerCenter__c,ownerDepartment__c,updateghfw__c,sfscghfw__c,reviewName__c,Name,NewprojectType__c
 from Contract__c where id=:recordId];
                asd.ApproveComponent__c = '22222';
            	 if(asd.StartId__c == '是'&&asd.isfindSupply__c == '是'){
					 if(asd.ownerCenter__c == '销售中心'&& asd.ownerDepartment__c != '感应加热业务' ){
                         if(asd.updateghfw__c == null && asd.sfscghfw__c != '是'){
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, '还未从CPQ获取供货范围清单，不能提交审批！'));                          
                 			 return null;
                         }else{	
                             String CPQreturn_msg = 'fail';  
                             if(system.Test.isRunningTest()){
                                 CPQreturn_msg ='success';
                             }else{
                                 if(asd.Submitcpq__c == '成功'){
                                    CPQreturn_msg ='success';
                                 }else{ 
                                 	CPQreturn_msg = WebContractToCPQ.getSubmitinfo(asd.id, asd.reviewName__c, asd.Name,asd.NewprojectType__c);
                                 }
                             }
                             if(CPQreturn_msg!= 'success'){
                                 ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'CPQ返回失败，原因：'+CPQreturn_msg));                          
                                 return null;
                             }else{
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
                             }
                         }
                     }else{
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
                     }  
                }else{
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
                }
        }catch(Exception e){ 
              Contract__c asd1 = [select id,ApproveComponent__c from Contract__c where id=:recordId];
              asd1.ApproveComponent__c = '';
              update asd1;
              ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, '此记录不满足任何有效批准过程的项目条件或初始提交'));                          
              return null;
            
        }
    }
}