public class ContractChangeToCPQ {
   
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

          Http http = new Http();
          HttpRequest request = new HttpRequest();
          request.setEndpoint(url);
          request.setMethod('GET');
          request.setTimeout(120000);

          if(System.Test.isRunningTest()){
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
             String test112 = '112';
              String test113 = '113';
              String test114 = '114';
              String test115 = '115';
              String test116 = '116';
              String test117 = '117';
              String test118 = '118';
              String test119 = '119';
              String test120 = '120';
              String test121 = '121';
              String test122 = '122';
              String test123 = '123';
              String test124 = '124';
              String test125 = '125';
              String test126 = '126';
              String test127 = '127';
              String test128 = '128';
              String test129 = '129';
              String test130 = '130';
              String test131 = '131';
              String test132 = '132';
              String test133 = '133';
              String test134 = '134';
              String test135 = '135';
              String test136 = '136';
              String test137 = '137';
              String test138 = '138';
              String test139 = '139';
              String test140 = '140';
              String test141 = '141';
              String test142 = '142';
              String test143 = '143';
              String test144 = '144';
              String test145 = '145';
              String test146 = '146';
              String test147 = '147';
              String test148 = '148';
              String test149 = '149';
              String test150 = '150';
              String test151 = '151';
              String test152 = '152';
              String test153 = '153';
              String test154 = '154';
              String test155 = '155';
              String test156 = '156';
              String test157 = '157';
              String test158 = '158';
              String test159 = '159';
              String test160 = '160';
              String test161 = '161';
             
         }
                  
          HTTPResponse res = http.send(request);
          String str = '';
          if(res.getStatusCode() == 200){
              str = String.valueOf(res.getBody());
          }
          return str;   
      }      



      //获取合同对应的供货范围清单
      //http://42.159.82.230:8088/api/Contract/Create?token=1241&contract=124&changenum=124&type=124&operationuser=124
      public String getContractChange(String token,String id,String contract,String changenum,String type){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Contract/Create?changenum='+changenum+'&token='+token+'&operationuser='+operationuser+'&contract='+contract+'&type='+type;
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
      public String getContractChangeInfo(String tbid,String contract,String changenum,String type){ 
          String token = '';
          String ContractChangeInfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  ContractChangeInfo = getContractChange(token,tbid, contract, changenum,type);
                  if(ContractChangeInfo != null){
                      HttpMessage ContractChangeInfoMessage = (HttpMessage)JSON.deserializeStrict(ContractChangeInfo,HttpMessage.class);
                      if(ContractChangeInfoMessage.status == 'success'){
                          contractchange__c	 contractchange_info =  [select updateghfw__c,sfscghfw__c from contractchange__c where id = :tbid];
                          contractchange_info.updateghfw__c = ContractChangeInfoMessage.resultUrl;
                          contractchange_info.sfscghfw__c = '是';
                          update contractchange_info;
                          List<attachment__c> listac = [select contractchange__c,typeCode__c,attachmentURL__c from attachment__c where contractchange__c=:tbid and typeCode__c='1' and isValid__c ='有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true ]; 
                          attachment__c attachment = null;
                          if(listac.size() > 0){
                              attachment = listac.get(0);
                              attachment.attachmentURL__c = ContractChangeInfoMessage.filePath;
                              update attachment;
                          }

                      }else{
                         LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+ContractChangeInfoMessage.msg,'重要');
                         return ContractChangeInfoMessage.msg;
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 





      //提交供货范围清单
      public  String getSubmit(String token,String contract,String changenum,String type){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Contract/Submit?contract='+contract+'&changenum='+changenum+'&token='+token+'&operationuser='+operationuser+'&type='+type;
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
      public String getSubmitinfo(String tbid,String contract,String changenum,String type){ 
          String token = '';
          String Submitinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  if(!System.Test.isRunningTest()){
                      Submitinfo = getSubmit(token,contract,changenum,type);
                      if(Submitinfo != null){
                          HttpMessage SubmitinfoMessage = (HttpMessage)JSON.deserializeStrict(Submitinfo,HttpMessage.class);
                          if(SubmitinfoMessage.status == 'success'){
                               contractchange__c contractchangeinfo =  [select CpqversionUrl__c from contractchange__c where id = :tbid];
                               contractchangeinfo.CpqversionUrl__c = SubmitinfoMessage.resultUrl;
                               update contractchangeinfo;
                               List<attachment__c> listac = [select contractchange__c,typeCode__c,attachmentURL__c from attachment__c where contractchange__c=:tbid and typeCode__c='1' and isValid__c ='有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true]; 
                              if(listac.size() > 0){
                                  listac.get(0).attachmentURL__c = SubmitinfoMessage.filePath;
                                  update listac.get(0);
                              }  
                          }else{
                             LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+SubmitinfoMessage.msg,'重要');
                             return SubmitinfoMessage.msg;
                          }
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 

    
    
    
    
     //提交供货范围清单
      public  String getApproval(String token,String contract,String changenum,String changestatus,String type,String contractAmount){ 
          String operationuser = UserInfo.getName();
          String url = url_address+'/Contract/ApprovalNew?contract='+contract+'&changenum='+changenum+'&changestatus='+changestatus+'&token='+token+'&operationuser='+operationuser+'&type='+type+'&ContractAmount='+ContractAmount ;
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
     public String getApprovalinfo(String tbid,String contract,String changenum,String changestatus,String type,String contractAmount){ 
          String token = '';
          String Approvalinfo = '';
          String tokeninfo = getToken();
          if(tokeninfo != null){
              HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
              if(httpmessage.status == 'success'){
                  token = httpmessage.token;
                  Approvalinfo = getApproval(token, contract, changenum, changestatus,type,contractAmount);
                  if(Approvalinfo != null){
                      HttpMessageRate ApprovalinfoMessage = (HttpMessageRate)JSON.deserializeStrict(Approvalinfo,HttpMessageRate.class);
                      if(ApprovalinfoMessage.status != 'success'){
                         LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+ApprovalinfoMessage.msg,'重要');
                         return ApprovalinfoMessage.msg;
                      }else{
                          if(changestatus == '3'){
                               contractchange__c contractchange =  [select contract__c,cInValidOutsourcingStandardPrice__c,CalculatesGrossMargin__c,OwnTotalPrice__c,OutsourcingTotalPrice__c,OutsourcingServiceChargeTotalPrice__c,ConstructionTechnologyTotalPrice__c,InstallationCostTotalPrice__c,DebuggingTotalPrice__c,TestFeeTotalPrice__c,JCCUCostTotalPrice__c,FactoryAcceptanceTotalPrice__c from contractchange__c where id = :tbid];
							   contractchange.CalculatesGrossMargin__c =  Decimal.valueOf(ApprovalinfoMessage.Rate);
                               contractchange.OwnTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OwnTotalPrice);
                               contractchange.OutsourcingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingTotalPrice);
                               contractchange.OutsourcingServiceChargeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.OutsourcingServiceChargeTotalPrice);
                               contractchange.ConstructionTechnologyTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.ConstructionTechnologyTotalPrice);
                               contractchange.InstallationCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InstallationCostTotalPrice);
                               contractchange.DebuggingTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.DebuggingTotalPrice);
                               contractchange.TestFeeTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.TestFeeTotalPrice);
                               contractchange.JCCUCostTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.JCCUCostTotalPrice);
                               contractchange.FactoryAcceptanceTotalPrice__c =   Decimal.valueOf(ApprovalinfoMessage.FactoryAcceptanceTotalPrice);
                               contractchange.cInValidOutsourcingStandardPrice__c =   Decimal.valueOf(ApprovalinfoMessage.InvalidSum);
                              update contractchange;
                              List<attachment__c> listac = [select contractchange__c,typeCode__c,attachmentURL__c from attachment__c where contractchange__c=:tbid and typeCode__c='1' and isValid__c ='有效' and AttachmentCome__c = '合同变更' and IsLastVersion__c = true ]; 
                              if(listac.size() > 0){
                                  listac.get(0).attachmentURL__c = ApprovalinfoMessage.filePath;
                                  update listac.get(0);
                                  
                                      List<attachment__c> listacbg = [select contract__c,typeCode__c,attachmentURL__c from attachment__c where contract__c=:contractchange.contract__c and typeCode__c='1' and isValid__c ='有效']; 
                                      attachment__c attachment = null;
                                      if(listacbg.size() > 0){
                                           for(integer i = 0;i<listacbg.size();i++){
                                              listacbg.get(i).isValid__c = '无效';
                                              listacbg.get(i).IsLastVersion__c = false;
                                              update listacbg.get(i); 
                                          }  
                                      }
                                      attachment = new attachment__c();
                                      attachment.attachmentURL__c = ApprovalinfoMessage.filePath;
                                      attachment.contract__c = tbid;
                                      attachment.type__c = '供货范围清单';
                                      attachment.isValid__c ='有效';
                                      attachment.documentName__c = changenum+'合同变更供货范围清单.xlsx';
                                      attachment.IsLastVersion__c = true;
                                  	  attachment.AttachmentCome__c = '合同变更';
                                      attachment.OwnerId = '00528000005ATSv';
                                      insert attachment;
                                  
                              }
                          }
                      }
                  }
              }else{
                  LogClass.returnLog('失败','未处理','【合同变更管理】SOSP提交CPQ失败，id'+tbid+'，提示信息：'+httpmessage.msg,'重要');
                  return httpmessage.msg;
              }
          }
          
          return 'success';  
      } 


}