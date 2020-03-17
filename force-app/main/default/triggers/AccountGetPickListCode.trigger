trigger AccountGetPickListCode on Account (before insert, before update) {
   for(Account a:Trigger.new){
//导入数据跳过触发器。
      if(trigger.new.size() > 100){
         System.Debug('Account Batch DMLs, ignore...');
         return;
      }
      
       
//找到Account Code      
      FuncPools FP = new FuncPools();
      Map<String,Map<String,String>> CodeList = new Map<String,Map<String,String>>();
      CodeList = new Map<String,Map<String,String>>(FP.getCodeValues('客户'));
         
      try{
         a.industryCode__c = CodeList.get('行业二级分类').get(a.industrySecondLevel__c);
         System.Debug('CodeList.get().get(a.industryCode__c)'+ CodeList.get('行业二级分类').get(a.industrySecondLevel__c));
      }catch(Exception e){
         System.Debug('没有得到 行业二级分类 的字段编码');
      }
         
      try{
         a.countryCode__c = CodeList.get('国家').get(a.billingNation__c);
      }catch(Exception e){
         System.Debug('没有得到 国家 的字段编码');
      }
         
      try{
         a.regionCode__c = CodeList.get('省份').get(a.billingState__c);
      }catch(Exception e){
         System.Debug('没有得到 省份 的字段编码');
      }
   }
}