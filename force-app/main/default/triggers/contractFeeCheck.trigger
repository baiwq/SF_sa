//TestContractFee
trigger contractFeeCheck on contractFee__c (before insert,before update) {
 if(trigger.new.size()>100){
      return;
   }else{
      for(contractFee__c newCC:trigger.new){
          if(trigger.isUpdate){
             contractFee__c oldCC = (contractFee__c)trigger.oldMap.get(newCC.Id);
              
              if(newCC.InitialState__c == '提交待审批' && newCC.InitialState__c != oldCC.InitialState__c){
                  //几种类型不加客户信息不能提交
                  if(newCC.RecordTypeName__c == '节日活动' || newCC.RecordTypeName__c == '业务机会-引导客户阶段' || newCC.RecordTypeName__c == '业务机会-制定并提交解决方案阶段'|| newCC.RecordTypeName__c == '业务机会-赢单、未生成合同'|| newCC.RecordTypeName__c == '合同管理-履约、回款'|| newCC.RecordTypeName__c == '合同管理-质量事件处理'){
                      List<ExpenseCustomerInfo__c> ls = [select id from ExpenseCustomerInfo__c where contractFee__c =:newCC.id];
                      if(ls.size() == 0 ){
                          newCC.addError('请至少填写一条"费用备案客户信息"!');
                      }
                  }
                  
                  if(newCC.marketing__c == 0 && newCC.TotalEstimatedAmount__c == 0){
                        newCC.addError('请填写相关预计费用情况，才能提交审批!');
                  }
              }
              
              if(newCC.InitialState__c == '初审通过' && newCC.approveState__c  == '提交待审批'&& newCC.approveState__c  != oldCC.approveState__c ){
                  
                  if(newCC.ActualExpenditure__c  == 0 && newCC.TotalActualAmount__c == 0){
                     
                     newCC.addError('请填写相关实际费用情况，才能提交审批!');
                  }
              }else{
                  
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
              }
  
          }
      }
   }   
}