global class GetApprovalUser {
  global class Approval{
            
        webservice String ApprovalUser;
        webservice String ApprovalUserEamil;
        webservice String ApprovalstaffID;
    }
   
    global class Response{
        webservice String flag;
        webservice String message;
        webservice String ApprovalLength;
    }
    
    webservice static Response GetPendingUserList(){
        Response resp = new Response();
           
        List<Approval>  ApprovalList = new List<Approval>();
        String findv = 'false';
        try{
           
                    findv = 'true';
                    List<AggregateResult>  ProcessInstanceWorkitemList =  [SELECT OriginalActorId  FROM ProcessInstanceWorkitem group by OriginalActorId];
                    //AggregateResult
            		List<User> UserList = [select id,Username,staffID__c,name from user where IsActive = true ];
            		Approval app = null;
                    for(AggregateResult PWorkItem:ProcessInstanceWorkitemList){
                        app = new Approval();
                        for(User userl:UserList){
                            if(PWorkItem.get('OriginalActorId') == userl.id){
                                app.ApprovalUser = userl.name;
                                app.ApprovalUserEamil = userl.Username;
                                app.ApprovalstaffID = userl.staffID__c;
                                break;
                            }
                        }
                        ApprovalList.add(app);
                    }
                   
           			System.debug(SYSTEM.JSON.serialize(ApprovalList));
                    resp.message = SYSTEM.JSON.serialize(ApprovalList);
                    //logClass.returnLog('成功', '已处理', '获取用户待办事项成功', '正常');
                    resp.flag='Y';
          
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
        }
        return resp;
    }
}