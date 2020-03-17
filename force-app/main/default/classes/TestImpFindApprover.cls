@isTest
public class TestImpFindApprover {
  @testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心',department__c = '国网业务部',Province__c ='甘肃');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心',department__c = '东北区', Manager = u1);
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '国际业务',department__c = '华北区', Manager = u2);
      insert u3;
      String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心',department__c = '西北区', Manager = u3);
      insert u4;
      String profileid2 = [select id from Profile where name ='A-项目管理工程师(运营)'][0].id;
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u3);
      insert u5;
      
       User u6 = new User(LastName = '测试经理6',Alias = '测试6', UserName = 'sunx6@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test6', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心',department__c = '华中区',Province__c ='浙江', Manager = u2);
      insert u6;
      
      User u7 = new User(LastName = '测试经理7',Alias = '测试7', UserName = 'sunx7@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test7', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心',Province__c ='河南', Manager = u2);
      insert u7;

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
      p4.departmentName__c = '电力系统销售中心';
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
                                           MainIndustrySales__c = '发电行业',MainProductGroup__c = '输变电业务单元-电网保护自动化事业部',Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;

      
//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;
    
//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
       

    
//创建合同
      //RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.SalesCenterManager__c= null;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.tenderScheme__c = '1234';
      cc.opportunity__c = o1.id;
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '电力系统销售中心';
      cc.approvalStatus__c = '审批通过';
      cc.MainIndustrySales__c = '发电行业';
      insert cc;
        
  //创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇' );
      insert t1;  
      t1.ApproveComponent__c = '123';
      update t1;
//创建投标评审
     RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
     bidReview__c brc = new bidReview__c(SalesCenterManager__c=null,MainIndustrySales__c = '发电行业',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c ='招标项目',ownerid =u1.id);
      insert brc;
      brc.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      update brc;
      
      
     //创建报价
      //RecordType quatationType = [Select id from RecordType where SobjectType =:'quatation__c' and Name =:'报价管理' limit 1];
      quatation__c  qtc = new quatation__c(MainProductGroup__c = '输变电业务单元-电网保护自动化事业部',opportunity__c = o1.Id,approvalStatus__c='审批通过',/*RecordTypeId = quatationType.id,*/bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
      insert qtc;

      contractreview__c cr = new contractreview__c(MainIndustrySales__c='国际业务',departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,quatation__c=qtc.Id,opportunity__c=o1.id,biddingApproval__c=brc.Id);
      insert cr;
      cr.ApproveComponent__c = '123';
      update cr;
        //创建非常用外购
       //RecordType notCommonOutType = [SELECT Id from RecordType where  SobjectType= :'notCommonOutsourcing__c' and name =:'多级审批外购申请表']; 
       notCommonOutsourcing__c ncoc =new notCommonOutsourcing__c(/*RecordTypeId =notCommonOutType.id,*/type__c='电力系统销售中心',MainProductGroup__c='输变电业务单元-电网保护自动化事业部');
       insert ncoc;
       ncoc.ApproveComponent__c = '123';
       update ncoc;
      
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
      insert i;
      i.ApproveComponent__c = '123';
      update i;
      
      guaranteeLetter__c g1 = new guaranteeLetter__c(SalesCenterManager__c=null,amount__c =10000,type__c = '履约保证金',regionalDirector__c=u1.id, operator__c =u1.id);
      insert g1;
      g1.ApproveComponent__c = '123';
      update g1;
      
      receipt__c r = new receipt__c(receiptAccount__c = a.id, approvalStatus__c = '草稿',payeeUser__c = u2.id, applyBy__c =u4.id);
      insert r;
      r.ApproveComponent__c = '123';
      update r;
      
      shipping__c s=new shipping__c();
      s.approvalDate__c=System.now();
      s.returnContractTime__c=System.today();
      insert s;
      s.ApproveComponent__c = '123';
      update s;
      
      bidCost__c ba = new bidCost__c(approvalStatus__c = '草稿');
      insert ba;
      ba.ApproveComponent__c = '123';
      update ba;
      
          
      RecordType ContractChangeRecordType = [Select id from RecordType where SobjectType =:'contractchange__c' and Name =:'供货范围变更' limit 1];
      contractchange__c cccts = new contractchange__c(cpywdyfzr__c=u1.id,SalesTerritoryManager__c=u1.id,SalesIndustoryManager__c=u1.id,DepartmentManager2__c=u1.id,applyBy__c='设计院',RecordTypeId =ContractChangeRecordType.id,contract__c =cc.id,changeContent__c='213',totalDischarge__c=true,contractAdmin__c =u4.id);
      insert cccts;
      cccts.applyBy__c='设计院';
      update cccts;
   } 

    
    static testMethod void testAchivementRecognization123(){
       Test.startTest();
       Test.stopTest();
   }
}