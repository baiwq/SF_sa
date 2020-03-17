trigger OpportunityAfterInsert on Opportunity (after insert) {
if(trigger.new.size()>100){
      return;
   }else{
      for(Opportunity newCC:trigger.new){   
          if(newCC.level1center__c == '国际业务'&& newCC.leadSource__c != null){
              List<attachment__c> atcList =[select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,opportunity__c,quatation__c,contractReview__c,bidReview__c,salesLeads__c from attachment__c where  salesLeads__c =:newCC.leadSource__c  and  isValid__c = '有效' and attachmentURL__c != null]; 
              if(atcList.size() > 0){
                  List<attachment__c> List2 = new List<attachment__c>();
                    for(attachment__c at:atcList){
                        attachment__c atcUpList = new attachment__c();
                        if(at.documentName__c != null)
                         atcUpList.documentName__c = at.documentName__c;
                        if(at.isValid__c != null)
                         atcUpList.isValid__c = at.isValid__c ;
                        if(at.type__c != null)
                         atcUpList.type__c = at.type__c; 
                        if(at.attachmentURL__c != null)
                         atcUpList.attachmentURL__c = at.attachmentURL__c; 
                        if(at.notes__c != null)
                         atcUpList.notes__c = at.notes__c; 
                        if(at.AttachmentCome__c != null)
                         atcUpList.AttachmentCome__c = at.AttachmentCome__c;                 
                         atcUpList.opportunity__c = newCC.Id; 
                         List2.add(atcUpList);                                
                    }
                    insert List2;  
              }
          }
      }
    }
}