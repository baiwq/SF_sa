global class ScheduleGetInvoiceInfo implements Schedulable {
    global void execute(SchedulableContext SC){
        SOSPGetInvoiceInfo.getInvoiceInfo();
        //ID batchGetInvoiceInfo =Database.executeBatch(new BatchGetInvoiceInfo());
    }
}