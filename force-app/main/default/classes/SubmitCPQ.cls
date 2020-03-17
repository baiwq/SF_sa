public class SubmitCPQ {
    
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
          
          //新增
          public String Rate{get;set;}
          public String OwnTotalPrice{get;set;}
          public String OutsourcingTotalPrice{get;set;}
          public String OutsourcingServiceChargeTotalPrice{get;set;}
          public String ConstructionTechnologyTotalPrice{get;set;}
          public String InstallationCostTotalPrice{get;set;}
          public String DebuggingTotalPrice{get;set;}
          public String TestFeeTotalPrice{get;set;}
          public String JCCUCostTotalPrice{get;set;}
          public String FactoryAcceptanceTotalPrice{get;set;}  
          
          public String InvalidSum{get;set;} 
          //客户指定 CustomerSpecified__c         
          public String CustomerSpecified{get;set;} 
          
          //销售指定 SalesDesignation__c 
          public String SalesDesignation{get;set;}
          
          //新业务 NewBusiness 
          public String NewBusiness{get;set;} 
          
          //public String rate{get;set;}

       }
    
      //获取CPQ token
      public static String getToken(){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Account/LoginSYS?username='+username+'&pwd='+pwd+'&operationuser='+operationuser;

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(12000);

 
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;  
          
         
      }      

    
     //提交供货范围清单
     //http://42.159.82.230:8088/api/Approval/Approval?token=7c74af41f8a24dd7aa7a36a1a3812707&businessNo=OT-00000001&quotationNo=S-00000001&reviewNumber=1&reviewStatus=3&operationuser=2
      public String getApproval(String token,String businessNo,String quotationNo,String reviewNumber,String reviewStatus,String type,String contractAmount){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Approval/ApprovalNew?businessNo='+businessNo+'&quotationNo='+quotationNo+'&contractAmount='+contractAmount+'&reviewNumber='+reviewNumber+'&reviewStatus='+reviewStatus+'&token='+token+'&operationuser='+operationuser+'&type='+type;
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
      public String getApprovalinfo(String tbid,String businessNo,String quotationNo,String reviewNumber,String reviewStatus,String type,String contractAmount){ 
          //  token  Token
          //  businessNo  业务机会号
          //  quotationNo 报价管理编号
          //  reviewNumber  合同评审编号
          String token = '';
          String Approvalinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Approvalinfo = getApproval(token, businessNo, quotationNo, reviewNumber,reviewStatus,type,contractAmount);
                  if(Approvalinfo != null){
                      HttpMessage ApprovalinfoMessage = (HttpMessage)JSON.deserializeStrict(Approvalinfo,HttpMessage.class);
                      if(ApprovalinfoMessage.status != 'success'){
                         LogClass.returnLog('失败','未处理','SOSP提交CPQ失败，id'+tbid+'，提示信息：'+ApprovalinfoMessage.msg,'重要');
                         return ApprovalinfoMessage.msg;
                      }else{
                          if(reviewStatus == '3'){
                              
                           contractreview__c contractreview =  [select CPQfailReason__c ,updateghfw__c,cInValidOutsourcingStandardPrice__c,CalculatesGrossMargin__c,OwnTotalPrice__c,OutsourcingTotalPrice__c,OutsourcingServiceChargeTotalPrice__c,ConstructionTechnologyTotalPrice__c,InstallationCostTotalPrice__c,DebuggingTotalPrice__c,TestFeeTotalPrice__c,JCCUCostTotalPrice__c,FactoryAcceptanceTotalPrice__c  from contractreview__c where id = :tbid];
                           contractreview.updateghfw__c  = ApprovalinfoMessage.resultUrl;
                           contractreview.CalculatesGrossMargin__c =  Decimal.valueOf(ApprovalinfoMessage.Rate);
                           contractreview.OwnTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OwnTotalPrice);
                           contractreview.OutsourcingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingTotalPrice);
                           contractreview.OutsourcingServiceChargeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingServiceChargeTotalPrice);
                           contractreview.ConstructionTechnologyTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.ConstructionTechnologyTotalPrice);
                           contractreview.InstallationCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InstallationCostTotalPrice);
                           contractreview.DebuggingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.DebuggingTotalPrice);
                           contractreview.TestFeeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.TestFeeTotalPrice);
                           contractreview.JCCUCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.JCCUCostTotalPrice);
                           contractreview.FactoryAcceptanceTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.FactoryAcceptanceTotalPrice);
                           contractreview.cInValidOutsourcingStandardPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InvalidSum);
   						  
                           update contractreview;
                           List<attachment__c> listac = [select contractReview__c,typeCode__c,attachmentURL__c from attachment__c where contractReview__c =:tbid and typeCode__c='1' and isValid__c ='有效']; 
                              if(listac.size() > 0){                                  
                                  listac.get(0).attachmentURL__c = ApprovalinfoMessage.filePath;
                                  update  listac.get(0);
                              }
                          }
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 



}