global class SchedulePaymentSendEmail implements Schedulable {
    global void execute(SchedulableContext SC){
       Messaging.Email[] messages = new Messaging.Email[0];
       EmailTemplate ET = [Select id from EmailTemplate where DeveloperName =:'CKTemplate1' limit 1];  
       List<paymentTerm__c> PTList = [select id,paymentStageDate__c,surplusMoney__c,sendEmailFlag__c, LYUserId__c, CreatedById from paymentTerm__c where surplusMoney__c > 0 and sendEmailFlag__c = false and paymentStageDate__c <= :System.today() and LYUserId__c != null limit 499];
       if(PTList.size() > 0){
          for(paymentTerm__c p:PTList){
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setReplyTo('sam.sun@tranzvision.com.cn');
             mail.setSenderDisplayName('四方继保SOSP项目组');
             mail.setTemplateId(ET.id);
             mail.setTargetObjectId(p.LYUserId__c);
             mail.saveAsActivity = false;
             mail.setWhatId(p.Id);
             messages.add(mail);
             p.sendEmailFlag__c = true;
          }
       }
       Messaging.sendEmail(messages); 
       update PTList;
    }
}