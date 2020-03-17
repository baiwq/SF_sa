trigger BidReviewBeforeUpdate on bidReview__c (before update) {
    for(bidReview__c crNew : Trigger.new){
        if(crNew.departmentmanager1__c != null){
            crNew.departmentmanager__c =crNew.departmentmanager1__c;
        }else{
            crNew.departmentmanager__c=null;
        }
        bidReview__c crOld = Trigger.oldMap.get(crNew.id);
        if(crNew.reviewStatus__c!=crOld.reviewStatus__c&&crNew.reviewStatus__c=='评审完成'&&crNew.ownerCenter__c=='销售中心'&&crNew.RecordTypeFol__c=='投标评审-重大项目评审' ){
            //添加更新此字段满足审批条件2019-3-28
            crNew.ApproveComponent__c = '2222';
            if(crNew.legalFinalReviewSuggestion__c=='拒绝'){
                if(crNew.LegalRiskWork__c!=null&&crNew.LegalRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写法务风险应对措施');
                }
            }
            if(crNew.financeFinalReviewSuggestion__c =='拒绝'){
                if(crNew.FinanceRiskWork__c!=null&&crNew.FinanceRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写财务风险应对措施');
                }
            }
            if(crNew.outsourcingFinalReviewSuggestion__c =='拒绝'){
                if(crNew.OutSouringRiskWork__c!=null&&crNew.OutSouringRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写外购风险应对措施');
                }
            }
            if(crNew.technologyFinalReviewSuggestion__c =='拒绝'){
                if(crNew.TechnologyRiskWork__c!=null&&crNew.TechnologyRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写技术风险应对措施');
                }
            }
            if(crNew.warrantyPeriodFinalReviewSuggestion__c =='拒绝'){
                if(crNew.GuaranteeRiskWork__c!=null&&crNew.GuaranteeRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写质保期风险应对措施');
                }
            }
            if(crNew.dateOfDeliveryFinalReviewSuggestion__c =='拒绝'){
                if(crNew.DeliveryRiskWork__c!=null&&crNew.DeliveryRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写交货期风险应对措施');
                }
            }
            
            
            if(crNew.legalFinalReviewSuggestion__c=='拒绝'||crNew.outsourcingFinalReviewSuggestion__c =='拒绝'||
                crNew.technologyFinalReviewSuggestion__c =='拒绝'||crNew.warrantyPeriodFinalReviewSuggestion__c =='拒绝'
                ||crNew.dateOfDeliveryFinalReviewSuggestion__c =='拒绝'){
                if(crNew.EntiretyRiskWork__c!=null&&crNew.EntiretyRiskWork__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写整体风险应对措施');
                }
                /*if(crNew.EntiretyRiskSuggestion__c!=null&&crNew.EntiretyRiskSuggestion__c.trim()!=''){
                
                }else{
                    crNew.addError('请填写整体风险应对措施建议');
                }*/
            }
        }
    }
}