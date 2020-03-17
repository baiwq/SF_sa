@isTest
public class TestExecuteApexSQLPage {
    public static testMethod void testApexSql(){
        
        ExecuteApexSQLCtrl ct = new ExecuteApexSQLCtrl();
        ct.startDate='2018-01-01 01:01:01';
        ct.endDate='2018-08-01 01:01:01';
        ct.getData();
    }
}