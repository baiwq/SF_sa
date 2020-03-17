@isTest
/***
*CPQ毛利率测试类
*创建人：付肖
*创建时间：2019-12-18
***/
public class TestApprovalCPQ {
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

//创建年度计划   
      List<Plan__c> pList = new List<Plan__c>();
      Plan__c p1= new Plan__c();
      p1.OwnerId = u1.id;
      p1.year__c = '2019';
      p1.departmentName__c = '个人';
      pList.add(p1);
  
      Plan__c p2= new Plan__c();
      p2.OwnerId = u2.id;
      p2.year__c = '2016';
      p2.departmentName__c = '个人';
      pList.add(p2);
    
      Plan__c p3= new Plan__c();
      p3.OwnerId = u3.id;
      p3.year__c = '2016';
      p3.departmentName__c = '个人';
      pList.add(p3);
    
      Plan__c p4= new Plan__c();
      p4.OwnerId = u4.id;
      p4.year__c = '2019';
      p4.departmentName__c = '销售中心';
      pList.add(p4);
    
      insert pList;

//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      
      Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a1b;
      
//创建联系人
      Contact c = new Contact(LastName ='孙权', AccountId = a.Id);
      insert c;
      
//创建销售线索
      salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                            expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                            projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务');
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(MainProductGroup__c='直流输电及电力电子业务单元-直流输电及电力电子产品',MainIndustrySales__c ='输变电业务',ProductGroup__c='直流输电及电力电子业务单元-直流输电及电力电子产品',Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
        
//创建投标评审
     RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     bidReview__c brc = new bidReview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c ='招标项目');
      insert brc;
//创建报价
      //RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',/*RecordTypeId = quatationType.id,*/bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;
//创建合同评审
       //RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
       contractreview__c cttw = new contractreview__c(SalesIndustoryManager__c=u1.id,SalesTerritoryManager__c=u1.id,cpywdyfzr__c=u1.id,sfscghfw__c='是',opportunity__c=o1.id,approvalStatus__c='审批通过',biddingApproval__c=brc.id,/*RecordTypeId=contractreviewType.id,*/quatation__c=qtc.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
       insert cttw;
       cttw.applyImportantProject__c='否';
       update cttw;
     
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.reviewNumber__c  = cttw.id;
      cc.opportunity__c = o1.id;
      cc.tenderScheme__c = '1234';
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.approvalStatus__c = '审批通过';
      insert cc;  
      cc.deliveryTeamCenter__c = '销售中心';
      update cc;
      
       RecordType ContractChangeRecordType = [Select id from RecordType where SobjectType =:'contractchange__c' and Name =:'供货范围变更' limit 1];
       contractchange__c cccts = new contractchange__c(cpywdyfzr__c=u1.id,SalesTerritoryManager__c=u1.id,SalesIndustoryManager__c=u1.id,DepartmentManager2__c=u1.id,applyBy__c='设计院',RecordTypeId =ContractChangeRecordType.id,contract__c =cc.id,changeContent__c='213',totalDischarge__c=true,contractAdmin__c =u4.id);
       insert cccts;
       cccts.applyBy__c='设计院';
       update cccts;
   } 

 
 static testMethod void testcpq(){
      test.startTest();
      Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 

       test.stopTest(); 
   }
    
     

}