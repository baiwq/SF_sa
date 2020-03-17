public class GetApproveJson{
    public class step{ //审批步骤      
        public String needToDo;
        public String actualDo;
        public String doDate;
        public String status;
        public String comments;
    }
    public class instance{ //审批提交人 
        public String createPeo;
        public List<step> stepList; //审批步骤List
    }
    public String getApproveString(ID changeId){//根据合同变更记录Id查询审批流信息
        ProcessInstance p = [select id,CreatedById from ProcessInstance where TargetObjectId =:changeId and Status ='Approved'];
        User u = [select name from User where id =:p.CreatedById];//得到审批提交人姓名
        List<ProcessInstanceStep> pisList = [select OriginalActorId,ActorId,Comments,StepStatus,CreatedDate from ProcessInstanceStep where ProcessInstanceId =:p.id order by CreatedDate ASC];//得到审批步骤List
        
        instance ins = new instance();
        ins.createPeo = u.name;
        
        List<step> sList = new List<step>();
        
        
        for(ProcessInstanceStep pis:pisList){
            step st = new step();
            st.needToDo = [select name from User where id=:pis.OriginalActorId].name;
            st.actualDo = [select name from User where id=:pis.ActorId].name;
            st.doDate = String.valueOf(pis.CreatedDate).replace('T',' ').replace('.000Z','') ;
            st.status = getValue(pis.StepStatus);
            st.comments = pis.Comments;
            sList.add(st);
        }
        ins.stepList = new List<step>(sList);

        
        //m.put(ins.createPeo,ins.stepList);
        System.debug('ins————————>   '+ ins);
        
       
        
        String finalValue =  JSON.serialize(ins);
        System.debug('finalValue ————————>   '+ finalValue );
     
        return finalValue ;
        
        
    }
    public String getValue(String s){
        if(s == 'Approved'){
            return '已批准';
        }else if( s == 'Started'){
            return '已提交';
        }else{
            return '已拒绝';
        }
        
    }

    
}