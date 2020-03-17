trigger ReturnItemBeforeUpdate on returnItem__c (before update) {
    for(returnItem__c ri :trigger.new){
        FuncPools FP = new FuncPools();
        //查履约的合同号
       if(ri.LYBaozhengjing__c!=null){
           ri.contractNOLY__c = FP.queryContractName(ri.LYBaozhengjing__c);
       }
       if(ri.recordTypeName__c=='合同回款'){
           returnPool__c rp =[select id,Name,contractSAP__c,contractAccountCode__c from returnPool__c where id =:ri.returnPool__c];
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
       if(ri.recordTypeName__c =='合同回款'||ri.recordTypeName__c =='履约保证金'){
          Contract__c c = [Select id, incomeConfirmDate__c from Contract__c where id =:ri.contracts__c];
          if(c.incomeConfirmDate__c == null){
             ri.incomeType__c = '预收款';
          }else{
             ri.incomeType__c = '应收款';
          }
          //system.debug('ri.incomeType__c::'+ri.incomeType__c);
       }
        //履约
        if(ri.LYBaozhengjing__c!=null){
            guaranteeLetter__c gl = [select id,Name,accountName__c,accountCode__c from guaranteeLetter__c where id = :ri.LYBaozhengjing__c];
            ri.accountCodeLV__c=gl.accountCode__c;
            ri.accountNameLV__c=gl.accountName__c;
        }
    }
}