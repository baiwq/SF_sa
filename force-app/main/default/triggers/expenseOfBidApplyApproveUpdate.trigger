trigger expenseOfBidApplyApproveUpdate on expenseOfBidApply__c (before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(expenseOfBidApply__c newCC:trigger.new){

          
          expenseOfBidApply__c  oldCC = Trigger.oldMap.get(newCC.id);

          if( newCC.SalesIndustoryManager__c == null || newCC.MainIndustrySales__c != oldCC.MainIndustrySales__c){

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
          
    }
  }
}