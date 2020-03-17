public with sharing class NotificationHomeController {
    public List<notification__c> nList{get;set;}
    
    public NotificationHomeController(ApexPages.StandardController controller) {
        nList = [SELECT Id, Name,  createDate__c, subject__c, area__c, owner__c, type__c, category__c from notification__c where active__c = true order by top__c desc, CreatedDate desc limit 10];
    }

}