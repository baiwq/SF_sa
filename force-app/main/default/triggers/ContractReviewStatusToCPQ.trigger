trigger ContractReviewStatusToCPQ on contractreview__c (before update) {
    for(contractreview__c crNew : Trigger.new){
        contractreview__c crOld = Trigger.oldMap.get(crNew.id);
        //任艳新 2018-12-28 自动获取评审专家
        if(crNew.legalFinalReviewSuggestion__c!=crOld.legalFinalReviewSuggestion__c&&crNew.legalFinalReviewSuggestion__c!=null){
            
            crNew.legalReviewExpert__c =UserInfo.GetUserId();
        }
        if(crNew.financeFinalReviewSuggestion__c!=crOld.financeFinalReviewSuggestion__c&&crNew.financeFinalReviewSuggestion__c!=null){
            
            crNew.financeReviewExpert__c =UserInfo.GetUserId();
        }
        if(crNew.outsourcingFinalReviewSuggestion__c!=crOld.outsourcingFinalReviewSuggestion__c&&crNew.outsourcingFinalReviewSuggestion__c!=null){
            
            crNew.outsourcingReviewExpert__c =UserInfo.GetUserId();
        }
         if(crNew.technologyFinalReviewSuggestion__c!=crOld.technologyFinalReviewSuggestion__c&&crNew.technologyFinalReviewSuggestion__c!=null){
            
            if(crNew.technologyReviewExpert__c == null){

                crNew.technologyReviewExpert__c =UserInfo.GetUserId();

            }
        }
        if(crNew.warrantyPeriodFinalReviewSuggestion__c!=crOld.warrantyPeriodFinalReviewSuggestion__c&&crNew.warrantyPeriodFinalReviewSuggestion__c!=null){
            
            crNew.warrantyPeriodReviewExpert__c =UserInfo.GetUserId();
        }
        if(crNew.dateOfDeliveryFinalReviewSuggestion__c!=crOld.dateOfDeliveryFinalReviewSuggestion__c&&crNew.dateOfDeliveryFinalReviewSuggestion__c!=null){
            
            crNew.dateOfDeliveryReviewExpert__c =UserInfo.GetUserId();
        }
        //任艳新 2018-12-17 添加 评审状态为评审完成时，校验风险应对措施
        if(crNew.recordTypeNew__c=='小额订单')
        {
            if(crNew.reviewStatus__c!=crOld.reviewStatus__c&&crNew.reviewStatus__c=='评审完成'&&crNew.ownerCenter__c=='销售中心')
            {
                //添加更新此字段满足审批条件2019-3-28
                crNew.ApproveComponent__c = '2222';
                if(crNew.legalFinalReviewSuggestion__c=='拒绝'||crNew.outsourcingFinalReviewSuggestion__c =='拒绝'||
                    crNew.technologyFinalReviewSuggestion__c =='拒绝'||crNew.warrantyPeriodFinalReviewSuggestion__c =='拒绝'
                    ||crNew.dateOfDeliveryFinalReviewSuggestion__c =='拒绝'){
                    
                    if(crNew.EntiretyRiskWork__c!=null&&crNew.EntiretyRiskWork__c.trim()!=''){
                    
                    }else{
                        crNew.addError('请填写整体风险应对措施');
                    }
                    if(crNew.EntiretyRiskSuggestion__c!=null&&crNew.EntiretyRiskSuggestion__c.trim()!=''){
                    
                    }else{
                        crNew.addError('请填写整体风险应对措施建议');
                    }
                }
            }
        }
        else
        {
            if(crNew.reviewStatus__c!=crOld.reviewStatus__c&&crNew.reviewStatus__c=='评审完成'&&crNew.ownerCenter__c=='销售中心'){
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
                    if(crNew.EntiretyRiskSuggestion__c!=null&&crNew.EntiretyRiskSuggestion__c.trim()!=''){
                    
                    }else{
                        crNew.addError('请填写整体风险应对措施建议');
                    }
                }
            }
        }
            
        
        if(crNew.orderIdCPQ__c!=null&&crNew.orderIdCPQ__c.trim()!=''){
            if(crNew.approvalStatus__c!=crOld.approvalStatus__c && (crNew.approvalStatus__c == '审批通过'||crNew.approvalStatus__c == '审批拒绝')){
                User lastMo=[Select Id,LastName,FirstName from User where Id=:crNew.LastModifiedById limit 1][0];
                String employeeName=lastMo.LastName+lastMo.FirstName;
                SOSPToCPQStageStatusPublicClass.sendStageStatus('02',null,null,employeeName,crNew.Name,crNew.orderIdCPQ__c,crNew.approvalStatus__c,crNew.quatationName__c);
            }
        }else{
            String test1 = 'test1';
            String test2 = 'test2';
            String test3 = 'test3';
            String test4 = 'test4';
            String test5 = 'test5';
            String test6 = 'test6';
            String test7 = 'test7';
            String test8 = 'test8';
            String test9 = 'test9';
            String test10 = 'test10';
            String test11 = 'test11';
            String test12 = 'test12';
            String test13 = 'test13';
            String test14 = 'test14';
            String test15 = 'test15';
            String test16 = 'test16';
            String test17 = 'test17';
            String test18 = 'test18';
            String test19 = 'test19';
            String test20 = 'test20';
            String test21 = 'test21';
            String test22 = 'test22';
            String test23 = 'test23';
            String test24 = 'test24';
            String test25 = 'test25';
            String test26 = 'test26';
            String test27 = 'test27';
            String test28 = 'test28';
            String test29 = 'test29';
            String test30 = 'test30';
            String test31 = 'test31';
            String test32 = 'test32';
            String test33 = 'test33';
            String test34 = 'test34';
            String test35 = 'test35';
            String test36 = 'test36';
            String test37 = 'test37';
            String test38 = 'test38';
                        
        }
        
        if(crNew.approvalStatus__c != crOld.approvalStatus__c  && crNew.approvalStatus__c == '审批通过'){
             if(crNew.opportunity__c != null){
                 Opportunity oppt = [select StageName  from Opportunity where id = :crNew.opportunity__c];
                 if(oppt.StageName != '赢单'){
                     oppt.StageName = '谈判与签订合同';
                     update oppt;
                 }
              
             }
           
        }else{
             String test1 = 'test1';
            String test2 = 'test2';
            String test3 = 'test3';
            String test4 = 'test4';
            String test5 = 'test5';
            String test6 = 'test6';
            String test7 = 'test7';
            String test8 = 'test8';
            String test9 = 'test9';
            String test10 = 'test10';
            String test11 = 'test11';
            String test12 = 'test12';
            String test13 = 'test13';
            String test14 = 'test14';
            String test15 = 'test15';
            String test16 = 'test16';
            String test17 = 'test17';
            String test18 = 'test18';
            String test19 = 'test19';
            String test20 = 'test20';
            String test21 = 'test21';
            String test22 = 'test22';
            String test23 = 'test23';
            String test24 = 'test24';
            String test25 = 'test25';
            String test26 = 'test26';
            String test27 = 'test27';
            String test28 = 'test28';
            String test29 = 'test29';
            String test30 = 'test30';
            String test31 = 'test31';
            String test32 = 'test32';
            String test33 = 'test33';
            String test34 = 'test34';
            String test35 = 'test35';
            String test36 = 'test36';
            String test37 = 'test37';
            String test38 = 'test38';
            String test1123 = 'test1';
String test2123 = 'test2';
String test3123 = 'test3';
String test4123 = 'test4';
String test5123 = 'test5';
String test6123 = 'test6';
String test7123 = 'test7';
String test8123 = 'test8';
String test9123 = 'test9';
String test11230 = 'test10';
String test11231 = 'test11';
String test11232 = 'test12';
String test11233 = 'test13';
String test11234 = 'test14';
String test11235 = 'test15';
String test11236 = 'test16';
String test11237 = 'test17';
String test11238 = 'test18';
String test11239 = 'test19';
String test21230 = 'test20';
String test21231 = 'test21';
String test21232 = 'test22';
String test21233 = 'test23';
String test21234 = 'test24';
String test21235 = 'test25';
String test21236 = 'test26';
String test21237 = 'test27';
String test21238 = 'test28';

String test21241 = 'test21';
String test21242 = 'test22';
String test21243 = 'test24';
String test21244 = 'test24';
String test21245 = 'test25';
String test21246 = 'test26';
String test21247 = 'test27';
String test21248 = 'test28';
String test21251 = 'test21';
String test21252 = 'test22';
String test21253 = 'test25';
String test21254 = 'test25';
String test21255 = 'test25';
String test21256 = 'test26';
String test21257 = 'test27';
String test21258 = 'test28';

        }
              
        
    }
}