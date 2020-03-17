public class sendAccountToSap{
    //参数1 合同编号（系统唯一ID）,参数2 类型C/D（销售客户/投标保证金客户），参数3 公司编码如CC01，参数4 销售组织如S001
    public Boolean sendAccountToSap(String step,String accountId,String sType,String subCompanyCode,String salesOrgNameCode){
        boolean boolRe = false;
        if(accountId==null||sType==null){
            LogClass.returnLog('失败','未处理','【推送客户给SAP】阶段:'+step+',客户编号：' + accountId + '，客户类型：' + sType + '，公司编码：' + subCompanyCode ,'重要');
            return false;
        } 
        String accType = sType + '000';
        String Str_AKONT;
        
        if(sType=='C'){
        	Str_AKONT = '0113101000';
        }else{
        	Str_AKONT = '0119102000';
        }
       
        
        try{
            ZsdCustomerCreate.ZSD_CUSTOMER_CREATESOAP customObj = new ZsdCustomerCreate.ZSD_CUSTOMER_CREATESOAP();
            ZsdCustomerCreate.ZSD_CUSTOMER_CREATEResponse_element custom_reaponse;

            ZsdCustomerCreate.CENTRALType CENTRAL = new ZsdCustomerCreate.CENTRALType();
            ZsdCustomerCreate.CENTRALXType CENTRALX = new ZsdCustomerCreate.CENTRALXType();
            ZsdCustomerCreate.ADDRESSType ADDRESS = new ZsdCustomerCreate.ADDRESSType();
            ZsdCustomerCreate.ADDRESSXType ADDRESSX = new ZsdCustomerCreate.ADDRESSXType();
            List<ZsdCustomerCreate.COMPANYType> COMPANY = new List<ZsdCustomerCreate.COMPANYType>();
            List<ZsdCustomerCreate.SALESType> SALES = new List<ZsdCustomerCreate.SALESType>();
            List<ZsdCustomerCreate.PARTNERSType> PARTNERS = new List<ZsdCustomerCreate.PARTNERSType>();
            
            List<Account> accountContractList = new List<Account>();          
            accountContractList = [select Id,SAP_ID__c,SAPIDD__c,taxpayerNumber__c,Name,city__c,billingStreet__c,countryCode__c,regionCode__c,postcode__c from account where Id = :accountId];
            if(accountContractList.size()>0){
                Account accountContract = new Account();
                //客户中心数据
                accountContract = accountContractList[0];
                String accountNo = '';
                System.Debug('AAA1');
                if(sType=='C'){
                    accountNo =  accountContract.SAP_ID__c;
                }else{
                    accountNo =  accountContract.SAPIDD__c;
                }
                System.Debug('AAA2');
                CENTRAL.KUNNR = accountNo;
                CENTRAL.KTOKD =  accType;
                System.Debug('AAA3');
                if(sType=='C'){
                    CENTRAL.STCEG =  accountContract.taxpayerNumber__c;
                }
                System.Debug('AAA4');
                //客户中心数据-更改字段
                CENTRALX.STCEG = 'X';
                //客户地址数据
                Integer nameLength = accountContract.Name.length();
                System.Debug('AAA5');
                if(nameLength>40){
                    ADDRESS.NAME = accountContract.Name.substring(0,40);
                    ADDRESS.NAME_2 = accountContract.Name.substring(40,nameLength);
                }else{ 
                    ADDRESS.NAME = accountContract.Name;
                }
                System.Debug('AAA6');
                if(accountContract.city__c==null){
                    ADDRESS.CITY ='';
                }else{
                    ADDRESS.CITY = accountContract.city__c;
                }
                System.Debug('AAA7');
                ADDRESS.COUNTRY = accountContract.countryCode__c;
                if(accountContract.countryCode__c=='CN'){
                    ADDRESS.STREET = accountContract.billingStreet__c;
                    ADDRESS.POSTL_COD1 = accountContract.postcode__c;
                    
                }
                //ADDRESS.COUNTRY = 'CN';
                ADDRESS.LANGU = '1';
                System.Debug('AAA8');
                ADDRESS.REGION = accountContract.regionCode__c;
                //ADDRESS.REGION = '050';
                //ADDRESS.POSTL_COD1 = '100083';
                //客户地址数据-更改字段
                ADDRESSX.NAME = 'X';
                ADDRESSX.CITY = 'X';
                ADDRESSX.STREET = 'X';
                ADDRESSX.POSTL_COD1 = 'X';
                ADDRESSX.COUNTRY = 'X';
                ADDRESSX.REGION = 'X';
                
                
                if(subCompanyCode!=null&&subCompanyCode.trim()!=''){
                    //公司级别数据
                	ZsdCustomerCreate.COMPANYType single_COMPANY = new ZsdCustomerCreate.COMPANYType();
                    single_COMPANY.BUKRS = subCompanyCode;
                    single_COMPANY.AKONT = Str_AKONT;
                    COMPANY.add(single_COMPANY);
                }
                
                System.Debug('AAA9');
                
                //销售客户才有销售区域及合作伙伴角色
                if(sType=='C'){
                    //销售区域
                    System.Debug('AAA10');
                    if(salesOrgNameCode!=null&&salesOrgNameCode!=''&&salesOrgNameCode!=' '){
                        ZsdCustomerCreate.SALESType single_SALES = new ZsdCustomerCreate.SALESType();
                        single_SALES.VKORG = salesOrgNameCode;
                        single_SALES.VTWEG = '11';
                        single_SALES.SPART = '00';
                        single_SALES.VSBED = '01';
                        single_SALES.WAERS = 'RMB';
                        single_SALES.KDGRP = '01';
                        single_SALES.VERSG = '1';
                        single_SALES.KALKS = '1';
                        SALES.add(single_SALES);
                        System.Debug('AAA11');
                    }
                    System.Debug('AAA12');
                    //合作伙伴角色
                    List<String> partnersList = new String[]{'WE','RG','RE','AG'};
                    for(String par:partnersList){
                        System.Debug('AAA13');
                        ZsdCustomerCreate.PARTNERSType single_PARTNERS = new ZsdCustomerCreate.PARTNERSType();
                        single_PARTNERS.PARVW = par;
                        PARTNERS.add(single_PARTNERS);
                    }
                    System.Debug('AAA13');                                                       
                }
                System.Debug('AAA14');
                custom_reaponse = customObj.ZSD_CUSTOMER_CREATE(CENTRAL,CENTRALX,ADDRESS,ADDRESSX,COMPANY,SALES,PARTNERS);
                if(custom_reaponse.IS_ERROR=='X'){
                    List<ZsdCustomerCreate.RETURNType> rsList = new List<ZsdCustomerCreate.RETURNType>();
                    rsList = custom_reaponse.RETURN_x;
                    String messageInfo = '';
                    for(ZsdCustomerCreate.RETURNType sReturn:rsList){
                        messageInfo = messageInfo + '消息类型：' + sReturn.TYPE_x + '；消息：' + sReturn.MESSAGE;
                    }
                    LogClass.returnLog('失败','未处理','【推送客户给SAP】阶段:'+step+',客户编号：' + accountId + '，客户类型：' + sType + '，公司编码：' + subCompanyCode + '，区域编号：' + accountContract.regionCode__c + '。Sap返回错误消息：' + messageInfo,'重要');
                }else{
                    Account account = [select id,SAP_ID__c,SAPIDD__c,pushSAPStatus__c,pushSAPTime__c from Account where id = :accountContract.Id][0];
                    if(accountNo==null){                                                                   
                        String sapAccountNo = custom_reaponse.KUNNR;
                        if(sType=='C'){
                            account.SAP_ID__c = sapAccountNo ;
                        }else{
                            account.SAPIDD__c = sapAccountNo;
                        }                                             
                    }
                    account.pushSAPStatus__c = '同步成功';
                    account.pushSAPTime__c = system.now();
                    update account;   
                    LogClass.returnLog('成功','已处理','【推送客户给SAP】阶段:'+step+',客户编号：' + accountId + '，客户类型：' + sType + '，公司编码：' + subCompanyCode + '，区域编号：' + accountContract.regionCode__c + '。系统中原有客户编码：' + accountNo + '；Sap系统返回客户编码为：' + custom_reaponse.KUNNR,'正常');
                    boolRe = true;
                }
            }else{
                LogClass.returnLog('失败','未处理','【推送客户给SAP】阶段:'+step+',客户编号：' + accountId + '，客户类型：' + sType + '，公司编码：' + subCompanyCode + '。无法找到客户数据','重要');
            }           
        }catch(Exception e){
            System.Debug('BBBB:'+ e);
            LogClass.returnLog('失败','未处理','【推送客户给SAP】阶段'+step+',客户编号：' + accountId + '，客户类型：' + sType + '，公司编码：' + subCompanyCode + '。Sosp返回错误消息：' + e.getMessage(),'重要');         
        }
        return boolRe;
    }
}