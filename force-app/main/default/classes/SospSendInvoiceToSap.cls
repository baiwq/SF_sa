public class SospSendInvoiceToSap{
    @future(callout=true)
    public static void SospSendInvoiceToSap(Set<Id> idList){
        sendInvoiceToSAP obj = new sendInvoiceToSAP();
        Boolean bool = obj.sendInvoiceToSAP(idList);
    }
}