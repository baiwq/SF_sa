@RestResource(urlMapping='/PaymentTermToExternalSystem/*')
global class PaymentTermToExternalSystem {
    @HttpPost
    global static Map<String,String> getPaymentTerm(Datetime startTime ,Datetime endTime){
        String Status='失败';
        String dealStatus='未处理';
        String priority = '重要';
        String StatusMessage='';
        Map<String,String> retuMap = new Map<String,String>();
        try{
            system.debug('startTime---'+startTime);
            Integer limitCount =20000;
            List<PaymentLimit__c> payLimit = [Select Name,Limit__c ,IsActive__c From PaymentLimit__c where IsActive__c=:true];
            if(payLimit.size()>0){
                limitCount = Integer.valueOf(payLimit[0].Limit__c);
            }
            Schema.DescribeSObjectResult fieldApiResult = paymentTerm__c.sObjectType.getDescribe();
            String query='Select ';
            for(String apiName:fieldApiResult.fields.getMap().keySet()){
                query=query+apiName+',';
            }
            
            query = query.substring(0, query.length()-1);
            query = query+' From paymentTerm__c where SystemModstamp>=:startTime and SystemModstamp<=:endTime and contractApprovalStatus__c =\'审批通过\' and contract__r.historicalContractDentity__c = false  limit :limitCount';
            system.debug('limitCount---'+limitCount);
            system.debug('query---'+query);
            List<paymentTerm__c> payList = Database.query(query);
            //String payListStr = Json.serialize(payList,true);
            /*list<Map<String, Object>> allFieldValue = new list<Map<String, Object>> ();


            for (paymentTerm__c pay : payList) {
                Map<String, Object> payValue = new Map<String, Object> ();
                for (SObjectField payField : paymentTerm__c.sobjecttype.getdescribe().fields.getmap().values()) {
                    try { payValue.put(String.valueOf(payField), pay.get(payField)); }
                    catch(Exception e) { payValue.put(String.valueOf(payField), null); }
                }
                allFieldValue.add(payValue);
            }*/
            
            retuMap.put('data',Json.serialize(payList));
            system.debug('payList---'+payList);
            
            retuMap.put('flag','S');
            Status='成功';
            dealStatus='已处理';
            priority='正常';
            StatusMessage='【付款条件信息接口】开始时间：'+startTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')+'，结束时间：'+endTime.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')+'，Limit量：'+limitCount+'，获取付款条件信息条数：'+payList.size();
            //logClass.returnLog('成功', '已处理', '【付款条件信息接口】开始时间：'+startTime+'，结束时间：'+endTime+'，获取付款条件信息条数：'+payList.size(), '正常');            
        }catch(Exception e){
            retuMap.put('flag','F');
            retuMap.put('message',e.getMessage());
            Status='失败';
            dealStatus='未处理';
            priority='重要';
            StatusMessage= '【付款条件信息接口】开始时间：'+startTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSz')+'，结束时间：'+endTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ')+'，错误信息：'+e.getMessage();
            //logClass.returnLog('失败', '未处理', '【付款条件信息接口】开始时间：'+startTime+'，结束时间：'+endTime+'，错误信息：'+e.getMessage(), '重要'); 
        }finally{
            logClass.returnLog(Status, dealStatus, StatusMessage, priority);
            
        }
        return retuMap;
          
    }
    
}