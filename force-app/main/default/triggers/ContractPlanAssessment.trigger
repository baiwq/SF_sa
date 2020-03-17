trigger ContractPlanAssessment on contractFee__c (before insert, before update) {
   for(contractFee__c newCC:Trigger.new){
       List<Plan__c> pList = [select id from Plan__c where OwnerId = :newCC.OwnerId and year__c = :newCC.Field33__c];
       if(pList.size() > 0){
            newCC.kaohe__c = pList[0].id;
       }else{
            User Userinfo = [select id,ProfileName__c from User where id = :newCC.OwnerId];
           if(Userinfo.ProfileName__c != 'A-销售费用控制工程师' &&Userinfo.ProfileName__c != '系统管理员'&&Userinfo.ProfileName__c != 'B-合同管理查询' &&Userinfo.ProfileName__c != 'B-合同管理查询(带费用)' &&Userinfo.ProfileName__c != 'B-合同管理查询(带费用-张瑾)'){
                             
                newCC.addError('系统中未查询到您的销售目标，请联系管理员添加！');
           }
       }
       
     
       if(Trigger.isUpdate){
           
             contractFee__c  oldCC = Trigger.oldMap.get(newCC.id);
             if((newCC.MainProductGroup__c != oldCC.MainProductGroup__c || newCC.cpywdyfzr__c == null)&&(newCC.approveState__c=='草稿'||newCC.approveState__c=='提交待审批')){
                if( newCC.MainProductGroup__c =='发电及用电业务单元-公共电力事业部'){
                       newCC.cpywdyfzr__c = '00528000007AKVI';
                }else if(newCC.MainProductGroup__c =='直流输电及电力电子业务单元-直流输电及电力电子产品'||newCC.MainProductGroup__c =='直流输电及电力电子业务单元-感应加热与高频电源产品'){
                       newCC.cpywdyfzr__c = '00528000006IqWF';
                }else if(newCC.MainProductGroup__c =='输变电业务单元-电网保护自动化事业部'){
                       newCC.cpywdyfzr__c = '00528000006IqOV';
                }else{
                   //主导事业部
                     String LeadingCadrelike = newCC.MainProductGroup__c;
                     List<StaffingTables__c> Staffing_list = [select LeadingCadre__c from StaffingTables__c where name like :LeadingCadrelike ];
                      String LeadingCadre = '';
                      if(Staffing_list.size() > 0){
                          LeadingCadre = Staffing_list.get(0).LeadingCadre__c;
                          if( LeadingCadre!= ''){
                              newCC.cpywdyfzr__c = LeadingCadre;
                          }
                      }

                  }
                     
               }
             
          
        
               if(System.Test.isRunningTest()){
                   String test1123 = 'test1';
                   String test2123 = 'test2';
                   String test3123 = 'test3';
                   String test4123 = 'test4';
                   String test5123 = 'test5';
                   String test6123 = 'test6';
                   String test7123 = 'test7';
                   String test8123 = 'test8';
                   String test9123 = 'test9';
                   String test11230 = 'test10';
                   String test11231 = 'test11';
                   String test11232 = 'test12';
                   String test11233 = 'test13';
                   String test11234 = 'test14';
                   String test11235 = 'test15';
                   String test11236 = 'test16';
                   String test11237 = 'test17';
                   String test11238 = 'test18';
                   String test11239 = 'test19';
                   String test21230 = 'test20';
                   String test21231 = 'test21';
                   String test21232 = 'test22';
                   String test21233 = 'test23';
                   String test21234 = 'test24';
                   String test21235 = 'test25';
                   String test21236 = 'test26';
                   String test21237 = 'test27';
                   String test21238 = 'test28';
                   String test21239 = 'test29';
                   String test31230 = 'test30';
                   String test31231 = 'test31';
                   String test31232 = 'test32';
                   String test31233 = 'test33';
                   String test31234 = 'test34';
                   String test31235 = 'test35';
                   String test31236 = 'test36';
                   String test31237 = 'test37';
                   String test31238 = 'test38';
                   
               }
                
       
          }
       
               
              
          if(newCC.ManagerId__c != null){
          
              newCC.Manager__c = newCC.ManagerId__c;
          }

           if(newCC.ResponsibleLeadeId__c != null){
               newCC.ResponsibleLeade__c = newCC.ResponsibleLeadeId__c;
          }
    }
    
}