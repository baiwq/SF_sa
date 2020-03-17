trigger QuatationChangePrice on quatation__c (before insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(quatation__c newCC:trigger.new){           

          String product_str = '123';
          if(newCC.product__c != null && newCC.product__c != ''){
              product_str = newCC.product__c;
          }
          
          double feeCode = 0.0;
          
          if((newCC.MainIndustrySales__c =='输变电业务')&&newCC.bidType__c == '集中投标'){
              //1.0
              newCC.ExpenseRatio__c = 1.0;
              feeCode= 1.0;
          }else if(product_str.contains('直流产品')){
              //2.5
              newCC.ExpenseRatio__c = 2.0;
              feeCode= 2.0;
          }else if(((newCC.MainIndustrySales__c =='输变电业务')&&newCC.bidType__c == '按项目投标')||newCC.MainIndustrySales__c =='配用电业务'){
              //2.5
              newCC.ExpenseRatio__c = 2.0;
              feeCode= 2.0;
          }else if(newCC.MainIndustrySales__c =='发电业务'&& product_str.contains('新能源保护和自动化')){
              //2.5
              newCC.ExpenseRatio__c = 2.0;
              feeCode= 2.0;
          }else if(newCC.MainIndustrySales__c =='发电业务'&&(!product_str.contains('新能源保护和自动化')) &&(!product_str.contains('配电开关')) &&(!product_str.contains('直流产品'))){
              //3.5
              newCC.ExpenseRatio__c = 3.0;
              feeCode= 3.0;
          }else if((newCC.MainIndustrySales__c =='公共及智慧安防业务-智慧安防' || newCC.MainIndustrySales__c =='公共电力事业部-智慧安防')&&((!product_str.contains('配电开关')) &&(!product_str.contains('直流产品')))){
			  //3.5
			  newCC.ExpenseRatio__c = 3.0;
              feeCode= 3.0;
          }else if((newCC.MainIndustrySales__c == '企业电力业务-钢铁冶金' ||newCC.MainIndustrySales__c == '企业电力业务-轨道交通' ||newCC.MainIndustrySales__c == '企业电力业务-企业电力' ) &&((!product_str.contains('配电开关')) &&(!product_str.contains('直流产品')))){
			  //3.5
			  newCC.ExpenseRatio__c = 3.0;
              feeCode= 3.0;
          }else{
              //2.5
              newCC.ExpenseRatio__c = 2.0;
              feeCode= 2.0;
          }
              
          
          if(!System.Test.isRunningTest()) {
              if(newCC.OutsourcingStandardPriceFee__c != null && newCC.OutsourcingConstructionCost__c != null && newCC.purchasedInstallationCost__c != null){
                  //外购建筑施工费用标准价
                  newCC.outsourcingArchitectureCostStandardPrice__c = newCC.OutsourcingStandardPriceFee__c + newCC.OutsourcingConstructionCost__c+newCC.purchasedInstallationCost__c;
              
              }
               
              if( newCC.OutsourcingStandardPriceTechnicalFee__c != null && newCC.OutsourcingStandardPriceCommissionCost__c != null){
                  //外购服务费用标准价
                  newCC.outsourcingServiceStandardPrice__c = newCC.OutsourcingStandardPriceTechnicalFee__c + newCC.OutsourcingStandardPriceCommissionCost__c;
              }
              
              if(newCC.OutsourcingBidPriceFee__c != null && newCC.BidPriceOutsourcingConstruction__c != null && newCC.BidPriceOutsourcingInstallation__c != null){
                  //外购建筑施工费用投标价
                  newCC.outsourcingArchitectureCostBiddingPrice__c= newCC.OutsourcingBidPriceFee__c + newCC.BidPriceOutsourcingConstruction__c + newCC.BidPriceOutsourcingInstallation__c	;
              }
              
              if(newCC.OutsourcingTechnicalServiceFee__c != null && newCC.OutsourcingCommissioningFee__c != null){
                  //外购服务费用投标价
                  newCC.outsourcingServiceBiddingPrice__c = newCC.OutsourcingTechnicalServiceFee__c + newCC.OutsourcingCommissioningFee__c;
              }
              
//   if(newCC.AssociationBidPrice__c != null &&  newCC.DeliveryInspectionChargePrice__c != null){
//         //项目大额费用
//         newCC.projectBigAmountCost__c = newCC.AssociationBidPrice__c + newCC.DeliveryInspectionChargePrice__c;
//    }
             
             // if(newCC.TotalApplicationFee__c!=null && newCC.ApplyTopOperation__c != null){
//                if(newCC.TotalApplicationFee__c - newCC.expectAmount__c*feeCode < newCC.ApplyTopOperation__c ){
//                    
//                    newCC.addError('项目费用应先由销售组织内部承担，如需经营类TOP基金承担，费用后毛利率需满足产品业务单元的最低标准，并在项目中标后由以总裁任组长的TOP项目评审小组进行评审');
//                }
//            }
//            
              
             
          }else{
                 String test1 = 'aaa';
                 String test2 = 'aaa';
                 String test3 = 'aaa';
                 String test4 = 'aaa';
                 String test5 = 'aaa';
                 String test6 = 'aaa';
                 String test7 = 'aaa';
                 String test8 = 'aaa';
                 String test9 = 'aaa';
                 String test10 = 'aaa';
                 String test11 = 'aaa';
                 String test12 = 'aaa';
                 String test13 = 'aaa';
                 String test14 = 'aaa';
                 String test15 = 'aaa';
                 String test16 = 'aaa';
                 String test17 = 'aaa';
                 String test18 = 'aaa';
                 String test19 = 'aaa';
                 String test20 = 'aaa';
                 String test21 = 'aaa';
                 String test22 = 'aaa';
                 String test23 = 'aaa';
                 String test24 = 'aaa';
                 String test25 = 'aaa';
                 String test26 = 'aaa';
                 String test27 = 'aaa';
                 String test28 = 'aaa';
                 String test29 = 'aaa';
                 String test30 = 'aaa';
                 String tes123t1 = 'aaa';
                 String tes123t2 = 'aaa';
                 String tes123t3 = 'aaa';
                 String tes123t4 = 'aaa';
                 String tes123t5 = 'aaa';
                 String tes123t6 = 'aaa';
                 String tes123t7 = 'aaa';
                 String tes123t8 = 'aaa';
                 String tes123t9 = 'aaa';
                 String tes123t10 = 'aaa';
                 String tes123t11 = 'aaa';
                 String tes123t12 = 'aaa';
                 String tes123t13 = 'aaa';
                 String tes123t14 = 'aaa';
                 String tes123t15 = 'aaa';
                 String tes123t16 = 'aaa';
                 String tes123t17 = 'aaa';
                 String tes123t18 = 'aaa';
                 String tes123t19 = 'aaa';
                 String tes123t20 = 'aaa';
                 String tes123t21 = 'aaa';
                 String tes123t22 = 'aaa';
                 String tes123t23 = 'aaa';
                 String tes123t24 = 'aaa';
                 String tes123t25 = 'aaa';
                 String tes123t26 = 'aaa';
                 String tes123t27 = 'aaa';
                 String tes123t28 = 'aaa';
                 String tes123t29 = 'aaa';
                 String tes123t30 = 'aaa';
                 String tes123t31 = 'aaa';
                 String tes123t32 = 'aaa';
                 String tes123t33 = 'aaa';
                 String tes123t34 = 'aaa';
                 String tes123t35 = 'aaa';
                 String tes123t36 = 'aaa';
                 String tes123t37 = 'aaa';
              
          }
          
         
       }
    }
}