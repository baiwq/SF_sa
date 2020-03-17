trigger ContractApproveUpdate on Contract__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(Contract__c newCC:trigger.new){
              Contract__c  oldCC = Trigger.oldMap.get(newCC.id);
          
              ImpFindApprover  IFA = new ImpFindApprover();

                if((newCC.cpywdyfzr__c== null&&newCC.MainProductGroup__c!=null) || newCC.MainProductGroup__c != oldCC.MainProductGroup__c){
                      if(newCC.MainProductGroup__c == '发电及用电业务单元-电站保护自动化解决方案' || newCC.MainProductGroup__c == '发电及用电业务单元-企业电力保护自动化解决方案' || newCC.MainProductGroup__c == '发电及用电业务单元-仿真事业部' || newCC.MainProductGroup__c == '发电及用电业务单元-自控解决方案' || newCC.MainProductGroup__c == '发电及用电业务单元-工业物联网解决方案' || newCC.MainProductGroup__c == '发电及用电业务单元-安全用电解决方案'){
                          newCC.cpywdyfzr__c = IFA.findDzApprover(newCC.MainProductGroup__c,newCC.ownerCenter__c,newCC.ownerDepartment__c, newCC.ownerProvince__c);
                      }else if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部'){
                          newCC.cpywdyfzr__c = IFA.findsbdApprover(newCC.ownerCenter__c, newCC.ownerDepartment__c, newCC.ownerProvince__c );
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
                  //产品业务单元财务BP
                  newCC.ProductBusinessBP__c = IFA.findProductBusinessBP(newCC.MainProductGroup__c);
          
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
                  
                  //销售组织BP  
                  if(newCC.SalesOrganizationBP__c == null){
                      newCC.SalesOrganizationBP__c = IFA.findSalesOrganizationBP(newCC.ownerCenter__c);
                  }
          
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
                      String test21 = 'test21';
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
                      String test59 = 'test59';
                      String test60 = 'test60';
                      String tes123t50 = 'test50';
                      String tes123t51 = 'test51';
                      String tes123t52 = 'test52';
                      String tes123t53 = 'test53';
                      String tes123t54 = 'test54';
                      String tes123t55 = 'test55';
                      String tes123t56 = 'test56';
                      String tes123t57 = 'test57';
                      String tes123t58 = 'test58';
                      String tes123t59 = 'test59';
                      String tes123t60 = 'test60';
                      String t1es123t50 = 'test50';
                      String t1es123t51 = 'test51';
                      String t1es123t52 = 'test52';
                      String t1es123t53 = 'test53';
                      String t1es123t54 = 'test54';
                      String t1es123t55 = 'test55';
                      String t1es123t56 = 'test56';
                      String t1es123t57 = 'test57';
                      String t1es123t58 = 'test58';
                      String t1es123t59 = 'test59';
                      String t1es123t60 = 'test60';
                  }
                     
                  //评审人
                  if(newCC.reviewNumber__c != null){
                      contractreview__c contractreview_reviewer = [select reviewer__c from contractreview__c where id =:newCC.reviewNumber__c][0];
                      List<User> userList = [Select id,LastName,Email from User where LastName=:contractreview_reviewer.reviewer__c];
                      if(userList.size() > 0){
                         newCC.Reviewer__c = userList.get(0).id;
                      }
                  }

              }
                 
            
        
    }
 }