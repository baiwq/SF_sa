trigger SchedulingAfterUpdate on scheduling__c (after update) {
/*
   for(scheduling__c s : Trigger.new){
      scheduling__c o = Trigger.oldMap.get(s.id);
      if(s.approvalStatus__c == '审批通过' && s.approvalStatus__c != o.approvalStatus__c && s.companyCode__c != null && s.orgCode__c != null){
         SoapSendAccountToSap.soapSendAccountToSap(s.accountID__c,'C',s.companyCode__c,s.orgCode__c);
      }       
   }
 */
}