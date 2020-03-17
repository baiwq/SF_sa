//Roll-up Summary
//不支持批量导入
trigger ReturnItemTotle on returnItem__c (after insert,after update,after delete) {
   FuncPools FP = new FuncPools();
   
   if(trigger.isDelete||trigger.isUpdate){
      for(returnItem__c r:Trigger.old){
         if(!(!FP.getReturnPermission()&&r.DMLFlag__c)){
            if(r.recordTypeName__c =='合同回款'){
               summaryOfContract(r);
            }else if(r.recordTypeName__c =='投标保证金清分'){
               summaryOfBidCost(r);
            }else if(r.recordTypeName__c =='履约保证金清分'){
               summaryOfLYCost(r);
            }
         }else{
            r.addError(System.Label.NoPrivilege);
         }
      }
   } 
   
   if(trigger.isInsert||trigger.isUpdate){
      for(returnItem__c r:Trigger.new){
         if(!(!FP.getReturnPermission()&&r.DMLFlag__c)){
            if(r.recordTypeName__c =='合同回款'){
               summaryOfContract(r);
            }else if(r.recordTypeName__c =='投标保证金清分'){
               summaryOfBidCost(r);
            }else if(r.recordTypeName__c =='履约保证金清分'){
               summaryOfLYCost(r);
            }
         }else{
            r.addError(System.Label.NoPrivilege);
         }
      }
   }
   
   public void summaryOfContract(returnItem__c ri){
      Decimal totalAmount = 0;
      if(ri.contracts__c != null){
         Contract__c cc = [Select id, returnAmountAll__c from Contract__c where id =:ri.contracts__c];
         List<returnItem__c> riList = [Select id, amount__c from returnItem__c where contracts__c =:ri.contracts__c and recordTypeName__c=:'合同回款'];
         for(integer i=0; i<riList.size(); i++){
            totalAmount = totalAmount + riList[i].amount__c;
         }
         cc.returnAmountAll__c = totalAmount;
         update cc;
       }
   }
   
   public void summaryOfBidCost(returnItem__c ri){
      Decimal totalAmount = 0;
      if(ri.bidCost__c != null){
         tbbaozhengjin__c bc = [Select id, returnAmount__c from tbbaozhengjin__c where id =:ri.bidCost__c];
         List<returnItem__c> riList = [Select id, amount__c from returnItem__c where bidCost__c =:ri.bidCost__c and recordTypeName__c=:'投标保证金清分' and amount__c > 0];
          
         for(integer i=0; i<riList.size(); i++){
             if(riList[i].amount__c==null){
                 riList[i].amount__c=0;
             }
             totalAmount = totalAmount + riList[i].amount__c;
         }
         bc.returnAmount__c = totalAmount;
         update bc;
      }
   }

   public void summaryOfLYCost(returnItem__c ri){
      Decimal totalAmount = 0;
      if(ri.LYBaozhengjing__c != null){
         guaranteeLetter__c gl = [Select id, returnAmount__c from guaranteeLetter__c where id =:ri.LYBaozhengjing__c];
         List<returnItem__c> riList = [Select id, amount__c from returnItem__c where LYBaozhengjing__c =:ri.LYBaozhengjing__c and recordTypeName__c=:'履约保证金清分' and amount__c > 0];
         for(integer i=0; i<riList.size(); i++){
            totalAmount = totalAmount + riList[i].amount__c;
         }
         gl.returnAmount__c = totalAmount;
         update gl;
      }
   }
}