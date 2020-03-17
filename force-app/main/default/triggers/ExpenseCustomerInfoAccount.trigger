//TestContractFee
trigger ExpenseCustomerInfoAccount on ExpenseCustomerInfo__c (before insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(ExpenseCustomerInfo__c newCC:trigger.new){
          if(trigger.isInsert){
              if(newCC.OpportunityId__c != null){
                 Opportunity  opp = [select Accountid,designAccount__c,contractorAccount__c,projectOwner__c from Opportunity where id =:newCC.OpportunityId__c];
                  if(newCC.Account__c == opp.Accountid){
                      newCC.AccountType__c = '采购方';
                  }else if( newCC.Account__c == opp.designAccount__c ){
                      newCC.AccountType__c = '设计方';
                  }else if( newCC.Account__c == opp.contractorAccount__c){
                      newCC.AccountType__c = '施工方';
                  }else if( newCC.Account__c == opp.projectOwner__c){
                  	  newCC.AccountType__c = '业主方';
                  }else{
                      newCC.addError('只能选择业务机会下对应的客户、设计单位、总包单位、项目业主单位其中一项，其他客户不可选！');
                  }
              
              }else{
                  if(newCC.Account__c != newCC.ContractFeeAccunt__c ){
                       newCC.addError('必须与费用备案中的客户一致！');
                  }else{
                     newCC.AccountType__c = '业主方';
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
          }else if(trigger.isUpdate){
             ExpenseCustomerInfo__c oldCC = (ExpenseCustomerInfo__c)trigger.oldMap.get(newCC.Id);
              if(newCC.InitialState__c == '初评通过' && (newCC.EstimatedCost__c != oldCC.EstimatedCost__c || newCC.ExpectedActivityDate__c  != oldCC.ExpectedActivityDate__c)  ){
                   newCC.addError('初评通过后，预计活动日期 和 预计花费金额 不能修改！');
              }
              if(newCC.Account__c != oldCC.Account__c){
                   newCC.addError('客户不能修改！');
              }
              
          }   
      }
   }   
}