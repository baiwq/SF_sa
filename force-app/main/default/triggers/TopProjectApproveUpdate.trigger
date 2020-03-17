trigger TopProjectApproveUpdate on TopProjectApp__c (before update) {
   if(trigger.new.size()>100){
      return;
   }else{
      for(TopProjectApp__c newCC:trigger.new){
          ImpFindApprover  IFA = new ImpFindApprover();
    
                    TopProjectApp__c  oldCC = Trigger.oldMap.get(newCC.id);

                   if(newCC.MainProductGroup__c != oldCC.MainProductGroup__c || newCC.cpywdyfzr__c == null ){
                     if(newCC.MainProductGroup__c == '输变电业务单元-电网保护自动化事业部'){
                       newCC.cpywdyfzr__c = IFA.findsbdApprover(newCC.ownerCenter__c,newCC.ownerDepartment__c,newCC.ownerProvince__c   );
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
          
        }
    }
  }