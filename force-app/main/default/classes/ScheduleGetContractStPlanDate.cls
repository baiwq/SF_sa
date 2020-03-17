global class ScheduleGetContractStPlanDate implements Schedulable {
    global void execute(SchedulableContext SC){

        GetContractStPlanSchedule.getConPlanDate();       
       // ID batchGetContractStPlanDate =Database.executeBatch(new GetContractStPlanDate());
    }
}