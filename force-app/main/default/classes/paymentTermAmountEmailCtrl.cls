public class paymentTermAmountEmailCtrl {
     public String cId {get;set;}
        public List<paymentTerm__c> getPaymentTermList(){
            if(cId!=null){
                List<paymentTerm__c> terms = [SELECT Id,Name,No__c ,surplusMoney__c,stageDate__c,returnStage__c,contractNo__c,stage__c,percentage__c,backMoney__c from paymentTerm__c where contract__c=:cId];
                
                return terms;
            }else{
                return null;
            }
        }
}