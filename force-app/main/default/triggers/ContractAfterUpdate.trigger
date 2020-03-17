trigger ContractAfterUpdate on Contract__c (after update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(Contract__c newCC:trigger.new){
         
         FuncPools FP = new FuncPools();
//编辑时自动改变分享情况
         Contract__c oldCC = Trigger.oldMap.get(newCC.id);
         //2018-09-06 任艳新 勾选“是否有项目成本费用”，邮件通知赵佳宏经理
         if(newCC.approvalStatus__c!=oldCC.approvalStatus__c&&newCC.approvalStatus__c=='提交待审批'){ 
            if(newCC.IsProjectCost__c){
                EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ProjectCost' limit 1];
                List<String> emailList = new List<String>();
                
                emailList.add('ningbin@sf-auto.com');
                EmailToolClass.sendEmail(emailList,newCC.OwnerId,newCC.Id,template.Id);
            } 
         }
         
//如果编辑了合同签订人 signedby__c 分享给这个人
         if(newCC.signedby__c != oldCC.signedby__c && newCC.signedby__c != null){
            insert new Contract__share(RowCause = Schema.Contract__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = newCC.signedby__c, ParentId = newCC.id);
            List<Contract__share>  ccsList = [select id from Contract__share where UserOrGroupId =:oldCC.signedby__c and ParentId = :newCC.id];
            if(oldCC.signedby__c != newCC.OwnerId){
               delete ccsList;
            }
         }
         
//如果编辑了销售项目主责人 accountManager__c 分享给这个人
         if(newCC.accountManager__c != oldCC.accountManager__c && newCC.accountManager__c != null){
            insert new Contract__share(RowCause = Schema.Contract__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = newCC.accountManager__c, ParentId = newCC.id);
            List<Contract__share>  ccsList = [select id from Contract__share where UserOrGroupId =:oldCC.accountManager__c and ParentId = :newCC.id];
            if(oldCC.accountManager__c != newCC.OwnerId){
               delete ccsList;
            }
         }


//如果编辑了所有人，自动分享给创建人
         if(newCC.OwnerId != oldCC.OwnerId && oldCC.OwnerId == oldCC.CreatedById){
            insert new Contract__share(RowCause = Schema.Contract__share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = newCC.createdById, ParentId = newCC.id);   
         }
     

        //如果编辑了履约执行人 deliveryPerson__c 分享给这个人
         if(newCC.deliveryPerson__c != oldCC.deliveryPerson__c && newCC.deliveryPerson__c != null){
            insert new Contract__share(RowCause = Schema.Contract__share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = newCC.deliveryPerson__c, ParentId = newCC.id);
            List<Contract__share>  ccsList = [select id from Contract__share where UserOrGroupId =:oldCC.deliveryPerson__c and ParentId = :newCC.id];
            if(oldCC.deliveryPerson__c != newCC.OwnerId){
               delete ccsList;
            }
         }
     
//如果合同填写了合同接收日期
         if(newCC.contractReceptDate__c != null && newCC.contractReceptDate__c != oldCC.contractReceptDate__c){   
            //合同接收发送邮件
           
            EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ContractReceptDateChanged' limit 1];
            if(newCC.salesTeamDepartment__c =='感应加热业务'){
                 EmailToProject.exe_sendEmail('合同接收日期变化', newCC.contractNO__c, newCC.accountManager__c, newCC.Id, template.Id,'wangyongli_sy@sf-auto.com',null); 
            }else{
                 EmailToProject.exe_sendEmail('合同接收日期变化', newCC.contractNO__c, newCC.accountManager__c, newCC.Id, template.Id,'shm@sf-auto.com',null); 
            } 
                
         
            if(newCC.opportunityYesOrNo__c =='有'){
               List<commisionSplit__c> CSList = [Select id from commisionSplit__c where opportunity__c =:newCC.opportunity__c and approvalStatus__c =:'审批通过'];
               if(newCC.performanceOrNot__c == true){
                  List<AchivementRecognization__c> ARList = new List<AchivementRecognization__c>();
                  try{
                     List<commisionUser__c> CUList = [Select id, member__c, performanceProportion__c from commisionUser__c where commisionSplit__c = :CSList[0].id and performanceProportion__c>0];
                     if(CUList.size() > 0){
                         for(commisionUser__c CU:CUList){
                            ARList.add(new AchivementRecognization__c(
                            achivementOwner__c = CU.member__c,
                            performanceProportion__c = CU.performanceProportion__c,
                            contract__c = newCC.id,
                            ARMember__c = CU.id,
                            date__c = newCC.contractReceptDate__c)); 
                         }
                         insert ARList;
                      }
                   }catch(Exception e){
                       newCC.addError('此合同无业绩确认表');
                   }
               }else{
                  System.debug('没有找到业绩分配比例成员!');
               }
            }else{
               System.debug('无机会!');
               if(newCC.performanceOrNot__c == true&&newCC.recordTypeDevelop__c=='UrgentConvertContract'){
                  List<AchivementRecognization__c> ARList = new List<AchivementRecognization__c>();
                  ARList.add(new AchivementRecognization__c(
                            achivementOwner__c = newCC.accountManager__c ,
                            performanceProportion__c = 100,
                            contract__c = newCC.id,
                            date__c = newCC.contractReceptDate__c));
                  insert ARList; 
               }else{
                  System.debug('没有计入销售业绩');
               }
            }
         }

         
//如果合同修改了合同金额，任艳新2018-09-06修改有效业绩金额变化
         if(newCC.ValidPerformance__c != oldCC.ValidPerformance__c && newCC.ValidPerformance__c != null){
            List<AchivementRecognization__c> ARList = [Select id from AchivementRecognization__c where contract__c = :newCC.id];
            if(ARList.size() > 0){
               update ARList;  //为了触发写在业绩确认表上的触发器
            }else{
               System.Debug('暂时还没有合同完成情况，修改金额不涉及!');
            }
         }
         //获取销售组织编码
         List<Contract__c> ccList= new List<Contract__c>();
         if((newCC.salesOrgName__c!=oldCC.salesOrgName__c)||(newCC.approvalPsDate__c != oldCC.approvalPsDate__c)||
         (newCC.approvalStatus__c != oldCC.approvalStatus__c)||(newCC.updateCode__c != oldCC.updateCode__c)){
             Contract__c cclone =newCC.clone(true,true);
             Map<String,Map<String,String>> CodeList = new Map<String,Map<String,String>>();
             CodeList = new Map<String,Map<String,String>>(FP.getCodeValues('合同管理'));
             
             try{  
                 cclone.salesOrgNameCode__c=CodeList.get('销售组织').get(newCC.salesOrgName__c);
                 ccList.add(cclone);
                 System.Debug('CodeList.get().get(newCC.salesOrgName__c)'+CodeList.get('销售组织').get(newCC.salesOrgName__c));
             }catch(Exception e){
                 System.Debug('没有得到 销售组织 的字段编码');
             }
         }
         if(ccList.size()>0){
             update ccList;
         }
         
//如果修改了回款金额及合同金额,重新修改付款阶段对应情况    
         if((newCC.returnAmountAll__c != oldCC.returnAmountAll__c)||(newCC.returnHistory__c != oldCC.returnHistory__c)||(newCC.amount__c != oldCC.amount__c)){
            if(!System.Test.isRunningTest()){
             	FP.SyncPayment(newCC.id,newCC.returnAmount__c);
            }
         }
         
//如果修改了质保期,重新计算付款阶段对应质保期 
         if(newCC.warrantyPeriod__c != oldCC.warrantyPeriod__c){
            List<Contract__c> CW = [Select id, Name from Contract__c where id = :newCC.id];
            new cal_warranty_Date().updateWarrantyStageDate(CW);  
         }
         
//如果修改了所属客户,重新推送客户给SAP         
         if(newCC.approvalStatus__c == '审批通过' && newCC.account__c != oldCC.account__c && newCC.subCompanyCode__c != null && newCC.salesOrgNameCode__c != null){
            SoapSendAccountToSap.soapSendAccountToSap('合同阶段修改客户',newCC.account__c,'C', newCC.subCompanyCode__c, newCC.salesOrgNameCode__c);
         }         
         
//合同审批通过,推送客户给SAP         
         if(newCC.approvalStatus__c != oldCC.approvalStatus__c && newCC.approvalStatus__c == '审批通过' && newCC.oldContractNumber__c == null ){
            SoapSendAccountToSap.soapSendAccountToSap('合同审批通过',newCC.account__c,'C', newCC.subCompanyCode__c, newCC.salesOrgNameCode__c);
         } 
      }
   }   
}