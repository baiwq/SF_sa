@isTest
public class TestSRMClass {
    @testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1);
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u2);
      insert u3;
      
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u4;
      
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u5;

//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'A',Rating = '1',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442',approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      
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
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务');
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', actualbidamount__c=1000, StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id);
      insert o1;
      
//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,type__c = '投标保证金',operator__c = u1.Id, account__c =a.id,amount__c = 100000,remittanceWay__c ='电汇' );
      insert t1;   
      
//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;
    
//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
      
      commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];     
      cu.performanceProportion__c = 90;
      update cu;
      
      CS.approvalStatus__c = '审批通过';
      update CS;
    
//创建合同
 
      Contract__c cc2 = new Contract__c();  //有合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.updateCode__c = '12345';
      cc2.opportunity__c = o1.id;
      cc2.ownerid = u1.id;
      cc2.amount__c = 100000;
      cc2.returnAmountAll__c = 1;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.incomeConfirmDate__c=system.today();
      insert cc2;    
        
    }
    static testMethod void testSRM(){
      User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User user2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'12345' limit 1];
      notCommonOutsourcing__c nc = new notCommonOutsourcing__c(contract__c = c.id, type__c='销售中心',occurrenceStage__c='设计阶段', peymentAmount__c='2个月', salesManager__c = user1.id);
      insert nc;
      attachment__c attach1 = new attachment__c(notCommonOutsourcing__c = nc.id, type__c = '合同文本');
      insert attach1;
     
      materiel__c ma = new materiel__c(notCommonOutsourcing__c=nc.id,Name='测试', model__c='ceshi', number__c=1, unit__c='tai', applyReason__c='客户指定');
      insert ma;
      /*Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Submitting request for approval.');
      req1.setObjectId(nc.id);
      req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req1.setSubmitterId(user1.id); 
      req1.setProcessDefinitionNameOrId('ApprovalProcessneewew1');
      req1.setSkipEntryCriteria(false);
      Approval.ProcessResult result = Approval.process(req1);
      List<Id> newWorkItemIds = result.getNewWorkitemIds();
      Approval.ProcessWorkitemRequest req2 =
            new Approval.ProcessWorkitemRequest();
      req2.setComments('Approving request.');
      req2.setAction('Approve');
      req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req2.setWorkitemId(newWorkItemIds.get(0));
        // Submit the request for approval
      Approval.ProcessResult result2 =  Approval.process(req2);
      List<Id> newWorkItemIds3 = result2.getNewWorkitemIds();
      Approval.ProcessWorkitemRequest req3 =
            new Approval.ProcessWorkitemRequest();
      req3.setComments('Approving request.');
      req3.setAction('Rejected');
      req3.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req3.setWorkitemId(newWorkItemIds3.get(0));
        // Submit the request for approval
      Approval.ProcessResult result3 =  Approval.process(req3);*/
      nc.salesManager__c = user2.id;
      nc.approvalStatus__c='审批通过';
      nc.approvalTime__c=System.now();
      update nc; 
      //DateTime stratTime = Datetime.valueOf('2016-01-01T01:01:01');
      //DateTime endTime = Datetime.valueOf('2018-01-01T01:01:01');
      DateTime stratTime = System.now()-100;
      DateTime endTime =  System.now()+100;
      SOSPToSRMClass.Response respon= SOSPToSRMClass.getList(stratTime, endTime);
     
    }
}