@isTest
/***
*供货范围附件测试类
*创建人：杨明
*创建时间：2019-01-15
*sf-sosp-tranzvision
***/
public class TestAttementControllerF {
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
      String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u4;
      String profileid2 = [select id from Profile where name ='A-项目管理工程师(运营)'][0].id;
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u5;


//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      
      
//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
         
////创建投标评审
 //RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
 //bidReview__c brc = new bidReview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c //='招标项目');
 //insert brc;            
////创建报价
//RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
//quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = quatationType.id,bidType__c //='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
//insert qtc;
////创建合同评审
//RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
//contractreview__c cttw = new contractreview__c(opportunity__c=o1.id,approvalStatus__c='审批通过',reviewStatus__c  ='评审进行中',biddingApproval__c=brc.id,RecordTypeId=contractrev//iewType.id,quatation__c=qtc.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
//insert cttw;           
//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
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
   //   cc.reviewNumber__c = cttw.id;
      insert cc;   
      attachment__c atc10 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contract__c= cc.id);
       insert atc10;
       atc10.notes__c='1231';
       update atc10;
//创建合同变更
       RecordType contractchangeType = [SELECT Id from RecordType where  SobjectType= :'contractchange__c' and name =:'供货范围变更'];
       contractchange__c ctcc = new contractchange__c(RecordTypeId =contractchangeType.id,contract__c=cc.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u4.id,approvalStatus__c='提交待审批');
       insert ctcc;       
//创建合同变更附件      
      attachment__c atc3 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contractChange__c = ctcc.id);
       insert atc3;
      atc3.notes__c='1231';
       update atc3;
//创建合同发货
     RecordType shappingType = [SELECT Id from RecordType where  SobjectType= :'shipping__c' and name =:'发货申请表'];
      shipping__c shipping = new shipping__c(RecordTypeId = shappingType.id,approvalStatus__c='审批通过',contracts__c = cc.id,contractAdmin__c=u4.id,deliveryName__c='2313',deliveryCall__c='23131');
       insert shipping;  
//创建合同发货附件      
     attachment__c atc8 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',shipping__c = shipping.id);
      insert atc8;
     atc8.notes__c='333';
     update atc8;
   } 
   static testMethod void testSalesLeadsApprove1(){
     
       test.startTest(); 
       test.stopTest();  
   }
    
}