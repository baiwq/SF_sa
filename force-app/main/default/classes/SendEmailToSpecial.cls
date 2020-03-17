global class SendEmailToSpecial {
    webservice static Boolean exe_SendEmail(String[] toAddress,String objectId,String whatId,String TemplateId){
        system.debug('toAddress12---'+toAddress);
            system.debug('objectId12---'+objectId);
            system.debug('whatId12---'+whatId);
            system.debug('TemplateId12---'+TemplateId);
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);
            mail.setReplyTo('sam.sun@tranzvision.com.cn');
            mail.setSenderDisplayName('四方继保SOSP项目组');
            mail.setTemplateId(TemplateId);
            mail.setTargetObjectId(objectId);
            mail.saveAsActivity = false;
            mail.setWhatId(whatId);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
            system.debug('toAddress---'+toAddress);
            system.debug('objectId---'+objectId);
            system.debug('whatId---'+whatId);
            system.debug('TemplateId---'+TemplateId);
            return true;
        }catch(Exception e){
            return false;
        }
    }
}