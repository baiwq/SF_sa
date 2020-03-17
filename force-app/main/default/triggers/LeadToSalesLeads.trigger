trigger LeadToSalesLeads on Lead (after insert,before update){
    for(Lead ld:Trigger.new){
//取得所有的邮件列表里的值放在List里   
        String[] toAddresses = new String[] {ld.Email};
        FuncPools FP = new FuncPools();
        
        if(Trigger.isInsert){
            EmailTemplate ETNew = [Select id from EmailTemplate where DeveloperName =:'newLeadsNotification' limit 1];
            //FP.sendEmails(toAddresses,ld.id,ETNew.id);
        }
        
        if(Trigger.isUpdate){
            if(ld.Status == '重复'){
                EmailTemplate ETEdit = [Select id from EmailTemplate where DeveloperName =:'leadsRepeatedNotification' limit 1];
                //FP.sendEmails(toAddresses,ld.id,ETEdit.id);
                System.Debug('toAddresses:' + toAddresses);
                System.Debug('ld.id:' + ld.id);
                System.Debug('ETEdit.id:' + ETEdit.id);
                lock(ld);
            }
            if(ld.Status == '已转化'){
                try{
                    salesLeads__c sL = new salesLeads__c();
                    sL.Name = ld.name__c;
                    sL.Ownerid = ld.owner__c;
                    if(ld.account__c != null){
                        sL.account__c = ld.account__c;
                    }
                    if(ld.contact__c != null){
                        sL.contact__c = ld.contact__c;
                    }
                    if(ld.stationLevel__c != null){
                        sL.stationLevel__c = ld.stationLevel__c;
                    }
                    if(ld.expectBidDate__c != null){
                        sL.expectBidDate__c = ld.expectBidDate__c;
                    }
                    if(ld.pathBy__c != null){
                        sL.pathBy__c = ld.pathBy__c;
                    }
                    if(ld.expectAmount__c != null){
                        sL.estimatedAmount__c = ld.expectAmount__c;
                    }
                    if(ld.Description != null){
                        sL.requirements__c = ld.Description;
                    }
        
                    insert sL;
                    
                    EmailTemplate ETConvert = [Select id from EmailTemplate where DeveloperName =:'leadsConvertedNotification' limit 1];
                    //FP.sendEmails(toAddresses,ld.id,ETConvert.id);
                    ld.transDate__c = system.today();
                    lock(ld);       
                    }
                 catch(exception e){
                    ld.addError(System.Label.A_Error_info);
                    }
                 }
              }
            }
            
       public void lock(Lead x){
          Approval.LockResult lr=Approval.lock(x, true); 
       }
     
}