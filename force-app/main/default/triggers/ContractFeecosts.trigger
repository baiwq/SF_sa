trigger ContractFeecosts on contractFee__c (before update) {
  for(contractFee__c newCC:Trigger.new){
      contractFee__c oldCC = Trigger.oldMap.get(newCC.id);
      if(newCC.ChangeDate__c != null && newCC.ChangeDate__c != oldCC.ChangeDate__c  ){
         DateTime st = DateTime.valueOf('2018-12-31 00:00:00');
         AggregateResult CostAaccumulationObj=[select sum(amountFee__c) CostAaccumulation_sum from contractFee__c where OwnerId =:newCC.OwnerId  and id!=:newCC.Id and (approveState__c='审批通过' or (approveState__c='提交待审批' and FirstLevel__c = '是')) and CreatedDate >:st];
          if(CostAaccumulationObj.get('CostAaccumulation_sum') != null){
              newCC.costAaccumulation__c = CostAaccumulationObj.get('CostAaccumulation_sum')+'';
          }else{
              newCC.costAaccumulation__c = '0.0';
          }

          AggregateResult BudgetaryExpenditureObj =[select sum(TotalSalesApplicationAmoun__c) BudgetaryExpenditureObj_sum from contractFee__c where OwnerId =:newCC.OwnerId  and id!=:newCC.Id and (approveState__c='审批通过' or (approveState__c='提交待审批' and FirstLevel__c = '是')) and CreatedDate >:st];
          if(CostAaccumulationObj.get('CostAaccumulation_sum') != null){
              newCC.BudgetaryExpenditure__c  = Decimal.valueOf(BudgetaryExpenditureObj.get('BudgetaryExpenditureObj_sum')+'');
          }else{
              newCC.BudgetaryExpenditure__c  = 0.0;
          }

          AggregateResult CostExpenditureObj =[select sum(CostedAmount__c) CostedAmount_sum from contractFee__c where OwnerId =:newCC.OwnerId  and id!=:newCC.Id and (approveState__c='审批通过' or (approveState__c='提交待审批' and FirstLevel__c = '是')) and CreatedDate >:st];
          if(CostExpenditureObj.get('CostedAmount_sum') != null){
              newCC.CostExpenditure__c = Decimal.valueOf(CostExpenditureObj.get('CostedAmount_sum')+'');
          }else{
              newCC.CostExpenditure__c = 0.0;
          }
          
          if(newCC.account__c !=null){
              AggregateResult CustomersCumulativeAmountObj =[select sum(TotalSalesApplicationAmoun__c) CustomersCumulativeAmount_sum from contractFee__c where account__c =:newCC.account__c  and id!=:newCC.Id and (approveState__c='审批通过' or (approveState__c='提交待审批' and FirstLevel__c = '是')) and CreatedDate >:st];
              if(CustomersCumulativeAmountObj.get('CustomersCumulativeAmount_sum') != null){
                  newCC.CustomersCumulativeAmount__c = Decimal.valueOf(CustomersCumulativeAmountObj.get('CustomersCumulativeAmount_sum')+'');
              }else{
                  newCC.CustomersCumulativeAmount__c = 0.0;
              }    
          }
          
          
          AggregateResult CumulativeHOrderObj =[select sum(HOrderCostAmount__c) CumulativeHOrder_sum from contractFee__c where OwnerId =:newCC.OwnerId  and id!=:newCC.Id and (approveState__c='审批通过' or (approveState__c='提交待审批' and FirstLevel__c = '是')) and CreatedDate >:st];
          if(CumulativeHOrderObj.get('CumulativeHOrder_sum') != null){
              newCC.CumulativeHOrder__c  = Decimal.valueOf(CumulativeHOrderObj.get('CumulativeHOrder_sum')+'');
          }else{
              newCC.CumulativeHOrder__c  = 0.0;
          }
      }
        
    }
}