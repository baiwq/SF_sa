trigger GiveIsHabs on Contract__c (before insert,before update,after update) {
   if(Trigger.isInsert && Trigger.isBefore){
       for(Contract__c c:Trigger.new){
           if(c.FrameworkContact__c != null){
               Contract__c  ci = [select id,contractOrNot__c from Contract__c where id = :c.FrameworkContact__c];
               c.TestIsContract__c = ci.contractOrNot__c;  
           }       
       }
   }
   else if(Trigger.isUpdate && Trigger.isAfter){
       for(Contract__c c:Trigger.new){
           Contract__c cc = Trigger.oldMap.get(c.id);
           if(c.contractOrNot__c!= cc.contractOrNot__c && c.salesTeamDepartment__c == '金融事业部'&&c.RecordTypeName__c != '安全服务合同'){             
               List<Contract__c> cList =[select id,TestIsContract__c from Contract__c where FrameworkContact__c =:c.id ];
               if(cList.size()>0){
                 list<contract__c> atcUpList = new list<contract__c>();
                 for(Contract__c cp:cList){
                    cp.TestIsContract__c = c.contractOrNot__c;
                    atcUpList.add(cp);
                 }
                 update atcUpList;               
               }
           }
       }
   
   }
   else{
       for(Contract__c c:Trigger.new){
          Contract__c cc = Trigger.oldMap.get(c.id);
          if(c.FrameworkContact__c != cc.FrameworkContact__c && c.RecordTypeName__c  == '安全服务合同'){
              Contract__c co = [select id,contractOrNot__c from Contract__c where id =:c.FrameworkContact__c ];
              c.TestIsContract__c  = co.contractOrNot__c;  
          }
       
       }
   }
}