/**
 * 新建：2019-01-02 任艳新  
 * 功能：提交审批和审批通过后，不能新建、修改和删除附件
 */
trigger SalesNotDMLAttachment on Attachment (before insert,before update,before delete) {
    String currentUser = [select Profile.Name from User where id=:UserInfo.getUserId()][0].Profile.Name;
    if(Trigger.IsInsert){
        for(Attachment atta :Trigger.new){
            //标书费申请
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'expenseOfBidApply__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    expenseOfBidApply__c eba = [Select id,approvalStatus__c from expenseOfBidApply__c where id=:atta.ParentId];
                    if(eba.approvalStatus__c!='草稿'&&eba.approvalStatus__c!='审批拒绝'){
                        atta.addError('标书费申请已提交审批不能创建附件');
                    }
                }
            }
            //投标保证金
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'tbbaozhengjin__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    tbbaozhengjin__c tb = [Select id,approvalStatus__c from tbbaozhengjin__c  where id=:atta.ParentId];
                    if(tb.approvalStatus__c!='草稿'&&tb.approvalStatus__c!='审批拒绝'){
                        atta.addError('投标保证金/保函已提交审批不能创建附件');
                    }
                }
            }
            //中标服务费
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'bidCost__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    bidCost__c bc = [Select id,approvalStatus__c from bidCost__c where id=:atta.ParentId];
                    if(bc.approvalStatus__c!='草稿'&&bc.approvalStatus__c!='审批拒绝'){
                        atta.addError('中标服务费申请已提交审批不能创建附件');
                    }
                }
            }
            //履约保证金/保函
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'guaranteeLetter__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    guaranteeLetter__c gl = [Select id,approvalStatus__c from guaranteeLetter__c where id=:atta.ParentId];
                    if(gl.approvalStatus__c!='草稿'&&gl.approvalStatus__c!='审批拒绝'){
                        atta.addError('履约保证金/保函费申请已提交审批不能创建附件');
                    }
                }
            }
        }      
    }
    if(Trigger.IsUpdate){
        for(Attachment atta :Trigger.new){
            //标书费申请
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'expenseOfBidApply__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    expenseOfBidApply__c eba = [Select id,approvalStatus__c from expenseOfBidApply__c where id=:atta.ParentId];
                    if(eba.approvalStatus__c!='草稿'&&eba.approvalStatus__c!='审批拒绝'){
                        atta.addError('标书费申请已提交审批不能修改附件');
                    }
                }
            }
            //投标保证金
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'tbbaozhengjin__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    tbbaozhengjin__c tb = [Select id,approvalStatus__c from tbbaozhengjin__c  where id=:atta.ParentId];
                    if(tb.approvalStatus__c!='草稿'&&tb.approvalStatus__c!='审批拒绝'){
                        atta.addError('投标保证金/保函已提交审批不能修改附件');
                    }
                }
            }
            //中标服务费
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'bidCost__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    bidCost__c bc = [Select id,approvalStatus__c from bidCost__c where id=:atta.ParentId];
                    if(bc.approvalStatus__c!='草稿'&&bc.approvalStatus__c!='审批拒绝'){
                        atta.addError('中标服务费申请已提交审批不能修改附件');
                    }
                }
            }
            //履约保证金/保函
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'guaranteeLetter__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    guaranteeLetter__c gl = [Select id,approvalStatus__c from guaranteeLetter__c where id=:atta.ParentId];
                    if(gl.approvalStatus__c!='草稿'&&gl.approvalStatus__c!='审批拒绝'){
                        atta.addError('履约保证金/保函费申请已提交审批不能修改附件');
                    }
                }
            }
        }  
    }
    if(Trigger.IsDelete){
        for(Attachment atta :Trigger.old){
            //标书费申请
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'expenseOfBidApply__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    expenseOfBidApply__c eba = [Select id,approvalStatus__c from expenseOfBidApply__c where id=:atta.ParentId];
                    if(eba.approvalStatus__c!='草稿'&&eba.approvalStatus__c!='审批拒绝'){
                        atta.addError('标书费申请已提交审批不能删除附件');
                    }
                }
            }
            //投标保证金
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'tbbaozhengjin__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    tbbaozhengjin__c tb = [Select id,approvalStatus__c from tbbaozhengjin__c  where id=:atta.ParentId];
                    if(tb.approvalStatus__c!='草稿'&&tb.approvalStatus__c!='审批拒绝'){
                        atta.addError('投标保证金/保函已提交审批不能删除附件');
                    }
                }
            }
            //中标服务费
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'bidCost__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    bidCost__c bc = [Select id,approvalStatus__c from bidCost__c where id=:atta.ParentId];
                    if(bc.approvalStatus__c!='草稿'&&bc.approvalStatus__c!='审批拒绝'){
                        atta.addError('中标服务费申请已提交审批不能删除附件');
                    }
                }
            }
            //履约保证金/保函
            if (atta.parentId.getSobjectType().getDescribe().getName() == 'guaranteeLetter__c'){
                if(currentUser=='A-客户经理（四方三伊）'||currentUser=='A-客户经理'||currentUser=='A-省区经理'||currentUser=='A-大区经理'||currentUser=='A-客户经理(国际)'){
                    guaranteeLetter__c gl = [Select id,approvalStatus__c from guaranteeLetter__c where id=:atta.ParentId];
                    if(gl.approvalStatus__c!='草稿'&&gl.approvalStatus__c!='审批拒绝'){
                        atta.addError('履约保证金/保函费申请已提交审批不能删除附件');
                    }
                }
            }
        }  
    }
}