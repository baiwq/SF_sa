public class TestCon {
   	 public TestCon(ApexPages.StandardController controller) {
       	 String url = 'http://sfis.sf-auto.com:10023/api/Task/getTaskData/';

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
 
          HTTPResponse res = http.send(request);
      }
}