trigger ShippingComments on shipping__c (before insert,before update) {
 
   for(shipping__c newCC:Trigger.new){ 
       newCC.SalesTerritoryManager__c  = newCC.SalesTerritoryManagerid__c;
       
       newCC.Reviewer__c = newCC.Reviewerid__c;
        
    if(newCC.ownerDepartment__c  == '感应加热业务' || '感应加热业务'.equals(newCC.ownerDepartment__c )){
      if(newCC.comments__c == '' || newCC.comments__c == null){

          newCC.addError('请填写发货申请备注再保存。');

      }

    }
    if( newCC.SalesTerritoryManager__c == null){
          String SalesTerritoryManagerlike = '%'+newCC.ownerProvince__c+'%';
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