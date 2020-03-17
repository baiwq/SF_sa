trigger EmailToProject on paymentTerm__c (after update) {
    if(trigger.new.size()>7){
      return;
    }else{
        Integer i=-1;
        Integer j=-1;
        Set<String> conSet = new Set<String>();
        for(paymentTerm__c newPay:Trigger.new){
            conSet.add(newPay.contract__c);
            //发送邮件通知
            //预收阶段回款金额发生变化时
            paymentTerm__c oldPay = Trigger.oldMap.get(newPay.id);
            if(newPay.stage__c=='预收'&&newPay.backMoney__c!=oldPay.backMoney__c){
                i=1;
            }
            //提货阶段
            if(newPay.stage__c=='提货'&&newPay.backMoney__c!=oldPay.backMoney__c){
                j=1;
            }
        }
        if(conSet.size()==1){
            
            Contract__c con =[Select id,OwnerId, accountManager__c,contractNo__c, salesTeamCenter__c from Contract__c where id in:conSet];
            if(i>0&&j>0){
                
                EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'PaymentTermAmountChanged' limit 1];
                if(con.salesTeamCenter__c=='四方三伊'){
                    EmailToProject.exe_sendEmail('预收及提货阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'wangyongli_sy@sf-auto.com',null);
                }else{
                    EmailToProject.exe_sendEmail('预收及提货阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'shm@sf-auto.com',null);
                }
                
                return;
            }
            if(i>0){
                EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ReceivableInAdvanceAmountChanged' limit 1];
                if(con.salesTeamCenter__c=='四方三伊'){
                    EmailToProject.exe_sendEmail('预收阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'wangyongli_sy@sf-auto.com',null);
                    
                }else{
                    EmailToProject.exe_sendEmail('预收阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'shm@sf-auto.com',null);
                    
                }
                
                return;
            }
            if(j>0){
                
                EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'TakeDeliveryOfGoodsAmountChanged' limit 1];
                if(con.salesTeamCenter__c=='四方三伊'){
                    
                    EmailToProject.exe_sendEmail('提货阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'wangyongli_sy@sf-auto.com',null);
                }else{
                    
                    EmailToProject.exe_sendEmail('提货阶段回款金额发生变化', con.contractNo__c, con.accountManager__c, con.Id, template.Id,'shm@sf-auto.com',null);
                }
                
                return;
            }
        }
    }
}