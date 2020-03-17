/*
	类名：OpportunityTeamMemberAfterInsert 测试类
	作者：Mark 柏文强-雨花石
	时间：2019-11-13
    覆盖率： 88.61%
 */
@isTest
private class TestOpportunityTeamMember 
{
	@testSetup static void CreateBaseData()
	{
		User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', IsActive = true);
      	insert u1;
      	String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      	User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sun2@tranzvision.sifang.test',
                   email = 'sunx2@tranzvision.sifang',COMMUNITYNICKNAME = 'test2', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u1 , IsActive = true);
      	insert u2;

        User u3 = new User(LastName = '测试经理3',Alias = '测试2', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx3@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u1 , IsActive = true);
        insert u3;

      	Account account = new Account();
      	account.Name = '测试';
      	account.Industry = '招标代理机构';
      	account.city__c = '成都';
      	account.billingStreet__c = 'ceshi jiedao';
      	account.postcode__c = '110110';
      	account.financial__c = '很好';
        account.approvalStatus__c = '审批通过';
        account.accountStatus__c = '有效';
      	insert account;

      	//创建业务机会
      	opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId = account.id, actualbidamount__c = 10);
      	o1.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      	o1.ProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      	o1.MainIndustrySales__c = '输变电业务';
        o1.OwnerId = u1.Id;
      	insert o1;
         
		//创建投标评审,填写必填字段
     	RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     	bidReview__c brc = new bidReview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.Id,CloseDate__c = System.today(),projectClassification__c ='招标项目',tenderingAgent__c='测试');
      	brc.OwnerId = u1.Id;
        insert brc;

      	//创建报价管理,填写必填字段
      	RecordType quoType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
       	quatation__c quo = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = quoType.Id);
       	quo.bidReview__c = brc.Id;
       	quo.bidType__c = '按项目投标';
       	quo.QuotationProductCategory__c = '常规产品';
       	quo.epctbjxmmll__c = 0.1;
       	quo.outsourcingPayment__c = '无外购';
       	quo.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
        quo.ProductGroup__c = '输变电业务单元-电网保护自动化事业部';
        quo.MainIndustrySales__c = '输变电业务';
        quo.OwnerId = u1.Id;
      	insert quo;

      	//创建合同评审,填写必填字段
      	RecordType conReviewType = [Select id from RecordType where SobjectType =:'contractreview__c' and Name =:'合同评审' limit 1];
     	contractreview__c conReview = new contractreview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = conReviewType.Id);
     	conReview.SignCompany__c = '北京四方继保自动化股份有限公司';
     	conReview.ContractName__c = '北京四方继保自动化股份有限公司';
     	conReview.ContractType__c = '新建-系统级';
     	conReview.contractAmount__c = 100000;
     	conReview.Currency__c = '人民币';
     	conReview.ExchangeRate__c = 0.7;
     	conReview.FinalUserIndustry__c = '电网';
     	conReview.FinalUserGroup__c = '101国家电网';
     	conReview.IndustrySecondLevel__c = '国网';
     	conReview.ProductType__c = '系统内保护和自动化';
     	conReview.ProjectCategory__c = '常规站_综自';
     	conReview.WarrantyPeriod__c = '0个月';
     	conReview.ContractSupplyDate__c = Date.today();
     	conReview.CloseDate__c = Date.today();
     	conReview.QuotationProductCategory__c = '常规产品';
     	conReview.Product__c = '仿真';
     	conReview.OutsourcingPeriod__c = '10';
     	conReview.AccessorialService__c = '组配';
        conReview.OwnerId = u1.Id;
      	insert conReview;

	}
    static testMethod void testShareRead() 
    {
    	test.startTest();
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];
       	Id user1Id = users[0].Id;
       	Id user2Id = users[1].Id;
        Id user3Id = users[2].Id;

        bidReview__c bid = [SELECT Id FROM bidReview__c LIMIT 1];
        bidReview__Share bidShare = new bidReview__Share();
        bidShare.ParentId = bid.Id;
        bidShare.UserOrGroupId = user1Id;
        bidShare.AccessLevel = 'read';
        insert bidShare;

        quatation__c qua = [SELECT Id FROM quatation__c LIMIT 1];
        quatation__Share quaShare = new quatation__Share();
        quaShare.ParentId = qua.Id;
        quaShare.UserOrGroupId = user1Id;
        quaShare.AccessLevel = 'read';
        insert quaShare;

        contractreview__c con = [SELECT Id FROM contractreview__c LIMIT 1];
        contractreview__Share conShare = new contractreview__Share();
        conShare.ParentId = con.Id;
        conShare.UserOrGroupId = user1Id;
        conShare.AccessLevel = 'read';
        insert conShare;

       	opportunity opp = [select Id from opportunity limit 1];
   
      	// Create new job.
        List<OpportunityTeamMember> memberList = new List<OpportunityTeamMember>();
      	OpportunityTeamMember oppMember = new OpportunityTeamMember();
      	oppMember.OpportunityId = opp.Id;
      	oppMember.TeamMemberRole = '销售经理';
      	oppMember.UserId = user1Id;
        memberList.add(oppMember);

        OpportunityTeamMember oppMember1 = new OpportunityTeamMember();
        oppMember1.OpportunityId = opp.Id;
        oppMember1.TeamMemberRole = '销售经理';
        oppMember1.UserId = user2Id;
        memberList.add(oppMember1);

        OpportunityTeamMember oppMember2 = new OpportunityTeamMember();
        oppMember2.OpportunityId = opp.Id;
        oppMember2.TeamMemberRole = '销售经理';
        oppMember2.UserId = user3Id;
        memberList.add(oppMember2);

        insert memberList;

        Database.delete(oppMember2);
      	test.stopTest();
    }
}