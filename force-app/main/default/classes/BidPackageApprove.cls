global class BidPackageApprove {

    webservice static String  confirm(String recordId,String submitId){      
        try{
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();  
            req1.setObjectId(recordId);// 当前记录ID
            //User u = [select id,center__c from User where id=:m.ownerId];
            req1.setSubmitterId(submitId);// 初始提交人ID                             
            req1.setSkipEntryCriteria(false);// 是否跳过标准   
            Approval.ProcessResult result = Approval.process(req1); //提交审批
            return 'success';
        }catch(Exception e){ 
              return e.getMessage();
        }
    }
}