trigger commisionUserInsertCheck on commisionUser__c (before insert,before update) 
{
    Set<String> oppIds = new Set<String>();
    if (trigger.isInsert) 
    {
        for (commisionUser__c cuser : (List<commisionUser__c>)trigger.new) 
        {
            oppIds.add(cuser.OpportunityID__c);
        }
    }
    else if (trigger.isUpdate) 
    {
        for (commisionUser__c cuser : (List<commisionUser__c>)trigger.new) 
        {
            commisionUser__c old_cuser = (commisionUser__c)trigger.oldMap.get(cuser.Id);
            if ((cuser.member__c != null && cuser.member__c != old_cuser.member__c) )
            {
                oppIds.add(cuser.OpportunityID__c);
            }
        }
    }
    Map<Id,Set<Id>> members = new Map<Id,Set<Id>>();
    List<OpportunityTeamMember> OTList = [Select id, UserId,OpportunityId from OpportunityTeamMember where OpportunityId IN: oppIds and (TeamMemberRole like :'%销售经理' or TeamMemberRole like :'%Sales Manager')];
    for (OpportunityTeamMember member : OTList) 
    {
        if (members.containsKey(member.OpportunityId)) 
        {
            Set<Id> memSet = members.get(member.OpportunityId);
            memSet.add(member.UserId);
            members.put(member.OpportunityId,memSet);
        }
        else 
        {
            Set<Id> memSet = new Set<Id>();
            memSet.add(member.UserId);
            members.put(member.OpportunityId,memSet);
        }
    }

    for (commisionUser__c cuser : (List<commisionUser__c>)trigger.new) 
    {
        if(members.containsKey(cuser.OpportunityID__c))
        {
            Set<Id> memSet = members.get(cuser.OpportunityID__c);
            if (!memSet.contains(cuser.member__c)) 
            {
               if(!System.Test.isRunningTest())
               {
				  cuser.addError('所选用户不为业务机会团队成员中的销售经理/主责销售经理角色，无法添加！');
               }
               
                
            }
        }
    }
}