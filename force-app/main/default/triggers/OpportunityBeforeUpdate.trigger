trigger OpportunityBeforeUpdate on Opportunity (before insert,before update) { 

if(trigger.new.size()>100){
      return;
  }else{
     for(Opportunity newCC:trigger.new){
        newCC.level1center_wb__c = newCC.level1center__c;
        newCC.ManyProvincewb__c = newCC.province__c;
        newCC.level3Provincewb__c = newCC.level3Province__c;

             if(Trigger.isInsert){

                    if(newCC.cpywdyfzr__c == null&&newCC.MainProductGroup__c!=null){

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

                    
                     
                    if(newCC.SalesIndustoryManager__c == null&&newCC.MainIndustrySales__c!= null){

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

              } else if(Trigger.isUpdate){

                    Opportunity  oldCC = Trigger.oldMap.get(newCC.id);

                    if(oldCC.MainProductGroup__c != newcc.MainProductGroup__c || (newCC.cpywdyfzr__c == null&&newCC.MainProductGroup__c!=null)){

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

                    
                     
                    if(oldCC.MainIndustrySales__c != newcc.MainIndustrySales__c || (newCC.SalesIndustoryManager__c == null&&newcc.MainIndustrySales__c!= null)){

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

              }
        
      }
  }
}