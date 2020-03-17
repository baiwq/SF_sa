/*
    类名：commisionUserUpdateCheck
    功能：业绩分配比例成员数据修改校验，当业绩分配比例为提交待审批或者为审批通过时，业绩分配比例成员不能修改或删除
    说明：因删除动作无法使用验证规则进行控制，因此使用代码控制此逻辑。
    时间：2019-11-20
    作者：Jimmy Cao 曹阳 - 雨花石
*/
trigger commisionUserUpdateCheck on commisionUser__c (before update,before delete) 
{
    if (trigger.isUpdate) 
    {
        for (commisionUser__c user : (List<commisionUser__c>)Trigger.new) {
            if (user.fatherApprovalStatus__c == '提交待审批' || user.fatherApprovalStatus__c == '审批通过') {
                user.addError('业绩分配比例审批状态为“审批通过“或“提交待审批“状态时，业绩分配比例成员信息不允许修改！');
            }
        }
    }
    else if (trigger.isDelete) 
    {
        for (commisionUser__c user : (List<commisionUser__c>)Trigger.old) {
            if (user.fatherApprovalStatus__c == '提交待审批' || user.fatherApprovalStatus__c == '审批通过') {
                user.addError('业绩分配比例审批状态为“审批通过“或“提交待审批“状态时，业绩分配比例成员信息不允许删除！');
            }        
        }
    }
}