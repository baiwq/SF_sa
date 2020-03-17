trigger changestatusdm on contractreview__c (after update) {
 for(contractReview__c c:Trigger.new){
 contractreview__c cold = Trigger.oldMap.get(c.id);
 if(c.IsChange__c != cold.IsChange__c && c.IsChange__c == true ){
 List<attachment__c> atcList =[select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,quatation__c,ChangeNum__c from attachment__c where quatation__c = null and contractReview__c =:c.id and (type__c ='供货范围清单') and isValid__c = '有效' and attachmentURL__c != null]; 
  list<attachment__c> atcUpList = new list<attachment__c>();
  String name ='1111';
  string alde ='weqeq';
  String peoled = 'dsae';
                 for(attachment__c at:atcList){
                      at.ChangeNum__c  = ((at.ChangeNum__c==null)?0:at.ChangeNum__c++);
                      at.isValid__c = '无效';  
                    atcUpList.add(at);                  
                 }
                 update atcUpList;     

 }
 }
}