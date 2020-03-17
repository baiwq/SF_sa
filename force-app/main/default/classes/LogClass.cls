public class LogClass {
    public static void returnLog(String identification,String dealStatus,String content,String priority){
        log__c l = new log__c();
        l.identification__c=identification;
        l.dealStatus__c=dealStatus;
        l.content__c=content;
        l.priority__c=priority;
        try{
            insert l;            
        }catch(Exception e){
            
        }
    }
    public static log__c reLog(String identification,String dealStatus,String content,String priority){
        log__c l = new log__c();
        l.identification__c=identification;
        l.dealStatus__c=dealStatus;
        l.content__c=content;
        l.priority__c=priority;
        return l;
    }
    public static void insertLog(List<log__c> li){
        try{
            insert li;            
        }catch(Exception e){
            
        }
    }
}