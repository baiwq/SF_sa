global class ScheduleContractChangeTobpm implements Schedulable {
    global void execute(SchedulableContext SC){
        ContractChangeFailList.getContractChangeFailList();
    }
}