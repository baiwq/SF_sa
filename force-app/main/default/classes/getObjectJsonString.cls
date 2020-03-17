public class getObjectJsonString{
    public String getAddAccountJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);   
        //得到database.query()的字符串参数
        String objectName = 'Account'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }      
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
        //System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE  CreatedDate >= :st and CreatedDate <= :et';
        //查找对象List        
        List<Account> accList = database.query(query);    
        //转化为JSON字符串  
        String accJsonString=  JSON.serialize(accList );
        System.debug(accJsonString);
        return accJsonString;
    }
    public String getAddSalesLeadJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);        
        //得到database.query()的字符串参数
        String objectName = 'salesLeads__c'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE  CreatedDate >= :st and CreatedDate <= :et';                 
        List<salesLeads__c> sldList = database.query(query);      
        String sldJsonString=  JSON.serialize(sldList );
        System.debug(sldJsonString);
        return sldJsonString;
    }
    public String getAddOpportunityJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);     
        //得到database.query()的字符串参数
        String objectName = 'Opportunity'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE  CreatedDate >= :st and CreatedDate <= :et';
                 
        List<Opportunity> oppoList = database.query(query);      
        String oppoJsonString=  JSON.serialize(oppoList );
        System.debug(oppoJsonString);
        return oppoJsonString;
    }
    public String getAddContractJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);        
        //得到database.query()的字符串参数
        String objectName = 'Contract__c'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE  CreatedDate >= :st and CreatedDate <= :et';
                 
        List<Contract__c> conList = database.query(query);      
        String conJsonString=  JSON.serialize(conList );
        System.debug(conJsonString);
        return conJsonString;
    }
    
    public String getUpdateAccountJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);   
        //得到database.query()的字符串参数
        String objectName = 'Account'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }      
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
            //System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE (CreatedDate < :st or  CreatedDate > :et) and LastModifiedDate >= :st and LastModifiedDate <= :et'; 
                 
        List<Account> accList = database.query(query);      
        String accJsonString=  JSON.serialize(accList );
        System.debug(accJsonString);
        return accJsonString;
    }
    public String getUpdateSalesLeadJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);        
        //得到database.query()的字符串参数
        String objectName = 'salesLeads__c'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE (CreatedDate < :st or  CreatedDate > :et) and LastModifiedDate >= :st and LastModifiedDate <= :et'; 
                 
        List<salesLeads__c> sldList = database.query(query);      
        String sldJsonString=  JSON.serialize(sldList );
        System.debug(sldJsonString);
        return sldJsonString;
    }
    public String getUpdateOpportunityJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);     
        //得到database.query()的字符串参数
        String objectName = 'Opportunity'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE (CreatedDate < :st or  CreatedDate > :et) and LastModifiedDate >= :st and LastModifiedDate <= :et'; 
                 
        List<Opportunity> oppoList = database.query(query);      
        String oppoJsonString=  JSON.serialize(oppoList );
        System.debug(oppoJsonString);
        return oppoJsonString;
    }
    public String getUpdateContractJsonString(String startTime,String endTime){
        DateTime st = DateTime.valueOf(startTime);
        DateTime et = DateTime.valueOf(endTime);  
        //得到database.query()的字符串参数
        String objectName = 'Contract__c'; 
        String query = 'SELECT';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        for(String s : objectFields.keySet()) {
           query += ' ' + s + ',';
        }   
          
        if (query.subString(query.Length()-1,query.Length()) == ','){
            query = query.subString(0,query.Length()-1);
        }
           // System.debug(query );
        query += ' FROM ' + objectName;
        query += ' WHERE (CreatedDate < :st or  CreatedDate > :et) and LastModifiedDate >= :st and LastModifiedDate <= :et'; 
                 
        List<Contract__c> conList = database.query(query);      
        String conJsonString=  JSON.serialize(conList );
        System.debug(conJsonString);
        return conJsonString;
    }
}