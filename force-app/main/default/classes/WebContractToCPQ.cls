global class WebContractToCPQ {
    
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



      //获取合同对应的供货范围清单
      //http://42.159.82.230:8088/api/Scheduling/Create?token=124&reviewNumber=124&businessNo=124&quotationNo=124&contract=124&type=124&operationuser=124
      webservice static String getScheduling(String token,String businessNo,String quotationNo,String reviewNumber,String contract,String type){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Scheduling/Create?businessNo='+businessNo+'&quotationNo='+quotationNo+'&reviewNumber='+reviewNumber+'&token='+token+'&operationuser='+operationuser+'&contract='+contract+'&type='+type;
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



      //合同管理--创建供货范围清单
      webservice  static String getSchedulinginfo(String tbid,String businessNo,String quotationNo,String reviewNumber,String contract,String type){ 
          String token = '';
          String Schedulinginfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Schedulinginfo = getScheduling(token, businessNo, quotationNo, reviewNumber,contract,type);
                  if(Schedulinginfo != null){
                      HttpMessage SchedulinginfoMessage = (HttpMessage)JSON.deserializeStrict(Schedulinginfo,HttpMessage.class);
                       if(SchedulinginfoMessage.status == 'success'){
                          Contract__c contract_info =  [select updateghfw__c,sfscghfw__c,OwnerId from Contract__c where id = :tbid];
                          contract_info.updateghfw__c = SchedulinginfoMessage.resultUrl;
                          contract_info.sfscghfw__c = '是';
                          update contract_info;
                          List<attachment__c> listac = [select contract__c,typeCode__c,attachmentURL__c,isValid__c,IsLastVersion__c from attachment__c where contract__c=:tbid and typeCode__c='1' ]; 
                         
                           for(attachment__c ac:listac){
                                ac.isValid__c = '无效';
                                ac.IsLastVersion__c = false;
                           }
                		  update listac;
                       
                        if(SchedulinginfoMessage.filePath!= null){
                            attachment__c attachment = new attachment__c();
                            attachment.attachmentURL__c =  SchedulinginfoMessage.filePath;
                            attachment.Contract__c = tbid;
                            attachment.type__c = '供货范围清单';
                            attachment.isValid__c ='有效';
                            attachment.IsLastVersion__c = true;
                            attachment.documentName__c = reviewNumber+'供货范围清单.xlsx';
                            attachment.OwnerId = '00528000005ATSv';
                            attachment.rbase__c = 'CPQ获取';
                            insert attachment; 
                        }
                      }else{
                         return SchedulinginfoMessage.msg;
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
       webservice  static String getSubmit(String token,String reviewNumber,String contract,String type){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Scheduling/Submit?reviewNumber='+reviewNumber+'&contract='+contract+'&token='+token+'&operationuser='+operationuser+'&type='+type;
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
       webservice  static String getSubmitinfo(String tbid,String reviewNumber,String contract,String type){ 
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
                  Submitinfo = getSubmit(token, reviewNumber, contract,type);
                  if(Submitinfo != null){
                      HttpMessage SubmitinfoMessage = (HttpMessage)JSON.deserializeStrict(Submitinfo,HttpMessage.class);
                      if(SubmitinfoMessage.status == 'success'){
                           Contract__c contractinfo =  [select CpqversionUrl__c,OwnerId from Contract__c where id = :tbid];
                           contractinfo.CpqversionUrl__c = SubmitinfoMessage.resultUrl;
                           contractinfo.Submitcpq__c = '成功';
                           update contractinfo;
                           List<attachment__c> listac = [select Contract__c,IsLastVersion__c,typeCode__c,attachmentURL__c,isValid__c from attachment__c where Contract__c=:tbid and typeCode__c='1' and isValid__c ='有效']; 
                     
                          attachment__c attachment = null;
                          if(listac.size() > 0){     
                               for(integer i = 0;i<listac.size();i++){
                                  if(i==0){
                                      listac.get(i).attachmentURL__c = SubmitinfoMessage.filePath;
                                      listac.get(i).IsLastVersion__c = true;
                                  }else{
                                      listac.get(i).isValid__c = '无效';
                                      listac.get(i).IsLastVersion__c = false;
                                  }
                                  update listac; 
                              }  
                          }else{
                               attachment = new attachment__c();
                               attachment.attachmentURL__c = SubmitinfoMessage.filePath;
                               attachment.contract__c = tbid;
                               attachment.type__c = '供货范围清单';
                               attachment.isValid__c ='有效';
                               attachment.documentName__c = reviewNumber+'供货范围清单.xlsx';
                               attachment.IsLastVersion__c = true;
                               attachment.OwnerId = '00528000005ATSv';
                               attachment.rbase__c = 'CPQ获取';
                               insert attachment;
                          }
                          
                      }else{
                         LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+SubmitinfoMessage.msg,'重要');
                         return SubmitinfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
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