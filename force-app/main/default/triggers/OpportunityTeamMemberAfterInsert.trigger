/*
	类名：OpportunityTeamMemberAfterInsert
	功能：为业务机会上的业务机会团队成员设置业务机会相关对象记录的只读权限
	功能逻辑：
	对应测试类：TestOpportunityTeamMember
	作者：Mark 柏文强-雨花石
	时间：2019-11-13
    覆盖率：91%
    
    修改人：Mark
    修改逻辑：在查询出对于记录的访问权限记录的时候，存放在map中，但是key使用的是记录的Id
             修改数据结构Map<String,Map<String,xxx__Share>>
    修改时间：2020-02-26
 */
trigger OpportunityTeamMemberAfterInsert on OpportunityTeamMember(after insert,before delete) 
{
	Set<Id> oppMemberSet = new Set<Id>();
	// Map<Id,OpportunityTeamMember> oppMemberMap = (Map<Id,OpportunityTeamMember>)Trigger.newMap;
	Id oppId = null;

    if(Trigger.isInsert){
        for(OpportunityTeamMember oppMember : (List<OpportunityTeamMember>)Trigger.new)
        {
            oppId = oppMember.OpportunityId;
            oppMemberSet.add(oppMember.UserId);
        }
    }

    if(Trigger.isDelete){
        for(OpportunityTeamMember oppMember : (List<OpportunityTeamMember>)Trigger.old)
        {
            oppId = oppMember.OpportunityId;
            oppMemberSet.add(oppMember.UserId);
        }
    }

    System.debug('oppMemberSet==='+oppMemberSet);
    
    Set<Id> bidSet = new Set<Id>();
    Set<Id> quaSet = new Set<Id>();
    Set<Id> conReviewSet = new Set<Id>();

    Map<Id,Id> bidIdMap = new Map<Id,Id>();
    Map<Id,Id> quaIdMap = new Map<Id,Id>();
    Map<Id,Id> conIdMap = new Map<Id,Id>();
    // 查询当前业务机会关联的投标评审，报价管理，合同评审信息
    List<bidReview__c> bidList = new List<bidReview__c>([select Id,OwnerId from bidReview__c where opportunity__c =:oppId]);
    for (bidReview__c bid : bidList) 
    {
    	bidSet.add(bid.Id);
        bidIdMap.put(bid.Id,bid.OwnerId);
    }

    List<quatation__c> quaList = new List<quatation__c>([select Id,OwnerId from quatation__c where opportunity__c =:oppId]);
    for (quatation__c qua : quaList) 
    {
    	quaSet.add(qua.Id);
        quaIdMap.put(qua.Id,qua.OwnerId);
    }

    List<contractreview__c> conReviewList = new List<contractreview__c>([select Id,OwnerId from contractreview__c where opportunity__c =:oppId]);
    for (contractreview__c conReview : conReviewList) 
    {
    	conReviewSet.add(conReview.Id);
        conIdMap.put(conReview.Id,conReview.OwnerId);
    }
    System.debug('bidList==='+bidList);
    System.debug('quaList==='+quaList);
    System.debug('conReviewList==='+conReviewList);

    /**
     * 1.ParentId  访问记录的Id
     * 2.UserOrGroupId  共享的用户或者小组 Id
     * 3.AccessLevel   授予权限等级 Edit Read All
     */

    // 业务机会关联的投标评审
    List<bidReview__Share> bidShareList = new List<bidReview__Share>([select Id,UserOrGroupId,ParentId from bidReview__Share 
    												where UserOrGroupId IN:oppMemberSet AND ParentId IN:bidSet]);
    // 业务机会关联的报价管理
    List<quatation__Share> quaShareList = new List<quatation__Share>([select Id,UserOrGroupId,ParentId from quatation__Share 
                                                    where UserOrGroupId IN:oppMemberSet AND ParentId IN:quaSet]);
    // 业务机会关联的合同评审
    List<contractreview__Share> conReviewShareList = new List<contractreview__Share>([select Id,UserOrGroupId,ParentId from contractreview__Share 
    												where UserOrGroupId IN:oppMemberSet AND ParentId IN:conReviewSet]);
	
    System.debug('bidShareList==='+bidShareList);
    System.debug('quaShareList==='+quaShareList);
    System.debug('conReviewShareList==='+conReviewShareList);
    
    if(Trigger.isDelete)
    {
        System.debug('删除操作');
        List<bidReview__Share> bidShareDelList = new List<bidReview__Share>();
        for (bidReview__Share bid : bidShareList) 
        {
            if(bidIdMap.containsKey(bid.ParentId) && bidIdMap.get(bid.ParentId) == bid.UserOrGroupId)
            {
                continue;
            }
            else
            {
                bidShareDelList.add(bid);
            }
        }
        List<quatation__Share> quaShareDelList = new List<quatation__Share>();
        for (quatation__Share qua : quaShareList) 
        {
            if(quaIdMap.containsKey(qua.ParentId) && quaIdMap.get(qua.ParentId) == qua.UserOrGroupId)
            {
                continue;
            }
            else
            {
                quaShareDelList.add(qua);
            }
        }
        List<contractreview__Share> conReviewShareDelList = new List<contractreview__Share>();
        for (contractreview__Share con : conReviewShareList) 
        {
            if(conIdMap.containsKey(con.ParentId) && conIdMap.get(con.ParentId) == con.UserOrGroupId)
            {
                continue;
            }
            else
            {
                conReviewShareDelList.add(con);
            }
        }
        Database.delete(bidShareDelList);
        Database.delete(quaShareDelList);
        Database.delete(conReviewShareDelList);
    }

    if(Trigger.isInsert)
    {
        Map<String,Map<String,bidReview__Share>> bidReviewMap = new Map<String,Map<String,bidReview__Share>>();
        Map<String,Map<String,quatation__Share>> quaMap = new Map<String,Map<String,quatation__Share>>();
        Map<String,Map<String,contractreview__Share>> conReviewMap = new Map<String,Map<String,contractreview__Share>>();

        for (bidReview__Share bid : bidShareList) 
        {
            // 2020--2-26 修改内容
            if(bidReviewMap.containsKey(bid.ParentId))
            {
                Map<String,bidReview__Share> brMap = bidReviewMap.get(bid.ParentId);
                brMap.put(bid.UserOrGroupId, bid);
                bidReviewMap.put(bid.ParentId, brMap);
            }
            else
            {
                Map<String,bidReview__Share> brMap = new Map<String,bidReview__Share>();
                brMap.put(bid.UserOrGroupId, bid);
                bidReviewMap.put(bid.ParentId, brMap);
            }
            
        }

        for (quatation__Share qua : quaShareList) 
        {
            // 2020--2-26 修改内容
            if(quaMap.containsKey(qua.ParentId))
            {
                Map<String,quatation__Share> qMap = quaMap.get(qua.ParentId);
                qMap.put(qua.UserOrGroupId, qua);
                quaMap.put(qua.ParentId, qMap);
            }
            else
            {
                Map<String,quatation__Share> qMap = new Map<String,quatation__Share>();
                qMap.put(qua.UserOrGroupId, qua);
                quaMap.put(qua.ParentId, qMap);
            }
        }

        for (contractreview__Share conReview : conReviewShareList) 
        {
            // 2020--2-26 修改内容
            if(conReviewMap.containsKey(conReview.ParentId))
            {
                Map<String,contractreview__Share> cMap = conReviewMap.get(conReview.ParentId);
                cMap.put(conReview.UserOrGroupId, conReview);
                conReviewMap.put(conReview.ParentId, cMap);
            }
            else
            {
                Map<String,contractreview__Share> cMap = new Map<String,contractreview__Share>();
                cMap.put(conReview.UserOrGroupId, conReview);
                conReviewMap.put(conReview.ParentId, cMap);
            }
        }

        // 记录将要插入的共享
        List<bidReview__Share> bidReviewNewList = new List<bidReview__Share>();
        List<quatation__Share> quaNewList = new List<quatation__Share>();
        List<contractreview__Share> conReviewNewList = new List<contractreview__Share>();

        for (bidReview__c bid : bidList) 
        {
            for (OpportunityTeamMember oppMember : (List<OpportunityTeamMember>)Trigger.new) 
            {
                // 2020--2-26 修改内容
                if(bidReviewMap.containsKey(bid.Id))
                {
                    Map<String,bidReview__Share> bMap = bidReviewMap.get(bid.Id);
                    if(bMap.containsKey(oppMember.UserId) && oppMember.UserId==bMap.get(oppMember.UserId).UserOrGroupId)
                    {
                        continue;
                    }
                    else
                    {
                        bidReview__Share bidShare = new bidReview__Share();
                        bidShare.UserOrGroupId = oppMember.UserId;
                        bidShare.ParentId = bid.Id;
                        bidShare.AccessLevel = 'read';//设置为只读状态
                        bidReviewNewList.add(bidShare);
                    }
                }
                else
                {
                    bidReview__Share bidShare = new bidReview__Share();
                    bidShare.UserOrGroupId = oppMember.UserId;
                    bidShare.ParentId = bid.Id;
                    bidShare.AccessLevel = 'read';//设置为只读状态
                    bidReviewNewList.add(bidShare);
                }
            }
        }

        for (quatation__c qua : quaList) 
        {
            for (OpportunityTeamMember oppMember : (List<OpportunityTeamMember>)Trigger.new) 
            {
                // 2020--2-26 修改内容
                if(quaMap.containsKey(qua.Id))
                {
                    Map<String,quatation__Share> qMap = quaMap.get(qua.Id);
                    if(qMap.containsKey(oppMember.UserId) && oppMember.UserId==qMap.get(oppMember.UserId).UserOrGroupId)
                    {
                        System.debug('quatation__c=====oppMember.UserId='+oppMember.UserId);
                        continue;
                    }
                    else
                    {
                        quatation__Share quaShare = new quatation__Share();
                        quaShare.UserOrGroupId = oppMember.UserId;
                        quaShare.ParentId = qua.Id;
                        quaShare.AccessLevel = 'read';//设置为只读状态
                        quaNewList.add(quaShare);
                    }
                }
                else
                {
                    quatation__Share quaShare = new quatation__Share();
                    quaShare.UserOrGroupId = oppMember.UserId;
                    quaShare.ParentId = qua.Id;
                    quaShare.AccessLevel = 'read';//设置为只读状态
                    quaNewList.add(quaShare);
                }
            }
        }

        for (contractreview__c conReview : conReviewList) 
        {
            for (OpportunityTeamMember oppMember : (List<OpportunityTeamMember>)Trigger.new) 
            {
                if(conReviewMap.containsKey(conReview.Id))
                {
                    // 2020--2-26 修改内容
                    Map<String,contractreview__Share> cMap = conReviewMap.get(conReview.Id);
                    if(cMap.containsKey(oppMember.UserId) && oppMember.UserId==cMap.get(oppMember.UserId).UserOrGroupId)
                    {
                        continue;
                    }
                    else
                    {
                        contractreview__Share conReviewShare = new contractreview__Share();
                        conReviewShare.UserOrGroupId = oppMember.UserId;
                        conReviewShare.ParentId = conReview.Id;
                        conReviewShare.AccessLevel = 'read';//设置为只读状态
                        conReviewNewList.add(conReviewShare);
                    }
                }
                else
                {
                    contractreview__Share conReviewShare = new contractreview__Share();
                    conReviewShare.UserOrGroupId = oppMember.UserId;
                    conReviewShare.ParentId = conReview.Id;
                    conReviewShare.AccessLevel = 'read';//设置为只读状态
                    conReviewNewList.add(conReviewShare);
                }
            }
        }

        // 执行插入操作
        insert bidReviewNewList;
        insert quaNewList;
        insert conReviewNewList;
    }
    
}