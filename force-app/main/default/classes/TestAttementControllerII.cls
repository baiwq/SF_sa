@isTest
/***
*供货范围附件测试类
*创建人：杨明
*创建时间：2019-01-15
*sf-sosp-tranzvision
***/
public class TestAttementControllerII{
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

//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
         

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;

//创建合同评审
     //  RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
       contractreview__c cttw = new contractreview__c(opportunity__c=o1.id,approvalStatus__c='审批通过',contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
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
     // cc.RecordTypeId = ContractRecordType1.id;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.reviewNumber__c = cttw.id;
      cc.approvalStatus__c = '审批通过';
      insert cc;      
//创建合同变更
       RecordType contractchangeType = [SELECT Id from RecordType where  SobjectType= :'contractchange__c' and name =:'供货范围变更'];
       contractchange__c ctcc = new contractchange__c(RecordTypeId =contractchangeType.id,contract__c=cc.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u4.id,approvalStatus__c='审批通过');
       insert ctcc;       
//创建合同变更附件      
      attachment__c atc3 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contractChange__c = ctcc.id);
       insert atc3;
      
    //  ctcc.approvalStatus__c = '审批通过';
     //  update ctcc;
//创建合同二次变更
       contractchange__c ctcc2 = new contractchange__c(RecordTypeId =contractchangeType.id,contract__c=cc.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u4.id,approvalStatus__c='草稿');
       insert ctcc2;
//创建合同二次变更附件      
      attachment__c atc4 = new attachment__c(type__c ='供货范围清单',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',isValid__c = '有效',contractChange__c = ctcc2.id);
       insert atc4;
      ctcc2.approvalStatus__c = '审批通过';
      update ctcc2;
//创建合同三次变更
  //     contractchange__c ctcc3 = new contractchange__c(RecordTypeId =contractchangeType.id,contract__c=cc.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u4.id,approvalStatus__c='草稿');
   //    insert ctcc3;
   //    ctcc3.approvalStatus__c = '审批通过';
  //    update ctcc3;
   } 
    static testMethod void testSalesLeadsApprove1(){
     
       test.startTest(); 
       test.stopTest();  
   }
}