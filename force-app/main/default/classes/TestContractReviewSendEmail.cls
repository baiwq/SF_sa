@isTest
public class TestContractReviewSendEmail {
  @testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心',department__c='华南区' );
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
      contractreview__c cttw = new contractreview__c(isDeptAchievement__c='是',isCheckScopeSupply__c='是',ownerid=u1.id,MainProductGroup__c = '输变电业务单元-电网保护自动化事业部',MainIndustrySales__c = '配用电业务',departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c=o1.id,legalFinalReviewSuggestion__c = '通过',financeFinalReviewSuggestion__c = '通过',outsourcingFinalReviewSuggestion__c = '通过',technologyFinalReviewSuggestion__c = '通过',warrantyPeriodFinalReviewSuggestion__c = '通过',dateOfDeliveryFinalReviewSuggestion__c = '通过',One__c=100,approvalStatus__c='草稿',reviewStatus__c ='评审完成',biddingApproval__c=brc.id,quatation__c=qtc.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
      insert cttw;
      cttw.MainProductGroup__c ='发电及用电业务单元-电站事业部';
      update cttw;
      cttw.MainProductGroup__c ='输变电业务单元-电网保护自动化事业部';
      update cttw;
              
       
   } 
    static testMethod void testSalesLeadsApprove1(){
     
       test.startTest(); 
       test.stopTest();  
   }
}