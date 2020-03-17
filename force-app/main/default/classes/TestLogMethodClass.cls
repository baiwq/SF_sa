@isTest
public class TestLogMethodClass{
    static testMethod void testLogMethod(){
        test.startTest();
        LogClass.returnLog('成功','已处理','','正常');
        LogClass.returnLog('成功','处理','','正常');
        log__c l1 = LogClass.reLog('成功','已处理','','正常');
        List<log__c> li= new List<log__c>();
        li.add(l1);
        LogClass.insertLog(li);
        List<log__c> li2= new List<log__c>();
        LogClass.insertLog(li2);
        test.stopTest();
    }
}