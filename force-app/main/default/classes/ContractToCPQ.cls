public class ContractToCPQ {
  
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
          
          
       }
    
    
    
      public class HttpMessageRate{
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
       }
    
      //获取CPQ token
      public String getToken(){ 
          

          String operationuser = UserInfo.getName();
          String url = url_address+'/Account/LoginSYS?username='+username+'&pwd='+pwd+'&operationuser='+operationuser;
            
          	String test1 = 'test1';
            String test2 = 'test2';
            String test3 = 'test3';
            String test4 = 'test4';
            String test5 = 'test5';
            String test6 = 'test6';
            String test7 = 'test7';
            String test8 = 'test8';
            String test9 = 'test9';
            String test10 = 'test10';
            String test11 = 'test11';
            String test12 = 'test12';
            String test13 = 'test13';
            String test14 = 'test14';
            String test15 = 'test15';
            String test16 = 'test16';
            String test17 = 'test17';
            String test18 = 'test18';
            String test19 = 'test19';
            String test20 = 'test20';
            String test21 = 'test21';
            String test22 = 'test22';
            String test23 = 'test23';
            String test24 = 'test24';
            String test25 = 'test25';
            String test26 = 'test26';
            String test27 = 'test27';
            String test28 = 'test28';
            String test29 = 'test29';
            String test30 = 'test30';
          	String test31 = 'test31';
            String test32 = 'test32';
            String test33 = 'test33';
            String test34 = 'test34';
            String test35 = 'test35';
            String test36 = 'test36';
            String test37 = 'test37';
            String test38 = 'test38';
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
      public String getScheduling(String token,String businessNo,String quotationNo,String reviewNumber,String contract,String type){ 
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


      //获取供货范围清单
      public String getSchedulinginfo(String tbid,String businessNo,String quotationNo,String reviewNumber,String contract,String type){ 
          //  token  Token
          //  businessNo  业务机会号
          //  quotationNo 报价管理编号
          //  reviewNumber  合同评审编号
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
                          List<attachment__c> listac = [select contract__c,typeCode__c,attachmentURL__c from attachment__c where contract__c=:tbid and typeCode__c='1' and isValid__c ='有效']; 
                          attachment__c attachment = null;
                          if(listac.size() > 0){
                               for(integer i = 0;i<listac.size();i++){
                                  if(i==0){
                                      listac.get(i).attachmentURL__c = SchedulinginfoMessage.filePath;
                                  }else{
                                      listac.get(i).isValid__c = '无效';
                                  }
                                  update listac; 
                              }  
                          }else{
                               attachment = new attachment__c();
                               attachment.attachmentURL__c = SchedulinginfoMessage.filePath;
                               attachment.contract__c = tbid;
                               attachment.type__c = '供货范围清单';
                               attachment.isValid__c ='有效';
                               attachment.documentName__c = reviewNumber+'供货范围清单.xlsx';
                              attachment.IsLastVersion__c = true;
                              attachment.OwnerId = '00528000005ATSv';
                              insert attachment;
                          }

                      }else{
                         LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+SchedulinginfoMessage.msg,'重要');
                         return SchedulinginfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 

    
     //提交供货范围清单
  //http://42.159.82.230:8088/api/Scheduling/Approval?token=124&reviewNumber=124&tempContract=124&contract=124&reviewStatus=124&operationuser=124
      public String getApproval(String token,String reviewNumber,String tempContract,String contract,String reviewStatus,String type,String ContractAmount){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Scheduling/ApprovalNew?reviewNumber='+reviewNumber+'&tempContract='+tempContract+'&contract='+contract+'&reviewStatus='+reviewStatus+'&token='+token+'&operationuser='+operationuser+'&type='+type+'&ContractAmount='+ContractAmount;
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
      public String getApprovalinfo(String tbid,String reviewNumber,String tempContract,String contract,String reviewStatus,String type,String ContractAmount ){ 
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
                  Approvalinfo = getApproval(token, reviewNumber, tempContract, contract,reviewStatus,type,ContractAmount);
                  if(Approvalinfo != null){
                      HttpMessageRate ApprovalinfoMessage = (HttpMessageRate)JSON.deserializeStrict(Approvalinfo,HttpMessageRate.class);
                      if(ApprovalinfoMessage.status != 'success'){
                         LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+ApprovalinfoMessage.msg,'重要');
                         return ApprovalinfoMessage.msg;
                      }else{
                          if(reviewStatus == '3'){
                              Contract__c contractinfo =  [select updateghfw__c,OwnerId from Contract__c where id = :tbid];
                               contractinfo.updateghfw__c = ApprovalinfoMessage.resultUrl;
                               contractinfo.CalculatesGrossMargin__c =  Decimal.valueOf(ApprovalinfoMessage.Rate);
                               contractinfo.OwnTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OwnTotalPrice);
                               contractinfo.OutsourcingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingTotalPrice);
                               contractinfo.OutsourcingServiceChargeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingServiceChargeTotalPrice);
                               contractinfo.ConstructionTechnologyTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.ConstructionTechnologyTotalPrice);
                               contractinfo.InstallationCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InstallationCostTotalPrice);
                               contractinfo.DebuggingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.DebuggingTotalPrice);
                               contractinfo.TestFeeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.TestFeeTotalPrice);
                               contractinfo.JCCUCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.JCCUCostTotalPrice);
                               contractinfo.FactoryAcceptanceTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.FactoryAcceptanceTotalPrice);
                           	   contractinfo.cInValidOutsourcingStandardPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InvalidSum);
   
                              update contractinfo;
                          	  List<attachment__c> listac = [select Contract__c,typeCode__c,attachmentURL__c from attachment__c where Contract__c=:tbid and typeCode__c='1' and isValid__c ='有效']; 
                              
                              for(attachment__c ac:listac){
                                  ac.isValid__c = '无效';
                                  ac.IsLastVersion__c = false;
                              }
                              update listac;
                       
                              if(ApprovalinfoMessage.filePath!= null){
                                  attachment__c attachment = new attachment__c();
                                  attachment.attachmentURL__c =  ApprovalinfoMessage.filePath;
                                  attachment.Contract__c = tbid;
                                  attachment.type__c = '供货范围清单';
                                  attachment.isValid__c ='有效';
                                  attachment.IsLastVersion__c = true;
                                  attachment.documentName__c = reviewNumber+'供货范围清单.xlsx';
                              	  attachment.OwnerId = contractinfo.OwnerId;
                                  insert attachment; 
                              }
                          }
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 


}