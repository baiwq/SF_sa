@isTest
/***
*供货范围附件测试类
*创建人：杨明
*合同评审
*创建时间：2019-01-15
*sf-sosp-tranzvision
***/
public class TestAttementControllerGG {
  @testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1);
      insert u4;
      String profileid2 = [select id from Profile where name ='A-项目管理工程师(运营)'][0].id;
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1);
      insert u5;


//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
         

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
         
//创建投标评审
    // RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     bidReview__c brc = new bidReview__c(MainIndustrySales__c = '配用电业务',opportunity__c = o1.Id,approvalStatus__c='审批通过',CloseDate__c = System.today(),projectClassification__c ='招标项目');
      insert brc;
//创建报价
     // RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;
//创建合同评审
     //  RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
       contractreview__c cttw = new contractreview__c(isDeptAchievement__c='是',isCheckScopeSupply__c = '是',MainIndustrySales__c = '配用电业务',departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c=o1.id,legalFinalReviewSuggestion__c = '通过',financeFinalReviewSuggestion__c = '通过',outsourcingFinalReviewSuggestion__c = '通过',technologyFinalReviewSuggestion__c = '通过',warrantyPeriodFinalReviewSuggestion__c = '通过',dateOfDeliveryFinalReviewSuggestion__c = '通过',One__c=100,approvalStatus__c='审批通过',reviewStatus__c ='评审完成',biddingApproval__c=brc.id,quatation__c=qtc.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
       insert cttw;   
       
//创建合同评审附件      
      attachment__c atc2 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contractReview__c = cttw.id);
       insert atc2; 
//创建合同
     // RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u1.id;
      cc.accountManager__c = u1.id;
      cc.tenderScheme__c = '1234';
      cc.opportunity__c = o1.id;
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
    //  cc.RecordTypeId = ContractRecordType1.id;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.approvalStatus__c = '审批通过';
      cc.reviewNumber__c = cttw.id;
      insert cc;   
//创建合同变更
       RecordType contractchangeType = [SELECT Id from RecordType where  SobjectType= :'contractchange__c' and name =:'供货范围变更'];
       contractchange__c ctcc = new contractchange__c(DepartmentManager2__c = u1.id,isSandbox__c = '是',RecordTypeId =contractchangeType.id,contract__c=cc.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u4.id,approvalStatus__c='草稿',orderIdCPQ__c ='111111',contractChangedProjectGrossProfitMargin__c=10,standardProjectGrossProfitMarginCtrChag__c=10,standardProjectGrossProfitContractChange__c =10,contractChangedProjectGrossProfit__c =10);
      insert ctcc;  
       attachment__c atc3 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contractChange__c = ctcc.id); 
       insert atc3;
       ctcc.approvalStatus__c = '提交待审批';
       update ctcc;       
       
   } 
    static testMethod void testSalesLeadsApprove1(){
     
       test.startTest(); 
       test.stopTest();  
   }
}