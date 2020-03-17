Global class SOSPGetInvoiceInfo {
    @future(callout=true)
    Global static void getInvoiceInfo(){
        Date nowdays = System.today();
        String startDate = datetime.newinstance(nowdays.addDays(-1).year(), nowdays.addDays(-1).month(), nowdays.addDays(-1).day()).format('yyyy-MM-dd')+' 00:00:00.000';
        String endDate = datetime.newinstance(nowdays.addDays(-1).year(), nowdays.addDays(-1).month(), nowdays.addDays(-1).day()).format('yyyy-MM-dd')+' 23:59:59.000';
        System.Debug('startDate: ' + startDate);
        System.Debug('endDate: ' + endDate);
        getInvoiceInfo invoice = new getInvoiceInfo();
        invoice.getInvoiceInfo(startDate, endDate);
    }
}