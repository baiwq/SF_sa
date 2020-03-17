// SAM
@isTest
public with sharing class TestLogicReturnClass{
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

//创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;

      Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a1b;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
      insert o1;

        
//创建合同
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.updateCode__c = '1234';
      //cc.opportunity__c = o1.id;
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
      cc.SalesTerritoryManager__c  = u2.Id; 
      insert cc;
      //创建重点项目
      majorProjects__c major = new majorProjects__c(cpywdyfzr__c=u1.Id,sqjl__c=u1.Id);
      insert major;
      //创建附件  
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc.Id);
      insert ac;
      attachment__c ac11 = new attachment__c(isValid__c = '有效',type__c = '供货范围清单',contract__c = cc.Id);
      insert ac11;
       
      RecordType ContractRecordType2 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
      Contract__c cc2 = new Contract__c(); //无合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.updateCode__c = '1234日';
      //cc2.opportunity__c = o1.id;
      cc2.RecordTypeId = ContractRecordType2.id;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.salesDepartment__c = '华东区';
      cc2.salesProvince__c = '江苏-电厂';
      cc2.deliveryTeamDepartment__c   = '华东区';
      cc2.deliveryTeamProvince__c = '浙江';
      cc2.deliveryTeamCenter__c = '销售中心';
      cc2.approvalStatus__c='审批通过'; 
      cc2.SalesTerritoryManager__c  = u2.Id;  
      insert cc2;

      attachment__c ac1 = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = cc2.Id);
      insert ac1;
       
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
//创建工程屏柜拆解
      Dismantlecabinet__c disl = new Dismantlecabinet__c(contract__c=cc.id, customproject__c='是', number__c=8, productstate__c='装置已生产，已组屏', Disassemblenumber__c=1, applicationreason__c='合同部分取消', arrivalgoods__c='是',
                                                  Reasonphrase__c='test', costcenter__c='asfasf', PM__c=u6.id);
      insert disl;

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

   static testMethod void testContract1(){
       Test.startTest();
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';

      List<User> uList = [Select id, profileid from User where profileid = :Userinfo.getProfileId() and isActive = true];
      System.debug('uList:' + uList);
      c.signedby__c= uList[3].id;
      c.deliveryPerson__c = uList[0].id;
      c.accountManager__c = uList[5].id;
      c.OwnerId = uList[5].id;
      c.amount__c = 1234;
      update c;

      c.approvalStatus__c = '审批通过';
      update c;

      Contract__c c2= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234日' limit 1];
      c2.approvalStatus__c = '审批通过';
      c2.performanceOrNot__c = true;
      update c2;
       Test.stopTest();
   }

   static testMethod void testContractInclude(){
       Test.startTest();
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234日' limit 1];
      RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      attachment__c ac = new attachment__c(isValid__c = '有效',type__c = '合同文本',contract__c = c.Id,attachmentURL__c = 'aaa');
      insert ac;
      c.RecordTypeId = ContractRecordType1.id;
      c.approvalStatus__c = '审批通过';
      c.performanceOrNot__c = true;  
      update c;
       Test.stopTest();
   }

   static testMethod void testContractChange(){
       Test.startTest();
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      Contract__c c= [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c limit 1];
      c.approvalStatus__c='审批通过';
      update c; 
      contractchange__c cc= new contractchange__c();
      cc.contract__c=c.id;
      cc.applyBy__c='客户';
      cc.ownerId = u1.id;   
      cc.ApproveComponent__c='123123';
      cc.notCompletelySchedulingExplain__c='测试';
      cc.RecordTypeId = [Select id from RecordType where sobjectType = 'contractchange__c' and Name = '合同金额变更'].id;
      cc.scopeOfSupplyChangeIsExcited__c ='否';
       cc.isSandbox__c = '是';
       insert cc;
      
      attachment__c attach2 = new attachment__c(contractChange__c = cc.id, type__c = '供货范围清单');
      insert attach2;
      
      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Submitting request for approval.');
      req1.setObjectId(cc.id);
      req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
      req1.setSubmitterId(u1.id); 
      
      req1.setSkipEntryCriteria(true);
      Approval.ProcessResult result = Approval.process(req1);
    
      cc.totalDischarge__c = true;
      cc.approvalStatus__c = '审批通过';
      cc.notifyTo__c = '毕海霞[bihaixia@sf-auto.com]';
      update cc;
       Test.stopTest();
   }

 
   static testMethod void testInvoice(){
      Test.startTest();
      Account a = [Select id from Account where Name = :'A1' limit 1];
      Account a1b = [Select id from Account where Name = :'A1b' limit 1];
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User u2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Contract__c cc = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
      insert i;

      try{i.applyBy__c = u2.id; update i;}catch(exception e){}
      try{i.approvalStatus__c = '提交待审批'; update i;}catch(exception e){}
      try{i.approvalStatus__c = '审批通过'; update i;}catch(exception e){}
      try{i.account__c = a1b.id; update i;}catch(exception e){}

      i.approvalStatus__c = '草稿';
      i.account__c = a.id;
      update i;

      invoiceItem__c ii1 = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 2000);
      insert ii1;

      goodsName__c gn = new goodsName__c(invoice__c = i.id, quantity__c = 1, amount__c = 2000);
      insert gn;

      i.approvalStatus__c = '审批通过';
      update i;

      try{
         ii1.invoiceAmount__c = 100;
         update ii1;
      }catch(exception e){

      }
      Test.stopTest();

   }
   static testMethod void testInvoice_1(){
      Test.startTest();
      invoice__c i = [Select id, invoiceStatus__c, invoiceType__c, orderCompany__c, applyBy__c, applyDate__c, account__c, approvalStatus__c from invoice__c limit 1];
      invoiceItem__c ii1 = [Select id, invoiceStatus__c, invoice__c, invoiceAmount__c from invoiceItem__c limit 1];
      Contract__c cc = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      i.approvalStatus__c = '审批通过';
      update i;
      
      invoiceItem__c ii2 = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 1000);
      insert ii2;
      delete ii2;

      try{
         ii1.invoiceAmount__c = 100;
         update ii1;
      }catch(exception e){

      }

      try{
         delete ii1;
      }catch(exception e){

      }
      Test.stopTest();

   }

  
   static testMethod void testSchedule(){
   //排产
   	Test.startTest();
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
      update c;

      paymentTerm__c pt = [select id, percentage__c from paymentTerm__c where contract__c = :c.id limit 1];
      pt.percentage__c = 100;
      update pt;

      attachment__c attach1 = new attachment__c(contract__c = c.id, type__c = '合同文本');
      insert attach1;
      attachment__c attach2 = new attachment__c(contract__c = c.id, type__c = '供货范围清单');
      insert attach2;
      scheduling__c s = new scheduling__c(contract__c = c.id , totalDischarge__c = true);
      insert s;


      s.approvalStatus__c = '审批通过';
      s.approvalDate__c = System.now();
      update s;
       Test.stopTest();
   }

   static testMethod void testAttachment(){
       Test.startTest();
      User u1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      ProjectTask__c pt = new ProjectTask__c();
       pt.contract__c = c.id;
       pt.domainUser__c = 'fuxiao';
       pt.projectManagementEngineer__c = '付肖';
       insert pt;
      contractchange__c cc= new contractchange__c();
      cc.contract__c=c.id;
      cc.applyBy__c='客户';
      cc.ownerId = u1.id;   
      cc.notCompletelySchedulingExplain__c='测试';
      cc.RecordTypeId = [Select id from RecordType where sobjectType = 'contractchange__c' and Name = '供货范围变更'].id;
      insert cc;
      attachment__c attach2 = new attachment__c(contract__c = c.id, type__c = '供货范围清单');
      insert attach2;
      attach2.isValid__c = '有效';
      attach2.URLAddress__c = 'dsa';
      attach2.attachmentURL__c = 'ds';
      update attach2;
       Test.stopTest();
   }
   
   static testMethod void testShipping(){
   //发货
		Test.startTest();
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      c.approvalStatus__c = '审批通过';
      update c;

      shipping__c sp = new shipping__c(contracts__c = c.id);
      insert sp;
      
      shipping__c sp2 = new shipping__c(contracts__c = c.id);
      try{
          insert sp2;
      }catch(exception e){
      }
      
      sp.notifyTo__c = '安凯[ankai@sf-auto.com]';
      update sp;
       Test.stopTest();
   }

   static testMethod void testReceipt(){
      Test.startTest();
      Account a = [Select id from Account limit 1];
      User u = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Contract__c c = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      receipt__c r = [Select id, receiptAccount__c, payeeUser__c, approvalStatus__c,applyBy__c from receipt__c limit 1];

      receiptItem__c ri = new receiptItem__c();
      ri.invoiceReceipt__c = r.id;
      ri.contract__c = c.id;
      ri.receiptAmount__c = 10;
      insert ri;
      
      ri.receiptAmount__c = 100;
      update ri;

      r.applyBy__c = u.id;
      r.approvalStatus__c = '提交待审批';
      update r;
      r.approvalStatus__c = '审批通过';
      update r;
      
      receiptItem__c ri2 = new receiptItem__c();
      ri2.invoiceReceipt__c = r.id;
      ri2.contract__c = c.id;
      ri2.receiptAmount__c = 10;
      insert ri2;
      
      ri2.receiptAmount__c = 200;
      update ri2;

      delete ri;
      Test.stopTest();
   }

   static testMethod void testGuarantee(){
       Test.startTest();
      guaranteeLetter__c gl = [Select id from guaranteeLetter__c  where type__c =:'履约保证金' limit 1];
      guaranteeLetter__c g2 = [Select id from guaranteeLetter__c  where type__c =:'履约保函' limit 1];
      gl.type__c = '履约保证金';
      gl.amount__c = 1000;
      update gl;
      g2.type__c = '履约保证金';
      g2.amount__c = 1000;
      update g2;
      try{
         delete g2;
      }catch(Exception e){
      }
       Test.stopTest();
   }
   
   static testMethod void testPES(){
       Test.startTest();
      User u = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      Plan__c p4= new Plan__c();
      p4.OwnerId = u.id;
      p4.year__c = '2017';
      p4.departmentName__c = '销售中心';
      insert p4;
      
      monthlyPlan__c mp = new monthlyPlan__c(plan__c = p4.id);
      insert mp;
      
      PlanAndExeStatus__c pes = new PlanAndExeStatus__c(monthplan__c = mp.id);
      insert pes;
      delete pes;
       Test.stopTest();
   }
  
   static testMethod void testLocalDateController(){
       Test.startTest();
      localDateFormatController local = new localDateFormatController();
      local.date_time=system.now();
      local.defined_format='yyyy-MM-dd HH:mm:ss';
      local.getFormattedDatetime();
       Test.stopTest();
   }
   
   static testMethod void testPaymentSendEmail(){
       Test.startTest();
      Contract__c cc = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      statusTracking__c st = [Select id, advanceActualFinish__c, debugActualFinish__c, debugFinishActualFinish__c, sendActualFinish__c, qualityActualFinish__c from statusTracking__c where contract__c = :cc.id];
      st.advanceActualFinish__c = System.today().addDays(-100);
      st.debugActualFinish__c = System.today().addDays(-100);
      st.debugFinishActualFinish__c = System.today().addDays(-100);
      st.sendActualFinish__c = System.today().addDays(-100);
      st.qualityActualFinish__c = System.today().addDays(-100);
      update st;
      List<paymentTerm__c> ptList = [select id, percentage__c from paymentTerm__c where contract__c = :cc.id];
      for(paymentTerm__c pt:ptList){
         pt.percentage__c = 15;
      }
      update ptList;
      String testSchedulePaymentSendEmail = System.schedule('TestSchedulePaymentSendEmail','0 0 0 3 9 ? 2020',new SchedulePaymentSendEmail());
      Test.stopTest();
   }
}