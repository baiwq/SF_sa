/*
    类名：BidCostAttachmentSynchronization
    功能：当中标服务费对象中填写了合同评审编号时，如果合同评审下具有中标通知附件，
            系统自动将合同评审下的中标通知附件代入至中标通知。
    作者：Jimmy cao 曹阳 雨花石
    时间：2019-08-07
*/
trigger BidCostAttachmentSynchronization on bidCost__c (after insert) 
{
    Set<Id> contractreviewIds = new Set<Id>();
    Map<Id,Id> bidCostContractMap = new Map<Id,Id>();
    for (bidCost__c bidCost : (List<bidCost__c>)trigger.new) 
    {
        if (bidCost.contractreview__c != null) {
            contractreviewIds.add(bidCost.contractreview__c);
            bidCostContractMap.put(bidCost.Id, bidCost.contractreview__c);
        }
    }

    if (contractreviewIds != null && contractreviewIds.size() > 0) 
    {
        List<attachment__c> attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c,contractReview__c from attachment__c WHERE contractReview__c IN: contractreviewIds AND type__c = '中标通知'];
        List<attachment__c> updateAttList = new List<attachment__c>();
        for (Id bidcostId : bidCostContractMap.keySet()) 
        {
            System.debug('=====bidcostId:'+bidcostId);
            for (attachment__c att : attList) 
            {
                System.debug('=====att:'+att.Id);
                if (att.contractReview__c == bidCostContractMap.get(bidcostId)) 
                {
                    System.debug('=====qqqqqqq');
                    attachment__c newAtt = new attachment__c();
                    newAtt.bidCost__c = bidcostId;
                    newAtt.type__c = att.type__c;
                    newAtt.documentName__c = att.documentName__c;
                    newAtt.isValid__c = att.isValid__c;
                    newAtt.attachmentURL__c = att.attachmentURL__c;
                    newAtt.notes__c = att.notes__c;             
                    updateAttList.add(newAtt);
                }
            }
        }
        if (updateAttList != null && updateAttList.size() > 0) {
            INSERT updateAttList;
        }
    }
}