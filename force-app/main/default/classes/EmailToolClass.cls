public class EmailToolClass {
    
    public static void sendEmail(List<String> toAddress,String objectId,String whatId,String TemplateId){
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddress);    
            mail.setReplyTo('renyx@tranzvision.com.cn');
            mail.setSenderDisplayName('四方继保SOSP项目组');
            mail.setTemplateId(TemplateId);
            mail.setTargetObjectId(objectId);
            mail.saveAsActivity = false;
            mail.setWhatId(whatId);
            mail.setTreatTargetObjectAsRecipient(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });        
        }catch(Exception e){
            
        }  
    }
    //2018-12-19 任艳新 创建： 标书制作人员邮件 
    public static void sendEmailBid(List<String> toAddress,String objectId,String whatId,String TemplateId,String salesManager){
        try{
            List<String> ccAddress = new List<String>();
            ccAddress.add('wudexia@sf-auto.com');
            ccAddress.add('panmei@sf-auto.com');
            ccAddress.add('huangsihui@sf-auto.com');
            ccAddress.add('zhaopei@sf-auto.com');
            ccAddress.add('fengxiaoqian@sf-auto.com');
            ccAddress.add('lianglijun@sf-auto.com');
            ccAddress.add('wangheli@sf-auto.com');
            ccAddress.add('zhangjianbo@sf-auto.com');
            ccAddress.add(salesManager);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setToAddresses(toAddress);    
            mail.setReplyTo('renyx@tranzvision.com.cn');
            mail.setSenderDisplayName('市场支持部');
            mail.setTemplateId(TemplateId);
            mail.setTargetObjectId(objectId);
            mail.setCcAddresses(ccAddress);
            mail.saveAsActivity = false;
            mail.setWhatId(whatId);
            mail.setTreatTargetObjectAsRecipient(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });        
        }catch(Exception e){
            

        }  
    }
    
     //2018-12-19 任艳新 创建： 标书制作人员邮件 
    public static void sendEmailtbry(List<String> toAddress,String objectId,String whatId,String TemplateId,String salesManager){
        try{
            List<String> ccAddress = new List<String>();
            ccAddress.add(salesManager);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();            
            mail.setToAddresses(toAddress);    
            mail.setReplyTo('renyx@tranzvision.com.cn');
            mail.setSenderDisplayName('市场支持部');
            mail.setTemplateId(TemplateId);
            mail.setTargetObjectId(objectId);
            mail.setCcAddresses(ccAddress);
            mail.saveAsActivity = false;
            mail.setWhatId(whatId);
            mail.setTreatTargetObjectAsRecipient(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });        
        }catch(Exception e){
            

        }  
    }
}