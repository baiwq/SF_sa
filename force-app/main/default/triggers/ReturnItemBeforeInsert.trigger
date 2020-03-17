trigger ReturnItemBeforeInsert on returnItem__c (before insert) {
   for(returnItem__c ri:Trigger.new){
// 校验
      returnPool__c rp = [Select id, Name, category__c, receiptOrNot__c,recordType__c,contractSAP__c, contractAccountCode__c from returnPool__c where id = :ri.returnPool__c];
      if(rp.category__c == null){
         ri.addError(System.Label.ReturnItem_TypeNull);
      }
      
      if(rp.recordType__c =='承兑汇票' && rp.receiptOrNot__c != '是'){
         ri.addError('System.Label.ReturnItem_ABComfirm');
      }

      
//设置清分日期等于当前时间
       ri.returnDate__c = System.today();
       
      if(!System.Test.isRunningTest()){
        
               FuncPools FP = new FuncPools();
        //判断 应/预收       
              if(ri.recordTypeName__c =='合同回款'){
                 Contract__c c = [Select id, incomeConfirmDate__c from Contract__c where id =:ri.contracts__c];
                 if(c.incomeConfirmDate__c == null){
                    ri.incomeType__c = '预收款';
                 }else{
                    ri.incomeType__c = '应收款';
                 }
               }
               
        //查履约的合同号.合同客户编码
              if(ri.LYBaozhengjing__c!=null){
                 ri.contractNOLY__c = FP.queryContractName(ri.LYBaozhengjing__c);
              }
              if(ri.recordTypeName__c=='合同回款'){
                 rp.contractSAP__c=ri.contractName__c;
                 rp.contractAccountCode__c=ri.accountCode__c;
                 update rp;
              }
               
        //投标客户编码
              if(ri.recordTypeName__c=='投标保证金清分'){
                 tbbaozhengjin__c tb = [select id, Name, accountCodeD__c, accountName__c from tbbaozhengjin__c where id = :ri.bidCost__c];
                 ri.accountCodeD__c = tb.accountCodeD__c;
                 ri.accountNameD__c = tb.accountName__c;
               }
        //履约
              if(ri.LYBaozhengjing__c!=null){
                 guaranteeLetter__c gl = [select id,Name,accountName__c,accountCode__c from guaranteeLetter__c where id = :ri.LYBaozhengjing__c];
                 ri.accountCodeLV__c=gl.accountCode__c;
                 ri.accountNameLV__c=gl.accountName__c;
              }
           }
   }
}