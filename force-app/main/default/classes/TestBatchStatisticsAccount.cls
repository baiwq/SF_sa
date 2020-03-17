/*
    类名：BatchStatisticsAccountProcessData
    作者：Mark 柏文强-雨花石
    时间：2019-11-21
    修改内容：
 */
@isTest
private class TestBatchStatisticsAccount 
{
	@testSetup
	static void CreateBasicData()
	{
		/*List<Account> acclist = new List<Account>();
		Account account1 = new Account();
      	account1.Name = '测试1';
      	account1.Industry = '招标代理机构';
      	account1.city__c = '成都';
      	account1.billingStreet__c = 'ceshi jiedao';
      	account1.postcode__c = '110110';
      	account1.financial__c = '很好';
      	acclist.add(account1);

      	Account account2 = new Account();
      	account2.Name = '测试2';
      	account2.Industry = '招标代理机构';
      	account2.city__c = '成都';
      	account2.billingStreet__c = 'ceshi jiedao';
      	account2.postcode__c = '220220';
      	account2.financial__c = '很好';
      	acclist.add(account2);
      	insert acclist;*/

      	String profileid1 = [select id from Profile where name ='A-项目管理工程师(国际)'][0].id;
    	User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', IsActive = true);
      	insert u1;
      	String profileid2 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      	User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test2', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1 , IsActive = true);
      	insert u2;

      	Account account = new Account();
      	account.Name = '测试';
      	account.Industry = '招标代理机构';
      	account.city__c = '成都';
      	account.billingStreet__c = 'ceshi jiedao';
      	account.postcode__c = '110110';
      	account.financial__c = '很好';
      	account.accountStatus__c = '有效';
      	account.approvalStatus__c = '审批通过';
      	account.taxpayerNumber__c = '11111111111111111111';
      	insert account;

      	//创建业务机会
      	opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId = account.id, actualbidamount__c = 10);
      	o1.MainProductGroup__c = 'EPC业务单元';
      	o1.ProductGroup__c = 'EPC业务单元';
      	o1.MainIndustrySales__c = 'EPC业务单元';
      	insert o1;

      	//创建业务机会成员
      	OpportunityTeamMember oppMemeber = new OpportunityTeamMember();
      	oppMemeber.UserId = u2.Id;
      	oppMemeber.OpportunityId = o1.Id;
      	insert oppMemeber;

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
      	insert conReview;

    	// 合同管理
      	RecordType conType = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
      	Date contractDate = Date.today();
      	Contract__c contract = new Contract__c();
      	contract.opportunity__c = o1.Id;
      	contract.reviewNumber__c = conReview.Id;
      	contract.reviewDate__c = Date.today();
            contract.RecordTypeId = conType.Id;
      	contract.Field1_test__c = '4';
      	contract.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      	contract.MainIndustrySales__c = 'EPC业务单元';
      	contract.ProductGroup__c = '输变电业务单元-电网保护自动化事业部';
            System.debug('1');
      	contract.account__c = account.Id;
      	contract.customerContractCode__c = '100';
      	contract.FinalUserIndustry__c = '电网';
       	contract.FinalUserGroup__c = '101国家电网';
       	contract.IndustrySecondLevel__c = '国网';
       	contract.ContractType__c = '新建-系统级';
       	contract.active__c = '履约中';
       	contract.amount__c = 10000;
       	contract.subCompany__c = '北京四方继保工程技术有限公司';
       	contract.contractReceptDate__c = contractDate.addDays(10);
       	contract.contractPreReturnDate__c = contractDate.addDays(20);
       	contract.salesCenter__c = '销售中心';
       	contract.salesProvince__c = '重庆';
       	contract.accountManager__c = u1.Id;
       	contract.salesTeamCenter__c = '销售中心';
       	contract.salesTeamProvince__c = '安徽';
       	// cont
       	contract.signedBy__c = u2.Id;
       	contract.signTeamCenter__c = '销售中心';
       	contract.signTeamProvince__c = '安徽';
       	contract.deliveryPerson__c = u1.Id;
       	contract.deliveryTeamCenter__c = '销售中心';
       	contract.deliveryTeamProvince__c = '安徽';
       	contract.implementationStation__c = '1111';
      	contract.country__c = '阿鲁巴';
      	contract.province__c = '北京';
      	contract.voltageLevel__c = '6KV';
      	contract.buildType__c = '基建';
      	contract.productType__c = '系统内保护和自动化';
      	contract.projectType__c = '常规站_综自';
      	contract.warrantyPeriod__c = '0个月';
      	contract.contractSupplyDate__c = contractDate.addDays(10);
      	contract.totalDischarge__c = '是';
      	contract.userConfirmDate__c = contractDate.addDays(20);
            contract.completelyDeliverDate__c = contractDate.addDays(21);
      	contract.technologyContact__c = '102';
      	contract.contactPerson1__c = '103';
      	contract.cancelMark__c = '否';
      	contract.contactPerson1Phone__c = '102103';
      	contract.approvalStatus__c = '审批通过';
      	contract.technologyContactPhone__c = '103102';
      	
      	insert contract;

      	Contract__c contract1 = new Contract__c();
      	contract1.opportunity__c = o1.Id;
      	contract1.reviewNumber__c = conReview.Id;
      	contract1.reviewDate__c = Date.today();
        contract1.RecordTypeId = conType.Id;
      	contract1.Field1_test__c = '4';
      	contract1.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      	contract1.MainIndustrySales__c = 'EPC业务单元';
      	contract1.ProductGroup__c = '输变电业务单元-电网保护自动化事业部';
        System.debug('1');
      	contract1.account__c = account.Id;
      	contract1.customerContractCode__c = '100';
      	contract1.FinalUserIndustry__c = '电网';
       	contract1.FinalUserGroup__c = '101国家电网';
       	contract1.IndustrySecondLevel__c = '国网';
       	contract1.ContractType__c = '新建-系统级';
       	contract1.active__c = '履约中';
       	contract1.amount__c = 10000;
       	contract1.subCompany__c = '北京四方继保工程技术有限公司';
       	contract1.contractReceptDate__c = contractDate.addDays(10);
       	contract1.contractPreReturnDate__c = contractDate.addDays(20);
            contract1.completelyDeliverDate__c =  contractDate.addDays(21);
       	contract1.salesCenter__c = '销售中心';
       	contract1.salesProvince__c = '重庆';
       	contract1.accountManager__c = u1.Id;
       	contract1.salesTeamCenter__c = '销售中心';
       	contract1.salesTeamProvince__c = '安徽';
       	// cont
       	contract1.signedBy__c = u2.Id;
       	contract1.signTeamCenter__c = '销售中心';
       	contract1.signTeamProvince__c = '安徽';
       	contract1.deliveryPerson__c = u1.Id;
       	contract1.deliveryTeamCenter__c = '销售中心';
       	contract1.deliveryTeamProvince__c = '安徽';
       	contract1.implementationStation__c = '1111';
      	contract1.country__c = '阿鲁巴';
      	contract1.province__c = '北京';
      	contract1.voltageLevel__c = '6KV';
      	contract1.buildType__c = '基建';
      	contract1.productType__c = '系统内保护和自动化';
      	contract1.projectType__c = '常规站_综自';
      	contract1.warrantyPeriod__c = '0个月';
      	contract1.contractSupplyDate__c = contractDate.addDays(10);
      	contract1.totalDischarge__c = '是';
      	contract1.userConfirmDate__c = contractDate.addDays(20);
      	contract1.technologyContact__c = '102';
      	contract1.contactPerson1__c = '103';
      	contract1.cancelMark__c = '否';
      	contract1.contactPerson1Phone__c = '102103';
      	contract1.approvalStatus__c = '审批通过';
      	contract1.technologyContactPhone__c = '103102';
      	insert contract1;

      	// 付款条件信息创建
      	List<paymentTerm__c> payList = new List<paymentTerm__c>();
      	paymentTerm__c pamentTerm = new paymentTerm__c();
      	pamentTerm.contract__c = contract.Id;
      	pamentTerm.stageDate__c = Date.newInstance(2019, 10, 1);
      	payList.add(pamentTerm);

      	paymentTerm__c pamentTerm1 = new paymentTerm__c();
      	pamentTerm1.contract__c = contract.Id;
      	pamentTerm1.stageDate__c = Date.newInstance(2018, 10, 1);
      	payList.add(pamentTerm1);

      	paymentTerm__c pamentTerm2 = new paymentTerm__c();
      	pamentTerm2.contract__c = contract.Id;
      	pamentTerm2.stageDate__c = Date.newInstance(2017, 10, 1);
      	payList.add(pamentTerm2);

      	paymentTerm__c pamentTerm3 = new paymentTerm__c();
      	pamentTerm3.contract__c = contract.Id;
      	pamentTerm3.stageDate__c = Date.newInstance(2016, 10, 1);
      	payList.add(pamentTerm3);

      	paymentTerm__c pamentTerm4 = new paymentTerm__c();
      	pamentTerm4.contract__c = contract.Id;
      	pamentTerm4.stageDate__c = Date.newInstance(2015, 10, 1);
      	payList.add(pamentTerm4);

      	paymentTerm__c pamentTerm5 = new paymentTerm__c();
      	pamentTerm5.contract__c = contract.Id;
      	pamentTerm5.stageDate__c = Date.newInstance(2014, 10, 1);
      	payList.add(pamentTerm5);

      	paymentTerm__c pamentTerm6 = new paymentTerm__c();
      	pamentTerm6.contract__c = contract.Id;
      	pamentTerm6.stageDate__c = Date.newInstance(2019, 10, 1);
      	payList.add(pamentTerm6);

      	paymentTerm__c pamentTerm7 = new paymentTerm__c();
      	pamentTerm7.contract__c = contract.Id;
      	pamentTerm7.stageDate__c = Date.newInstance(2018, 10, 1);
      	payList.add(pamentTerm7);

      	paymentTerm__c pamentTerm8 = new paymentTerm__c();
      	pamentTerm8.contract__c = contract.Id;
      	pamentTerm8.stageDate__c = Date.newInstance(2017, 10, 1);
      	payList.add(pamentTerm8);

      	paymentTerm__c pamentTerm9 = new paymentTerm__c();
      	pamentTerm9.contract__c = contract.Id;
      	pamentTerm9.stageDate__c = Date.newInstance(2016, 10, 1);
      	payList.add(pamentTerm9);

      	paymentTerm__c pamentTerm10 = new paymentTerm__c();
      	pamentTerm10.contract__c = contract.Id;
      	pamentTerm10.stageDate__c = Date.newInstance(2015, 10, 1);
      	payList.add(pamentTerm10);

      	paymentTerm__c pamentTerm11 = new paymentTerm__c();
      	pamentTerm11.contract__c = contract.Id;
      	pamentTerm11.stageDate__c = Date.newInstance(2014, 10, 1);
      	payList.add(pamentTerm11);
      	insert payList;
	}

    static testMethod void testBatchSumAmount() 
    {
        test.startTest();
      	BatchStatisticsAccountProcessData batchSAPD = new BatchStatisticsAccountProcessData();
      	System.Database.executeBatch(batchSAPD);
        test.stopTest();
    }
}