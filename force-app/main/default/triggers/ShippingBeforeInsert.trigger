/*
 *去掉创建发货时更改记录类型
 *修改人：任艳新
 *修改日期：2018-2-6
 **/

trigger ShippingBeforeInsert on shipping__c (before insert) {
   FuncPools FP = new FuncPools();
   for(shipping__c s:Trigger.new){
//每个合同只能提交一次排产申请
      if(s.contracts__c != null){
         List<shipping__c> SList= [Select id from shipping__c where contracts__c =:s.contracts__c];
         if(SList.size() >= 1){
            s.addError(System.Label.Shipping_Duplicate);
         }
      }
      
//创建时自动给记录类型2018-2-6去掉创建发货时更改记录类型
      //String DevelopName = 'abnormalShippingApplication';
      //if(s.contractOrNot__c =='有') DevelopName = 'shippingApplication';
      //s.RecordTypeId = [Select id from RecordType where DeveloperName =:DevelopName and SobjectType=:'shipping__c'].id;
   
//得到该大区所有无合同发货金额
      s.allNoReturnAmount__c = FP.getAmountNoContract(s.area__c);
      s.accountReturnCount__c = FP.getAccountNoContractCount(s.accountID__c);
//得到大区经理
      if(s.departmentmanager__c!=null){
          s.departmentmanager1__c = s.departmentmanager__c;
      }else{
          s.departmentmanager1__c = null;
      }
//得到上级经理
      try{
         s.createdByManager__c = [Select ManagerId from User where id =:Userinfo.getUserId()].ManagerId;
      }catch(Exception e){
         s.addError(System.Label.Shipping_Manager);
      }
   }
}