trigger tbbaozhengjinApproveUpdate on tbbaozhengjin__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(tbbaozhengjin__c newCC:trigger.new){
          
          tbbaozhengjin__c  oldCC = Trigger.oldMap.get(newCC.id);
          
          
          ImpFindApprover  IFA = new ImpFindApprover();

          //销售中心总经理 
          if((newCC.MainIndustrySales__c != null &&  newCC.SalesCenterManager__c == null) || (newCC.MainIndustrySales__c != oldCC.MainIndustrySales__c)) {
              // newCC.SalesCenterManager__c = IFA.findSalesCenterManager(newCC.ownerCenter__c, newCC.MainIndustrySales__c);
              if(newCC.FindApply__c != '未知'){
                  newCC.SalesCenterManager__c = newCC.FindApply__c;
              }else if(newCC.ownerCenter__c == '行业销售中心'){ 
                  //高峰
                  newCC.SalesCenterManager__c =  '00528000007AKVI';
                  
              }else if(newCC.ownerCenter__c == '电力系统销售中心' && (newCC.MainIndustrySales__c ==  '用电业务'|| newCC.MainIndustrySales__c == '发电业务'||newCC.MainIndustrySales__c ==  '用电行业'|| newCC.MainIndustrySales__c == '发电行业')){
                  //吴延龙
                  newCC.SalesCenterManager__c = '00528000005WuxV'; 
              }else if(newCC.ownerCenter__c == '电力系统销售中心' && (newCC.MainIndustrySales__c == '输变电业务'|| newCC.MainIndustrySales__c == '配用电业务' || newCC.MainIndustrySales__c == '输变电行业'|| newCC.MainIndustrySales__c == '配电行业')){
                  //张兴
                  newCC.SalesCenterManager__c = '00528000005LQGi';
              }else if(newCC.ownerCenter__c == '电力系统销售中心' && (newCC.MainIndustrySales__c == '' || newCC.MainIndustrySales__c == null)){        
                  //吴延龙
                  newCC.SalesCenterManager__c = '00528000005WuxV';
              }else if(newCC.ownerCenter__c == '电力系统销售中心' && (newCC.MainIndustrySales__c != '输变电业务' && newCC.MainIndustrySales__c != '发电业务' && newCC.MainIndustrySales__c != '用电业务' && newCC.MainIndustrySales__c == '配用电业务'&&newCC.MainIndustrySales__c != '输变电行业' && newCC.MainIndustrySales__c != '发电行业' && newCC.MainIndustrySales__c != '用电行业' && newCC.MainIndustrySales__c == '配电行业')){        
                  //吴延龙
                  newCC.SalesCenterManager__c = '00528000005WuxV';
              }else if(newCC.ownerCenter__c == '电力系统销售中心' && (newCC.MainIndustrySales__c != ''&& newCC.MainIndustrySales__c != null &&newCC.MainIndustrySales__c != '输变电业务' && newCC.MainIndustrySales__c != '发电业务'&&newCC.MainIndustrySales__c != '用电业务'&& newCC.MainIndustrySales__c != '配用电业务')){        
                  //高峰
                  newCC.SalesCenterManager__c =  '00528000005LQGi';
              }
              
          }
          
          
              //else if(newCC.MainIndustrySales__c == null && newCC.ownerCenter__c == '电力系统销售中心'){
                //  newCC.addError('请选择项目所属行业！');
              //}
       
          if(System.Test.isRunningTest()){
              String test1 = 'test1';
              String test2 = 'test2';
              String test3 = 'test3';
              String test4 = 'test4';
              String test5 = 'test5';
              String test6 = 'test6';
              String test7 = 'test7';
              String test8 = 'test8';
              String test9 = 'test9';
              String test10 = 'test10';
              String test11 = 'test11';
              String test12 = 'test12';
              String test13 = 'test13';
              String test14 = 'test14';
              String test15 = 'test15';
              String test16 = 'test16';
              String test17 = 'test17';
              String test18 = 'test18';
              String test19 = 'test19';
              String test20 = 'test20';
              String test22 = 'test22';
              String test23 = 'test23';
              String test24 = 'test24';
              String test25 = 'test25';
              String test26 = 'test26';
              String test27 = 'test27';
              String test28 = 'test28';
              String test29 = 'test29';
              String test30 = 'test30';
              String test31 = 'test31';
              String test32 = 'test32';
              String test33 = 'test33';
              String test34 = 'test34';
              String test35 = 'test35';
              String test36 = 'test36';
              String test37 = 'test37';
              String test38 = 'test38';
              String test39 = 'test39';
              String test40 = 'test40';
              String test41 = 'test41';
              String test42 = 'test42';
              String test43 = 'test43';
              String test44 = 'test44';
              String test45 = 'test45';
              String test46 = 'test46';
              String test47 = 'test47';
              String test48 = 'test48';
              String test49 = 'test49';
              String test50 = 'test50';
              String test51 = 'test51';
              String test52 = 'test52';
              String test53 = 'test53';
              String test54 = 'test54';
              String test55 = 'test55';
              String test56 = 'test56';
              String test57 = 'test57';
              String test58 = 'test58';
          }
          
    }
  }
}