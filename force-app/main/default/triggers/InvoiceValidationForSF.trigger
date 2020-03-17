trigger InvoiceValidationForSF on invoice__c (before update,before insert){
   Boolean flag  = false;
   for(invoice__c i:Trigger.new){
      if(Trigger.isInsert){
         if(i.postOrNot__c && i.kuaidi__c =='顺丰'){
            flag = true;
         }
         if(i.receiverCompany__c==null){
             i.receiverCompany__c=i.receiver__c;
         }
      }
      if(Trigger.isUpdate){
         invoice__c iOld = Trigger.oldMap.get(i.id);
         if(iOld.postOrNot__c != i.postOrNot__c || iOld.kuaidi__c != i.kuaidi__c){
            if(i.postOrNot__c && i.kuaidi__c =='顺丰'){
               flag = true;
            }
         }
         if(i.approvalStatus__c=='审批通过'&&i.receiverCompany__c==null){
             i.receiverCompany__c=i.receiver__c;
         }
      }
   
      if(flag){
         if(i.shippingAddress__c == null || i.receiver__c == null || i.receiverPhone__c == null){
            i.addError('需要顺丰邮寄时，收件人、收件电话、邮寄地址必需填写！');
         }
      }
     
       if( i.SalesTerritoryManager__c  == null){  
          String SalesTerritoryManagerlike = '%'+i.ownerProvince__c+'%';
          List<StaffingTables__c> SalesTerritoryManager_list = [select LeadingCadre__c from StaffingTables__c where name like :SalesTerritoryManagerlike ];

          String SalesTerritoryManager = '';

          if(SalesTerritoryManager_list.size() > 0){

              SalesTerritoryManager = SalesTerritoryManager_list.get(0).LeadingCadre__c;

              if( SalesTerritoryManager != ''){

                  i.SalesTerritoryManager__c = SalesTerritoryManager;

              }

          }
      }
   }
}