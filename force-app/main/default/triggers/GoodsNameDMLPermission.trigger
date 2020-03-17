trigger GoodsNameDMLPermission on goodsName__c (before insert, before update, before delete) {

//审批过程中不能创建/编辑/删除开票项
   List<goodsName__c> GNList = new List<goodsName__c>();
   If(Trigger.isDelete){
      GNList = Trigger.old;
   }else{
      GNList = Trigger.new;
   }
   
   List<Profile> PList = [Select id, Name from Profile where id = :Userinfo.getProfileID() and (Name = :'System Administrator' or Name =:'系统管理员' or Name like :'B-%')];
   
   for(goodsName__c ip :GNList){
      if((ip.approvalStatus__c == '提交待审批' || ip.approvalStatus__c == '销售领导通过' || ip.approvalStatus__c == '审批通过')&& PList.size() != 1){
         ip.addError(System.Label.GoodsName_Approval);
      }
   } 
   
}