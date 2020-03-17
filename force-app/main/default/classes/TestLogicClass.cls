// SAM
@isTest
public with sharing class TestLogicClass{
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

      Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a1b;

//创建联系人
      Contact c = new Contact(LastName ='孙权', AccountId = a.Id);
      insert c;

//创建潜在客户
      Lead l1 = new Lead(Status = '未转化',Email = '123@sifang.com',account__c = a.Id, owner__c = u1.Id, Lastname = '张', Company = '四方继保',contact__c = c.Id, stationLevel__c = '20kV',expectBidDate__c = system.today(), pathBy__c ='公共媒体', expectAmount__c = 10000, Description = 'aaa');
      insert l1;
      l1.Status = '重复';
      update l1;
      l1.Status = '已转化';
      update l1;

//创建销售线索
      salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                            expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                            projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',
                                            MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
      insert o1;

//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇' );
      insert t1;

//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;

//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
   
       //创建行业比例
       IndustryProportion__c IP = new IndustryProportion__c(commisionSplit__c= cs.id,MainIndustrySales__c='输变电业务',Allocation__c =100);
       insert IP;
       
      commisionUser__c cu = new commisionUser__c(commisionSplit__c = cs.id,performanceProportion__c = 10, member__c = u2.id);
      insert cu;
      //commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];
      cu.performanceProportion__c = 0.9;
      

      CS.approvalStatus__c = '审批通过';
      update CS;
      //创建投标评审
        bidReview__c  br = new bidReview__c(MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c =o1.id,approvalStatus__c='审批通过');
        insert br;

        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=br.Id,approvalStatus__c ='审批通过');
        insert qua;
        
        system.debug('1231231231');

        contractreview__c cr = new contractreview__c(departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,quatation__c=qua.Id,opportunity__c=o1.id,biddingApproval__c=br.Id);
        insert cr;
        
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
      //创建重点项目
      majorProjects__c major = new majorProjects__c(cpywdyfzr__c=u1.Id,sqjl__c=u1.Id);
      insert major;
      //创建附件  
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc.Id);
      insert ac;
      attachment__c ac11 = new attachment__c(isValid__c = '有效',type__c = '供货范围清单',contract__c = cc.Id);
      insert ac11;
       
      RecordType ContractRecordType2 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
      Contract__c cc2 = new Contract__c(); //无合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.updateCode__c = '1234日';
      //cc2.opportunity__c = o1.id;
      cc2.RecordTypeId = ContractRecordType2.id;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.salesDepartment__c = '华东区';
      cc2.salesProvince__c = '江苏-电厂';
      cc2.deliveryTeamDepartment__c   = '华东区';
      cc2.deliveryTeamProvince__c = '浙江';
      cc2.deliveryTeamCenter__c = '销售中心';
      cc2.approvalStatus__c='审批通过'; 
      cc2.SalesTerritoryManager__c  = u2.Id;  
      insert cc2;

      attachment__c ac1 = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc2.Id);
      insert ac1;
       
      System.debug('dsad:'+ cc.id);
      try{
         List<Contract__c> CCList = new List<Contract__c>();
         for(Integer i=0;i<102; i++){
            Contract__c cctemp = new Contract__c();
            cctemp.account__c= a.id;
            cctemp.signedby__c= u1.id;
            cctemp.deliveryPerson__c = u2.id;
            cctemp.accountManager__c = u3.id;
            cctemp.contractReceptDate__c = date.newInstance(2016, 2, 17);
            CCList.add(cctemp);
         }
         insert CCList;

      }catch(Exception e){
         System.debug('(((((((((((((((((((');
      }
   }

   static testMethod void testContract1(){
       Test.startTest();
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';

      List<User> uList = [Select id, profileid from User where profileid = :Userinfo.getProfileId() and isActive = true];
      System.debug('uList:' + uList);
      c.signedby__c= uList[3].id;
      c.deliveryPerson__c = uList[0].id;
      c.accountManager__c = uList[5].id;
      c.OwnerId = uList[5].id;
      c.amount__c = 1234;
      update c;

      c.approvalStatus__c = '审批通过';
      update c;

      Contract__c c2= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234日' limit 1];
      c2.approvalStatus__c = '审批通过';
      c2.performanceOrNot__c = true;
      update c2;
       Test.stopTest();
   }

   static testMethod void testContractInclude(){
       Test.startTest();
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234日' limit 1];
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = c.Id,attachmentURL__c = 'aaa');
      insert ac;
      c.RecordTypeId = ContractRecordType1.id;
      c.approvalStatus__c = '审批通过';
      c.performanceOrNot__c = true;  
      update c;
       Test.stopTest();
   }

   static testMethod void testTB(){
       Test.startTest();
      tbbaozhengjin__c t1 = [Select id from tbbaozhengjin__c limit 1];
      t1.returnAmount__c = 10000;
      update t1;
       Test.stopTest();
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

   static testMethod void testInvoice(){
      Test.startTest();
      Account a = [Select id from Account where Name = :'A1' limit 1];
      Account a1b = [Select id from Account where Name = :'A1b' limit 1];
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User u2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Contract__c cc = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
      insert i;

      try{i.applyBy__c = u2.id; update i;}catch(exception e){}
      try{i.approvalStatus__c = '提交待审批'; update i;}catch(exception e){}
      try{i.approvalStatus__c = '审批通过'; update i;}catch(exception e){}
      try{i.account__c = a1b.id; update i;}catch(exception e){}

      i.approvalStatus__c = '草稿';
      i.account__c = a.id;
      update i;

      invoiceItem__c ii1 = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 2000);
      insert ii1;

      goodsName__c gn = new goodsName__c(invoice__c = i.id, quantity__c = 1, amount__c = 2000);
      insert gn;

      i.approvalStatus__c = '审批通过';
      update i;

      try{
         ii1.invoiceAmount__c = 100;
         update ii1;
      }catch(exception e){

      }
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

   static testMethod void testSalesLead(){
       Test.startTest();
      User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User user2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      salesLeads__c SL = [Select id, RecordTypeId, approvalStatus__c, assignOrNot__c, promoter__c, projectManager__c from salesLeads__c where pathBy__c =:'公共媒体' limit 1];
      SL.OwnerId = user2.id;
      update SL;
      
      SL.RecordTypeId = [Select id from RecordType where Name =:'常规' and SobjectType = :'salesLeads__c'].id;
      SL.capacity__c = 'ds';
      SL.bidLanguage__c = 'da';
      SL.country__c = '中国';
      SL.province__c = '北京';
      SL.assignOrNot__c = true;
      SL.promoter__c = user1.id;
      SL.projectManager__c = user2.id;
      SL.name='测试';
      SL.industry__c='国网总部';
      SL.estimatedAmount__c=1200;
      SL.expectBidDate__c=System.today();
      SL.projectStage__c='内部立项';
      SL.projectCategory__c='常规项目';
      SL.projectLevel__c='一般项目';

      SL.equipmentInterfaceLanguage__c = 'ds';
      SL.equipmentFileLanguage__c = 'sa';
      SL.projectGoal__c = '打压对手';
      SL.projectTrackingPlan__c = 'ds';
      SL.projectTrackingStrategy__c = 'ds';
      SL.overseasAchievement__c = '无业绩';
      SL.finalUserAchievement__c = '无业绩';
      SL.finalUserQualificationRequireme__c = '不清楚';
      SL.finalUserAcceptability__c = '不清楚';
      SL.deliverWorkRange__c = '其他';
      SL.implementationStation__c = '其他';

      update SL;

      SL.approvalStatus__c = '已立项';
      update SL;
       Test.stopTest();
   }

   static testMethod void testBidCostBar(){
       Test.startTest();
      Account a = [Select id from Account limit 1];
      Opportunity o = [Select id from Opportunity limit 1];
      bidCost__c bc = new bidCost__c(opportunity__c = o.id, account__c = a.id, costCenter__c='12324', remittanceMethod__c='电汇');
      insert bc;
       Test.stopTest();
   }

   static testMethod void testBidReviewBar(){
       Test.startTest();
      Opportunity o = [Select id from Opportunity limit 1];
      bidReview__c br= new bidReview__c(opportunity__c = o.id);
      insert br;
      br.OwnerId=[select id from User where LastName = '测试经理1'][0].id;
      update br;
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

 
   static testMethod void testQuatation(){
       Test.startTest();
      Opportunity o = [Select id from Opportunity limit 1];
      //创建投标评审
      bidReview__c  br = new bidReview__c(opportunity__c =o.id,approvalStatus__c='审批通过');
      insert br;     
      quatation__c qua = new quatation__c(opportunity__c = o.id,bidReview__c=br.Id,RecordTypeId=[select id from RecordType where SobjectType='quatation__c' and DeveloperName='RecordType'].id);
      insert qua;
      qua.OwnerId=[select id from User where LastName = '测试经理1'][0].id;
      qua.standardProjectGrossProfitMargin__c=1;
        qua.commonProjectOwnDevicePercent__c=1;
        qua.specialProductCostPercent__c=1;
        qua.outsourcingCostPercent__c=1;
        qua.companyTrainAndServiceCostPercent__c=1;
        qua.projectRunCostPercent__c=1;
        qua.projectRistCostPercent__c=1;
        qua.projectBigAmountCostPercent__c=1;
        
        qua.bidPriceProjectMarginRate__c=1;
        qua.bidCommonProjectOwnDevicePercent__c=1;
        qua.bidspecialProductCostPercent__c=1;
        qua.bidoutsourcingCostPercent__c=1;
        qua.bidcompanyTrainAndServiceCost__c=1;
        qua.bidprojectRunCostPercent__c=1;
        qua.bidprojectRistCostPercent__c=1;
        qua.bidprojectBigAmountCostPercent__c=1;
        
        qua.commonProjectOwnEquipmentBidPriceDctFml__c=1;
        qua.specialProductBiddingPriceDCT__c=1;
        qua.ownSoftBiddingPriceDCT__c=1;
        qua.outsourcingBiddingPriceDct__c=1;
        qua.outsourcingServiceBiddingPriceDct__c=1;
        qua.outsourcingArchitectureCostBidPriceDct__c=1;
        qua.companyTrainServiceBiddingPriceDct__c=1;
        qua.biddingTotalPriceDct__c=1;
        qua.approvalStatus__c='审批通过';
        
      update qua;
       Test.stopTest();
   }
   static testMethod void testContractView(){
       Test.startTest();
      Opportunity o = [Select id from Opportunity limit 1];  
      bidReview__c  br = new bidReview__c(opportunity__c =o.id,approvalStatus__c='审批通过');
      insert br;   
      quatation__c q = new quatation__c(approvalStatus__c = '审批通过',opportunity__c = o.id,bidReview__c=br.Id,RecordTypeId=[select id from RecordType where SobjectType='quatation__c' and DeveloperName='RecordType'].id);
      insert q;
      contractreview__c cr = new contractreview__c(opportunity__c = o.id,quatation__c=q.Id,biddingApproval__c=br.Id); 
      insert cr;
      cr.OwnerId=[select id from User where LastName = '测试经理1'][0].id;
       cr.contractProjectGrossProfitMargin__c=1;
        cr.commonProjectOwnDevicePercent__c=1;
        cr.specialProductCostPercent__c=1;
        cr.outsourcingCostPercent__c=1;
        cr.companyTrainAndServiceCostPercent__c=1;
        cr.contractProjectRunCostPercent__c=1;
        cr.contractProjectRistCostPercent__c=1;
        cr.contractProjectBigAmountCostPercent__c=1;
        
        
        update cr;
      update cr;
       Test.stopTest();
   }
   
   static testMethod void testExpenseOfBidApplyBar(){
       Test.startTest();
      Opportunity o =[Select id, name, StageName from Opportunity limit 1];
      expenseOfBidApply__c eb = new expenseOfBidApply__c(opportunity__c = o.id);
      insert eb;
       Test.stopTest();
   }

   static testMethod void testRelationshipPlan(){
       Test.startTest();
      Account a = [Select id, currentRelationship__c, orgRelationship__c from Account limit 1];
      Contact c = [Select id, maturity__c from Contact limit 1];
      RecordType RecordType1 = [SELECT Id from RecordType where SobjectType ='relationshipPlan__c' and Name ='提升 普遍客户关系现状' limit 1];
      RecordType RecordType2 = [SELECT Id from RecordType where SobjectType ='relationshipPlan__c' and Name ='提升 组织客户关系现状' limit 1];
      RecordType RecordType3 = [SELECT Id from RecordType where SobjectType ='relationshipPlan__c' and Name ='提升联系人 成熟度' limit 1];
      relationshipPlan__c r1 = new relationshipPlan__c();
      r1.RecordTypeId = RecordType1.id;
      r1.account__c = a.id;
      r1.contact__c = c.id;
      r1.currentRelationship__c ='优';
      r1.orgRelationship__c = 'A';
      r1.improveTo__c = '铁杆儿';
      r1.improveStatus__c = '确认完成';
      insert r1;

      r1.approvalStatus__c = '审批通过';
      update r1;
      r1.RecordTypeId = RecordType2.id;
      update r1;

      r1.RecordTypeId = RecordType3.id;
      update r1;
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
   
   static testMethod void testAchivementRecognization(){
       Test.startTest();
       Opportunity opp = [Select id from  Opportunity limit 1];
      Contract__c c= [Select id, approvalStatus__c,contractReceptDate__c, opportunity__c ,deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
     
	  c.opportunity__c =opp.Id;	      
      c.contractReceptDate__c = date.newInstance(2017, 2, 17);
      update c;
      
      AchivementRecognization__c ar = [Select id, comments__c from AchivementRecognization__c limit 1];
      ar.comments__c = '备注';
      update ar;
      delete ar;
       Test.stopTest();
   }
  
}