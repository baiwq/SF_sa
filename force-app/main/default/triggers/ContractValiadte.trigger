trigger ContractValiadte on Contract__c (before update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(Contract__c newCC:trigger.new){
         Contract__c oldCC = Trigger.oldMap.get(newCC.id);
         Opportunity opty;
          if(newCC.opportunity__c!=null){
            opty =[Select id,opportunityRecordType__c
               from Opportunity where id=:newCC.opportunity__c];
            if(opty.opportunityRecordType__c!='集招/集采'&&opty.opportunityRecordType__c!='子业务机会'){
             

                if(newCC.account__c!=oldCC.account__c||newCC.amount__c!=oldCC.amount__c||newCC.warrantyPeriod__c!= oldCC.warrantyPeriod__c){
                    if(UserInfo.getProfileId()=='00e28000001wLtoAAE'||UserInfo.getProfileId()=='00e28000001wMIzAAM'||UserInfo.getProfileId()=='00e0I000001wiaQQAQ'||UserInfo.getProfileId()=='00e0I000000f8gjQAA'){
                      newCC.addError('不允许操作合同金额、质保期、客户信息，请联系管理员!');
                    }
                }
            }
          }
         
//校验记录类型的更改情况     
         if(newCC.recordTypeDevelop__c != oldCC.recordTypeDevelop__c){
            if(newCC.recordTypeDevelop__c != 'noContractTransfer'){
               if(oldCC.recordTypeDevelop__c == 'opportunityNoContractApproved'){
                  newCC.addError('有机会无合同(审批通过)记录类型 才能更改至 无合同转有合同 记录类型!');
               }
            }
            //2018-07-09校验紧急事件合同无合同记录类型只能转紧急事件合同转有合同
            if(oldCC.recordTypeDevelop__c == 'UrgentNoContractApproved'){
               if(newCC.recordTypeDevelop__c != 'UrgentConvertContract'){
                  newCC.addError('紧急事件无合同(审批通过) 请选择 紧急事件转有合同 记录类型, 不能选择其他记录类型!');
               }
            }
            //2018-09-11销售经理不能手动修改紧急事件合同
            if(oldCC.recordTypeDevelop__c == 'UrgentNoContract'){
               
                if(UserInfo.getProfileId()=='00e28000001wLtoAAE'||UserInfo.getProfileId()=='00e28000001wMIzAAM'||UserInfo.getProfileId()=='00e0I000001wiaQQAQ'||UserInfo.getProfileId()=='00e0I000000f8gjQAA'){
                    newCC.addError('紧急事件无合同 记录类型, 不能选择其他记录类型!');
                }
        
            }
            if(oldCC.recordTypeDevelop__c == 'opportunityNoContractApproved'){
               if(newCC.recordTypeDevelop__c != 'noContractTransfer'){
                  newCC.addError('无合同转有合同 请选择 无合同转有合同 记录类型, 不能选择其他记录类型!');
               }
            }
         }
//2018-07-09 紧急合同审批时，服务经理是否填写服务费用         
         if(newCC.serviceManagerApproval__c != oldCC.serviceManagerApproval__c && newCC.serviceManagerApproval__c=='是'){
             if(newCC.serviceCharge__c==null){
                 newCC.addError('未设置服务费用价格');
             }
         }
//审批状态变成提交待审批时******          
         if(newCC.approvalStatus__c != oldCC.approvalStatus__c  && newCC.approvalStatus__c == '提交待审批'){
            if(newCC.recordTypeDevelop__c == 'UrgentNoContract'){
                if(newCC.amount__c < newCC.expectedContractAmount__c){
                    newCC.addError('合同金额必须大于或等于预签合同金额，请重新填写合同金额');
                }
            }
//检查电压等级、建设类型
            if(newCC.buildType__c!=null&&newCC.voltageLevel__c!=null){
                      
            }else{
                newCC.addError('电压等级或建设类型信息为空');
            }

//检查合同附件 供货范围清单 附件  
//2019-3-22 新增安全服务合同的判断
            if(newCC.recordTypeDevelop__c != 'RecordType4444'&& newCC.recordTypeDevelop__c != 'FinancialSecurityContract'){
                List<attachment__c> AList = [Select id, Name, type__c, isValid__c from attachment__c where contract__c =:newCC.id  and type__c=:'供货范围清单' and isValid__c = :'有效' and attachmentURL__c != null];
                if(AList.size() < 1){
                   newCC.addError(System.Label.Schedule_GHFW);
                }
            }
             
            //检查合同附件 是否有文件服务器连接
            List<attachment__c> urlList = [select id,attachmentURL__c from attachment__c where contract__c =:newCC.id and isValid__c = :'有效' and attachmentURL__c = null ];
            if(urlList.size()>0){
                newCC.addError('有效的合同附件未全部上传文件');
            }
//检查合同附件 合同文本 附件    
            if(newCC.contractOrNot__c =='有'){
               List<attachment__c> BList = [Select id, Name, type__c, isValid__c from attachment__c where contract__c =:newCC.id and type__c=:'合同文本' and isValid__c = :'有效' and attachmentURL__c != null];
               if(BList.size() < 1){
                  newCC.addError(System.Label.Schedule_Contract);
               }
            }
            
//检查付款条件信息是否满足100%
            if(newCC.X1__c == null || newCC.X2__c == null || newCC.X3__c == null || newCC.X4__c == null || newCC.X5__c == null || newCC.X6__c == null){
               newCC.addError('付款比例阶段缺少阶段!');
            }else if((newCC.X1__c + newCC.X2__c + newCC.X3__c + newCC.X4__c + newCC.X5__c + newCC.X6__c) != 100){
               newCC.addError('付款比例不到100!');
            }
            
//检查是否有业绩分配比例表
            if(newCC.opportunityYesOrNo__c =='有'){
               List<commisionSplit__c> CSList = [Select id from commisionSplit__c where opportunity__c =:newCC.opportunity__c and approvalStatus__c =:'审批通过'];
               if(CSList.size() != 1){  
                  newCC.addError(System.Label.Contract_NoCommisionMember);
               }
            }
         }
             
         
//审批状态变成审批通过时******
         if(newCC.approvalStatus__c != oldCC.approvalStatus__c  && newCC.approvalStatus__c == '审批通过'){
            //2018-07-19 紧急合同审批通过后合同金额=预签合同金额  2018-11-27 紧急合同优化去掉此功能
            /*if(newCC.recordTypeDevelop__c == 'UrgentNoContract'||newCC.recordTypeDevelop__c == 'UrgentNoContractApproved'||newCC.recordTypeDevelop__c == 'UrgentConvertContract'){
                newCC.amount__c = newCC.expectedContractAmount__c;
            }*/
            if(newCC.contractOrNot__c != oldCC.contractOrNot__c && newCC.contractOrNot__c == '有' && newCC.contractReceptDate__c != null){
               newCC.contractReceptDate__c = System.today();
            }
            if(newCC.contractOrNot__c != oldCC.contractOrNot__c && newCC.contractOrNot__c == '有'){
               //检查合同附件 合同文本 附件    
                if(newCC.contractOrNot__c =='有'){
                   List<attachment__c> BList = [Select id, Name, type__c, isValid__c from attachment__c where contract__c =:newCC.id and type__c=:'合同文本' and isValid__c = :'有效' and attachmentURL__c != null];
                   if(BList.size() < 1){
                      newCC.addError(System.Label.Schedule_Contract);
                   }
                }
            }
         }
         
      } 
   }
}