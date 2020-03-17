trigger GuaranteeLetterTotalDelete on GuaranteeLetter__c (before delete) {
    Decimal total=0;
    for(GuaranteeLetter__c gl : Trigger.old){ 
//删除，类型为‘履约保证金’，-
        if(gl.type__c=='履约保证金' && gl.amount__c>0&&gl.approvalStatus__c=='审批通过'){
            Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
            total+=gl.amount__c;
            c.guaranteeMoney__c=c.guaranteeMoney__c-total;
            
            if(c.guaranteeMoney__c<=0.00){
               // c.guaranteeMoneyIsExisted__c=false;
                c.guaranteeMoney__c=0.00;
            }
            update c;
        }    
    }
}