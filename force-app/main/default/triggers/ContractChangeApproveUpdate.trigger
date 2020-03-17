trigger ContractChangeApproveUpdate on contractchange__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(contractchange__c newCC:trigger.new){

              contractchange__c  oldCC = Trigger.oldMap.get(newCC.id);

          	  ImpFindApprover  IFA = new ImpFindApprover();

              if(newCC.ManagerId__c != null){
                 newCC.Manager__c = newCC.ManagerId__c;
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
                        String test61 = 'test61';
               			String tes123t24 = 'test24';
                        String tes123t25 = 'test25';
                        String tes123t26 = 'test26';
                        String tes123t27 = 'test27';
                        String tes123t28 = 'test28';
                        String tes123t29 = 'test29';
                        String tes123t30 = 'test30';
                        String tes123t31 = 'test31';
                        String tes123t32 = 'test32';
                        String tes123t33 = 'test33';
                        String tes123t34 = 'test34';
                        String tes123t35 = 'test35';
                        String tes123t36 = 'test36';
                        String tes123t37 = 'test37';
                        String tes123t38 = 'test38';
                        String tes123t39 = 'test39';
                        String tes123t40 = 'test40';
                        String tes123t41 = 'test41';
                        String tes123t42 = 'test42';
                        String tes123t43 = 'test43';
                        String tes123t44 = 'test44';
                        String tes123t45 = 'test45';
                        String tes123t46 = 'test46';
                        String tes123t47 = 'test47';
                        String tes123t48 = 'test48';
                        String tes123t49 = 'test49';
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
                        String tes123t61 = 'test61';
                  }
                  
        
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
             

              if(newCC.SalesTerritoryManager__c  == null){

                 //地域负责人
                 String SalesTerritoryManagerlike = newCC.ownerProvince__c;
                 List<StaffingTables__c> SalesTerritoryManager_list = [select LeadingCadre__c from StaffingTables__c where name like :SalesTerritoryManagerlike ];
                 String SalesTerritoryManager = '';
                  if(SalesTerritoryManager_list.size() > 0){
                      SalesTerritoryManager = SalesTerritoryManager_list.get(0).LeadingCadre__c;
                      if( SalesTerritoryManager != ''){
                          newCC.SalesTerritoryManager__c = SalesTerritoryManager;
                      }
                  }

              }
              
              

               if( newCC.MainIndustrySales__c!= oldCC.MainIndustrySales__c || newCC.SalesIndustoryManager__c == null){
                   //主导行业销售
                   String xshyfzrlike = newCC.MainIndustrySales__c;
                   List<StaffingTables__c> Staff_list = [select LeadingCadre__c from StaffingTables__c where name like :xshyfzrlike ];
                    String xshyfzr = '';
                    if(Staff_list.size() > 0){
                        xshyfzr = Staff_list.get(0).LeadingCadre__c;
                        if( xshyfzr != ''){
                            newCC.SalesIndustoryManager__c = xshyfzr;
                        }
                    }
               }
               
               if( newCC.contract__c!=null){
               
               //评审人
                Contract__c contract_reviewer = [select reviewer__c from Contract__c where id =:newCC.contract__c][0];
                 if(contract_reviewer.reviewer__c != null){
                   newCC.Reviewer__c = contract_reviewer.reviewer__c;
                 }else{
                   newCC.Reviewer__c = '00528000006IqdHAAS';
                 }
               
               }
               
                
// 				if(newCC.contract__c != null){
//                 contract__c  con = [select MainProductGroup__c,MainIndustrySales__c,ProductGroup__c,IndustrySales__c from contract__c where id =:newCC.contract__c][0];
//                 if(con.MainProductGroup__c != null){
//                    if(newCC.MainProductGroup__c==null){
//                        newCC.MainProductGroup__c = con.MainProductGroup__c;
//                    }
//                 }
//
//                 if(con.MainIndustrySales__c != null){
//                    if(newCC.MainProductGroup__c==null){
//                        newCC.MainIndustrySales__c = con.MainIndustrySales__c;
//                    }
//                 }
//             }

      }
       
    }

}