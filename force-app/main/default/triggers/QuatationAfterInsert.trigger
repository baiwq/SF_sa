/*
	类名：QuatationAfterInsert
	功能：设置报价管理的只读权限
	功能逻辑：
	对应测试类：TestQuatationAfterInsert
	作者：Mark 柏文强-雨花石
	时间：2019-11-18
 */
trigger QuatationAfterInsert on quatation__c(after insert) 
{
	// 记录将要更插入的数据
	List<quatation__Share> quatationNewList = new List<quatation__Share>();

	Map<Id,List<OpportunityTeamMember>> oppNewMap = new Map<Id,List<OpportunityTeamMember>>();
	// 
	Map<Id,Map<Id,OpportunityTeamMember>> oppMap = new Map<Id,Map<Id,OpportunityTeamMember>>();

	Set<Id> oppIdSet = new Set<Id>();
	Set<Id> quaSet = new Set<Id>();
	for (quatation__c quatation : (List<quatation__c>)Trigger.new) 
	{
		if(String.isNotBlank(quatation.opportunity__c))
		{
			oppIdSet.add(quatation.opportunity__c);
			quaSet.add(quatation.Id);
		}	
	}

	List<Opportunity> oppList = [select Id,
									(select Id,UserId,user.IsActive from OpportunityTeamMembers where user.IsActive = true) 
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

	List<quatation__Share> quaShareList = [select Id,UserOrGroupId,ParentId
    												from quatation__Share 
    												where ParentId IN:quaSet];
	Map<Id,String> quaShareMap = new Map<Id,String>();

	for (quatation__Share quaShare : quaShareList) 
	{
		quaShareMap.put(quaShare.ParentId, quaShare.UserOrGroupId);
	}

	System.debug('插入操作！');
	for (quatation__c quatation : (List<quatation__c>)Trigger.new) 
	{
		List<OpportunityTeamMember> oppMemberList = oppNewMap.get(quatation.opportunity__c);
		if(oppMemberList != null && oppMemberList.size()>0)
		{
			System.debug('存在业务机会成员！');
			for (OpportunityTeamMember oppMember : oppMemberList) 
			{
				System.debug('内循环操作');
				if((quaShareMap.containsKey(quatation.Id) && oppMember.UserId == quaShareMap.get(quatation.Id)) || oppMember.UserId == quatation.CreatedById)
				{
					continue;
				}
				else
				{
					System.debug('OpportunityTeamMember='+oppMember);
					quatation__Share quaShare = new quatation__Share();
				    quaShare.UserOrGroupId = oppMember.UserId;
				    quaShare.ParentId = quatation.Id;
				    quaShare.AccessLevel = 'read';//设置为只读状态
				    quatationNewList.add(quaShare);
				}
			}
		}
	}

	if(quatationNewList.size()>0)
	{
		insert quatationNewList;
	}
    
}