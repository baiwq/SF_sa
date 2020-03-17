/***
*标识合同来源
*创建人：杨明
*创建时间：2019-1-4
*sf-auto-tranzvision
***/
trigger IdentifySources on attachment__c (before insert) {
    for(attachment__c c:Trigger.new){
        if(c.type__c == '供货范围清单'){       
            if( c.quatation__c != null && c.contract__c==null && c.contractReview__c == null && c.contractChange__c == null){
               c.AttachmentCome__c = '报价管理';
              }
            if( c.contractReview__c != null && c.contract__c == null && c.contractChange__c == null){
               c.AttachmentCome__c = '合同评审';
              }
            if(c.contract__c != null && c.AttachmentCome__c == null && c.contractChange__c == null ){
               c.AttachmentCome__c ='合同管理';
              }
            if(c.contractChange__c != null && c.AttachmentCome__c == null){
               c.AttachmentCome__c ='合同变更';
              }
        }
    }
}