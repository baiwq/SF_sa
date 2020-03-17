/*
	类名：ContractReviewAfterInsert
	功能：设置投标评审记录的只读权限
	功能逻辑：
	对应测试类：TestContractReviewAfterInsert
	作者：Mark 柏文强-雨花石
	时间：2019-11-18
 */
trigger ContractReviewAfterInsert on contractreview__c(after insert) 
{
	// 记录将要更插入的数据
	List<contractReview__Share> contractReviewNewList = new List<contractReview__Share>();

	Map<Id,List<OpportunityTeamMember>> oppNewMap = new Map<Id,List<OpportunityTeamMember>>();
	// 
	Map<Id,Map<Id,OpportunityTeamMember>> oppMap = new Map<Id,Map<Id,OpportunityTeamMember>>();

	Set<Id> oppIdSet = new Set<Id>();
	Set<Id> conSet = new Set<Id>();
	for (contractReview__c contractReview : (List<contractReview__c>)Trigger.new) 
	{
		if(String.isNotBlank(contractReview.opportunity__c))
		{
			oppIdSet.add(contractReview.opportunity__c);
			conSet.add(contractReview.Id);
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
	List<contractReview__Share> contractShareList = [select Id,UserOrGroupId,ParentId
    												from contractReview__Share 
    												where ParentId IN:conSet];
	Map<Id,String> contractShareMap = new Map<Id,String>();

	for (contractReview__Share contractShare : contractShareList) 
	{
		contractShareMap.put(contractShare.ParentId, contractShare.UserOrGroupId);
	}

	System.debug('插入操作！');
	for (contractReview__c contractReview : (List<contractReview__c>)Trigger.new) 
	{
		List<OpportunityTeamMember> oppMemberList = oppNewMap.get(contractReview.opportunity__c);
		if(oppMemberList!=null && oppMemberList.size()>0)
		{
			System.debug('存在业务机会成员！');
			for (OpportunityTeamMember oppMember : oppMemberList) 
			{
				System.debug('内循环操作');
				if((contractShareMap.containsKey(contractReview.Id) && oppMember.UserId == contractShareMap.get(contractReview.Id)) || oppMember.UserId == contractReview.CreatedById)
				{
					continue;
				}
				else
				{
					System.debug('OpportunityTeamMember='+oppMember);
					contractReview__Share contractShare = new contractReview__Share();
				    contractShare.UserOrGroupId = oppMember.UserId;
				    contractShare.ParentId = contractReview.Id;
				    contractShare.AccessLevel = 'read';//设置为只读状态
				    contractReviewNewList.add(contractShare);
				}
			}
		}
	}

	if(contractReviewNewList.size()>0)
	{
		insert contractReviewNewList;
	}	
    
}