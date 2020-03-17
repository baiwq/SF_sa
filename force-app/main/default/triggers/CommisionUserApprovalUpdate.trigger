/*
    类名：CommisionUserApprovalUpdate
    功能：因为业绩比例分配的审批需要由被分享人先审批，所以需要将业绩比例分配人员的信息同步到业绩比例分配上去
            因流程上明确说明共享人不能大于8个，所以在业绩比例分配上新建了8个字段用于记录共享人
            当共享人超过8个时，只取前8个
    作者：Jimmy Cao 曹阳 - 雨花石
    时间：2019-07-11
*/
trigger CommisionUserApprovalUpdate on commisionUser__c (after insert,after delete,after update) 
{
    Set<String> commisionSplitIds = new Set<String>();
    if (trigger.isInsert) 
    {
        for (commisionUser__c cuser : (List<commisionUser__c>)trigger.new) 
        {
            commisionSplitIds.add(cuser.commisionSplit__c);
        }
    }
    else if (trigger.isUpdate) 
    {
        for (commisionUser__c cuser : (List<commisionUser__c>)trigger.new) 
        {
            commisionUser__c old_cuser = (commisionUser__c)trigger.oldMap.get(cuser.Id);
            if ((cuser.commisionSplit__c != null && cuser.commisionSplit__c != old_cuser.commisionSplit__c) ||(cuser.member__c != null && cuser.member__c != old_cuser.member__c) )
            {
                commisionSplitIds.add(cuser.commisionSplit__c);
            }
        }
    }
    else  if (trigger.isDelete) 
    {
        for (commisionUser__c cuser : (List<commisionUser__c>)trigger.old) 
        {
            commisionSplitIds.add(cuser.commisionSplit__c);
        }
    }

    List<commisionSplit__c> csplit = new List<commisionSplit__c>([SELECT Id,SharedPerson1__c,SharedPerson2__c,SharedPerson3__c,SharedPerson4__c,
                                                                            SharedPerson5__c,SharedPerson6__c,SharedPerson7__c,SharedPerson8__c,
                                                                            SharedPersonNum__c,
                                                                            (SELECT Id,member__c FROM e__r) 
                                                                    FROM commisionSplit__c 
                                                                    WHERE Id IN: commisionSplitIds]);
    for(commisionSplit__c com : csplit)
    {
        //先清空之前的记录，然后重新赋值
        com.SharedPerson1__c = null;
        com.SharedPerson2__c = null;
        com.SharedPerson3__c = null;
        com.SharedPerson4__c = null;
        com.SharedPerson5__c = null;
        com.SharedPerson6__c = null;
        com.SharedPerson7__c = null;
        com.SharedPerson8__c = null;
        if (com.e__r.size() > 0) 
        {
            if (com.e__r.size() > 8) 
            {
                com.SharedPersonNum__c = 8;
            }
            else 
            {
                com.SharedPersonNum__c = com.e__r.size();
            }
            for (commisionUser__c cu : com.e__r) 
            {
                if (com.SharedPerson1__c == null) 
                {
                    com.SharedPerson1__c = cu.member__c;
                }
                else if (com.SharedPerson2__c == null) 
                {
                    com.SharedPerson2__c = cu.member__c;
                }
                else if (com.SharedPerson3__c == null) 
                {
                    com.SharedPerson3__c = cu.member__c;
                }
                else if (com.SharedPerson4__c == null) 
                {
                    com.SharedPerson4__c = cu.member__c;
                }
                else if (com.SharedPerson5__c == null) 
                {
                    com.SharedPerson5__c = cu.member__c;
                }
                else if (com.SharedPerson6__c == null) 
                {
                    com.SharedPerson6__c = cu.member__c;
                }
                else if (com.SharedPerson7__c == null) 
                {
                    com.SharedPerson7__c = cu.member__c;
                }
                else if (com.SharedPerson8__c == null) 
                {
                    com.SharedPerson8__c = cu.member__c;
                }
            }
        }
    }

    UPDATE csplit;
}