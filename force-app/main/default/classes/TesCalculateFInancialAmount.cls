@isTest
private class TesCalculateFInancialAmount {
    @testSetup static void CreateBaseData(){
//创建用户
       
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test', 
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', contractAdmin__c = Userinfo.getUserId());
      insert u1;

      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id , contractAdmin__c = Userinfo.getUserId());
      insert u2;

      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u2.id , contractAdmin__c = Userinfo.getUserId());
      insert u3;

      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u4;

      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u5;
 


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
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
      insert o1;

//创建投标保证金
      //tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇' );
      //insert t1;

//创建机会点成员
      //OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      //insert OT;

//创建业绩分配比例及成员
      //commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      //insert CS;

      //commisionUser__c cu = new commisionUser__c(commisionSplit__c = cs.id,performanceProportion__c = 10, member__c = u2.id);
      //insert cu;
      //commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];
      //cu.performanceProportion__c = 0.9;
      //update cu;

      //CS.approvalStatus__c = '审批通过';
      //update CS;

//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and DeveloperName =:'FinancialSecurityContract' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.oldContractNumber__c='SC100100100';
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
      cc.approvalStatus__c = '审批通过';
      insert cc;
     
      //创建服务费用
      ServiceCharge__c service = new ServiceCharge__c();
      service.Amount__c = 100000;
      service.CostType__c = '设备费';
      service.Faxfw__c ='6%';
      service.Contract__c = cc.Id;
      service.ServiceOpeningDate__c = Date.newInstance(2018, 1, 1);
      service.ApprovalStatus__c = '审批通过';
      insert service;
      ServiceCharge__c service2 = new ServiceCharge__c();
      service2.Amount__c = 100000;
      service2.Faxfw__c ='6%';
      service2.CostType__c = '报警服务费';
      service2.Contract__c = cc.Id;
      service2.ServiceOpeningDate__c = Date.newInstance(2018, 1, 15);
      service2.ApprovalStatus__c = '审批通过';
      insert service2;

      ProjectTask__c task = new ProjectTask__c();
      task.Name='123';
      task.domainUser__c='renyx';
      task.contract__c=cc.Id;
      task.projectManagementEngineer__c='renyx';
      insert task;
      
    }
    static testMethod void testMethod1() {
        Test.startTest();
        CalculateFinancialAmount.calculateAmount(2018, 1, Date.newInstance(2018, 1, 31));
        test.stopTest();
    }
    static testMethod void testMethod2() {
        Test.startTest();
        SchduleCalculateFinancialAmount cal = new SchduleCalculateFinancialAmount();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, cal);
        Test.stopTest(); 
        
       
    }
}