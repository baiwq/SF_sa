trigger DismantlecabineTBFather on Dismantlecabinet__c (before insert, before update){
 for(Dismantlecabinet__c cr : trigger.new){
        if(cr.departmentmanager__c != null){
            cr.departmentmanager1__c=cr.departmentmanager__c;
        }else{
            cr.departmentmanager1__c=null;
        }
       
            
     if( cr.SalesTerritoryManager__c == null){
         String SalesTerritoryManagerlike = '%'+cr.province__c +'%';
          List<StaffingTables__c> SalesTerritoryManager_list = [select LeadingCadre__c from StaffingTables__c where name like :SalesTerritoryManagerlike ];
          String SalesTerritoryManager = '';
          if(SalesTerritoryManager_list.size() > 0){
              SalesTerritoryManager = SalesTerritoryManager_list.get(0).LeadingCadre__c;
              if( SalesTerritoryManager != ''){
                  cr.SalesTerritoryManager__c = SalesTerritoryManager;
              }

          }
    
     }
          
    }
}