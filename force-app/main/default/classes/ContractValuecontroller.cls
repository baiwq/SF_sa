public with sharing class ContractValuecontroller {
    public Decimal returnP{get;set;}
    public Decimal invoiceP1{get;set;}
    public Decimal invoiceP2{get;set;}
    public Decimal retinvP{get;set;}
    public ContractValuecontroller(ApexPages.StandardController controller) {
       ID RecordId = ApexPages.currentPage().getParameters().get('id');
       Contract__c cc = [Select id,returnProportion__c, receiptProportion__c, retinvPercent__c, invoicePercent__c  from Contract__c where id = :RecordId];
        if(cc.returnProportion__c==null){
            returnP=0.00;
        }
        if(cc.receiptProportion__c==null){
            invoiceP1=0.00;
        }
        if(cc.invoicePercent__c==null){
            invoiceP2=0.00;
        }
        if(cc.retinvPercent__c==null){
            retinvP=0.00;
        }
        //回款完成
         returnP = cc.returnProportion__c;
         //收据比例
         invoiceP1 = cc.receiptProportion__c;
         //开票比例
         invoiceP2 = cc.invoicePercent__c;
         //开票应收
         retinvP = cc.retinvPercent__c;
    }

}