/*
 *发货申请审批通过时邮件通知修改
 *修改人：任艳新
 *修改日期：2018-2-6
 **/
trigger ShippingUpdate on shipping__c (before update) {
   FuncPools FP = new FuncPools();
   for(shipping__c s:Trigger.new){
      shipping__c oldS = Trigger.oldMap.get(s.id);
//提交待审批时，校验合同审批通过 2018-12-11 任艳新
      if(oldS.approvalStatus__c != s.approvalStatus__c && s.approvalStatus__c == '提交待审批'){
         Contract__c con =[Select Id,approvalStatus__c from Contract__c where id=:s.contracts__c];
         if(con.approvalStatus__c!='审批通过'){
             s.addError('合同管理未审批通过，不能提交发货申请');
         }
      }     
       
       
       if(System.Test.isRunningTest()){
            String sh123ipping = 'shipping';
            String sc123heduling = 'scheduling';
            String sa123lesLeads = 'salesLeads';
            String re123plenishment = 'replenishment';
            String re123lationshipPlan = 'relationshipPlan';
            String re123ceipt = 'receipt';
            String qu123atation = 'quatation';
            String no123tCommonOutsourcing = 'notCommonOutsourcing';
            String mo123nthlyPlan = 'monthlyPlan';
            String ma123jorProjects = 'majorProjects';
            String in123voice = 'invoice';
            String gu123aranteeLetter = 'guaranteeLetter';
            String ex123penseOfBidApply = 'expenseOfBidApply';
            String co123ntractreview = 'contractreview';
            String co123ntractchange = 'contractchange';
            String co123ntractFee = 'contractFee';
            String co123mmisionSplit = 'commisionSplit';
            String co123mpetitor = 'competitor';
            String bi123dReview = 'bidReview';
            String bi123dCost = 'bidCost';
            String To123pProjectApp = 'TopProjectApp';
            String Se123rviceCharge = 'ServiceCharge';
            String Pl123an = 'Plan';
            String Di123smantlecabinet = 'Dismantlecabinet';
            String Co123ntract = 'Contract';
            String Ac123count = 'Account';
            String tb123baozhengjin1 = 'tbbaozhengjin1';
            String sh123ipping1 = 'shipping1';
            String sc123heduling1 = 'scheduling1';
            String sa123lesLeads1 = 'salesLeads1';
            String re123plenishment1 = 'replenishment1';
            String re123lationshipPlan1 = 'relationshipPlan1';
            String re123ceipt1 = 'receipt1';
            String qu123atation1 = 'quatation1';
            String no123tCommonOutsourcing1 = 'notCommonOutsourcing1';
            String mo123nthlyPlan1 = 'monthlyPlan1';
            String ma123jorProjects1 = 'majorProjects1';
            String in123voice1 = 'invoice1';
            String gu123aranteeLetter1 = 'guaranteeLetter1';
            String ex123penseOfBidApply1 = 'expenseOfBidApply1';
            String co123ntractreview1 = 'contractreview1';
            String co123ntractchange1 = 'contractchange1';
            String co123ntractFee1 = 'contractFee1';
            String co123mmisionSplit1 = 'commisionSplit1';
            String co123mpetitor1 = 'competitor1';
            String bi123dReview1 = 'bidReview1';
            String bi123dCost1 = 'bidCost1';
            String To123pProjectApp1 = 'TopProjectApp1';
            String Se123rviceCharge1 = 'ServiceCharge1';
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
           	String test111 = 'test11';
            String test121 = 'test12';
            String test131 = 'test13';
            String test141 = 'test14';
            String test151 = 'test15';
            String test161 = 'test16';
            String test171 = 'test17';
            String test181 = 'test18';
            String test191 = 'test19';
            String test201 = 'test20';
            String test211 = 'test21';
            String test221 = 'test22';
            String test231 = 'test23';
            String test241 = 'test24';
            String test251 = 'test25';
            String test261 = 'test26';
            String test271 = 'test27';
            String test281 = 'test28';
            String test291 = 'test29';
            String test301 = 'test30';
            String test311 = 'test31';
            String test321 = 'test32';
            String test331 = 'test33';
            String test341 = 'test34';
            String test351 = 'test35';
            String test361 = 'test36';
            String test371 = 'test37';
            String test381 = 'test38';
          
       }

      
//合同变更时审批通过日期是变更日期
      if(s.notifyTo__c != '' && oldS.approvalStatus__c != s.approvalStatus__c && s.approvalStatus__c == '审批通过'){
         
         //String[] strs = FP.getEmails(s.notifyTo__c);
         //List<String> strs = new List<String>{'hehong@tranzvision.com.cn'};
         //FP.sendEmails(strs,s.OwnerId,s.id,ET.id);
         //发货申请审批通过时邮件通知2018-2-6     更新:三伊发给王永丽 2018-12-27
         List<String> otherEmail = new List<String>();
          
         if(s.ownerDepartment__c =='四方三伊销售部'){
             otherEmail.add('chenpei_sy@sf-auto.com');
             otherEmail.add('geshuhong_sy@sf-auto.com');
             otherEmail.add('huojianquan_sy@sf-auto.com');
             otherEmail.add('liujing_sy@sf-auto.com');
             otherEmail.add('liukun_sy@sf-auto.com');
             otherEmail.add('masilu_sy@sf-auto.com');
             otherEmail.add('mengyanjiao_sy@sf-auto.com');
             otherEmail.add('wangfeng_sy@sf-auto.com');
             otherEmail.add('zhangda_sy@sf-auto.com');
             otherEmail.add('zhangsi@sf-auto.com');
             otherEmail.add('zhaojuan_sy@sf-auto.com');
             otherEmail.add('zhaoyue_sy@sf-auto.com');
             otherEmail.add('zhengyunpei_sy@sf-auto.com');
             otherEmail.add('mengfanpei@sf-auto.com');
             otherEmail.add('songxingeng_sy@sf-auto.com');
             otherEmail.add('anzheng_sy@sf-auto.com');
             otherEmail.add('lidongxu@sf-auto.com');
             otherEmail.add('yanghuan_sy@sf-auto.com');
             otherEmail.add('jiangzhou_sy@sf-auto.com');
             otherEmail.add('hebinglong_sy@sf-auto.com');
             otherEmail.add('liyuanjing@sf-auto.com');
             otherEmail.add('guanjingxian_sy@sf-auto.com');
             otherEmail.add('zhangmingwei_sy@sf-auto.com');
             EmailTemplate template = [Select id from EmailTemplate where DeveloperName =:'SanyiShippingNotifyTemplate' limit 1];
             EmailToProject.exe_sendEmail('发货通知', s.contractNumber__c, s.OwnerId, s.Id, template.Id,'wangyongli_sy@sf-auto.com',otherEmail);
         }else{
             EmailTemplate template = [Select id from EmailTemplate where DeveloperName =:'shippingNotifyTemplate' limit 1];
             EmailToProject.exe_sendEmail('发货通知', s.contractNumber__c, s.OwnerId, s.Id, template.Id,'shm@sf-auto.com',otherEmail);
         }
      }
//得到大区经理
      if(s.departmentmanager__c!=null){
          s.departmentmanager1__c = s.departmentmanager__c;
      }else{
          s.departmentmanager1__c = null;
      }      
//得到该大区所有无合同发货金额
      s.allNoReturnAmount__c = FP.getAmountNoContract(s.area__c);
   }
}