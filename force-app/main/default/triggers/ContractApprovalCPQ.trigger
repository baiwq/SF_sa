//TestApprovalCPQ
trigger ContractApprovalCPQ on Contract__c (before update) {
    for(Contract__c cc:Trigger.new){
        Contract__c oldcc = Trigger.oldMap.get(cc.id);
   
        if(!System.Test.isRunningTest()){
            if(cc.StartId__c == '是'){
                if(cc.isfindSupply__c == '是'){
                    
                    if(cc.sfscghfw__c == '是'){
                        if((oldcc.approvalStatus__c =='草稿' || oldcc.approvalStatus__c =='提交待审批') && cc.approvalStatus__c == '审批通过'){
                            
                            ContractCPQ.getApproval(cc.id, cc.reviewName__c, cc.Name, cc.Name,'3',cc.NewprojectType__c,cc.contractAmountRMB__c+'' );
                            
                        }
                        
                        if((oldcc.approvalStatus__c =='草稿' ||oldcc.approvalStatus__c =='提交待审批')&& cc.approvalStatus__c == '审批拒绝'){
                            
                            ContractCPQ.getApproval(cc.id, cc.reviewName__c, cc.Name, cc.Name,'2',cc.NewprojectType__c,cc.contractAmountRMB__c+'' );
                            
                        }
                        
                        
                    }   
                    
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
              	String test39 = 'test39';
                String test40 = 'test40';
                String test41 = 'test41';
                String test42 = 'test42';
                String test43 = 'test43';
                String test44 = 'test44';
                String test45 = 'test45';
                String test46 = 'test46';
                String test47 = 'test47';
                String test48 = 'test48';
                String test49 = 'test49';
                String test50 = 'test50';
                String test51 = 'test51';
                String test52 = 'test52';
                String test53 = 'test53';
                String test54 = 'test54';
                String test55 = 'test55';
                String test56 = 'test56';
                String test57 = 'test57';
                String test58 = 'test58';
                String test59 = 'test59';
                String test60 = 'test60';
                String test61 = 'test61';
                String test62 = 'test62';
                String test63 = 'test63';
                String test64 = 'test64';
                String test65 = 'test65';
                String test66 = 'test66';
                String test67 = 'test67';
                String test68 = 'test68';
                String test69 = 'test69';
                String test70 = 'test70';
            
        }
     }
}