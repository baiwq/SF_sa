global class WebCPQGetCurRate {
  		    public static final String url_address = CPQ_config__c.getValues('CPQ_config').urlAddress__c;
            
            public static final String username = CPQ_config__c.getValues('CPQ_config').UserName__c;
            
            public static final String pwd = CPQ_config__c.getValues('CPQ_config').Passwd__c;
    
            global class HttpMessage{
                webservice String status{get;set;}
                webservice String token{get;set;}
                webservice String msg{get;set;}
                webservice String CustomerSpecified{get;set;}
                webservice String SalesDesignation{get;set;}
                webservice String NewBusiness{get;set;}
                webservice String Rate{get;set;}
                webservice String OwnTotalPrice{get;set;}
                webservice String OutsourcingTotalPrice{get;set;}
                webservice String OutsourcingServiceChargeTotalPrice{get;set;}
                webservice String ConstructionTechnologyTotalPrice{get;set;}
                webservice String InstallationCostTotalPrice{get;set;}
                webservice String DebuggingTotalPrice{get;set;}
                webservice String TestFeeTotalPrice{get;set;}
                webservice String JCCUCostTotalPrice{get;set;}
                webservice String FactoryAcceptanceTotalPrice{get;set;}  
                
                //无效业绩
                webservice String InvalidSum{get;set;} 
            }
    
            webservice  static  String getToken(){ 
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
    
    
            webservice  static  String GetCurRateOutsourcing(String token,String reviewNumber,String contractAmount){ 
                String operationuser = UserInfo.getName();
                String url = url_address+'/Approval/GetCurRateAndOutsourcing?token='+token+'&ContractAmount='+contractAmount+'&reviewNumber='+reviewNumber;
                
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
            
            //获取毛利和毛利计算的各个分项
            webservice  static  String GetCurRateInfo(String tbid,String reviewNumber,String contractAmount){ 
                //  token  Token
                //  reviewNumber  合同评审号
                //  contractAmount 合同金额
                String token = '';
                String Rateinfo = '';
                String tokeninfo = getToken();
                if(tokeninfo != null){
                    HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
                    if(httpmessage.status == 'success'){
                        token = httpmessage.token;
                        Rateinfo = GetCurRateOutsourcing(token,reviewNumber,contractAmount);
                        if(Rateinfo != null){
                            HttpMessage RateinfoMessage = (HttpMessage)JSON.deserializeStrict(Rateinfo,HttpMessage.class);
                            if(RateinfoMessage.status == 'success'){
                                  contractreview__c contractreview =  [select id,cInValidOutsourcingStandardPrice__c,NewBusiness__c,SalesDesignation__c,CustomerSpecified__c,CalculatesGrossMargin__c,OwnTotalPrice__c,OutsourcingTotalPrice__c,OutsourcingServiceChargeTotalPrice__c,ConstructionTechnologyTotalPrice__c,InstallationCostTotalPrice__c,DebuggingTotalPrice__c,TestFeeTotalPrice__c,JCCUCostTotalPrice__c,FactoryAcceptanceTotalPrice__c from contractreview__c where id = :tbid];
                                  //contractreview.updateghfw__c = RateinfoMessage.resultUrl;
                                  //contractreview.sfscghfw__c = '是';
                                	if(RateinfoMessage.CustomerSpecified == '是'){
                                        contractreview.CustomerSpecified__c = true;
                                    }
                                    if(RateinfoMessage.SalesDesignation == '是'){
                                        contractreview.SalesDesignation__c = true;
                                    }
                                    if(RateinfoMessage.NewBusiness == '是'){
                                        contractreview.NewBusiness__c = true;
                                    }
                                  	contractreview.CalculatesGrossMargin__c =  Decimal.valueOf(RateinfoMessage.Rate);
                                    contractreview.OwnTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OwnTotalPrice);
                                    contractreview.OutsourcingTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OutsourcingTotalPrice);
                                    contractreview.OutsourcingServiceChargeTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OutsourcingServiceChargeTotalPrice);
                                    contractreview.ConstructionTechnologyTotalPrice__c =   Decimal.valueOf(RateinfoMessage.ConstructionTechnologyTotalPrice);
                                    contractreview.InstallationCostTotalPrice__c =   Decimal.valueOf(RateinfoMessage.InstallationCostTotalPrice);
                                    contractreview.DebuggingTotalPrice__c =   Decimal.valueOf(RateinfoMessage.DebuggingTotalPrice);
                                    contractreview.TestFeeTotalPrice__c =   Decimal.valueOf(RateinfoMessage.TestFeeTotalPrice);
                                    contractreview.JCCUCostTotalPrice__c =   Decimal.valueOf(RateinfoMessage.JCCUCostTotalPrice);
                                    contractreview.FactoryAcceptanceTotalPrice__c =   Decimal.valueOf(RateinfoMessage.FactoryAcceptanceTotalPrice);
                                    
                                    contractreview.cInValidOutsourcingStandardPrice__c =   Decimal.valueOf(RateinfoMessage.InvalidSum);

                                    update contractreview;                                 
                              }else{
                                  return RateinfoMessage.msg;
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