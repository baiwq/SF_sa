global class RestClient {
      public static final String url_address = CPQ_config__c.getValues('CPQ_config').urlAddress__c;
    
      public static final String username = CPQ_config__c.getValues('CPQ_config').UserName__c;
    
      public static final String pwd = CPQ_config__c.getValues('CPQ_config').Passwd__c;
    
    
      //获取CPQ token
      webservice  static String getToken(){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Account/LoginSYS?username='+username+'&pwd='+pwd+'&operationuser='+operationuser;

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(120000);

 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }      


      //获取CPQ供货范围清单返回数据
      //  token  Token
      //  businessNo  业务机会号
      //  quotationNo 报价管理编号
      //  reviewNumber  合同评审编号
      //  type  类型
      //  contract  合同号
      //  operationuser 操作用户
      //http://42.159.82.230:8088/api/Approval/Create?token=c0a1f5f7b24a40ada8e55d467f16b133&businessNo=1234&quotationNo=124&reviewNumber=1251&type=taewt&contract=1245&operationuser=1515
      webservice  static String getSupply(String token,String businessNo,String quotationNo,String reviewNumber,String type){ 
          String operationuser = UserInfo.getName();
         // String operationus123 = UserInfo.getUserName();
          String url = url_address+'/Approval/Create?businessNo='+businessNo+'&quotationNo='+quotationNo+'&reviewNumber='+reviewNumber+'&type='+type+'&token='+token+'&operationuser='+operationuser;
          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(120000);
 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }


      //获取CPQ token
      webservice  static String getTokeninfo(){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Account/LoginSYS?username='+username+'&pwd='+pwd+'&operationuser='+operationuser;

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(120000);

 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(String.valueOf(res.getBody()),HttpMessage.class);
              if(httpmessage.status == 'success'){
                  str = httpmessage.token;
              }
          }
          return str;   
      }      



      //合同评审--创建供货范围清单
      webservice  static String getSupplyInfo(String tbid,String businessNo,String quotationNo,String reviewNumber,String type){ 
          //  token  Token
          //  businessNo  业务机会号
          //  quotationNo 报价管理编号
          //  reviewNumber  合同评审编号
          //  type  类型
          //  contract  合同号
          //  operationuser 操作用户
          String token = '';
          String Supplyinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Supplyinfo = getSupply(token, businessNo, quotationNo, reviewNumber, type);
                  //Supplyinfo = getSupply(token, businessNo, quotationNo, reviewNumber, type,contract,org);
                  if(Supplyinfo != null){
                      HttpMessage SupplyinfoMessage = (HttpMessage)JSON.deserializeStrict(Supplyinfo,HttpMessage.class);
                      if(SupplyinfoMessage.status == 'success'){
                          
                          contractreview__c contractreview =  [select contractAmount__c,CalculatesGrossMargin__c,NewBusiness__c,CustomerSpecified__c,SalesDesignation__c,updateghfw__c,sfscghfw__c,OwnerId from contractreview__c where id = :tbid];
                          contractreview.updateghfw__c = SupplyinfoMessage.resultUrl;
                          contractreview.sfscghfw__c = '是';
                          update contractreview;
                          if(!System.Test.isRunningTest()){
                              ContractreviewCPQ.getRate(tbid, reviewNumber, contractreview.contractAmount__c+'');
                          }else{
                              String testlog = '123';
                          }
                          
                        List<attachment__c> listac = [select OwnerId,contractReview__c,typeCode__c,attachmentURL__c,IsLastVersion__c,isValid__c from attachment__c where contractReview__c=:tbid and typeCode__c='1'  and isValid__c ='有效']; 
                          for(attachment__c ac:listac){
                              ac.isValid__c = '无效';
                              ac.IsLastVersion__c = false;
                          }
                          update listac; 
                          attachment__c attachment = null;
                          if(SupplyinfoMessage.filePath!= null){  
                              attachment = new attachment__c();
                              attachment.attachmentURL__c = SupplyinfoMessage.filePath;
                              attachment.contractReview__c = tbid;
                              attachment.IsLastVersion__c = false;
                              attachment.type__c = '供货范围清单';
                              attachment.isValid__c ='有效';
                              attachment.documentName__c = reviewNumber+'供货范围清单.xlsx';
                              attachment.OwnerId = '00528000005ATSv';
                              insert attachment;
                          }
                         
                      }else{
                          return SupplyinfoMessage.msg;
                      }
                  }
              }else{
                  return httpmessage.msg;
              }
          }
          return 'success';  
      } 

    
     //提交供货范围清单
      //http://42.159.82.230:8088/api/Approval/Submit?token=98c90293d74045c898db076943ed6bf6&businessNo=OT-00000001&quotationNo=S-00000001&reviewNumber=1&operationuser=1
       webservice  static  String getSubmit(String token,String businessNo,String quotationNo,String reviewNumber,String type){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Approval/Submit?businessNo='+businessNo+'&quotationNo='+quotationNo+'&reviewNumber='+reviewNumber+'&token='+token+'&operationuser='+operationuser+'&type='+type;
          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(120000);

 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }
    
   //提交供货范围清单
      webservice  static String getSubmitinfo(String tbid,String businessNo,String quotationNo,String reviewNumber,String type){ 
          //  token  Token
          //  businessNo  业务机会号
          //  quotationNo 报价管理编号
          //  reviewNumber  合同评审编号
          String token = '';
          String Submitinfo = '';
          String tokeninfo = getToken();

          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Submitinfo = getSubmit(token, businessNo, quotationNo, reviewNumber,type);
                  if(Submitinfo != null){
                      HttpMessage SubmitinfoMessage = (HttpMessage)JSON.deserializeStrict(Submitinfo,HttpMessage.class);
                      if(SubmitinfoMessage.status == 'success'){
                          contractreview__c contractreview =  [select OwnerId,CpqversionUrl__c from contractreview__c where id = :tbid];
                          contractreview.CpqversionUrl__c = SubmitinfoMessage.resultUrl;
                          contractreview.Submitcpq__c = '成功';
                          update contractreview;
                          List<attachment__c> listac = [select contractreview__c,typeCode__c,attachmentURL__c,isValid__c from attachment__c where contractReview__c =:tbid and typeCode__c='1' and isValid__c ='有效' ]; 
                          if(listac.size() > 0){
                              for(integer i = 0;i<listac.size();i++){
                                  if(i==0){
                                      listac.get(i).attachmentURL__c = SubmitinfoMessage.filePath;
                                  }else{
                                      listac.get(i).isValid__c = '无效';
                                  }
                                  update listac; 
                              }  
                          }
                          
                      }else{
                         LogClass.returnLog('失败','未处理','SOSP提交CPQ失败，id'+tbid+'，提示信息：'+SubmitinfoMessage.msg,'重要');
                         return SubmitinfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 

    
    

      global class HttpMessage{
            public String status{get;set;} 
            public String msg{get;set;}
            public String token{get;set;} 
            public String resultUrl{get;set;} 
            public String filePath{get;set;} 
            public String comment{get;set;} 
            public String data{get;set;} 
          
       }


}