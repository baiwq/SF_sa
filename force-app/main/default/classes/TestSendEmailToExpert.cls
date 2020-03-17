@isTest()
public class TestSendEmailToExpert {
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
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务');
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

      commisionUser__c cu = new commisionUser__c(commisionSplit__c = cs.id,performanceProportion__c = 10, member__c = u2.id);
      insert cu;
      //commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];
      cu.performanceProportion__c = 0.9;
      

      CS.approvalStatus__c = '审批通过';
      update CS;
      //创建投标评审
        bidReview__c  br = new bidReview__c(opportunity__c =o1.id,dateOfDeliveryReviewExpert__c=u1.Id,approvalStatus__c='审批通过');
        insert br;

        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=br.Id,approvalStatus__c ='审批通过');
        insert qua;
        
        system.debug('1231231231');

        contractreview__c cr = new contractreview__c(quatation__c=qua.Id,dateOfDeliveryReviewExpert__c=u1.Id,opportunity__c=o1.id,biddingApproval__c=br.Id);
        insert cr;
    }
	public static testMethod void testSendEmailClass(){
    	/*EmailTemplate et = new EmailTemplate();
        et.Name='test';
        et.DeveloperName='test12';
        et.FolderId=UserInfo.getUserId();
        et.TemplateType='visualforce';
        et.Markup='<messaging:emailTemplate subject="特殊产品通知" recipientType="Contact" relatedToType="quatation__c"> <messaging:htmlEmailBody > <html> <head></head> <body> <p>您好 ,</p> <br/><p>有新的报价需要您配置特殊产品价格；</p> <br/><p>业务机会名称：{!relatedTo.opportunity__r.Name},</p> <br/><p>报价管理编号：{!relatedTo.Name}.</p> <br/><br/><a href="https://cs58.salesforce.com/{!relatedTo.id}">https://cs58.salesforce.com/{!relatedTo.id}</a> </body> </html> </messaging:htmlEmailBody> </messaging:emailTemplate>';
        insert et;
        List<String> toAddress = new List<String>();*/
        //toAddress.add('123@1231.com');
        bidReview__c  br = [Select id from bidReview__c limit 1];
        SendEmailToExpert.exe_SendEmail('bidReview__c', UserInfo.getUserId(), br.Id, 'BidSendEmailToExpert');
    }
}