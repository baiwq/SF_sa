trigger TbbaozhengjinAfterUpdate on tbbaozhengjin__c (after update) {
   public boolean flag = true;
   for(tbbaozhengjin__c tb : Trigger.new){

//判断投标保证金是否清分   
      tbbaozhengjin__c tbOld = Trigger.oldMap.get(tb.id);
      List<tbbaozhengjin__c> tbList = [select returnOrNot__c from tbbaozhengjin__c where opportunity__c=:tb.opportunity__c];        
         for(tbbaozhengjin__c t : tbList){
            if(t.returnOrNot__c==false){
               flag=false;
               break;
            }
         }
      
      Opportunity o =[Select assignIsExisted__c from Opportunity where id=: tb.opportunity__c ];
      if(flag){
         o.assignIsExisted__c=true;
      }else{
         o.assignIsExisted__c=false;
      }
      update o;  

//判断是否同步客户SAP,如果审批通过就同步
      if(tb.approvalStatus__c == '审批通过' && tb.approvalStatus__c != tbOld.approvalStatus__c){
         SoapSendAccountToSap.soapSendAccountToSap('投标保证金',tb.account__c,'D',tb.companyCode__c,null);
      }   
      
    }
}