public with sharing class PlanValuecontroller {
    public Decimal returnP{get;set;}
    public Decimal invoiceP1{get;set;}

 
    public PlanValuecontroller(ApexPages.StandardController controller) {
       ID RecordId = ApexPages.currentPage().getParameters().get('id');
       Plan__c cc = [Select id, percentOfContract__c, percentOfReturn__c, totalWeight__c  from Plan__c where id = :RecordId];
        if(cc.percentOfContract__c==null){
            returnP=0.00;
        }
        if(cc.percentOfReturn__c==null){
            invoiceP1=0.00;
        }
        //合同完成
         returnP = cc.percentOfContract__c;
         //回款完成
         invoiceP1 = cc.percentOfReturn__c;
         
    }

}