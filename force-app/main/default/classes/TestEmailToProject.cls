@isTest
public class TestEmailToProject {
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
    //运营用户
      Profile p = [select id from Profile where Name='A-项目管理工程师(运营)' limit 1];      
      User u6 = new User(LastName = '测试经理6',Alias = '测试6', UserName = 'sunx6@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test6', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = p.id,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u3.id , contractAdmin__c = Userinfo.getUserId());
      insert u6;
//创建年度计划
      List<Plan__c> pList = new List<Plan__c>();
      Plan__c p1= new Plan__c();
      p1.OwnerId = u1.id;
      p1.year__c = '2017';
      p1.departmentName__c = '销售中心';
      pList.add(p1);

      Plan__c p2= new Plan__c();
      p2.OwnerId = u2.id;
      p2.year__c = '2017';
      p2.departmentName__c = '华东区';
      pList.add(p2);

      Plan__c p3= new Plan__c();
      p3.OwnerId = u3.id;
      p3.year__c = '2017';
      p3.departmentName__c = '浙江';
      pList.add(p3);

      Plan__c p4= new Plan__c();
      p4.OwnerId = u4.id;
      p4.year__c = '2017';
      p4.departmentName__c = '个人';
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

//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇' );
      insert t1;

//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;

//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;

      commisionUser__c cu = new commisionUser__c(commisionSplit__c = cs.id,performanceProportion__c = 10, member__c = u2.id);
      insert cu;
      //commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];
      cu.performanceProportion__c = 0.9;
      update cu;

      CS.approvalStatus__c = '审批通过';
      update CS;

//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
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
      insert cc;
      //创建重点项目
      majorProjects__c major = new majorProjects__c(cpywdyfzr__c=u1.Id,sqjl__c=u1.Id);
      insert major;
      //创建附件  
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc.Id);
      insert ac;
      attachment__c ac11 = new attachment__c(isValid__c = '有效',type__c = '供货范围清单',contract__c = cc.Id);
      insert ac11;
      ProjectTask__c task = new ProjectTask__c();
      task.Name='123';
      task.domainUser__c='renyx';
      task.contract__c=cc.Id;
      task.projectManagementEngineer__c='renyx';
      insert task;
      
    }
	public static testMethod void testEmailToProjectMethod(){
        contract__c con =[select id,contractNO__c from contract__c where oldContractNumber__c =: 'SC100100100'];
    	EmailTemplate et = new EmailTemplate();
        et.Name='test';
        et.DeveloperName='test12';
        et.FolderId=UserInfo.getUserId();
        et.TemplateType='visualforce';
        et.Markup='<messaging:emailTemplate subject="测试" recipientType="User" relatedToType="contract__c"> <messaging:htmlEmailBody > <html> <head></head> <body> <p>您好 ,</p> <br/><p>有新的报价需要您配置特殊产品价格；</p> <br/><p>业务机会名称：{!relatedTo.opportunity__r.Name},</p> <br/><p>报价管理编号：{!relatedTo.Name}.</p> <br/><br/><a href="https://cs58.salesforce.com/{!relatedTo.id}">https://cs58.salesforce.com/{!relatedTo.id}</a> </body> </html> </messaging:htmlEmailBody> </messaging:emailTemplate>';
        insert et;
        List<String> toAddress = new List<String>();
        toAddress.add('123@1231.com');
        //SendEmailToSpecial.exe_SendEmail(toAddress, UserInfo.getUserId(), '', et.Id);
        EmailToProject.exe_sendEmail('step', con.contractNO__c, UserInfo.getUserId(), '', et.Id,null,null);
    }
    public static testMethod void testPaymentTermAmountEmailCtrl(){
        contract__c con =[select id,contractNO__c from contract__c where oldContractNumber__c =: 'SC100100100'];
        List<paymentTerm__c> payList = new List<paymentTerm__c>();
        paymentTerm__c pay1 =new paymentTerm__c();
        pay1.contract__c=con.id;
        pay1.stage__c='预收';
        pay1.percentage__c=100;
        payList.add(pay1);
        paymentTerm__c pay2 =new paymentTerm__c();
        pay2.contract__c=con.id;
        pay2.stage__c='提货';
        pay2.percentage__c=0;
        payList.add(pay2);
        paymentTerm__c pay3 =new paymentTerm__c();
        pay3.contract__c=con.id;
        pay3.stage__c='到货';
        pay3.percentage__c=0;
        payList.add(pay3);
        paymentTerm__c pay4 =new paymentTerm__c();
        pay4.contract__c=con.id;
        pay4.stage__c='调试';
        pay4.percentage__c=0;
        payList.add(pay4);
        paymentTerm__c pay5 =new paymentTerm__c();
        pay5.contract__c=con.id;
        pay5.stage__c='投运';
        pay5.percentage__c=0;
        payList.add(pay5);
        paymentTerm__c pay6 =new paymentTerm__c();
        pay6.contract__c=con.id;
        pay6.stage__c='质保';
        pay6.percentage__c=0;
        payList.add(pay6);
        insert payList;
        con.returnHistory__c=10;
        update con;
        paymentTermAmountEmailCtrl payCtrl = new paymentTermAmountEmailCtrl();
        payCtrl.cId=con.id;
        payCtrl.getPaymentTermList();
        
    }
}