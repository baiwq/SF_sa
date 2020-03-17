@isTest(seeAllData=true)
public class TestFileServer{
    @isTest static void testEchoString() {              
       Test.setMock(WebServiceMock.class, new TestMockImplFileServer());
       FileServerMethod.ext();
    }
}