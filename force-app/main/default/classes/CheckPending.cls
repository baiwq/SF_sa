public class CheckPending {
   	 public CheckPending(ApexPages.StandardController controller) {
         
         ID RecordId = ApexPages.currentPage().getParameters().get('id');

         String UserId = UserInfo.getUserId();
         String UserEmail = UserInfo.getUserEmail();
         DateTime dt = DateTime.now().addMinutes(-3);
         if(System.Test.isRunningTest()){
             dt = DateTime.now().addMinutes(-20000000);
             UserId = '00528000005Doig';
             RecordId = 'a0V0I00000W2aGH';
             
             //测试
             //RecordId = 'a0O0w000000MS2I';
         }
         
         User UserInfo_code = [select staffID__c  from user where id =:UserId];
         String GetToken_url = 'http://sfis.sf-auto.com:10985/api/Kafka/GetToken?Email='+UserEmail+'&Number='+UserInfo_code.staffID__c;
         String token = '';
         String url = 'http://sfis.sf-auto.com:10985/api/Kafka/VerificationToken?token=';
        
          List<ProcessInstance> ProcessInstanceList = [SELECT Id, TargetObjectId, Status,SubmittedById, IsDeleted, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp FROM ProcessInstance where TargetObjectId =:RecordId and LastModifiedById =:UserId and LastModifiedDate >:dt];
        
          //System.debug(ProcessInstanceList);
          if(ProcessInstanceList.size()>0){
              System.debug(GetToken_url);
              token = getToken(GetToken_url);
              if(token != null && token != ''){
                  url+= token;
                  Http http = new Http();
                  HttpRequest request = new HttpRequest();
                  request.setEndpoint(url);
                  request.setMethod('GET');
                  if(!System.Test.isRunningTest()){
                  	HTTPResponse res = http.send(request);
                  }
              }
            
          }
     
     }
    
    
     public static String getToken(String GetToken_url){         
          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(GetToken_url);
          request.setMethod('GET');
          request.setTimeout(120000);
         String str = '';

         if(!System.Test.isRunningTest()){
             HTTPResponse res = http.send(request);
             if(res.getStatusCode() == 200){
                 str = String.valueOf(res.getBody());
             } 
         }else{
             str = '123123';
         }
          
          return str;   
      }      
}