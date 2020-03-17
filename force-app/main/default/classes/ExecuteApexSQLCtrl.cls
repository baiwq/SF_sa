public class ExecuteApexSQLCtrl {
    public String startDate{get;set;}
    public String endDate{get;set;}
    public String IndexField{get;set;}
    public List<paymentTerm__c> objList{get;set;}
    public Integer objListSize{get;set;}
    public ExecuteApexSQLCtrl(){
        
    }
    public void getData(){
        system.debug('startDate----'+startDate);
        system.debug('endDate----'+endDate);
        Datetime st = Datetime.valueOf(startDate);
        Datetime et = Datetime.valueOf(endDate);
        if(IndexField == '1')
            objListSize =[Select id from paymentTerm__c where LastModifiedDate>=:st and LastModifiedDate<=:et].size();
        else
            objListSize =[Select id from paymentTerm__c where CreatedDate>=:st and CreatedDate<=:et].size();

    }
    
}