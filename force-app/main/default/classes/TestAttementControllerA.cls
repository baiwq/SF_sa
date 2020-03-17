@isTest
/***
*供货范围附件测试类
*报价
*创建人：杨明
*创建时间：2019-01-15
*sf-sosp-tranzvision
***/
public class TestAttementControllerA {
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
     RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     bidReview__c brc = new bidReview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c ='招标项目');
      insert brc;
//创建报价
      RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='草稿',RecordTypeId = quatationType.id,bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;
//创建报价附件      
     attachment__c atc1 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',quatation__c = qtc.id);
     insert atc1; 
     qtc.approvalStatus__c = '提交待审批';
     update qtc;
     

  } 
    static testMethod void testSalesLeadsApprove1(){
     
       test.startTest(); 
       test.stopTest();  
   }
}