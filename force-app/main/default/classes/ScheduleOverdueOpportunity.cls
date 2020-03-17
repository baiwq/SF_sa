global class ScheduleOverdueOpportunity implements Schedulable {
    global void execute(SchedulableContext SC){
        OverdueOpportunity.getData();       
    }

}