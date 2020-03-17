trigger GetContractProjectManagePeople on contractchange__c (before insert,before update) {
    for(contractchange__c c:Trigger.new){
         if(c.approvalStatus__c=='提交待审批' && c.ownerDepartment__c!='感应加热业务'){
           if(c.recordType__c == '供货范围变更' || c.recordType__c == '合同取消'|| c.recordType__c == '合同合并' || c.recordType__c  =='合同金额变更'){
                if(c.ProjectManageHoner__c == null){
                    list<ProjectTask__c> contract =[select email__c from ProjectTask__c where contract__c =:c.contract__c];
                    if(contract.size()>0){
                        List<User> projectManageName = [select id from User where Email = :contract[0].email__c];
                        if(projectManageName.size()>0){
                            c.ProjectManageHoner__c = projectManageName[0].id;
                        }
                        else{
                             c.ProjectManageHoner__c = '00528000006IbTW';
                        }
                    }
                    else{
                       c.ProjectManageHoner__c = '00528000006IbTW';
                    }
        
                }
                 
         
         }
      
          
      }
    }
}