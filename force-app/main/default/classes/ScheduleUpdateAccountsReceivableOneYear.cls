global class ScheduleUpdateAccountsReceivableOneYear implements Schedulable {
    global void execute(SchedulableContext SC){
        UpdateAccountsReceivableOneYear.getList();
    }
}