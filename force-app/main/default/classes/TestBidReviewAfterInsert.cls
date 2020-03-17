/*
	类名：BidReviewAfterInsert 测试类
	功能：投标评审
	作者：Mark 柏文强-雨花石
	时间：2019-11-18
	覆盖率：97.78%
 */
@isTest
private class TestBidReviewAfterInsert {
    @testSetup static void CreateBaseData()
	{
		User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', IsActive = true);
      	insert u1;
      	String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      	User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test2', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1 , IsActive = true);
      	insert u2;

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
      	opportunity opp = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId = account.id, actualbidamount__c = 10);
      	opp.MainProductGroup__c = 'EPC业务单元';
      	opp.ProductGroup__c = '	EPC业务单元';
      	opp.MainIndustrySales__c = 'EPC业务单元';
      	insert opp;

      	// 创建业务机会成员信息
      	OpportunityTeamMember oppMember = new OpportunityTeamMember();
      	oppMember.OpportunityId = opp.Id;
      	oppMember.TeamMemberRole = '销售经理';
      	oppMember.UserId = u2.Id;
      	insert oppMember;

	}

    static testMethod void testShareRead() 
    {
    	test.startTest();
       	opportunity opp = [select Id from opportunity limit 1];

       	//创建投标评审,填写必填字段
     	RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     	bidReview__c brc = new bidReview__c(opportunity__c = opp.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.Id,CloseDate__c = System.today(),projectClassification__c ='招标项目',tenderingAgent__c='测试');
      	insert brc;

      	test.stopTest();
    }
}