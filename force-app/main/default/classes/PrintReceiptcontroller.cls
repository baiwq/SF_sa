public class PrintReceiptcontroller {
    public String receiptNo{get;set;}
    public String invoiceCompany{get;set;}
    public String nowReceived{get;set;}
    public String handedType{get;set;}
    public String digitalCapital{get;set;}
    public Decimal amount{get;set;}
    public String apply{get;set;}
    public String payee{get;set;}
    public String content{get;set;}
    public String applyDateF{get;set;}
        
    public PrintReceiptcontroller(ApexPages.StandardController controller) {
       ID RecordId = ApexPages.currentPage().getParameters().get('id');
       receipt__c cc = [Select id, Name, invoiceCompany__c,receiptNO__c,receiptAccount__c, moneyType__c,digitalCapital__c,receiptAmount1__c,applyBy__c,payeeUser__c,applyDateF__c,content__c from receipt__c where id = :RecordId];
       try{
          User usra = [Select id,Name from User where id = :cc.applyBy__c];
          User usrb = [Select id,Name from User where id = :cc.payeeUser__c];
          Account acc = [Select id,Name from Account where id = :cc.receiptAccount__c];              
          receiptNo = cc.Name;
          invoiceCompany = cc.invoiceCompany__c;
          nowReceived = acc.Name;
          handedType = cc.moneyType__c;
          digitalCapital = cc.digitalCapital__c;
          amount = cc.receiptAmount1__c;
          apply = usra.Name;
          payee = usrb.Name;  
          content = cc.content__c;   
          applyDateF = cc.applyDateF__c; 
       }catch(Exception e){

       }
       
    }

}