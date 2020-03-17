global class PSPushProjectTask {
 global class ProTask{
        webservice String contractNo;
        webservice String taskNumber;
        webservice String projectManagementEngineer;
        webservice String domainUser;
        
        //新增字段。
        webservice String ProjectTaskName;
		webservice String OrderReason;
		webservice String OrderReasonCode;
		webservice String ProjectStatus;
		webservice String ProjectStatusCode;
        webservice String SaleNum;

        
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response DetailProjectTask(List<ProTask> ptojectTasks){
        system.debug('ptojectTasks---'+ptojectTasks.size());
        Response resp = new Response();
        try{
            if(ptojectTasks.size()>0){
                Set<String> contractNoSet = new Set<String>();
                Map<String,ProTask> keyMap = new Map<String,ProTask>();
                for(ProTask task:ptojectTasks){
                    if(task.contractNo!=null&&task.contractNo.trim()!=''){
                        contractNoSet.add(task.contractNo);
                    }else{
                        //返回错误信息，合同号为空
                        resp.flag='失败';
                        resp.message=task+'，合同号为空';
                        logClass.returnLog('失败', '已处理', '【PS推送项目管理任务】PS失败信息:任务'+task+'合同号为空', '正常');
                        return resp;
                    }
                    if(task.taskNumber!=null&&task.taskNumber.trim()!=''){
                        keyMap.put(task.contractNo+task.taskNumber,task);
                    }else{
                        //任务号为空    
                        resp.flag='失败';
                        resp.message=task+'，任务号为空';  
                        logClass.returnLog('失败', '已处理', '【PS推送项目管理任务】PS失败信息:'+task+'任务号为空', '正常');
                        return resp;
                    }
                    
                }
                List<Contract__c> conList =[select id,contractNO__c from Contract__c where contractNO__c in:contractNoSet];
                Map<String,String> conidMap = new Map<String,String>();
                Set<String> existSet = new Set<String>();
                if(conList.size()>0){
                    for(Contract__c con :conList){
                        existSet.add(con.contractNO__c);
                        conidMap.put(con.contractNO__c, con.Id);
                    }
                }else{
                    //根据所给合同号查不到合同
                    resp.flag='成功';
                    resp.message='未处理合同号:'+contractNoSet;
                    logClass.returnLog('成功', '已处理', '【PS推送项目管理任务】未处理合同:'+contractNoSet, '正常');
                    return resp;
                }
                List<ProjectTask__c> taskList =[select SaleNum__c,ProjectTaskName__c,OrderReason__c,OrderReasonCode__c,ProjectStatus__c,ProjectStatusCode__c,id,contract__c,key__c,domainUser__c ,projectManagementEngineer__c from ProjectTask__c where key__c in: keyMap.keySet()];
                Map<String,ProjectTask__c> sospTask = new Map<String,ProjectTask__c>();
                if(taskList.size()>0){
                    for(ProjectTask__c taskObj :taskList){
                        sospTask.put(taskObj.key__c, taskObj);
                    }
                }
                List<ProjectTask__c> insertProList = new List<ProjectTask__c>();
                List<ProjectTask__c> updateProList = new List<ProjectTask__c>();
                //遍历keyMap判断创建还是更新
                for(String key:keyMap.keySet()){
                    //更新
                    if(sospTask.get(key)!=null){
                        ProjectTask__c proTask=sospTask.get(key);
                        //proTask.Name=keyMap.get(key).taskNumber;
                        //proTask.contract__c=keyMap.get(key).taskNumber;
                        //proTask.key__c=key;
                        proTask.domainUser__c=keyMap.get(key).domainUser;
                        proTask.projectManagementEngineer__c=keyMap.get(key).projectManagementEngineer;
                        
						proTask.ProjectTaskName__c = keyMap.get(key).ProjectTaskName;
						proTask.OrderReason__c = keyMap.get(key).OrderReason;
						proTask.OrderReasonCode__c = keyMap.get(key).OrderReasonCode;
						proTask.ProjectStatus__c = keyMap.get(key).ProjectStatus;
						proTask.ProjectStatusCode__c = keyMap.get(key).ProjectStatusCode;
                        proTask.SaleNum__c = keyMap.get(key).SaleNum;

                        updateProList.add(proTask);
                    }else{
                    //新建
                        if(conidMap.get(keyMap.get(key).contractNo)!=null){
                            ProjectTask__c pro =new ProjectTask__c();
                            pro.Name=keyMap.get(key).taskNumber;
                            pro.contract__c=conidMap.get(keyMap.get(key).contractNo);
                            
                            pro.domainUser__c=keyMap.get(key).domainUser;
                            pro.projectManagementEngineer__c=keyMap.get(key).projectManagementEngineer;
                            
                            pro.ProjectTaskName__c = keyMap.get(key).ProjectTaskName;
							pro.OrderReason__c = keyMap.get(key).OrderReason;
							pro.OrderReasonCode__c = keyMap.get(key).OrderReasonCode;
							pro.ProjectStatus__c = keyMap.get(key).ProjectStatus;
							pro.ProjectStatusCode__c = keyMap.get(key).ProjectStatusCode;
							pro.SaleNum__c = keyMap.get(key).SaleNum;

                            insertProList.add(pro);
                        }
                        /*else{
                            resp.flag='失败';
                            resp.message='不存在的合同号，请检查合同号:'+keyMap.get(key).contractNo;  
                            return resp;
                        }*/
                        
                    }
                }
                if(insertProList.size()>0){
                    insert insertProList;
                }
                if(updateProList.size()>0){
                    update updateProList;
                }
                contractNoSet.removeAll(existSet);
                
                resp.flag='成功';
                
                resp.message='成功处理合同:'+existSet+',未处理合同：'+contractNoSet;
                logClass.returnLog('成功', '已处理', '【PS推送项目管理任务】SOSP更新项目管理任务条数:'+updateProList.size()+',创建项目管理任务条数:'+insertProList.size()+'；成功处理合同:'+existSet+',未处理合同:'+contractNoSet, '正常');     
                return resp;
            }else{
                resp.flag='失败';
                resp.message='传输数据为空';
                logClass.returnLog('成功', '已处理', '【PS推送项目管理任务】信息:PS传输数据为空', '正常');
                return resp;
            } 
        }catch(Exception e){
            resp.flag='失败';
            resp.message='失败信息:'+e.getMessage();  
            logClass.returnLog('失败', '未处理', '【PS推送项目管理任务】SOSP信息:'+e.getMessage(), '正常');
            return resp;
        }
          
    }
}