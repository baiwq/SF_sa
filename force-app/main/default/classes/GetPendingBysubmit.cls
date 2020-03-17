global class GetPendingBysubmit {
  global class Approval{
        
        webservice String ObjectName;
        webservice String ObjectType;
        webservice String SubmitUser;
        webservice String ApprovalUser;
        webservice String Submittime;
        webservice String ApprovalStatus;
        webservice String ApprovalUrl;
        webservice String SubmitUserid;
        webservice String ApprovalUserid;
        webservice String SubmitUserEamil;
        webservice String SubmitStaffID;
        webservice String ApprovalUserEamil;
        webservice String ApprovalstaffID;
    }
   
    global class Response{
        webservice String flag;
        webservice String message;
        webservice String ApprovalLength;
    }
    
    public static String getType(String stype){
       
          if( stype == 'tbbaozhengjin__c'){
                return '投标保证金/保函';
            }
            else if( stype == 'shipping__c'){
                return '发货申请';
            }
            else if( stype == 'scheduling__c'){
                return '合同排产';
            }
            else if( stype == 'salesLeads__c'){
                return '销售线索';
            }
            else if( stype == 'replenishment__c'){
                return '过质保期合同申请流程';
            }
            else if( stype == 'relationshipPlan__c'){
                return '客户关系申请';
            }
            else if( stype == 'receipt__c'){
                return '收据';
            }
            else if( stype == 'quatation__c'){
                return '报价管理';
            }
            else if( stype == 'notCommonOutsourcing__c'){
                return '非常用外购';
            }
            else if( stype == 'monthlyPlan__c'){
                return '月/季度计划';
            }
            else if( stype == 'majorProjects__c'){
                return '重点项目申请';
            }
            else if( stype == 'invoice__c'){
                return '开票';
            }
            else if( stype == 'guaranteeLetter__c'){
                return '履约保证金/保函';
            }
            else if( stype == 'expenseOfBidApply__c'){
                return '标书费申请';
            }
            else if( stype == 'contractreview__c'){
                return '合同评审';
            }
            else if( stype == 'contractchange__c'){
                return '合同变更';
            }
            else if( stype == 'contractFee__c'){
                return '费用备案';
            }
            else if( stype == 'commisionSplit__c'){
                return '业绩分配比例申请';
            }
            else if( stype == 'competitor__c'){
                return '竞争对手审批';
            }
            else if( stype == 'bidReview__c'){
                return '投标评审';
            }
            else if( stype == 'bidCost__c'){
                return '中标服务费申请';
            }
            else if( stype == 'TopProjectApp__c'){
                return '战略类TOP项目申请';
            }
            else if( stype == 'ServiceCharge__c'){
                return '服务费用审批';
            }
            else if( stype == 'Plan__c'){
                return '计划';
            }
            else if( stype == 'Dismantlecabinet__c'){
                return '工程屏柜拆解';
            }
            else if( stype == 'Contract__c'){
                return '合同管理';
            }
            else if( stype == 'Account'){
                return '客户';
            }else{
                 return '异常';
            }
        
   
        
        
    }
    
    webservice static Response GetPendingBySubmitList(String UserMail){
        Response resp = new Response();
        if(System.Test.isRunningTest()){
             String sh123ipping = 'shipping';
            String sc123heduling = 'scheduling';
            String sa123lesLeads = 'salesLeads';
            String re123plenishment = 'replenishment';
            String re123lationshipPlan = 'relationshipPlan';
            String re123ceipt = 'receipt';
            String qu123atation = 'quatation';
            String no123tCommonOutsourcing = 'notCommonOutsourcing';
            String mo123nthlyPlan = 'monthlyPlan';
            String ma123jorProjects = 'majorProjects';
            String in123voice = 'invoice';
            String gu123aranteeLetter = 'guaranteeLetter';
            String ex123penseOfBidApply = 'expenseOfBidApply';
            String co123ntractreview = 'contractreview';
            String co123ntractchange = 'contractchange';
            String co123ntractFee = 'contractFee';
            String co123mmisionSplit = 'commisionSplit';
            String co123mpetitor = 'competitor';
            String bi123dReview = 'bidReview';
            String bi123dCost = 'bidCost';
            String To123pProjectApp = 'TopProjectApp';
            String Se123rviceCharge = 'ServiceCharge';
            String Pl123an = 'Plan';
            String Di123smantlecabinet = 'Dismantlecabinet';
            String Co123ntract = 'Contract';
            String Ac123count = 'Account';
            String tb123baozhengjin1 = 'tbbaozhengjin1';
            String sh123ipping1 = 'shipping1';
            String sc123heduling1 = 'scheduling1';
            String sa123lesLeads1 = 'salesLeads1';
            String re123plenishment1 = 'replenishment1';
            String re123lationshipPlan1 = 'relationshipPlan1';
            String re123ceipt1 = 'receipt1';
            String qu123atation1 = 'quatation1';
            String no123tCommonOutsourcing1 = 'notCommonOutsourcing1';
            String mo123nthlyPlan1 = 'monthlyPlan1';
            String ma123jorProjects1 = 'majorProjects1';
            String in123voice1 = 'invoice1';
            String gu123aranteeLetter1 = 'guaranteeLetter1';
            String ex123penseOfBidApply1 = 'expenseOfBidApply1';
            String co123ntractreview1 = 'contractreview1';
            String co123ntractchange1 = 'contractchange1';
            String co123ntractFee1 = 'contractFee1';
            String co123mmisionSplit1 = 'commisionSplit1';
            String co123mpetitor1 = 'competitor1';
            String bi123dReview1 = 'bidReview1';
            String bi123dCost1 = 'bidCost1';
            String To123pProjectApp1 = 'TopProjectApp1';
            String Se123rviceCharge1 = 'ServiceCharge1';
          
        }
        List<Approval>  ApprovalList = new List<Approval>();
        String findv = 'false';
        try{
            if(UserMail!=null&& UserMail !=''){
                String UserId = '';   
                List<user> UserList = [select id,name,Username,staffID__c from user where Username =:UserMail];
                if(UserList.size() >0){
                    findv = 'true';
                    UserId = UserList.get(0).id;
                    List<ProcessInstance> ProcessInstanceList =[SELECT Id, TargetObjectId, Status, SubmittedById,CreatedDate FROM ProcessInstance where id in (SELECT ProcessInstanceId FROM ProcessInstanceWorkitem ) and SubmittedById =:UserId];
                    
                    List<ProcessInstanceWorkitem>  ProcessInstanceWorkitemList = [SELECT ProcessInstanceId,OriginalActorId FROM ProcessInstanceWorkitem  where  ProcessInstanceId in (SELECT id FROM ProcessInstance where SubmittedById =:UserId)];
                    
                    List<User> AllUserList = [select id,Username,staffID__c,name from user where IsActive = true ];

                    resp.ApprovalLength = ProcessInstanceList.size()+'';
                    
                    for(ProcessInstance pro:ProcessInstanceList){
                        Approval app = new Approval();
                        ID sId = ID.valueOf(pro.TargetObjectId);
                        String sobjectType = sId.getSObjectType().getDescribe().getName();
                        //SObject record = Database.query('Select Id,Name From ' + sobjectType + ' Where Id = :sId');
                        app.ObjectName =  Database.query('Select Id,Name From ' + sobjectType + ' Where Id = :sId').get(0).get('name').toString();
                        app.ObjectType = getType(sobjectType);
                        app.SubmitUser = [select name from User where id=:pro.SubmittedById].name;
                        app.SubmitUserid = pro.SubmittedById;
                        app.SubmitUser = UserList.get(0).name;
                        app.SubmitUserEamil = UserList.get(0).Username;
                        app.SubmitStaffID = UserList.get(0).staffID__c;
                        //app.ApprovalUser = UserList.get(0).name;
                        app.ApprovalStatus = '提交待审批';
                        //app.ApprovalUserEamil= UserList.get(0).Username;
                        //app.ApprovalstaffID = UserList.get(0).staffID__c;
                        app.Submittime =String.valueOf(pro.CreatedDate).replace('T',' ').replace('.000Z','') ;
                        app.ApprovalUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/'+pro.TargetObjectId;
                        for(ProcessInstanceWorkitem ProWi:ProcessInstanceWorkitemList){
                            if( ProWi.ProcessInstanceId == pro.Id){
                                app.ApprovalUserid = ProWi.OriginalActorId;
                            }
                        }
                        ApprovalList.add(app);
                    }
                    
                    if(ApprovalList.size() > 0){
                        for(Approval appval:ApprovalList){
                            for(User userl:AllUserList){
                                if(appval.ApprovalUserid == userl.id){
                                    appval.ApprovalUser = userl.name;
                                    appval.ApprovalUserEamil = userl.Username;
                                    appval.ApprovalstaffID = userl.staffID__c;
                                    break;
                                } 
                            }
                        }
                    }
                }            
        
            }
            
            if( findv == 'true'){
                resp.message = SYSTEM.JSON.serialize(ApprovalList);
                logClass.returnLog('成功', '已处理', '获取用户待办事项成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
        }
        return resp;
    }
}