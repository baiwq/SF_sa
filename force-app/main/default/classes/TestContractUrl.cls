@isTest
public class TestContractUrl {
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
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单',actualbidamount__c = 55555, projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id);
      insert o1;
      
//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,type__c = '投标保证金',operator__c = u1.Id, account__c =a.id,amount__c = 100000,remittanceWay__c ='电汇',remittanceNumber__c = 100,rate__c = 2.0 );
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
      cc2.tenderScheme__c = '12345';
      cc2.opportunity__c = o1.id;
      cc2.ownerid = u1.id;
      cc2.amount__c = 100000;
      cc2.returnAmountAll__c = 1;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.incomeConfirmDate__c=system.today();
      cc2.approvalStatus__c = '草稿';
      insert cc2; 
      cc2.approvalStatus__c = '审批通过';
      cc2.incomeConfirmDate__c = system.today()-1;
      cc2.contractName__c = '测试合同';
      update cc2;
    }
    
    
  static testMethod void testGetUrl(){
        Account a =[select id from Account where Name = :'A1' limit 1];
        User u1 = [select id from User where LastName = :'测试经理1' limit 1];
        User u2 = [select id from User where LastName = :'测试经理2' limit 1];
        User u3 = [select id from User where LastName = :'测试经理3' limit 1];
        opportunity o1 =[select id from opportunity where Name = 'O1NAME' limit 1];
        Contract__c cc = new Contract__c();  //有合同
        cc.account__c= a.id;
        cc.signedby__c= u1.id;
        cc.deliveryPerson__c = u2.id;
        cc.accountManager__c = u3.id;
        cc.tenderScheme__c = '1234';
        cc.opportunity__c = o1.id;
        cc.ownerid = u1.id;
        cc.amount__c = 10000000;
        cc.returnAmountAll__c = 1;
        cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
        cc.approvalPsDate__c=system.today();
        insert cc;
        attachment__c att = new attachment__c();
        att.contract__c=cc.id;
        att.documentName__c='ceshi';
        att.isValid__c='有效';
        att.type__c='合同文本';
        insert att;
        //GetContractUrl get = new GetContractUrl();
        test.startTest();
        GetContractUrl.queryAttachment(Datetime.valueOf('2016-01-01 00:00:00'), Datetime.valueOf('2020-01-01 00:00:00'));
        GetContractUrl.queryAttachment(Datetime.valueOf('2016-01-01 00:00:00'), Datetime.valueOf('2020-01-02 00:00:00'));
        test.stopTest();
    }
}