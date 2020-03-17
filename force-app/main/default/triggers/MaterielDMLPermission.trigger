trigger MaterielDMLPermission on materiel__c (before insert, before update, before delete) {

//审批过程中不能创建/编辑/删除开票项
   List<materiel__c> MList = new List<materiel__c>();
   If(Trigger.isDelete){
      MList = Trigger.old;
   }else{
      MList = Trigger.new;
   }
  
   for(materiel__c m:MList){
      if(m.approvalStatus__c == '审批通过'){
         m.addError(System.Label.ApprovalWarning);
      }
   } 
   
}