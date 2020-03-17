public class PrintSF {
   public String ApplyName{get;set;}
   public String ApplyPhone{get;set;}
   public String AccountName{get;set;}
   public String Receiver{get;set;}
   public String ReceiverPhone{get;set;}
   public String ShippingAddress{get;set;}
   public String ExpressComments{get;set;}
   
   public PrintSF(){
      String RecordId = ApexPages.currentPage().getParameters().get('id');
      invoice__c I = [Select id, name, applyByName__c, applyPhone__c, accountName__c, receiver__c, receiverPhone__c, shippingAddress__c, expressComments__c from invoice__c where id=: RecordId];
      ApplyName = I.applyByName__c;
      ApplyPhone = I.applyPhone__c;
      AccountName = I.accountName__c;
      Receiver = I.receiver__c;
      ReceiverPhone = I.receiverPhone__c;
      ShippingAddress = I.shippingAddress__c;
      ExpressComments = I.expressComments__c;
   }
}