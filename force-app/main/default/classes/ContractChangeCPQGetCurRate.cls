//testCPQrate
public class ContractChangeCPQGetCurRate {

            public static final String url_address = CPQ_config__c.getValues('CPQ_config').urlAddress__c;
            
            public static final String username = CPQ_config__c.getValues('CPQ_config').UserName__c;
            
            public static final String pwd = CPQ_config__c.getValues('CPQ_config').Passwd__c;
    
            public class HttpMessage{
                public String status{get;set;}
                public String token{get;set;}
                public String msg{get;set;}
                public String CustomerSpecified{get;set;}
                public String SalesDesignation{get;set;}
                public String NewBusiness{get;set;}
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

            }
    
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
    
    
            public String GetCurRateOutsourcing(String token,String Contractchange,String contractAmount){ 
                String operationuser = UserInfo.getName();
                String url = url_address+'/Approval/GetCurRateAndOutsourcing?token='+token+'&ContractAmount='+contractAmount+'&changeNum='+Contractchange;
                
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
            public String GetCurRateInfo(String tbid,String Contractchange,String contractAmount){ 
                //  token  Token
                //  ContractNo  合同编号
                //  contractAmount 合同金额
                String token = '';
                String Rateinfo = '';
                String tokeninfo = getToken();
                if(tokeninfo != null){
                    HttpMessage httpmessage = (HttpMessage)JSON.deserializeStrict(tokeninfo,HttpMessage.class);
                    if(httpmessage.status == 'success'){
                        token = httpmessage.token;
                        Rateinfo = GetCurRateOutsourcing(token,Contractchange,contractAmount);
                        if(Rateinfo != null){
                            HttpMessage RateinfoMessage = (HttpMessage)JSON.deserializeStrict(Rateinfo,HttpMessage.class);
                            if(RateinfoMessage.status == 'success'){
                                  	contractchange__c   Contractchange_info =  [select id,cInValidOutsourcingStandardPrice__c,CalculatesGrossMargin__c,OwnTotalPrice__c,OutsourcingTotalPrice__c,OutsourcingServiceChargeTotalPrice__c,ConstructionTechnologyTotalPrice__c,InstallationCostTotalPrice__c,DebuggingTotalPrice__c,TestFeeTotalPrice__c,JCCUCostTotalPrice__c,FactoryAcceptanceTotalPrice__c from contractchange__c  where id = :tbid];
                                
                                    Contractchange_info.CalculatesGrossMargin__c =  Decimal.valueOf(RateinfoMessage.Rate);
                                    Contractchange_info.OwnTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OwnTotalPrice);
                                    Contractchange_info.OutsourcingTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OutsourcingTotalPrice);
                                    Contractchange_info.OutsourcingServiceChargeTotalPrice__c =   Decimal.valueOf(RateinfoMessage.OutsourcingServiceChargeTotalPrice);
                                    Contractchange_info.ConstructionTechnologyTotalPrice__c =   Decimal.valueOf(RateinfoMessage.ConstructionTechnologyTotalPrice);
                                    Contractchange_info.InstallationCostTotalPrice__c =   Decimal.valueOf(RateinfoMessage.InstallationCostTotalPrice);
                                    Contractchange_info.DebuggingTotalPrice__c =   Decimal.valueOf(RateinfoMessage.DebuggingTotalPrice);
                                    Contractchange_info.TestFeeTotalPrice__c =   Decimal.valueOf(RateinfoMessage.TestFeeTotalPrice);
                                    Contractchange_info.JCCUCostTotalPrice__c =   Decimal.valueOf(RateinfoMessage.JCCUCostTotalPrice);
                                    Contractchange_info.FactoryAcceptanceTotalPrice__c =   Decimal.valueOf(RateinfoMessage.FactoryAcceptanceTotalPrice);
                                    
                                    Contractchange_info.cInValidOutsourcingStandardPrice__c =   Decimal.valueOf(RateinfoMessage.InvalidSum);

                                
                                    update Contractchange_info;                                 
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