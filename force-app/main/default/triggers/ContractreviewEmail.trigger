trigger ContractreviewEmail on contractreview__c (before insert) {
    for(contractreview__c cr : Trigger.new){
         if(cr.quatation__c != null){
       
            List<User> recipientList =[Select id ,Email from User where id=:cr.QuatationCreatedBy__c or id=:cr.accountManager__c ];
            Map<String,String> recipientMap =new Map<String,String>();
            recipientMap.put(recipientList[0].Id,recipientList[0].Email);
            if(recipientList.size()==2){
                recipientMap.put(recipientList[1].Id,recipientList[1].Email);
            }
            
            List<String> toAddress = new List<String>();
            toAddress.add(recipientMap.get(cr.QuatationCreatedBy__c));
            String templateBid;
            EmailTemplate outsourcingTemplate = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ContractreviewSendEmailToScope' limit 1];
            templateBid = outsourcingTemplate.Id;
            system.debug('QuatationCreatedBy__c---'+cr.QuatationCreatedBy__c);
            system.debug('recipientMap-----'+recipientMap);
            system.debug('toAddress-----'+toAddress);
            system.debug('ccAddress-----'+recipientMap.get(cr.accountManager__c));
            EmailToolClass.sendEmailtbry(toAddress,cr.OwnerId,cr.Id,templateBid,recipientMap.get(cr.accountManager__c));
        }
                                                
    }                       
}