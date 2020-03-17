trigger InvoiceItemDMLPermission on invoiceItem__c (before insert, before update, before delete) {

//审批过程中不能创建/编辑/删除开票项
   List<invoiceItem__c> ipList = new List<invoiceItem__c>();
   If(Trigger.isDelete){
      ipList = Trigger.old;
      if(trigger.old.size() > 25){System.Debug('InvoiceItem Batch DMLs, ignore...'); return;}
   }else{
      ipList = Trigger.new;
      if(trigger.new.size() > 25){System.Debug('InvoiceItem Batch DMLs, ignore...'); return;}
   }
   
   List<Profile> PList = [Select id, Name from Profile where id = :Userinfo.getProfileID() and (Name = :'System Administrator' or Name =:'系统管理员' or Name like :'B-%')];
   
   for(invoiceItem__c ip :ipList){
      if((ip.approvalStatus__c == '提交待审批' || ip.approvalStatus__c == '销售领导通过' || ip.approvalStatus__c == '审批通过')&& PList.size() != 1){
         ip.addError(System.Label.GoodsName_Approval);
      }
   } 
}