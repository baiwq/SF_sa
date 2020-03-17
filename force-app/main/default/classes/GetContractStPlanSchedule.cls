global class GetContractStPlanSchedule {
    @Future(callout=true)
    global static void getConPlanDate(){
        Datetime nowDate = System.now();
        Datetime lastDate = System.now()-1;
        String startDate = (lastDate).format('yyyy-MM-dd HH:mm:ss');
        String endDate=nowDate.format('yyyy-MM-dd HH:mm:ss');
        GetContractStPlanDate getContractStPlanDate = new GetContractStPlanDate();
        getContractStPlanDate.GetContractStPlanDate(startDate, endDate);
    }
}