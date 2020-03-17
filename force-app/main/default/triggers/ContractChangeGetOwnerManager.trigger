trigger ContractChangeGetOwnerManager on contractchange__c (before insert,before update) {
   boolean flag = false;
   for(contractchange__c cc:Trigger.new){
      if(Trigger.isInsert){
         flag = true;
      }else if(Trigger.isUpdate){
         contractchange__c ccold = Trigger.oldMap.get(cc.id);
         if(cc.OwnerId != ccold.OwnerId){
            flag = true;
         }
      }
      
      if(flag){
         List<User> u =[Select ManagerId,contractAdmin__c from User where id = :cc.OwnerId];
         cc.ownerProvinceManager__c = u[0].ManagerId;
      }
   }  
}