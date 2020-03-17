@isTest

/***
*提交审批测试类
*创建人：杨明
*创建时间：2018-12-27
*sf-sosp-tranzvision
***/
public class TestApproveController2 {
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
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',
                                           MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;

      
////创建机会点成员
//    OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
//    insert OT;
//  
////创建业绩分配比例及成员
//    commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
//    insert CS;
//    
//  
	  //创建合同
      //RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
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
      //cc.RecordTypeId = ContractRecordType1.id;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.approvalStatus__c = '审批通过';
      insert cc;  

//创建投标评审
     RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     bidReview__c brc = new bidReview__c(MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c ='招标项目');
      insert brc;
//创建报价
      //RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',/*RecordTypeId = quatationType.id,*/bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;
//创建中标服务费申请
      //RecordType bidCostType = [Select id from RecordType where SobjectType =:'bidCost__c' and Name =:'中标服务费-常规' limit 1]; 
      bidCost__c bcs = new bidCost__c(costCenter__c = '22222222',/*RecordTypeId =bidCostType.id,*/approvalStatus__c='审批通过',amount__c=111,account__c=a.id,bidNumber__c='1111',invoiceReturnDate__c=System.today(),opportunity__c=o1.id,remittanceMethod__c='支票',company__c='北京四方继保自动化股份有限公司',Reason__c='ee3',payComment__c='123');
      insert bcs;
//创建投标保证金/保函
      tbbaozhengjin__c tbbzj = new tbbaozhengjin__c(type__c ='投标保证金',approvalStatus__c='审批通过',remittanceNumber__c=1111,account__c=a.id,rate__c=2.2,opportunity__c=o1.id,peymentDate__c=System.today(),company__c='北京四方继保自动化股份有限公司',costCenterNumber__c='222',operator__c=u1.id,invoiceReturnDate__c=System.today(),remittanceWay__c = '电汇',reason__c='1111',payComment__c='231313');
      insert tbbzj;

//创建合同评审
       //RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
       contractreview__c cttw = new contractreview__c(MainIndustrySales__c = '配用电业务',opportunity__c=o1.id,approvalStatus__c='审批通过',biddingApproval__c=brc.id,/*RecordTypeId=contractreviewType.id,*/quatation__c=qtc.id,contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
       insert cttw;
//创建在重点工程项目
       majorProjects__c mpfs = new majorProjects__c(cpywdyfzr__c=u1.Id,sqjl__c=u1.Id,Projecttype__c = 'I类--单个合同额≥1000万',contractreview__c=cttw.id,projectcontext__c='2313',Field1__c='审批通过');
       insert mpfs;
//创建合同变更
       //RecordType contractchangeType = [SELECT Id from RecordType where  SobjectType= :'contractchange__c' and name =:'合同信息变更'];
      // contractchange__c ctcc = new contractchange__c(/*RecordTypeId =contractchangeType.id,*/DepartmentManager2__c=u1.id,contract__c=cc.id,applyBy__c='设计院',secondChanged__c='是',accountChanged__c='是',contractNameChanged__c='是',paymentTermChanged__c='是',warrantyChanged__c='是',changeContent__c='234',contractAdmin__c=u4.id,approvalStatus__c='审批通过');
       //insert ctcc;
//创建费用申请
       //RecordType contractFeeType = [SELECT Id from RecordType where  SobjectType= :'contractFee__c' and name =:'已生成合同（有LTC过程）'];
       contractFee__c cfeec = new contractFee__c(contract__c=cc.id,OwnerId = u1.id,contracreviwer__c=cttw.id,approveState__c='审批通过',opportunityName__c=o1.id,bidtype__c='集招',accountType__c='电网',Projecttype__c='EPC',Field1__c='是',contractReceive__c=System.today(),estimateDeliverDate__c=System.today(),To90time__c=System.today(),receivetim__c=System.today(),agency__c='212',agreementNumber__c='QWE2222',agencyPayment__c='213',specifyAmount__c=123,paymentPercentage__c='2312');
       insert cfeec;
//合同发货
       RecordType shappingType = [SELECT Id from RecordType where  SobjectType= :'shipping__c' and name =:'发货申请表'];
       shipping__c shipping = new shipping__c(/*RecordTypeId = shappingType.id,*/approvalStatus__c='审批通过',contracts__c = cc.id,contractAdmin__c=u4.id,deliveryName__c='2313',deliveryCall__c='23131');
       insert shipping;
     
   } 

//合同评审
    static testMethod void testContractreviewApprove(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];      
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
//重点工程项目
    static testMethod void testMajorProjectsApprove(){
      test.startTest();
      majorProjects__c i = [select id from majorProjects__c where Projecttype__c = 'I类--单个合同额≥1000万' limit 1];      
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveMajorProjectsPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveMajorProjectsCtrl amprc = new ApproveMajorProjectsCtrl(); 
       amprc.confirm();
       test.stopTest(); 
   }
//合同变更
//  static testMethod void testContractchangeApprove(){
//    test.startTest();
//    contractchange__c i = [select id from contractchange__c where applyBy__c='设计院' limit 1];      
//    User u = [Select id from User limit 1];
//    PageReference pageRef = Page.ApproveContractchangePage;
//    Test.setCurrentPage(pageRef);  
//    ApexPages.currentPage().getParameters().put('id',i.id);
//    
//     ApproveContractchangeCtrl amprc = new ApproveContractchangeCtrl();
//     amprc.confirm();
//     test.stopTest(); 
// }

//合同发货
 static testMethod void testShippingApprove(){
      test.startTest();
      shipping__c i = [select id from shipping__c where deliveryName__c='2313' limit 1];      
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveShippingPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveShippingCtrl amprc = new ApproveShippingCtrl();
       amprc.confirm();
       test.stopTest(); 
   }
    
    
    //合同发货
  static testMethod void testContractFee(){
      test.startTest();
      contractFee__c i = [select id from contractFee__c where agreementNumber__c='QWE2222' limit 1];      

        PageReference thePage = Page.ShowReturnItem;
      thePage.getParameters().put('id', i.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(i);
      QueryReturnItem eblb = new QueryReturnItem(sc);
      test.stopTest(); 
   }
    
}