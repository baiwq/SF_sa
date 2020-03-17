trigger SchedulingInsert on scheduling__c (before insert){
/*
   for(scheduling__c s:Trigger.new){
//每个合同只能提交一次排产申请
      if(s.contract__c != null){
         List<scheduling__c> SList= [Select id from scheduling__c where contract__c =:s.contract__c];
         if(SList.size() >= 1){
            s.addError(System.Label.Schedule_Duplicate);
         }
      }
      
//创建时自动给记录类型
      String DevelopName = 'abnormal';
      if(s.hasContract__c =='有') DevelopName = 'normal';
      s.RecordTypeId = [Select id from RecordType where DeveloperName =:DevelopName and SobjectType=:'scheduling__c'].id;
      
//检查合同附件 供货范围清单 附件
      List<attachment__c> AList = [Select id, Name, type__c, isValid__c from attachment__c where contract__c =:s.contract__c and type__c=:'供货范围清单' and isValid__c = :'有效'];
      if(AList.size() < 1){
         s.addError(System.Label.Schedule_GHFW);
      }
      
//检查合同附件 合同文本 附件    
     if(s.contractYesOrNo__c =='有'){
        List<attachment__c> BList = [Select id, Name, type__c, isValid__c from attachment__c where contract__c =:s.contract__c and type__c=:'合同文本' and isValid__c = :'有效'];
        if(BList.size() < 1){
           s.addError(System.Label.Schedule_Contract);
        }
     }
//得到销售主责任的经理
    if(s.salesMgr__c!=null){
        s.salesMgrlookup__c=s.salesMgr__c;
    }
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
        s.addError(System.Label.Schedule_Manager);
     }

   }
 */
}