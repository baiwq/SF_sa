// SAM
@isTest
public with sharing class TestIncludePageClass{
   @testSetup static void CreateBaseData(){
//创建用户
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
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.updateCode__c = '1234';
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
      cc.approvalStatus__c='审批通过';
      insert cc;

      RecordType ContractRecordType2 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
      Contract__c cc2 = new Contract__c(); //无合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.updateCode__c = '1234日';
      cc2.opportunity__c = o1.id;
      cc2.RecordTypeId = ContractRecordType2.id;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.salesDepartment__c = '华东区';
      cc2.salesProvince__c = '江苏-电厂';
      cc2.deliveryTeamDepartment__c   = '东北区';
      cc2.deliveryTeamProvince__c = '黑龙江';
      cc2.deliveryTeamCenter__c = '销售中心';
      cc2.approvalStatus__c='审批通过'; 
      insert cc2;

      System.debug('dsad:'+ cc.id);
      try{
         List<Contract__c> CCList = new List<Contract__c>();
         for(Integer i=0;i<102; i++){
            Contract__c cctemp = new Contract__c();
            cctemp.account__c= a.id;
            cctemp.signedby__c= u1.id;
            cctemp.deliveryPerson__c = u2.id;
            cctemp.accountManager__c = u3.id;
            cctemp.contractReceptDate__c = date.newInstance(2016, 2, 17);
            CCList.add(cctemp);
         }
         insert CCList;

      }catch(Exception e){
         System.debug('(((((((((((((((((((');
      }

//创建开票
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
      insert i;
      invoiceItem__c ii = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 1000);
      insert ii;
      goodsName__c gn = new goodsName__c(invoice__c = i.id, quantity__c = 1, amount__c = 1000);
      insert gn;

//创建履约保证金
      guaranteeLetter__c g1 = new guaranteeLetter__c(contract__c = cc.Id,amount__c =10000,type__c = '履约保证金',regionalDirector__c=u1.id, operator__c =u1.id);
      insert g1;
      guaranteeLetter__c g2 = new guaranteeLetter__c(contract__c = cc.Id,amount__c =10000,type__c = '履约保函',regionalDirector__c=u1.id, operator__c =u1.id);
      insert g2;
      g2.amount__c = 15000;
      update g2;

//创建收据
      receipt__c r = new receipt__c(receiptAccount__c = a.id, approvalStatus__c = '草稿',payeeUser__c = u2.id, applyBy__c =u4.id);
      insert r;
   }
   
   static testMethod void testContract(){
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      PageReference thePage = Page.ContractLightningPage;
      thePage.getParameters().put('id',c.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController aaa = new ApexPages.standardController(c);
      ContractLightningBar ac = new ContractLightningBar(aaa);
   }
   
   static testMethod void testContractInclude(){
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234日' limit 1];
      
      PageReference thePage = Page.ContractInclude;
      thePage.getParameters().put('id',c.id);
      test.starttest();
      Test.setCurrentPage(thePage);
      ApexPages.StandardController aaa = new ApexPages.standardController(c);
      ContractValuecontroller ac = new ContractValuecontroller(aaa);
      test.stoptest();
   }
   
   static testMethod void testInvoicePrintSF(){
      invoice__c i = [Select id from invoice__c limit 1];
      PageReference thePage = Page.PrintSF;
      Test.setCurrentPage(thePage);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      PrintSF pc = new PrintSF();
   }
   
   static testMethod void testInvoicePrintEMS(){
      invoice__c i = [Select id from invoice__c limit 1];
      PageReference thePage = Page.PrintEMS;
      Test.setCurrentPage(thePage);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      PrintEMS pc = new PrintEMS();
   }
   
   static testMethod void testTB(){
      tbbaozhengjin__c t1 = [Select id from tbbaozhengjin__c limit 1];
      PageReference thePage = Page.tbbaozhengjinLightningPage;
      thePage.getParameters().put('id',t1.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(t1);
      tbbaozhengjinLightningBar bclb = new tbbaozhengjinLightningBar(sc);
   }
   
   static testMethod void testReceiptPrint(){
      receipt__c r = [Select id, receiptAccount__c, payeeUser__c, approvalStatus__c,applyBy__c from receipt__c limit 1];

      PageReference thePage = Page.PrintReceipt;
      thePage.getParameters().put('id',r.Id);
      test.startTest();
      Test.setCurrentPage(thePage);
      ApexPages.StandardController rr = new ApexPages.standardController(r);
      PrintReceiptcontroller prc = new PrintReceiptcontroller(rr);
      test.stopTest();
   }
   
   static testMethod void testPlan_Value(){
      Plan__c r1 = [Select id from Plan__c limit 1];
      PageReference thePage = Page.PlanInclude;
      thePage.getParameters().put('id',r1.id);
      test.startTest();
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(r1);
      PlanValuecontroller eblb = new PlanValuecontroller(sc);
      test.stopTest();
   }
   
   static testMethod void testContractChange(){
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c limit 1];
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];

      contractchange__c cc= new contractchange__c();
      cc.contract__c=c.id;
      cc.applyBy__c='客户';
      cc.notCompletelySchedulingExplain__c='测试';
      cc.SalesIndustoryManager__c = u1.id;
      cc.LastUpdateIndustryChange__c = u1.id;
      insert cc;
      
      PageReference thePage = Page.contractchangeLightningPage;
      thePage.getParameters().put('id',cc.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(cc);
      contractchangeLightningBar cclb = new contractchangeLightningBar(sc);
   }
   
   static testMethod void testInvoice(){
      Account a = [Select id from Account where Name = :'A1' limit 1];
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
      insert i;

      PageReference thePage = Page.BillandreceiptLightningPage;
      thePage.getParameters().put('id',i.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController invo = new ApexPages.standardController(i);
      BillandreceiptLightningBar inco = new BillandreceiptLightningBar(invo);

   }
// static testMethod void testSchedule(){
//    Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
//    c.approvalStatus__c = '审批通过';
//    c.Reviewer__c ='0050I000008WE7r';
//    c.SalesTerritoryManager__c ='0050I000008WE7r';
//    c.cpywdyfzr__c ='0050I000008WE7r';
//    update c;
//    
//    paymentTerm__c pt = [Select id, percentage__c from paymentTerm__c where contract__c =:c.id limit 1];
//    pt.percentage__c = 100;
//    update pt;
//
//    attachment__c attach1 = new attachment__c(contract__c = c.id, type__c = '合同文本');
//    insert attach1;
//    attachment__c attach2 = new attachment__c(contract__c = c.id, type__c = '供货范围清单');
//    insert attach2;
//    scheduling__c s = new scheduling__c(contract__c = c.id , totalDischarge__c = true);
//    insert s;
//
//    s.approvalStatus__c = '审批通过';
//    s.approvalDate__c = System.now();
//    update s;
//
//    PageReference thePage = Page.schedulingLightningPage;
//    thePage.getParameters().put('id',s.Id);
//    Test.setCurrentPage(thePage);
//    ApexPages.StandardController sc = new ApexPages.StandardController(s);
//    schedulingLightningBar sb = new schedulingLightningBar(sc);
// }
// 
   static testMethod void testShipping(){
   //发货

      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
      update c;

      shipping__c sp = new shipping__c(contracts__c = c.id);
      insert sp;
      PageReference thePage = Page.ShippingLightningPage;
      thePage.getParameters().put('id',sp.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.StandardController(sp);
      ShippingLightningBar sb = new ShippingLightningBar(sc);
   }
   
    static testMethod void testAccountBar(){
      Account a = [Select id from Account limit 1];
      PageReference thePage = Page.AccountLightningPage;
      thePage.getParameters().put('id',a.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController aaa = new ApexPages.standardController(a);
      AccountLightningBar ac = new AccountLightningBar(aaa);
   }

   static testMethod void testBidCostBar(){
      Account a = [Select id from Account limit 1];
      Opportunity o = [Select id from Opportunity limit 1];
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];

      bidCost__c bc = new bidCost__c(opportunity__c = o.id,RegionalManager__c =u1.id,account__c = a.id, costCenter__c='12324', remittanceMethod__c='电汇');
      insert bc;
      PageReference thePage = Page.bidCostLightningPage;
      thePage.getParameters().put('id',bc.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(bc);
      bidCostLightningBar bclb = new bidCostLightningBar(sc);
   }

   static testMethod void testBidReviewBar(){
      Opportunity o = [Select id from Opportunity limit 1];
      bidReview__c br= new bidReview__c(opportunity__c = o.id,MainProductGroup__c ='直流输电及电力电子业务单元-直流输电及电力电子产品',MainIndustrySales__c ='输变电业务',ProductGroup__c ='直流输电及电力电子业务单元-直流输电及电力电子产品');
      insert br;
      PageReference thePage = Page.bidReviewLightningPage;
      thePage.getParameters().put('id',br.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(br);
      bidReviewLightningBar brlb = new bidReviewLightningBar(sc);
   }

   static testMethod void testNotCommon(){
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      notCommonOutsourcing__c nc = new notCommonOutsourcing__c(contract__c = c.id, type__c='销售中心',occurrenceStage__c='设计阶段', peymentAmount__c='2个月');
      insert nc;
      PageReference thePage = Page.notCommonOutsourcingLightningPage;
      thePage.getParameters().put('id',nc.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(nc);
      notCommonOutsourcingLightningBar nclb = new notCommonOutsourcingLightningBar(sc);
   }

   static testMethod void testSalesLeadBar(){
      salesLeads__c sa = [Select id, Name, approvalStatus__c from salesLeads__c limit 1];
      PageReference thePage = Page.LeadLightningPage;
      thePage.getParameters().put('id',sa.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController l = new ApexPages.standardController(sa);
      LeadLightningBar lc = new LeadLightningBar(l);
   }

   static testMethod void testLeadBar(){
      Lead l= [Select id from Lead limit 1];
      PageReference thePage = Page.PotentialAccountLightningPage;
      thePage.getParameters().put('id',l.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController lasc = new ApexPages.standardController(l);
      potentialAccountLightningBar palc = new potentialAccountLightningBar(lasc);
   }
   
   static testMethod void testMonthlyPlanBar(){
      monthlyPlan__c mp= [Select id from monthlyPlan__c limit 1];
      PageReference thePage = Page.MonthPlanLightningPage;
      thePage.getParameters().put('id',mp.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController lasc = new ApexPages.standardController(mp);
      MonthPlanLightningBar palc = new MonthPlanLightningBar(lasc);
   }
   // static testMethod void testQuatation(){
//    Opportunity o = [Select id from Opportunity limit 1];
//    //创建投标评审
//    bidReview__c  br = new bidReview__c(opportunity__c =o.id,approvalStatus__c='审批通过',MainProductGroup__c ='直流输电及电力电子业务单元-直流输电及电力电子产品',MainIndustrySales__c ='输变电业务',ProductGroup__c ='直流输电及电力电子业务单元-直流输电及电力电子产品');
//    insert br;
//    quatation__c q = new quatation__c(opportunity__c = o.id,bidReview__c=br.Id,RecordTypeId=[select id from RecordType where SobjectType='quatation__c' and DeveloperName ='RecordType'].id);
//    insert q;
//    PageReference thePage = Page.QuatationLightningPage;
//    thePage.getParameters().put('id',q.id);
//    Test.setCurrentPage(thePage);
//    ApexPages.StandardController qas = new ApexPages.standardController(q);
//    QuatationLightningBar qlbc = new QuatationLightningBar(qas);
// }

   static testMethod void testGuarantee(){
      guaranteeLetter__c gl = [Select id from guaranteeLetter__c  where type__c =:'履约保证金' limit 1];
      PageReference thePage = Page.guaranteeLetterLightningPage;
      thePage.getParameters().put('id',gl.Id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(gl);
      guaranteeLetterLightningBar gllb = new guaranteeLetterLightningBar(sc);
   }

   static testMethod void testOpportunityBar(){
      Opportunity o =[Select id, name, StageName from Opportunity limit 1];
      PageReference thePage = Page.OppLightningPage;
      thePage.getParameters().put('id', o.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController opp = new ApexPages.standardController(o);
      OppLightningBar oppController = new OppLightningBar(opp);
   }
   
   static testMethod void testExpenseOfBidApplyBar(){
      Opportunity o =[Select id, name, StageName from Opportunity limit 1];
      expenseOfBidApply__c eb = new expenseOfBidApply__c(opportunity__c = o.id);
      insert eb;
      
      PageReference thePage = Page.expenseOfBidApplyPage;
      thePage.getParameters().put('id',eb.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(eb);
      expenseOfBidApplyLightningBar eblb = new expenseOfBidApplyLightningBar(sc);
   }
   
   static testMethod void testReceipt(){
      receipt__c r = [Select id, receiptAccount__c, payeeUser__c, approvalStatus__c,applyBy__c from receipt__c limit 1];
      PageReference thePage = Page.ReceiptLightningPage;
      thePage.getParameters().put('id',r.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(r);
      ReceiptLightningBar rb = new ReceiptLightningBar(sc);
   }
   
   static testMethod void testRelationshipPlan(){
      relationshipPlan__c r1 = new relationshipPlan__c();
      r1.currentRelationship__c ='优';
      r1.orgRelationship__c = 'A';
      r1.improveTo__c = '铁杆儿';
      r1.improveStatus__c = '确认完成';
      insert r1;

      PageReference thePage = Page.relationshipLightningPage;
      thePage.getParameters().put('id',r1.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(r1);
      relationshipLightningBar eblb = new relationshipLightningBar(sc);
   }

}