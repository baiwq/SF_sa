/*
    类名：ContractAttachmentSynchronization
    功能：创建合同管理后需要将合同评审上的中标通知书附件带入。
    作者：Jimmy Cao 曹阳
    时间：2019-08-08
*/
trigger ContractAttachmentSynchronization on Contract__c (after insert) 
{
    Set<Id> contractreviewIds = new Set<Id>();
    Map<Id,Id> contractMap = new Map<Id,Id>();
    for (Contract__c con : (List<Contract__c>)trigger.new) 
    {
        if (con.reviewNumber__c != null) 
        {
            contractreviewIds.add(con.reviewNumber__c);
            contractMap.put(con.Id, con.reviewNumber__c);
        }
    }
    List<attachment__c> attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c,contractReview__c from attachment__c WHERE contractReview__c IN: contractreviewIds AND (type__c = '中标通知' or type__c = '标书归档-价格类')];
    List<attachment__c> cloneList = new List<attachment__c>();
    for (attachment__c att : attList) 
    {
        for(String contractId : contractMap.keySet())
        {
            if (att.contractReview__c == contractMap.get(contractId)) 
            {
                attachment__c newAtt = new attachment__c();
                newAtt.contract__c = contractId;
                newAtt.type__c = att.type__c;
                newAtt.documentName__c = att.documentName__c;
                newAtt.isValid__c = att.isValid__c;
                newAtt.attachmentURL__c = att.attachmentURL__c;
                newAtt.notes__c = att.notes__c;                   
                cloneList.add(newAtt); 
            } 
        }
    }
    System.debug('长度   '+cloneList.size());         
    if (cloneList != null && cloneList.size() > 0) 
    {
        INSERT cloneList;
    }
}