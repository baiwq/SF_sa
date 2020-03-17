trigger GuaranteeLetterAmountTotal on guaranteeLetter__c (after insert,after update) {
    Decimal total=0;
    for(guaranteeLetter__c gl : Trigger.new){ 
       /*if(Trigger.isInsert){
//创建，如果类型是‘履约保证金’并且金额大于0，累加
            if(gl.type__c=='履约保证金'&&gl.amount__c>0){
                Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
                if(c.guaranteeMoney__c==null){
                    c.guaranteeMoney__c=0.00;
                }
                total+=gl.amount__c;
                c.guaranteeMoney__c+=total;
                update c;
            }
        } */
        if(Trigger.isUpdate){
            for(guaranteeLetter__c glOld : Trigger.old){
                //编辑，类型'履约保证金'改为‘履约保函’并且金额大于0，保证金-保函金额
              if(glOld.approvalStatus__c!='审批通过'&&gl.approvalStatus__c=='审批通过'){  
                /*if(gl.type__c!='履约保证金'&&gl.amount__c>0&&glOld.type__c=='履约保证金'){
                    Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
                    total+=gl.amount__c;
                    if(c.guaranteeMoney__c==null){
                        c.guaranteeMoney__c=0.00;
                    }
                    c.guaranteeMoney__c=c.guaranteeMoney__c-total;
                    update c;
                }
//编辑，类型为‘履约保证金’，保证金加上变化的金额
                if(gl.type__c=='履约保证金'&&gl.amount__c>0&&glOld.type__c=='履约保证金'){
                    Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
                    total+=gl.amount__c;
                    if(c.guaranteeMoney__c==null){
                        c.guaranteeMoney__c=0.00;
                    }
                    c.guaranteeMoney__c=c.guaranteeMoney__c+total-glOld.amount__c;
                    update c;
                }
//‘履约保函’变为‘履约保证金’，累加
                if(gl.type__c=='履约保证金'&&gl.amount__c>0&&glOld.type__c!='履约保证金'){
                    Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
                    total+=gl.amount__c;
                    if(c.guaranteeMoney__c==null){
                        c.guaranteeMoney__c=0.00;
                    }
                    c.guaranteeMoney__c=c.guaranteeMoney__c+total;
                    update c;
                }*/
                if(gl.type__c=='履约保证金' && gl.contract__c != null){
                    Contract__c c =[select guaranteeMoney__c from Contract__c where id =:gl.contract__c];
                    total+=gl.amount__c;
                    if(c.guaranteeMoney__c==null){
                        c.guaranteeMoney__c=0.00;
                    }
                    c.guaranteeMoney__c=c.guaranteeMoney__c+total;
                    update c;
                }
              }
            } 
        }
    }
}