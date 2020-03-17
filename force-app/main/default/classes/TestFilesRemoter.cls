@isTest(seeAllData=true)
public with sharing class TestFilesRemoter{
    static testMethod void FilesRemoterTest1(){
       FilesRemoter.deleteLog();
       FilesRemoter.insertInvoice([Select id from Invoice__c where Field1__c='是' limit 1].id);
       FilesRemoter.sendReturn([Select id from returnPool__c limit 1].id);
       FilesRemoter.sendToSap([Select id from Invoice__c limit 1].id);
       FilesRemoter.sendacctoSap('客户变化阶段',[Select id from Account limit 1].id,'C','CC01','S001');
       FilesRemoter.getInvoiceInfo('2013-01-01','2016-12-01');
       FilesRemoter.GetContractStPlanDate('2013-01-01','2016-12-01');
       FilesRemoter.upload();
      
    }
    
}