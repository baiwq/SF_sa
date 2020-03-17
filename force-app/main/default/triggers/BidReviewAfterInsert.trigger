/*
	类名：BidReviewAfterInsert
	功能：设置投标评审记录的只读权限
	功能逻辑：
	对应测试类：TestBidReviewAfterInsert
	作者：Mark 柏文强-雨花石
	时间：2019-11-18
 */
trigger BidReviewAfterInsert on bidReview__c(after insert) 
{
	// 记录将要更插入的数据
	List<bidReview__Share> bidReviewNewList = new List<bidReview__Share>();

	// 数据共享数据过滤
	List<bidReview__Share> bidReviewUpdateList = new List<bidReview__Share>();

	Map<Id,List<OpportunityTeamMember>> oppNewMap = new Map<Id,List<OpportunityTeamMember>>();
	// 
	Map<Id,Map<Id,OpportunityTeamMember>> oppMap = new Map<Id,Map<Id,OpportunityTeamMember>>();

	Set<Id> oppIdSet = new Set<Id>();
	Set<Id> bidSet = new Set<Id>();
	for (bidReview__c bidReview : (List<bidReview__c>)Trigger.new) 
	{
		if(String.isNotBlank(bidReview.opportunity__c))
		{
			oppIdSet.add(bidReview.opportunity__c);
			bidSet.add(bidReview.Id);
		}
	}

	List<Opportunity> oppList = [select Id,
									(select Id,UserId,user.IsActive from OpportunityTeamMembers where user.IsActive=true) 
										from Opportunity where Id In:oppIdSet];

	for(Opportunity opp : oppList)
	{
		Map<Id,OpportunityTeamMember> memberMap = new Map<Id,OpportunityTeamMember>();
		List<OpportunityTeamMember> oppMemberList = new List<OpportunityTeamMember>();
		if(opp.OpportunityTeamMembers.size()>0)
		{
			for (OpportunityTeamMember oppMember : opp.OpportunityTeamMembers) 
			{
				memberMap.put(oppMember.UserId,oppMember);
			}
			oppMemberList = opp.OpportunityTeamMembers;
			oppNewMap.put(opp.Id, oppMemberList);
		}
		oppMap.put(opp.Id, memberMap);
	}

	// 查找存在的共享记录
	List<bidReview__Share> bidShareList = [select Id,UserOrGroupId,ParentId
    												from bidReview__Share 
    												where ParentId IN:bidSet];
	Map<Id,String> bidShareMap = new Map<Id,String>();

	for (bidReview__Share bidShare : bidShareList) 
	{
		bidShareMap.put(bidShare.ParentId, bidShare.UserOrGroupId);
	}

	System.debug('插入操作！');
	for (bidReview__c bidReview : (List<bidReview__c>)Trigger.new) 
	{
		List<OpportunityTeamMember> oppMemberList = oppNewMap.get(bidReview.opportunity__c);
		if(oppMemberList!=null && oppMemberList.size()>0)
		{
			System.debug('存在业务机会成员！');
			for (OpportunityTeamMember oppMember : oppMemberList) 
			{
				System.debug('内循环操作');
				if((bidShareMap.containsKey(bidReview.Id) && oppMember.UserId == bidShareMap.get(bidReview.Id)) || oppMember.UserId == bidReview.CreatedById)
				{
					continue;
				}
				else
				{
					System.debug('OpportunityTeamMember='+oppMember);
					bidReview__Share bidShare = new bidReview__Share();
				    bidShare.UserOrGroupId = oppMember.UserId;
				    bidShare.ParentId = bidReview.Id;
				    bidShare.AccessLevel = 'read';//设置为只读状态
				    bidReviewNewList.add(bidShare);
				}
			}
		}
	}

	if(bidReviewNewList.size()>0)
	{
		insert bidReviewNewList;
	}
	
}