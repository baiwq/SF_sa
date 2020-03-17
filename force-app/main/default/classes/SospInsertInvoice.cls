public class SospInsertInvoice{
    @future(callout=true)
    public static void SospInsertInvoice(String sId){
        insertInvoice invoiceObj = new insertInvoice();
        invoiceObj.insertInvoice(sId);
    }
}