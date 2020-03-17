/*
    功能：重点工程项目审批通过更新合同字段
    创建人：霍东飞
*/
trigger MajorProjectsUpdateContract on majorProjects__c (before update) {
    for(majorProjects__c m:Trigger.new){
        majorProjects__c oldm = Trigger.oldmap.get(m.id);
        if(m.contractreview__c != null){
            contractreview__c cv = [select id,approvalStatus__c  from contractreview__c where id=:m.contractreview__c limit 1];
            cv.majorProjectApprovalStatus__c = m.Field1__c;
            cv.majorProjectApprovedTime__c = m.Approvaltime__c;
            if(m.Field1__c == '审批通过' &&  m.Field1__c != oldm.Field1__c ){      
                //最后审批通过时，项目经理字段不能为空
                if(m.PM__c == null){  
                    m.addError('请填写项目经理。');
                }   
                //此时找到合同评审，然后找到合同管理 更新合同          
                cv.PM__c = m.PM__c;           
                if(cv.approvalStatus__c == '审批通过'){
                    List<contract__c> ccList = [select id,MP__c,MPnumber__c from contract__c where reviewNumber__c =:cv.id];
                    if(ccList.size()>0){          
                        for(contract__c cc:ccList){
                            cc.MPnumber__c = m.id;
                            cc.MP__c = true;   
                        }
                        update ccList;
                    }
                }
            }
            update cv;   
        }     
    }
}