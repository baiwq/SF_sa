@isTest(seeAlldata = true)
public with sharing class ContractCollectBeforeInsert_test {


    static testMethod void testSalesLeadsApprove1()
    {
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        insert u1;
        opportunity o1 = [SELECT ID,AccountId FROM opportunity where recordtype.Name != '集招/集采' and StageName = '赢单' Limit 1];
       RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
        RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = quatationType.id,bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;
        contractreview__c cttw = new contractreview__c(quatation__c = qtc.Id,approvalStatus__c='审批通过',MainIndustrySales__c = '配用电业务',departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,ApproveComponent__c ='123123',opportunity__c=o1.id,legalFinalReviewSuggestion__c = '通过',financeFinalReviewSuggestion__c = '通过',outsourcingFinalReviewSuggestion__c = '通过',technologyFinalReviewSuggestion__c = '通过',warrantyPeriodFinalReviewSuggestion__c = '通过',dateOfDeliveryFinalReviewSuggestion__c = '通过',One__c=100,reviewStatus__c ='评审进行中',RecordTypeId=contractreviewType.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
        insert cttw;
        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
        Contract__c cc = new Contract__c();  //有合同
        cc.reviewNumber__c = cttw.Id;
        cc.account__c= o1.AccountId;
        cc.signedby__c= u1.id;
        cc.deliveryPerson__c = u1.id;
        cc.accountManager__c = u1.id;
        cc.tenderScheme__c = '1234';
        cc.opportunity__c = o1.id;
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
        cc.approvalStatus__c = '审批通过';
        cc.Field1_test__c = '1';
        cc.orderIdCPQ__c = '1234';
        insert cc; 
    }
    static testMethod void testSalesLeadsApprove2()
    {
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        insert u1;  
       RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];

        opportunity o1 = [SELECT ID,AccountId FROM opportunity where recordtype.Name = '集招/集采' and StageName = '赢单' Limit 1];
        
        contractreview__c cttw = new contractreview__c(approvalStatus__c='审批通过',MainIndustrySales__c = '配用电业务',departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,ApproveComponent__c ='123123',opportunity__c=o1.id,legalFinalReviewSuggestion__c = '通过',financeFinalReviewSuggestion__c = '通过',outsourcingFinalReviewSuggestion__c = '通过',technologyFinalReviewSuggestion__c = '通过',warrantyPeriodFinalReviewSuggestion__c = '通过',dateOfDeliveryFinalReviewSuggestion__c = '通过',One__c=100,reviewStatus__c ='评审进行中',RecordTypeId=contractreviewType.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
        insert cttw; 
        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
        Contract__c cc = new Contract__c();  //有合同
        cc.reviewNumber__c = cttw.Id;
        cc.account__c= o1.AccountId;
        cc.signedby__c= u1.Id;
        cc.deliveryPerson__c = u1.id;
        cc.tenderScheme__c = '1234';
        cc.opportunity__c = o1.id;
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
        cc.approvalStatus__c = '审批通过';
        cc.Field1_test__c = '1';
        cc.orderIdCPQ__c = '1234';
        insert cc; 
    }
}