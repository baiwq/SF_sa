@isTest
public with sharing class TestReturnItemClass {
 @testSetup static void CreateBaseData(){
//创建用户
       
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test', 
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', contractAdmin__c = Userinfo.getUserId());
      insert u1;

      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id , contractAdmin__c = Userinfo.getUserId());
      insert u2;

      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u2.id , contractAdmin__c = Userinfo.getUserId());
      insert u3;

      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u4;

      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u5;
    //运营用户
      Profile p = [select id from Profile where Name='A-项目管理工程师(运营)' limit 1];      
      User u6 = new User(LastName = '测试经理6',Alias = '测试6', UserName = 'sunx6@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test6', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = p.id,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u6;

        //创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;

//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.updateCode__c = '1234';
      //cc.opportunity__c = o1.id;
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
      cc.RecordTypeId = ContractRecordType1.id;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.approvalStatus__c='审批通过'; 
      cc.SalesTerritoryManager__c  = u2.Id; 
      insert cc;
     
      //创建附件  
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc.Id);
      insert ac;
      attachment__c ac11 = new attachment__c(isValid__c = '有效',type__c = '供货范围清单',contract__c = cc.Id);
      insert ac11;

//创建回款
      returnPool__c rp1 = new returnPool__c(account__c = a.Id,amount__c = 300000);
      insert rp1;

//创建回款拆分项
      returnItem__c rim1 = new returnItem__c(returnPool__c = rp1.Id, contracts__c = cc.Id,amount__c = 1000, returnUser__c = u1.id);
      insert rim1;
   }

   static testMethod void testContractChange(){
       Test.startTest();
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c limit 1];
      c.approvalStatus__c='审批通过';
      update c; 
      contractchange__c cc= new contractchange__c();
      cc.contract__c=c.id;
      cc.applyBy__c='客户';
      cc.ownerId = u1.id;   
      cc.ApproveComponent__c='123123';
      cc.notCompletelySchedulingExplain__c='测试';
      cc.RecordTypeId = [Select id from RecordType where sobjectType = 'contractchange__c' and Name = '合同金额变更'].id;
      cc.scopeOfSupplyChangeIsExcited__c ='否';
       cc.isSandbox__c = '是';
       insert cc;
      
      attachment__c attach2 = new attachment__c(contractChange__c = cc.id, type__c = '供货范围清单');
      insert attach2;
      
      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Submitting request for approval.');
      req1.setObjectId(cc.id);
      req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req1.setSubmitterId(u1.id); 
      
      req1.setSkipEntryCriteria(true);
      Approval.ProcessResult result = Approval.process(req1);
    
      cc.totalDischarge__c = true;
      cc.approvalStatus__c = '审批通过';
      cc.notifyTo__c = '毕海霞[bihaixia@sf-auto.com]';
      update cc;
       Test.stopTest();
   }

   static testMethod void testActivity(){
       Test.startTest();
      List<User> uList = [Select id from User];
      Task t = new Task();
      t.Subject = '测试Task';
      t.Priority = '一般';
      t.ActivityDate = System.today();
      t.Status = '未完成';
      t.OwnerId = uList[0].id;
      insert t;

      t.OwnerId = uList[1].id;
      try{
         update t;
      }catch(Exception e){
      }

      try{
         delete t;
      }catch(Exception e){
      }

      Datetime myTimePass = datetime.newInstance(2008, 2, 5, 8, 30, 12);
      Datetime myDateFuture = datetime.newInstance(2028, 2, 5, 8, 30, 12);
      Event e1 = new Event();
      e1.subject = '测试Event';
      e1.OwnerId = Userinfo.getUserId();
      e1.StartDateTime = myTimePass;
      e1.EndDateTime = myTimePass;
      e1.finishOrNot__c = '是';

      insert e1;
      e1.StartDateTime = myTimePass;
      e1.EndDateTime = myTimePass.addDays(1);
      e1.OwnerId = uList[2].id;
      e1.finishOrNot__c = '是';

      try{
         update e1;
         e1.finishOrNot__c = '否';
         update e1;
      }catch(Exception e){
         System.Debug('eDDDD:' + e);
      }

      try{
         delete e1;
      }catch(Exception e){
      }

      Event e2 = new Event();
      e2.subject = '测试Event';
      e2.OwnerId = uList[0].id;
      e2.StartDateTime = myDateFuture;
      e2.EndDateTime = myDateFuture;
      e2.finishOrNot__c = '是';
      try{
         insert e2;
      }catch(Exception e){
      }
       Test.stopTest();
   }

   static testMethod void testFeedItem(){
       Test.startTest();
      FeedItem testFeed = new FeedItem(ParentId = Userinfo.getUserId(), Body = 'Hello');
      insert testFeed;
      FeedComment testFeedComment = new FeedComment(CommentBody='Test Feed 1 Comment', FeedItemId=testFeed.Id, CommentType='TextComment');
      insert testFeedComment;

      try{
         delete testFeedComment;
      }catch(Exception e){
      }

      try{
         delete testFeed;
      }catch(Exception e){
          // System.assertEquals('FIELD_CUSTOM_VALIDATION_EXCEPTION', e.getDmlStatusCode(0) );
      }
       Test.stopTest();
   }

   static testMethod void testReturnPool_1(){ 
      Test.startTest();
    //插入
      //Account acc1 = [Select id from Account limit 1];
      User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User user2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      RecordType type1 = [Select id from RecordType where SobjectType =:'returnPool__c' and Name =:'电汇' limit 1];
      RecordType type2 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'合同回款' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      returnPool__c rp1 = [Select id, account__c, amount__c, RecordTypeId from returnPool__c limit 1];
      returnItem__c tic= [Select id,returnPool__c,amount__c,RecordTypeId,contracts__c,returnUser__c from returnItem__c limit 1];
      //tbbaozhengjin__c  tb = [Select id from tbbaozhengjin__c limit 1];

      tic.returnUser__c = user2.id;
      tic.amount__c = 10000;
      update tic;

      returnItem__c tic1 = new returnItem__c(returnPool__c = rp1.Id, contracts__c = c.Id,amount__c = 90000, returnUser__c = user1.id);
      insert tic1;
      Test.stopTest();
   }

   static testMethod void testReturnPool_2(){// 删除
       Test.startTest();
     returnItem__c tic= [Select id from returnItem__c limit 1];
     delete tic;
       Test.stopTest();
   }
   
 
   static testMethod void testSchedule(){
   //排产
   	Test.startTest();
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
      update c;

      paymentTerm__c pt = [select id, percentage__c from paymentTerm__c where contract__c = :c.id limit 1];
      pt.percentage__c = 100;
      update pt;

      attachment__c attach1 = new attachment__c(contract__c = c.id, type__c = '合同文本');
      insert attach1;
      attachment__c attach2 = new attachment__c(contract__c = c.id, type__c = '供货范围清单');
      insert attach2;
      scheduling__c s = new scheduling__c(contract__c = c.id , totalDischarge__c = true);
      insert s;


      s.approvalStatus__c = '审批通过';
      s.approvalDate__c = System.now();
      update s;
       Test.stopTest();
   }

   static testMethod void testAttachment(){
       Test.startTest();
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      ProjectTask__c pt = new ProjectTask__c();
       pt.contract__c = c.id;
       pt.domainUser__c = 'fuxiao';
       pt.projectManagementEngineer__c = '付肖';
       insert pt;
      contractchange__c cc= new contractchange__c();
      cc.contract__c=c.id;
      cc.applyBy__c='客户';
      cc.ownerId = u1.id;   
      cc.notCompletelySchedulingExplain__c='测试';
      cc.RecordTypeId = [Select id from RecordType where sobjectType = 'contractchange__c' and Name = '供货范围变更'].id;
      insert cc;
      attachment__c attach2 = new attachment__c(contract__c = c.id, type__c = '供货范围清单');
      insert attach2;
      attach2.isValid__c = '有效';
      attach2.URLAddress__c = 'dsa';
      attach2.attachmentURL__c = 'ds';
      update attach2;
       Test.stopTest();
   }
   
   static testMethod void testShipping(){
   //发货
		Test.startTest();
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
      update c;

      shipping__c sp = new shipping__c(contracts__c = c.id);
      insert sp;
      
      shipping__c sp2 = new shipping__c(contracts__c = c.id);
      try{
          insert sp2;
      }catch(exception e){
      }
      
      sp.notifyTo__c = '安凯[ankai@sf-auto.com]';
      update sp;
       Test.stopTest();
   }


   static testMethod void testNotCommon(){
       Test.startTest();
      User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User user2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      notCommonOutsourcing__c nc = new notCommonOutsourcing__c(contract__c = c.id, type__c='销售中心',occurrenceStage__c='设计阶段', peymentAmount__c='2个月', salesManager__c = user1.id);
      insert nc;
      nc.salesManager__c = user2.id;
      update nc;
      try{
          materiel__c ma = new materiel__c(notCommonOutsourcing__c=nc.id,Name='测试', model__c='ceshi', number__c=1, unit__c='tai', applyReason__c='客户指定');
          insert ma;
      }catch(Exception e){
      
      }
       Test.stopTest();
   }
    
   
   static testMethod void testPES(){
       Test.startTest();
      User u = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Plan__c p4= new Plan__c();
      p4.OwnerId = u.id;
      p4.year__c = '2017';
      p4.departmentName__c = '销售中心';
      insert p4;
      
      monthlyPlan__c mp = new monthlyPlan__c(plan__c = p4.id);
      insert mp;
      
      PlanAndExeStatus__c pes = new PlanAndExeStatus__c(monthplan__c = mp.id);
      insert pes;
      delete pes;
       Test.stopTest();
   }
   
   static testMethod void testProduct(){
       Test.startTest();
      Product2 p = new Product2();
      p.name = 'abcd';
      insert p;
      p.name = 'dasd';
      p.companyCode__c = 'SC20001000';
      update p;
       Test.stopTest();
   }
   
   static testMethod void testLocalDateController(){
       Test.startTest();
      localDateFormatController local = new localDateFormatController();
      local.date_time=system.now();
      local.defined_format='yyyy-MM-dd HH:mm:ss';
      local.getFormattedDatetime();
       Test.stopTest();
   }
   
   static testMethod void testPaymentSendEmail(){
       Test.startTest();
      Contract__c cc = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      statusTracking__c st = [Select id, advanceActualFinish__c, debugActualFinish__c, debugFinishActualFinish__c, sendActualFinish__c, qualityActualFinish__c from statusTracking__c where contract__c = :cc.id];
      st.advanceActualFinish__c = System.today().addDays(-100);
      st.debugActualFinish__c = System.today().addDays(-100);
      st.debugFinishActualFinish__c = System.today().addDays(-100);
      st.sendActualFinish__c = System.today().addDays(-100);
      st.qualityActualFinish__c = System.today().addDays(-100);
      update st;
      List<paymentTerm__c> ptList = [select id, percentage__c from paymentTerm__c where contract__c = :cc.id];
      for(paymentTerm__c pt:ptList){
         pt.percentage__c = 15;
      }
      update ptList;
      String testSchedulePaymentSendEmail = System.schedule('TestSchedulePaymentSendEmail','0 0 0 3 9 ? 2020',new SchedulePaymentSendEmail());
      Test.stopTest();
   }
   
   
}