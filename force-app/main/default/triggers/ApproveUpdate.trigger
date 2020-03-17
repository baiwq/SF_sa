trigger ApproveUpdate on salesLeads__c (before update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(salesLeads__c newCC:trigger.new){
          ImpFindApprover  IFA = new ImpFindApprover();
          if(Trigger.isUpdate){

                    salesLeads__c  oldCC = Trigger.oldMap.get(newCC.id);

                   if(newCC.MainProductGroup__c != oldCC.MainProductGroup__c || newCC.cpywdyfzr__c == null ){
					 if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部'){
                       newCC.cpywdyfzr__c = IFA.findsbdApprover(newCC.level1center__c, newCC.level2Department__c, newCC.level3Province__c );
                 	 }else{
                       String LeadingCadrelike = '%'+newCC.MainProductGroup__c+'%';
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

                   
                   if(newCC.SpSuperiorManager__c == null){

                        //地域负责人
                       String SalesTerritoryManagerlike = newCC.level3Province__c;
                       List<StaffingTables__c> SalesTerritoryManager_list = [select LeadingCadre__c from StaffingTables__c where name like :SalesTerritoryManagerlike ];
                        String SalesTerritoryManager = '';
                        if(SalesTerritoryManager_list.size() > 0){
                            SalesTerritoryManager = SalesTerritoryManager_list.get(0).LeadingCadre__c;
                            if( SalesTerritoryManager != ''){
                                newCC.SpSuperiorManager__c = SalesTerritoryManager;
                            }
                       }
                    
                   }



  
                  if(newCC.MainIndustrySales__c != oldCC.MainIndustrySales__c || newCC.xshyfzr__c == null){
                      //主导行业销售
                   String xshyfzrlike = newCC.MainIndustrySales__c;
                   List<StaffingTables__c> Staff_list = [select LeadingCadre__c from StaffingTables__c where name like :xshyfzrlike ];
                    String xshyfzr = '';
                    if(Staff_list.size() > 0){
                        xshyfzr = Staff_list.get(0).LeadingCadre__c;
                        if( xshyfzr != ''){
                            newCC.xshyfzr__c = xshyfzr;
                        }
                    }

                  }

              }

        }
          
        
    }
  }