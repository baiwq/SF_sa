public class PerformanceImp {
    
      public static final String url_address = CPQ_config__c.getValues('CPQ_config').urlAddress__c;
    
      public static final String username = CPQ_config__c.getValues('CPQ_config').UserName__c;
    
      public static final String pwd = CPQ_config__c.getValues('CPQ_config').Passwd__c;
    

      public class HttpMessage{
          public String status{get;set;} 
          public String msg{get;set;}
          public String token{get;set;} 
          public String resultUrl{get;set;} 
          public String filePath{get;set;} 
          public String comment{get;set;} 
          public String data{get;set;} 
          
       }
    
       public class Achievement{
          public String achievement_id{set;get;}
            public String department{set;get;}
            public String contract_no{set;get;}
            public String achievement_scale{set;get;}
            public String achievement_money{set;get;}
            public String achievement_type{set;get;}
            public String achievement_datetime{set;get;}
        
        }
    
      //获取CPQ token
      public String getToken(){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Account/LoginSYS?username='+username+'&pwd='+pwd+'&operationuser='+operationuser;

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }      



      public String SaveAchievement(String token,String data){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/PS/AddAchievement?token='+token;
          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('POST');
          request.setHeader('Content-Type', 'application/json;charset=UTF-8');
          request.setBody(data);

 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }

    
    
     public String EditAchievement(String token,String data){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/PS/EditAchievement?token='+token;
          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('POST');
          request.setBody(data);
          request.setHeader('Content-Type', 'application/json;charset=UTF-8');
         // 将主体设置为JSON对象
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }


    
      public String SaveAchievementinfo(String id,String achievement_id, String department, String contract_no, String achievement_scale, String achievement_money, String achievement_type, String achievement_datetime ){
          String token = '';
          String Achievementinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  List<Achievement> Achievement_list = new List<Achievement>();
                  Achievement AchievementVo = new Achievement();
                  AchievementVo.achievement_id = achievement_id;
                  AchievementVo.department = department;
                  AchievementVo.contract_no = contract_no;
                  AchievementVo.achievement_scale = achievement_scale;
                  AchievementVo.achievement_money = achievement_money;
                  AchievementVo.achievement_type = achievement_type;
                  AchievementVo.achievement_datetime = achievement_datetime;
                  Achievement_list.add(AchievementVo);
                  String data =  JSON.serialize(Achievement_list);
                  Achievementinfo = SaveAchievement(token,data);
                  if(Achievementinfo != null){
                      HttpMessage AchievementinfoMessage = (HttpMessage)JSON.deserializeStrict(Achievementinfo,HttpMessage.class);
                      if(AchievementinfoMessage.status != 'success'){
                         LogClass.returnLog('失败','未处理','【事业部业绩创建失败】SOSP提交CPQ失败，id'+id+'，提示信息：'+AchievementinfoMessage.msg,'重要');
                         return AchievementinfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【事业部业绩创建失败】SOSP提交CPQ失败，id'+id+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 


    
    
     public String EditAchievementinfo(String id,String achievement_id, String department, String contract_no, String achievement_scale, String achievement_money, String achievement_type, String achievement_datetime ){
          String token = '';
          String Achievementinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                   List<Achievement> Achievement_list = new List<Achievement>();
                  Achievement AchievementVo = new Achievement();
                  AchievementVo.achievement_id = achievement_id;
                  AchievementVo.department = department;
                  AchievementVo.contract_no = contract_no;
                  AchievementVo.achievement_scale = achievement_scale;
                  AchievementVo.achievement_money = achievement_money;
                  AchievementVo.achievement_type = achievement_type;
                  AchievementVo.achievement_datetime = achievement_datetime;
                  Achievement_list.add(AchievementVo);
                  String data =  JSON.serialize(Achievement_list);
                  Achievementinfo = EditAchievement(token,data);
                  if(Achievementinfo != null){
                      HttpMessage AchievementinfoMessage = (HttpMessage)JSON.deserializeStrict(Achievementinfo,HttpMessage.class);
                      if(AchievementinfoMessage.status != 'success'){
                         LogClass.returnLog('失败','未处理','【事业部业绩修改失败】SOSP提交CPQ失败，id'+id+'，提示信息：'+AchievementinfoMessage.msg,'重要');
                         return AchievementinfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【事业部业绩修改失败】SOSP提交CPQ失败，id'+id+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 



     


}