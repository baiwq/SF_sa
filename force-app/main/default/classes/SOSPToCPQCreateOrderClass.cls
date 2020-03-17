global class SOSPToCPQCreateOrderClass {
    webservice static String setStandardPrice(String quatationId){
        String resp='失败';
        
        try{
                        
            wwwExampleOrgSospCpqCos001.inputType input = new wwwExampleOrgSospCpqCos001.inputType();
            wwwExampleOrgSospCpqCos001.SOSP_CPQ_COS_001SOAP requObj = new wwwExampleOrgSospCpqCos001.SOSP_CPQ_COS_001SOAP();
            wwwExampleOrgSospCpqCos001.outputType outType = new wwwExampleOrgSospCpqCos001.outputType();
            //LogClass.returnLog('成功','已处理','【CPQ接口COS001】SOSP调用成功01'+':'+quatationId,'重要');
            quatation__c quatation =[select id ,Name,opportunity__c from quatation__c where id=:quatationId limit 1][0];
            Opportunity oppo =[select id,Name,opportunityNumber__c,opportunityIndustry__c,industrySecondLevel__c,buildType__c,
                               projectType__c,voltageLevel__c,country__c,province__c,implementationStation__c,
                               expectDeliveryDate__c from Opportunity where id=:quatation.opportunity__c limit 1][0];
            //LogClass.returnLog('成功','已处理','【CPQ接口COS001】SOSP调用成功02'+':'+oppo.opportunityNumber__c,'重要');
            input.TENDER_CODE =oppo.opportunityNumber__c;
            input.PROJECT_NAME  =oppo.Name;
            input.PROJECT_CODE  =quatation.Name;
            input.USER_INDUSTRY  =oppo.opportunityIndustry__c;
            input.INDUSTRY_SECLASS  =oppo.industrySecondLevel__c;
            input.CONSTRUCTION_TYPE  =oppo.buildType__c;
            input.PROJECT_TYPE  =oppo.projectType__c;
            input.VOLTAGE_GRADE  =oppo.voltageLevel__c;
            input.SALE_PROVINCE   =oppo.province__c;
            //input.SALECITY=oppo.
            input.SALE_COUNTRY  =oppo.country__c;
            input.TERMINAL_TYPE =oppo.implementationStation__c;
            
            if(oppo.expectDeliveryDate__c==null){
                input.REQUIRED_DELIVERY_DATE ='';
            }else{
                input.REQUIRED_DELIVERY_DATE =oppo.expectDeliveryDate__c.format()+' 08:00:00';
            }
            input.EMPLOYEE_NO  =Userinfo.getUsername();
            input.ROLE =System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+quatationId;
            
            outType = requObj.SOSP_CPQ_COS_001(input);
            resp=outType.type_x ;
            if(resp=='S'){
                LogClass.returnLog('成功','已处理','【CPQ接口COS001】SOSP调用成功'+',业务机会编号:'+oppo.opportunityNumber__c+',报价ID:'+quatationId,'重要');
            }else{
                
                LogClass.returnLog('失败','未处理','【CPQ接口COS001】SOSP调用失败,CPQ返回错误信息:' +outType.message ,'重要');
            }
            //resp=outType.type_x; //+'--message--'+outType.message +'--result--'+outType.result; 
            
            
            
        }catch(Exception e){
            LogClass.returnLog('失败','未处理','【CPQ接口COS001】SOSP调用失败,异常信息:' + e.getMessage(),'重要');
        }
        return resp;
    }
}