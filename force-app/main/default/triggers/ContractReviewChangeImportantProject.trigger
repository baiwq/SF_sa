/*
    功能：合同评审创建/编辑/提交审批 重点工程项目随之变化
    创建人：霍东飞
*/
trigger ContractReviewChangeImportantProject  on contractreview__c (after insert,after update) {
    
    if(Trigger.isInsert){
        for(contractreview__c cv:Trigger.new){
            
            if(cv.applyImportantProject__c == '是'){
                majorProjects__c mp = new majorProjects__c(contractreview__c =cv.id,Projecttype__c=cv.projectType__c,projectcontext__c=cv.projectContext__c);
                insert mp;
            }
        }
    }
    if(Trigger.isUpdate){
        try{
        for(contractreview__c cv:Trigger.new){
            contractreview__c oldcv = Trigger.oldMap.get(cv.id);
            system.debug('aaa-'+cv.contractProjectGrossProfitMargin__c);
            system.debug('aaa-'+oldcv.contractProjectGrossProfitMargin__c);
            //任艳新 2018-09-05 财务及外购成本邮件提醒李鹏、史耀兆
            if(cv.approvalStatus__c=='草稿'||cv.approvalStatus__c=='审批拒绝'){
                if(cv.contractAmount__c>=3000000&&cv.contractProjectGrossProfitMarginFormula__c <15){
                    if(cv.contractProjectGrossProfitMarginFormula__c!=oldcv.contractProjectGrossProfitMarginFormula__c ||cv.contractAmount__c!=oldcv.contractAmount__c){
                        System.debug(123);
                        EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'FinanceAndOutsourcingCost' limit 1];
                        List<String> emailList = new List<String>();
                        emailList.add(cv.FinanceCostEmail__c);
                        emailList.add(cv.OutsourcingCostSEmail__c);
                        EmailToolClass.sendEmail(emailList,cv.OwnerId,cv.Id,template.Id);
                    }
                    
                }
            }
            //任艳新 2018-12-03 合同评审审批通过通知评审人员
        //if(cv.approvalStatus__c=='审批通过'&&cv.approvalStatus__c!=oldcv.approvalStatus__c&&cv.contractAmount__c>=500000&&cv.ownerCenter__c=='销售中心'){
//              EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'SendEmailToSalesCA' limit 1];
//              List<String> emailList = new List<String>();
//              List<User> userList = [Select id,LastName,Email from User where LastName=:cv.reviewer__c];
//              emailList.add(userList[0].Email);
//              EmailToolClass.sendEmail(emailList,cv.OwnerId,cv.Id,template.Id);
//          }
            if(cv.ownerId != oldcv.ownerId){
                List<majorProjects__c> mpList = [select id,ownerId from majorProjects__c where contractreview__c =:cv.id];
                if(mpList.size()>0){
                    mpList[0].ownerId = cv.ownerId;
                }
                update mpList;
            }
            if(cv.applyImportantProject__c ==  '是' && (oldcv.applyImportantProject__c ==  '否' || oldcv.applyImportantProject__c == null)  && cv.approvalStatus__c == '草稿'){ //创建后 编辑时勾选上 才创建重点工程。
                List<majorProjects__c> mpList = [select id from majorProjects__c where contractreview__c =:cv.id];
                if(mpList.size()==0){
                    majorProjects__c mp = new majorProjects__c(contractreview__c =cv.id,Projecttype__c=cv.projectType__c,projectcontext__c=cv.projectContext__c);
                    insert mp;
                }               
            }
            if((cv.applyImportantProject__c ==  '否' || cv.applyImportantProject__c == null) && oldcv.applyImportantProject__c == '是' && cv.approvalStatus__c == '草稿'){ // 创建后  若新的审批状态为草稿  才删除。
                List<majorProjects__c> aList = [select id from majorProjects__c where contractreview__c =:cv.id and Field1__c = '草稿'];
                if(aList.size()>0){
                    delete aList;
                }
            }
            if(cv.approvalStatus__c =='提交待审批' && cv.approvalStatus__c != oldcv.approvalStatus__c){
                List<majorProjects__c> mList = [select id,ownerId from majorProjects__c where contractreview__c =:cv.id and (Field1__c = '草稿' or Field1__c ='审批拒绝')];
                if(mList.size()>0){
                    for(majorProjects__c m:mList){
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();  
                        req1.setObjectId(m.id);// 当前记录ID
                        User u = [select id,center__c from User where id=:m.ownerId];
                        req1.setSubmitterId(u.id);// 初始提交人ID
                        if(u.center__c == '销售中心'){
                            req1.setProcessDefinitionNameOrId('ApprovalProcessXSZX');
                        }else if(u.center__c == '工业及公共业务'){
                            req1.setProcessDefinitionNameOrId('ApprovalProcessGG');
                        }                               
                        req1.setSkipEntryCriteria(true);// 是否跳过标准   
                        Approval.ProcessResult result = Approval.process(req1); //提交审批
                        update mList;
                    }
                }
            }         
        }
        }catch(exception e){
            System.debug('系统未知错误，请联系管理员');
        }
    }       
}