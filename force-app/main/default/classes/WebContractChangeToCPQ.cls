global class WebContractChangeToCPQ {
     
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
      webservice static String getScheduling(String token,String contract,String changenum,String type,String contractName,String BusinessChanceNumber,String BusinessChanceName,String controlMode,String caName,String designName){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Contract/Create?contract='+contract+'&changenum='+changenum+'&token='+token+'&operationuser='+operationuser+'&type='+type+'&contractName='+contractName+'&BusinessChanceNumber='+BusinessChanceNumber+'&BusinessChanceName='+BusinessChanceName+'&controlMode='+controlMode+'&caName='+caName+'&designName='+designName;
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



      //合同变更--创建供货范围清单
      webservice  static String getContractChangeinfo(String tbid,String contract,String changenum,String type,String contractName,String BusinessChanceNumber,String BusinessChanceName,String controlMode,String caName,String designName){ 
          String token = '';
          String Schedulinginfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Schedulinginfo = getScheduling(token, contract, changenum, type,contractName,BusinessChanceNumber,BusinessChanceName,controlMode,caName,designName);
                  if(Schedulinginfo != null){
                      HttpMessage SchedulinginfoMessage = (HttpMessage)JSON.deserializeStrict(Schedulinginfo,HttpMessage.class);
                       if(SchedulinginfoMessage.status == 'success'){
                          contractchange__c contractchange_info =  [select updateghfw__c,sfscghfw__c,cpqUrl__c from contractchange__c where id = :tbid];
                          contractchange_info.updateghfw__c = SchedulinginfoMessage.resultUrl;
                          contractchange_info.sfscghfw__c = '是';
                          contractchange_info.cpqUrl__c = SchedulinginfoMessage.cpqUrl;
                          update contractchange_info;
                          List<attachment__c> listac = [select IsLastVersion__c,isValid__c,contractchange__c,typeCode__c,attachmentURL__c from attachment__c where contractchange__c=:tbid and typeCode__c='1' and isValid__c ='有效' ]; 
                            for(attachment__c ac:listac){
                                ac.isValid__c = '无效';
                                ac.IsLastVersion__c = false;
                           }
                		  update listac;
                           
                         if(SchedulinginfoMessage.filePath!= null){
                             attachment__c attachment = new attachment__c();
                             attachment.attachmentURL__c =  SchedulinginfoMessage.filePath;
                             attachment.contractchange__c = tbid;
                             attachment.type__c = '供货范围清单';
                             attachment.isValid__c ='有效';
                             attachment.IsLastVersion__c = true;
                             attachment.AttachmentCome__c = '合同变更';
                             attachment.documentName__c = contract+'供货范围清单.xlsx';
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



      global class HttpMessage{
            public String status{get;set;} 
            public String msg{get;set;}
            public String token{get;set;} 
            public String resultUrl{get;set;} 
            public String filePath{get;set;} 
            public String comment{get;set;} 
            public String data{get;set;} 
            public String cpqUrl{get;set;} 
          
       }

}