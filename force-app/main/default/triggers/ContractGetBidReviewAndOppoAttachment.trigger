/*
    功能：创建合同自动把业务机会和投标评审的附件带过来
    创建人：霍东飞
    创建时间：2017-09-28
*/

trigger ContractGetBidReviewAndOppoAttachment on Contract__c (after insert) {
    if(trigger.new.size() > 100){
        System.Debug('Account Batch DMLs, ignore...');
    }else{
    for(Contract__c con:Trigger.new){  
        try{
        List<attachment__c> attList = new List<attachment__c>();
        List<attachment__c> cloneList = new List<attachment__c>();
        if(con.opportunity__c == null || con.reviewNumber__c == null){   //无机会肯定无合同评审编号。
            System.debug('无机会或无合同评审');
        }else{      //有机会肯定有合同评审编号    判断机会是否为子业务机会                   
            opportunity o = [select id,fatherOpportunity__c from opportunity where id =:con.opportunity__c];//判断业务机会          
            contractreview__c c = [select id,biddingApproval__c from contractreview__c where id =:con.reviewNumber__c]; //合同评审              
            if(o.fatherOpportunity__c != null){  //假如为子业务机会  
                if(c.biddingApproval__c != null){                 
                    attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c from attachment__c where 
                              (bidReview__c =:c.biddingApproval__c and type__c ='招标文件' and isValid__c = '有效') 
                              or (opportunity__c =:o.fatherOpportunity__c and type__c = '标书归档-非价格类' and isValid__c = '有效')];  
                }else{
                    attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c from attachment__c where opportunity__c =:o.fatherOpportunity__c and type__c = '标书归档-非价格类' and isValid__c = '有效'];
                }            
            }else{  //不为子业务机会     
                if(c.biddingApproval__c != null) {       
                    attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c from attachment__c where 
                              (bidReview__c =:c.biddingApproval__c and type__c ='招标文件' and isValid__c = '有效')                          
                              or (opportunity__c =:con.opportunity__c and type__c = '标书归档-非价格类' and isValid__c = '有效')];
                }else{
                    attList = [select id,contract__c,type__c,documentName__c,isValid__c,attachmentURL__c,notes__c from attachment__c where opportunity__c =:con.opportunity__c and type__c = '标书归档-非价格类' and isValid__c = '有效'];
                }
            }           
        }                                            
        for(attachment__c att:attList){
            attachment__c newAtt = new attachment__c();
            newAtt.contract__c = con.id;
            newAtt.type__c = att.type__c;
            newAtt.documentName__c = att.documentName__c;
            newAtt.isValid__c = att.isValid__c;
            newAtt.attachmentURL__c = att.attachmentURL__c;
            newAtt.notes__c = att.notes__c;                   
            cloneList.add(newAtt);  
            System.debug('长度   '+attList.size());         
        }
            insert cloneList;
            System.debug(cloneList);       
        }catch(exception e){
            System.debug('系统未知错误');
        }
    }
    }
}