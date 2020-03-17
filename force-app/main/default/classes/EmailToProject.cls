public class EmailToProject {
    public static void exe_sendEmail(String step,String contractNO,String objectId,String whatId,String TemplateId,String FixactionEmail,List<String> otherEmail){
        sendEmail(step,contractNO,deduplicationEmailByContract(contractNO),objectId,whatId,TemplateId,FixactionEmail,otherEmail);
    }
    public static List<String> deduplicationEmailByContract(String contractNO){
        List<ProjectTask__c> proList = [select id ,email__c from ProjectTask__c where contractNo__c =:contractNO];
        Set<String> emailSet = new Set<String>();
        List<String> emailList = new List<String>();
        if(proList.size()>0){
            for(ProjectTask__c task : proList){
                if(task.email__c!=null&&task.email__c.trim()!=''){
                    if(emailSet.add(task.email__c)){
                        emailList.add(task.email__c);
                    }
                }
            }
        }
        return emailList;
    }
    public static void sendEmail(String step,String contractNO,List<String> toAddress,String objectId,String whatId,String TemplateId,String FixactionEmail,List<String> otherEmail){
        try{
            
            if(toAddress.size()>0){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                if(otherEmail!=null&&otherEmail.size()>0){
                    toAddress.addAll(otherEmail);
                    toAddress.add(FixactionEmail);
                }
                mail.setToAddresses(toAddress);
                //mail.setSubject(step);
                //mail.setHtmlBody(htmlbody);
                mail.setReplyTo('renyx@tranzvision.com.cn');
                mail.setSenderDisplayName('四方继保SOSP项目组');
                mail.setTemplateId(TemplateId);
                mail.setTargetObjectId(objectId);
                mail.saveAsActivity = false;
                mail.setWhatId(whatId);
                mail.setTreatTargetObjectAsRecipient(false);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
                logClass.returnLog('成功', '已处理', '【发送邮件】:'+'合同：'+contractNO+',发送邮件节点:'+step+',发送邮件时间:'+system.now()+',邮件接收人:'+toAddress, '正常');
            }else{
                if(otherEmail!=null&&otherEmail.size()>0){
                    toAddress.addAll(otherEmail);
                   
                }
                if(FixactionEmail!=null){
          
                    toAddress.add(FixactionEmail);
                }    
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(toAddress);
                //mail.setSubject(step);
                //mail.setHtmlBody(htmlbody);
                mail.setReplyTo('renyx@tranzvision.com.cn');
                mail.setSenderDisplayName('四方继保SOSP项目组');
                mail.setTemplateId(TemplateId);
                mail.setTargetObjectId(objectId);
                mail.saveAsActivity = false;
                mail.setWhatId(whatId);
                mail.setTreatTargetObjectAsRecipient(false);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
                logClass.returnLog('成功', '已处理', '【发送邮件】:'+'合同：'+contractNO+',发送邮件节点:'+step+',发送邮件时间:'+system.now()+',邮件接收人:'+toAddress, '正常');
            }
        }catch(Exception e){
            logClass.returnLog('失败', '未处理', '【发送邮件】:'+'合同：'+contractNO+',发送邮件节点:'+step+',发送邮件时间:'+system.now()+',邮件接收人:'+toAddress+',原因:'+e.getMessage(), '重要');
        }
        
    }
}