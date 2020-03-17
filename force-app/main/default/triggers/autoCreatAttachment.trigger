/***
*供货范围附件传递
*创建人：杨明
*创建时间：2019-1-8
*sf-auto-tranzvision
***/
trigger autoCreatAttachment on contractreview__c (after insert,after update) {
if(Trigger.isInsert){
     for(contractreview__c c:Trigger.new){
        if(c.quatation__c != null){
         list<attachment__c> atcUpList = new list<attachment__c>();
          List<attachment__c> atcList =[select id,contractReview__c,ChangeNum__c  from attachment__c where quatation__c =:c.quatation__c and type__c ='供货范围清单' and isValid__c = '有效' and attachmentURL__c != null]; 
//如果供货范围变化，则将供货范围清单附件置为无效
          if(c.IsChange__c == false){
              for(attachment__c at:atcList){
                   at.contractReview__c  = c.id;    
                   at.ChangeNum__c  = ((at.ChangeNum__c==null)?0:at.ChangeNum__c++);       
                   atcUpList.add(at);                
              }             
           }
           else{
              for(attachment__c at:atcList){
                   at.contractReview__c  = c.id; 
                   at.isValid__c = '无效';  
                   at.ChangeNum__c  = ((at.ChangeNum__c==null)?0:at.ChangeNum__c++);       
                   atcUpList.add(at);                
              } 
           }    
           List<attachment__c> atcList22 =[select id,contractReview__c,ChangeNum__c  from attachment__c where quatation__c =:c.quatation__c and (type__c ='标准报价' or type__c='投标报价') and isValid__c = '有效' and attachmentURL__c != null];
           for(attachment__c asd:atcList22){
                   asd.contractReview__c  = c.id;    
                   asd.ChangeNum__c  = ((asd.ChangeNum__c==null)?0:asd.ChangeNum__c++);       
                   atcUpList.add(asd); 
           }      
           update atcUpList;
       }
     }
   }
else{
    for(contractReview__c c:Trigger.new){
       if(c.quatation__c != null){
         contractreview__c cold = Trigger.oldMap.get(c.id);
         if(c.IsChange__c != cold.IsChange__c && c.IsChange__c == true ){
             List<attachment__c> atcList =[select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,quatation__c,ChangeNum__c from attachment__c where quatation__c =:c.quatation__c and contractReview__c =:c.id and (type__c ='供货范围清单') and isValid__c = '有效' and attachmentURL__c != null];         
             List<attachment__c> atcList2 =[select id,Name,documentName__c,AttachmentCome__c,isValid__c,type__c,attachmentURL__c,notes__c,quatation__c,ChangeNum__c from attachment__c where quatation__c =:c.quatation__c and contractReview__c =:c.id and (type__c ='供货范围清单') and isValid__c = '有效' and AttachmentCome__c ='报价管理' and attachmentURL__c != null]; 
            SYSTEM.DEBUG('1111111'+atcList2);
            if(atcList2.size()>0){
            List<attachment__c> Listmsf = new List<attachment__c>();                
                 for(attachment__c atc:atcList2){
                 attachment__c atcUpList2 = new attachment__c();
                    if(atc.documentName__c != null)
                     atcUpList2.documentName__c = atc.documentName__c;
                    if(atc.isValid__c != null)
                     atcUpList2.isValid__c = '有效' ;
                    if(atc.type__c != null)
                     atcUpList2.type__c = atc.type__c; 
                    if(atc.attachmentURL__c != null)
                     atcUpList2.attachmentURL__c = atc.attachmentURL__c; 
                    if(atc.notes__c != null)
                     atcUpList2.notes__c = atc.notes__c; 
                    if(atc.AttachmentCome__c != null)
                     atcUpList2.AttachmentCome__c = atc.AttachmentCome__c;                   
                     atcUpList2.quatation__c = atc.quatation__c ; 
                     atcUpList2.IsLastVersion__c = false;
                     Listmsf.add(atcUpList2);                      
                 }
                    insert Listmsf;  
                 list<attachment__c> atcUpList = new list<attachment__c>();
                 for(attachment__c at:atcList){
                      at.ChangeNum__c  = ((at.ChangeNum__c==null)?0:at.ChangeNum__c++);
                      at.isValid__c = '无效';  
                      at.quatation__c = null;
                    atcUpList.add(at);                  
                 }
                 update atcUpList;                
            }
         }
       }
       
       
       
       
    }
  }
}