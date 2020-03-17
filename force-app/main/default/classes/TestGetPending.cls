@isTest
public class TestGetPending {
    @isTest(SeeAllData=true) static void testGetPending(){
        system.test.startTest();
        //Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
     	GetPending.GetPendingList('zhangping_yn@sf-auto.com.tob');
        GetPending.GetPendingList('yangjun@sf-auto.com');
        system.test.stopTest();
    }
    
    
     @isTest(SeeAllData=true) static void testGetPendingBysubmit(){
        system.test.startTest();
        //Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
     	GetPendingBysubmit.GetPendingBySubmitList('fuxiao@sf-auto.com.tob');
        GetPendingBysubmit.GetPendingBySubmitList('gongxuelu@sf-auto.com');
        system.test.stopTest();
    }
}