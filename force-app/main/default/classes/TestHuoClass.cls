@isTest
public with sharing class TestHuoClass{

     static testMethod void CreateBaseData(){
        //创建用户
      /*User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id);
      insert u2;

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
//创建父业务机会
      RecordType OppoRecordType1 = [Select id from RecordType where SobjectType =:'Opportunity' and Name =:'常规' limit 1];
      opportunity o1 = new opportunity(RecordTypeId =OppoRecordType1.id, Name = 'O1NA2ME', StageName = '赢单', actualbidamount__c = 33.00,projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id);
      insert o1;
//创建子业务机会
      RecordType OppoRecordType = [Select id from RecordType where SobjectType =:'Opportunity' and Name =:'子业务机会' limit 1];
      opportunity o = new opportunity(RecordTypeId =OppoRecordType.id, fatherOpportunity__c = o1.id,Name = 'O1NAME', StageName = '赢单',actualbidamount__c = 33.00, projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id);
      insert o;
//创建业务机会附件
      attachment__c at = new attachment__c(opportunity__c = o1.id,documentName__c ='投标附件',isValid__c ='有效',type__c = '标书归档-非价格类',attachmentURL__c ='abc',notes__c = 'aaa');
      insert at;     
//创建投标评审
      bidReview__c bid = new bidReview__c(opportunity__c = o1.id,approvalStatus__c ='审批通过');
      insert bid;
//创建投保评审附件
      attachment__c at1 = new attachment__c(bidReview__c = bid.id,documentName__c ='投标附件',isValid__c ='有效',type__c = '招标文件',attachmentURL__c ='abc',notes__c = 'aaa');
      insert at1;


        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=bid.Id);
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
        


//创建合同评审
      contractreview__c cv = new contractreview__c(opportunity__c = o1.id,quatation__c=qua.Id,biddingApproval__c = bid.id,approvalStatus__c ='草稿',technologyReviewContent__c = '内容',technologyReviewSuggestion__c ='意见',
      technologyReviewExpert__c = u1.id,accountManager__c=u2.Id,technologyFinalReviewSuggestion__c ='通过',outsourcingReviewContent__c = '内容',outsourcingReviewSuggestion__c = '意见',outsourcingReviewExpert__c = u2.id,
      outsourcingFinalReviewSuggestion__c = '通过',applyImportantProject__c = '是',PM__c = 'aa',projectContext__c='申请啊',projectType__c ='II类--项目为EPC项目、同一大包方的项目集');
      insert cv;
      contractreview__c cv1 = new contractreview__c(ownerId= u1.id,quatation__c=qua.Id,opportunity__c = o1.id,biddingApproval__c = bid.id,approvalStatus__c ='草稿',technologyReviewContent__c = '内容',technologyReviewSuggestion__c ='意见',
      technologyReviewExpert__c = u1.id,technologyFinalReviewSuggestion__c ='通过',outsourcingReviewContent__c = '内容',outsourcingReviewSuggestion__c = '意见',outsourcingReviewExpert__c = u2.id,
      outsourcingFinalReviewSuggestion__c = '通过',applyImportantProject__c = '否',PM__c = 'aa',projectContext__c='申请啊',projectType__c ='II类--项目为EPC项目、同一大包方的项目集');
      insert cv1;
      cv1.applyImportantProject__c = '是';
      update cv1;
      cv1.approvalStatus__c = '提交待审批';
      update cv1;
      cv1.approvalStatus__c = '审批通过';
      update cv1;
      
//创建重点工程项目申请
      majorProjects__c mp1 = new majorProjects__c(contractreview__c = cv1.id,Field1__c='草稿');
      insert mp1;
      mp1.PM__c = '经理';
      mp1.Field1__c='审批通过';
      update mp1;
//更新合同评审所有人
      cv1.ownerId = u2.id;
      update cv1;
//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      
      cc.tenderScheme__c = '1234';
      cc.opportunity__c = o1.id;
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
      cc.reviewNumber__c = cv1.id;
      cc.RecordTypeId = ContractRecordType1.id;
      cc.contractReceptDate__c = date.newInstance(2017, 2, 17);
      insert cc; */
    }
  
    
}