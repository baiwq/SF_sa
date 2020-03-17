global class SchduleCalculateFinancialAmount implements Schedulable {
    global void execute(SchedulableContext sc) {
        Date currentDay = System.today();
        Date s1 = Date.newInstance(currentDay.Year(),currentDay.Month()+1,1);
        Date ss=Date.newInstance(currentDay.Year(),currentDay.Month(),s1.addDays(-1).Day());
        CalculateFinancialAmount.calculateAmount(currentDay.Year(), currentDay.Month(),  ss);
    }
}