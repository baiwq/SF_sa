global class ContactChartHelper{
    webservice static void updateRecord(String id, String ToId){
        if(ToId == 'AccountId'){
           ToId = null;
        }
        Contact c = [Select id,ReportsToId from Contact where id = :id];
        c.ReportsToId = ToId;
        Update c;
    }
}