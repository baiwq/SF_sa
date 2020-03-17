trigger ContractUpdateUser on Contract__c (before insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(Contract__c newCC:trigger.new){
          if(Trigger.isInsert){
              
              User createdby = [Select id,center__c,department__c,Province__c from User where id=:UserInfo.getUserId()];
			  if( createdby.center__c != '国际业务'){
                  newCC.salesCenter__c = createdby.center__c;
                  //销售大区  SalesDepartment__c
                  newCC.salesDepartment__c = createdby.department__c;
                  //销售省区  SalesProvince__c
                  newCC.salesProvince__c = createdby.Province__c;
              } 
          }
          if(Trigger.isUpdate){
              Contract__c oldCC = Trigger.oldMap.get(newCC.id);
              if(newCC.approvalStatus__c == '审批通过'&& newCC.approvalStatus__c != oldCC.approvalStatus__c ){
                  if(newCC.ownerDepartment__c != '四方三伊销售部'){ 
                      // if(newCC.RecordTypeName__c=='紧急事件无合同'||newCC.RecordTypeName__c=='紧急事件无合同(审批通过)'||newCC.RecordTypeName__c=='紧急事件转有合同'){
                      if((newCC.salesTeamDepartment__c == null ||newCC.salesTeamDepartment__c == '无' )&& newCC.accountManager__c != null){
                          User  accountManager_user = [select id,Province__c,department__c  from User where id=:newCC.accountManager__c];
                          newCC.salesTeamProvince__c = accountManager_user.Province__c;
                          newCC.salesTeamDepartment__c  = accountManager_user.department__c;
                      }
                      if((newCC.signTeamDepartment__c == null ||newCC.signTeamDepartment__c == '无')&&newCC.signedBy__c != null){
                          
                          User  signedBy_user = [select id,Province__c,department__c  from User where id=:newCC.signedBy__c];
                          newCC.signTeamProvince__c = signedBy_user.Province__c;
                          newCC.signTeamDepartment__c  = signedBy_user.department__c;
                      }
                      
                      if((newCC.deliveryTeamDepartment__c == null ||newCC.deliveryTeamDepartment__c == '无')&&newCC.deliveryPerson__c !=null){
                          
                          User  deliveryPerson_user = [select id,Province__c,department__c  from User where id=:newCC.deliveryPerson__c];
                          newCC.deliveryTeamDepartment__c = deliveryPerson_user.department__c;
                          newCC.deliveryTeamProvince__c  = deliveryPerson_user.Province__c;
                          // }
                      }                     
                  }
                
              }
              if(newCC.ownerDepartment__c != '四方三伊销售部'){ 

                  //前后人员改变
                  if((newCC.accountManager__c != oldCC.accountManager__c) ||  (newCC.salesTeamProvince__c != oldCC.salesTeamProvince__c)){
                      User  accountManagerChange = [select id,Province__c,department__c  from User where id=:newCC.accountManager__c];
                      newCC.salesTeamProvince__c = accountManagerChange.Province__c;
                      newCC.salesTeamDepartment__c  = accountManagerChange.department__c;
                      
                  }
                  
                  //前后人员改变
                  if((newCC.signedBy__c != oldCC.signedBy__c) || (newCC.signTeamProvince__c != oldCC.signTeamProvince__c)){
                      User  signedByChange = [select id,Province__c,department__c  from User where id=:newCC.signedBy__c];
                      newCC.signTeamProvince__c = signedByChange.Province__c;
                      newCC.signTeamDepartment__c  = signedByChange.department__c;
                  }
                  
                  //前后人员改变
                  if((newCC.deliveryPerson__c != oldCC.deliveryPerson__c)  || (newCC.deliveryTeamProvince__c != oldCC.deliveryTeamProvince__c)){
                      User  deliveryPersonchange = [select id,Province__c,department__c  from User where id=:newCC.deliveryPerson__c];
                       newCC.deliveryTeamDepartment__c = deliveryPersonchange.department__c;
                       newCC.deliveryTeamProvince__c  = deliveryPersonchange.Province__c;
                  }
              }
          }      
      }
   }
}