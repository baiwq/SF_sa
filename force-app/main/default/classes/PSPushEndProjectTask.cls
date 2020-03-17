global class PSPushEndProjectTask {
   global class ProjectTask{
        webservice String ProjectEndTime;
        webservice String taskNumber;
        webservice String ProjectStatus;
        webservice String ProjectStatusCode;
        webservice String contractNo;
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response pushEndProjectTask(List<ProjectTask> ptojectTasks){

        Response resp = new Response();
        try{
            if(ptojectTasks.size()>0){
                Map<String,ProjectTask> keyMap = new Map<String,ProjectTask>();
                for(ProjectTask task:ptojectTasks){ 
                    if(task.taskNumber!=null&&task.taskNumber.trim()!=''){
                        keyMap.put(task.contractNo.trim()+task.taskNumber,task);
                    }else{
                        //任务号为空    
                        resp.flag='失败';
                        resp.message=task+'，任务号为空';  
                        logClass.returnLog('失败', '已处理', '【PS推送项目管理任务结束日期】PS失败信息:'+task+'任务号为空', '正常');
                        return resp;
                    }
                    
                }
               
                List<ProjectTask__c> taskList =[select id,Name,ProjectEndTime__c,ProjectStatusCode__c,ProjectStatus__c,key__c  from ProjectTask__c where key__c in: keyMap.keySet()];
                Map<String,ProjectTask__c> sospTask = new Map<String,ProjectTask__c>();
                if(taskList.size()>0){
                    for(ProjectTask__c taskObj :taskList){
                        sospTask.put(taskObj.key__c, taskObj);
                    }

                }
                List<ProjectTask__c> updateProList = new List<ProjectTask__c>();
                //遍历keyMap判断创建还是更新
                for(String key:keyMap.keySet()){                    
                    //更新
                    if(sospTask.get(key)!=null){
                        ProjectTask__c proTask=sospTask.get(key);    
                      	if(keyMap.get(key).ProjectEndTime != null && !keyMap.get(key).ProjectEndTime.trim().equals('')){
                            proTask.ProjectEndTime__c = date.valueOf(keyMap.get(key).ProjectEndTime.substring(0, 10));
                        }
                        proTask.ProjectStatus__c = keyMap.get(key).ProjectStatus;
                        proTask.ProjectStatusCode__c = keyMap.get(key).ProjectStatusCode;
                        updateProList.add(proTask);
                    }
                }
              
                if(updateProList.size()>0){
                    update updateProList;
                }                
                resp.flag='成功';
                
                resp.message='成功';
                logClass.returnLog('成功', '已处理', '【PS推送项目管理任务结束日期】SOSP更新项目管理任务条数:'+updateProList.size()+';', '正常');     
                return resp;
            }else{
                resp.flag='失败';
                resp.message='传输数据为空';
                logClass.returnLog('成功', '已处理', '【PS推送项目管理任务结束日期】信息:PS传输数据为空', '正常');
                return resp;
            } 
        }catch(Exception e){
            resp.flag='失败';
            resp.message='失败信息:'+e.getMessage();  
            logClass.returnLog('失败', '未处理', '【PS推送项目管理任务结束日期】SOSP信息:'+e.getMessage(), '正常');
            return resp;
        }
          
    }
}