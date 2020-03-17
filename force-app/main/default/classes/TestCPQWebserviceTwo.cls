@isTest
public class TestCPQWebserviceTwo {
    public static testMethod void testCPQToSOSPContractreviewClass(){
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
    
    //创建客户
          Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
          insert a;
    
          Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
          insert a1b;
    
    //创建销售线索
          
          salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                                expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                                projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                                projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',
                                               MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
          insert s1;
    
    //创建业务机会
          opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
          insert o1;
    
    //创建投标保证金
          tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇',remittanceNumber__c = 100,rate__c = 2.0 );
          insert t1;
    //创建投标评审
    	  bidReview__c  br = new bidReview__c(MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c =o1.id,approvalStatus__c='审批通过');
          insert br;
    //创建机会点成员
          OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
          insert OT;
    
    //创建业绩分配比例及成员
          commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
          insert CS;
        
               //创建行业比例
          IndustryProportion__c IP = new IndustryProportion__c(commisionSplit__c= cs.id,MainIndustrySales__c='输变电业务',Allocation__c =100);
          insert IP;
        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=br.Id);
        insert qua;
        qua.approvalStatus__c='审批通过';
        update qua;
        contractreview__c cr = new contractreview__c( biddingApproval__c=br.Id,quatation__c=qua.Id,opportunity__c=o1.id);
        insert cr;
        contractreview__c con = [select Name,quatationName__c from contractreview__c where id=:cr.id limit 1];
        CPQToSOSPContractreviewClass.Review re = new CPQToSOSPContractreviewClass.Review();
        re.revName=con.Name;
        re.quaName=con.quatationName__c;
        CPQToSOSPContractreviewClass.Response res = new CPQToSOSPContractreviewClass.Response();
        Test.startTest();
        CPQToSOSPContractreviewClass.setStandardPrice(re);
        Test.stopTest();
    }
    public static testMethod void testCPQToSOSPContractChangedClass(){
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
    
    //创建客户
          Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
          insert a;
    
          Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
          insert a1b;
    
  
    //创建业务机会
          opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
          insert o1;
    	
        //创建投标评审
    	  bidReview__c  br = new bidReview__c(MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,opportunity__c =o1.id,approvalStatus__c='审批通过');
          insert br;
        quatation__c qua = new quatation__c(opportunity__c=o1.Id,bidReview__c=br.Id);
        insert qua;
        qua.approvalStatus__c='审批通过';
        update qua;
        contractreview__c cr = new contractreview__c(departmentmanager1__c = u1.Id,cpywdyfzr__c = u1.Id,Industry_Representative__c = u1.Id,SalesIndustoryManager__c = u1.Id,biddingApproval__c=br.Id,quatation__c=qua.Id,opportunity__c=o1.id);

        insert cr;
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
      insert cc;
      //创建重点项目
      majorProjects__c major = new majorProjects__c(cpywdyfzr__c=u1.Id,sqjl__c=u1.Id);
       insert major;
      //创建附件  
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc.Id);
      insert ac;
      attachment__c ac11 = new attachment__c(isValid__c = '有效',type__c = '供货范围清单',contract__c = cc.Id);
      insert ac11;
      cc.approvalStatus__c='审批通过';
        update cc;
        contractchange__c cch= new contractchange__c();
      cch.contract__c=cc.id;
      cch.applyBy__c='客户';
      cch.ownerId = u1.id; 
      cch.DepartmentManager2__c = u1.id; 
      cch.notCompletelySchedulingExplain__c='测试';
      cch.RecordTypeId = [Select id from RecordType where sobjectType = 'contractchange__c' and Name = '合同金额变更'].id;
      insert cch;
      contractchange__c cc2 =[select Name,contractNo__c from contractchange__c where id=:cch.id limit 1];
        CPQToSOSPContractChangedClass.Changed chan =new CPQToSOSPContractChangedClass.Changed();
        chan.changedName=cc2.Name;
        chan.contractNo=cc2.contractNo__c;
        Test.startTest();
        CPQToSOSPContractChangedClass.setStandardPrice(chan);
        Test.stopTest();
    }
}