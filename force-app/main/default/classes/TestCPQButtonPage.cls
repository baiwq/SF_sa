@isTest
public class TestCPQButtonPage {
    @testSetup static void CreateBaseData(){
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
          insert u1;
    
          User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                       email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                       ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id);
          insert u2;
    
          User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                       email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                       ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u2.id);
          insert u3;
    
          User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                       email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                       ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id);
          insert u4;
    
          User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                       email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                       ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id);
          insert u5;
    
    //创建年度计划
          List<Plan__c> pList = new List<Plan__c>();
          Plan__c p1= new Plan__c();
          p1.OwnerId = u1.id;
          p1.year__c = '2016';
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
          p4.year__c = '2016';
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
    
    //创建潜在客户
          Lead l1 = new Lead(Status = '未转化',Email = '123@sifang.com',account__c = a.Id, owner__c = u1.Id, Lastname = '张', Company = '四方继保',contact__c = c.Id, stationLevel__c = '20kV',expectBidDate__c = system.today(), pathBy__c ='公共媒体', expectAmount__c = 10000, Description = 'aaa');
          insert l1;
          l1.Status = '重复';
          update l1;
          l1.Status = '已转化';
          update l1;
    
    //创建销售线索
          
          salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                                expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                                projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                                projectTrackingPlan__c ='123',deliverWorkRange__c = '服务');
          insert s1;
    
    //创建业务机会
          opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
          insert o1;

    //创建投标评审
    	  bidReview__c  br = new bidReview__c(opportunity__c =o1.id,approvalStatus__c='审批通过');
          insert br;
        
    //创建机会点成员
          OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
          insert OT;
     
        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=br.Id);
        insert qua;
        qua.standardProjectGrossProfitMargin__c=1;
        qua.commonProjectOwnDevicePercent__c=1;
        qua.specialProductCostPercent__c=1;
        qua.outsourcingCostPercent__c=1;
        qua.companyTrainAndServiceCostPercent__c=1;
        qua.projectRunCostPercent__c=1;
        qua.projectRistCostPercent__c=1;
        qua.projectBigAmountCostPercent__c=1;
        
        qua.bidPriceProjectMarginRate__c=1;
        qua.bidCommonProjectOwnDevicePercent__c=1;
        qua.bidspecialProductCostPercent__c=1;
        qua.bidoutsourcingCostPercent__c=1;
        qua.bidcompanyTrainAndServiceCost__c=1;
        qua.bidprojectRunCostPercent__c=1;
        qua.bidprojectRistCostPercent__c=1;
        qua.bidprojectBigAmountCostPercent__c=1;
        
        qua.commonProjectOwnEquipmentBidPriceDctFml__c=1;
        qua.specialProductBiddingPriceDCT__c=1;
        qua.ownSoftBiddingPriceDCT__c=1;
        qua.outsourcingBiddingPriceDct__c=1;
        qua.outsourcingServiceBiddingPriceDct__c=1;
        qua.outsourcingArchitectureCostBidPriceDct__c=1;
        qua.companyTrainServiceBiddingPriceDct__c=1;
        qua.biddingTotalPriceDct__c=1;
        qua.approvalStatus__c='审批通过';
        update qua;
        

        contractreview__c cr = new contractreview__c(quatation__c=qua.Id,opportunity__c=o1.id,biddingApproval__c=br.Id);
        insert cr;
        cr.contractProjectGrossProfitMargin__c=1;
        cr.commonProjectOwnDevicePercent__c=1;
        cr.specialProductCostPercent__c=1;
        cr.outsourcingCostPercent__c=1;
        cr.companyTrainAndServiceCostPercent__c=1;
        cr.contractProjectRunCostPercent__c=1;
        cr.contractProjectRistCostPercent__c=1;
        cr.contractProjectBigAmountCostPercent__c=1;
        
        
        update cr;
    }
    public static testMethod void testQuaButtonPieStandardChartController (){
        quatation__c qua =[select id from quatation__c limit 1];
        
        PageReference pagere =Page.quatationPieStandardVisualPage;
        Test.setCurrentPage(pagere);
        ApexPages.currentPage().getParameters().put('id',qua.id);
        ApexPages.StandardController ass = new ApexPages.StandardController(qua);
        PieStandardChartController pc = new PieStandardChartController(ass);
        
    }
    public static testMethod void testQuaButtonPieBidChadrtController (){
        quatation__c qua =[select id from quatation__c limit 1];
        
        PageReference pagere =Page.quatationPieBidVisualPage;
        Test.setCurrentPage(pagere);
        ApexPages.currentPage().getParameters().put('id',qua.id);
        ApexPages.StandardController ass = new ApexPages.StandardController(qua);
        PieBidChadrtController pc = new PieBidChadrtController(ass);
    }
    public static testMethod void testQuaButtonBarChartController(){
        quatation__c qua =[select id from quatation__c limit 1];
        
        PageReference pagere =Page.quatationBarStandardVisualPage;
        Test.setCurrentPage(pagere);
        ApexPages.currentPage().getParameters().put('id',qua.id);
        ApexPages.StandardController ass = new ApexPages.StandardController(qua);
        BarChartController  pc = new BarChartController (ass);
    }
    public static testMethod void testContractReviewPieStandController(){
        contractreview__c  qua =[select id from contractreview__c  limit 1];
        
        PageReference pagere =Page.contractreviewPieStandPage;
        Test.setCurrentPage(pagere);
        ApexPages.currentPage().getParameters().put('id',qua.id);
        ApexPages.StandardController ass = new ApexPages.StandardController(qua);
        ContractReviewPieStandController  pc = new ContractReviewPieStandController (ass);
    }
    public static testMethod void testContractReviewBarController (){
        contractreview__c  qua =[select id from contractreview__c  limit 1];
        
        PageReference pagere =Page.contractreviewBarContractPage;
        Test.setCurrentPage(pagere);
        ApexPages.currentPage().getParameters().put('id',qua.id);
        ApexPages.StandardController ass = new ApexPages.StandardController(qua);
        ContractReviewBarController  pc = new ContractReviewBarController (ass);
    }
}