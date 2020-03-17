trigger ProjectTaskEndDay on ProjectTask__c (after update) { 
if(trigger.new.size()>100){
     return;
  }else{
    for(ProjectTask__c newCC:trigger.new){        
        ProjectTask__c oldCC = Trigger.oldMap.get(newCC.id);
       
          if((newCC.ProjectEndTime__c != oldCC.ProjectEndTime__c ) || (newCC.ProjectStatusCode__c != oldCC.ProjectStatusCode__c )  ){
              if(newCC.OrderReason__c == null && newCC.OrderReasonCode__c == null){
                List<ProjectTask__c> pjList = [select id from ProjectTask__c where OrderReason__c = null and OrderReasonCode__c = null and ProjectEndTime__c = null and ProjectStatusCode__c != '41' and contract__c =:newCC.contract__c];                
                if(pjList.size() == 0){
                    AggregateResult ProjectEndTime = [select max(ProjectEndTime__c) ProjectEndTime from ProjectTask__c where OrderReason__c = null and OrderReasonCode__c = null and ProjectStatusCode__c != '41' and ProjectEndTime__c != null and contract__c =:newCC.contract__c];      
                    if(ProjectEndTime.get('ProjectEndTime')!= null){
                        Contract__c  Contract = [select ServiceCompletionDate__c,EquipmentCompletionDate__c  from Contract__c where id = :newCC.contract__c];
                        Contract.EquipmentCompletionDate__c = Date.valueOf(ProjectEndTime.get('ProjectEndTime'));
                        update Contract;
                    }
                }     
            }
            if(newCC.OrderReasonCode__c == '3'){
                List<ProjectTask__c> pjList1 = [select id from ProjectTask__c where OrderReasonCode__c = '3' and ProjectEndTime__c = null and ProjectStatusCode__c != '41'  and contract__c =:newCC.contract__c];
                if(pjList1.size() == 0){
                    AggregateResult ProjectEndTime1 = [select max(ProjectEndTime__c) ProjectEndTime from ProjectTask__c where OrderReasonCode__c = '3' and ProjectStatusCode__c != '41' and ProjectEndTime__c != null and contract__c =:newCC.contract__c];      
                    if(ProjectEndTime1.get('ProjectEndTime')!= null){
                        Contract__c  Contract = [select ServiceCompletionDate__c,EquipmentCompletionDate__c  from Contract__c where id = :newCC.contract__c];
                        Contract.ServiceCompletionDate__c = Date.valueOf(ProjectEndTime1.get('ProjectEndTime'));
                        update Contract; 
                    }
                   
                }
            }
        }
    }
  }
}