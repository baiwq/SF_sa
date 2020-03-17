// SAM
@isTest
public class TestPagesClass{
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
      
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u4;
      
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
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
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
      
//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,operator__c = u1.Id, amount__c = 10000,remittanceWay__c ='电汇',type__c = '投标保证金', approvalStatus__c = '审批通过');
      insert t1;   
      
//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;
    
//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
      
      commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];     
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
      cc.approvalStatus__c='审批通过'; 
      insert cc; 
       
 
      
//创建开票
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
       insert i;
      
      invoiceItem__c ii = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 1000);
      insert ii;
      goodsName__c gn = new goodsName__c(invoice__c = i.id, quantity__c = 1, amount__c = 1000);
      insert gn;
      i.pullSKJStatus__c = '同步成功';
      update i;
      
//创建履约保证金
      guaranteeLetter__c g1 = new guaranteeLetter__c(contract__c = cc.Id,amount__c =10000,type__c = '履约保证金', approvalStatus__c = '审批通过');
      insert g1;
         

      
//创建回款
      returnPool__c rp1 = new returnPool__c(account__c = a.Id, amount__c = 300000);
      insert rp1;
      
//创建回款拆分项
      returnItem__c rim1 = new returnItem__c(returnPool__c = rp1.Id, contracts__c = cc.Id,amount__c = 30000, returnUser__c = u1.id);
      insert rim1;
      
      rp1.finishedConfirm__c = true;
      update rp1;
   }
   
   static testMethod void testReturnPageContract(){
      Test.startTest(); 
      returnPool__c rp = [Select id from returnPool__c limit 1];
      User u = [Select id from User limit 1];
      Contract__c c = [Select id,deliveryTeamCenter__c from Contract__c limit 1];
      tbbaozhengjin__c tb = [Select id from tbbaozhengjin__c limit 1];

      PageReference pageRef = Page.ReturnPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',rp.id);
      
      ReturnPageController pc = new ReturnPageController();
      pc.getTBRecord();
      pc.getLYRecord();
      pc.previous();
      pc.next();
      pc.clickContract();
      pc.clickBidCost();
      pc.clickLYCost();
      
      pc.CValues1 = c.id + '@213#' + '文本✈' + u.id + ',';
      pc.commitContractRecord();
      Test.stopTest(); 
   }
    
   static testMethod void testReturnPageTB(){
       Test.startTest();
           
      returnPool__c rp = [Select id from returnPool__c limit 1];
      User u = [Select id from User limit 1];
      tbbaozhengjin__c tb = [Select id from tbbaozhengjin__c limit 1];

      PageReference pageRef = Page.ReturnPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',rp.id);
      
      ReturnPageController pc = new ReturnPageController();
      pc.getTBRecord();
      
      System.Debug('tbb.id:' + tb.id);
      pc.CValues2 = tb.id + '@132,';
      pc.commitBidRecord();
       Test.stopTest();
   }
 
   static testMethod void testReturnPageLY(){
       Test.startTest();
      returnPool__c rp = [Select id from returnPool__c limit 1];
      User u = [Select id from User limit 1];
      guaranteeLetter__c ly = [Select id from guaranteeLetter__c where type__c =:'履约保证金' limit 1];

      PageReference pageRef = Page.ReturnPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',rp.id);
      
      ReturnPageController pc = new ReturnPageController();
      pc.getTBRecord();
      pc.getLYRecord();
      
      System.Debug('lyy.id:' + ly.id);
      pc.CValues3 = ly.id + '@213,';
      
      pc.commitLYRecord();
       Test.stopTest();
   }
   
   static testMethod void testReturnToSAP1(){
       Test.startTest();
      Contract__c cc = [Select id,deliveryTeamCenter__c from Contract__c limit 1];
      returnPool__c rp = [Select id, finishedConfirm__c,finalSynchronizationStatus__c,finishPercent__c,forceStop__c,ConfirmTime__c from returnPool__c limit 1];
      User u1 = [Select id from User limit 1];
      
      returnItem__c rim2 = new returnItem__c(returnPool__c = rp.Id, contracts__c = cc.Id,amount__c = 270000, returnUser__c = u1.id);
      insert rim2;
      
      rp.finishedConfirm__c = true;
      rp.date__c = System.today();
      update rp;    

      PageReference pageRef = Page.ReturnSyncSAP;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',rp.id);
      
      returnToSAPController pc = new returnToSAPController();
      pc.Refresh();
      pc.SaveS();
       Test.stopTest();
   }
   
   static testMethod void testReturnToSAP2(){
       Test.startTest();
      Contract__c cc = [Select id,deliveryTeamCenter__c from Contract__c limit 1];
      returnPool__c rp = [Select id, finishedConfirm__c,finalSynchronizationStatus__c,finishPercent__c,forceStop__c,ConfirmTime__c from returnPool__c limit 1];
      User u1 = [Select id from User limit 1];
      
      returnItem__c rim2 = new returnItem__c(returnPool__c = rp.Id, contracts__c = cc.Id,amount__c = 270000, returnUser__c = u1.id);
      insert rim2;
      
      rp.finishedConfirm__c = true;
      rp.category__c = '投标保证金';
      rp.date__c = System.today();
      update rp;    

      PageReference pageRef = Page.ReturnSyncSAP2;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',rp.id);
      
      returnToSAPController2 pc = new returnToSAPController2();
      pc.Refresh();
      pc.SaveS();
       Test.stopTest();
   }

   static testMethod void testInvoiceToSAP(){
      Test.startTest();
      invoice__c i = [Select id,pullSKJStatus__c from invoice__c limit 1];
      i.pullSKJStatus__c = '同步成功';
      update i;
      User u = [Select id from User limit 1];
      
      PageReference pageRef = Page.InvoiceSyncSAP;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
      InvoiceToSAPController pc = new InvoiceToSAPController();
      pc.Refresh();
      Test.stopTest(); 
   }
   //测试顺丰页面
   static testMethod void testSFOrder1(){
      Test.startTest();
      invoice__c i = [Select id,postOrNot__c,kuaidi__c,receiverPhone__c,shippingAddress__c from invoice__c limit 1];
      i.postOrNot__c =true;
      i.kuaidi__c='顺丰';
      i.receiverPhone__c='18947051256';
      i.shippingAddress__c ='北京四方大厦';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.SFOrderPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
      SFOrderController  SF = new SFOrderController ();
       SF.Refresh();
      
      SF.SaveS();
      SF.setPagination('All');
     
      SF.Refresh();
       SF.SaveS();
      SF.setPagination('All');
       SF.getRecords('All');
     
      SF.Refresh();
      SF.setPagination('All');
       SF.getRecords('All');
      
      SF.Refresh();
       SF.setPagination('开票');
       SF.getRecords('开票');
     
      SF.Refresh();
      Test.stopTest();
   }
     static testMethod void testSFOrder2(){
      Test.startTest();
      invoice__c i = [Select id,postOrNot__c,kuaidi__c,receiverPhone__c,shippingAddress__c from invoice__c limit 1];
      i.postOrNot__c =true;
      i.kuaidi__c='顺丰';
      i.receiverPhone__c='18947051256';
      i.shippingAddress__c ='北京四方大厦';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.SFOrderPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
      SFOrderController  SF = new SFOrderController ();
      SF.setPagination('开票');
       SF.getRecords('开票');
      SF.Refresh();
      SF.setPagination('开票');
       SF.getRecords('开票');
      SF.Refresh();
     
      SF.setPagination('收据');
      SF.getRecords('收据');
      SF.Refresh();
         SF.SaveS();
      SF.setPagination('收据');
         SF.getRecords('收据');
      SF.Refresh();
      SF.setPagination('收据');
         SF.getRecords('收据');
      SF.Refresh();
      Test.stopTest();  
      
   }
//测试计算合同质保期页面
   static testMethod void TestCal_Warranty_Date(){
      Test.startTest();
      Cal_Warranty_Controller pc = new Cal_Warranty_Controller();
      List<Contract__c> c = [Select Name from Contract__c limit 10];
      String testContractNo = '';
      for(Contract__c ctemp:c){
         testContractNo = testContractNo + ctemp.Name + ',';
      }
      pc.conNumValue = testContractNo;
      pc.calculateWarrantyDays();
      Test.stopTest();
   }
//测试计算付款条件信息页面
    static testMethod void TestCal_StagePayment(){
        Test.startTest();
        Cal_StagePayment_Controller cc = new Cal_StagePayment_Controller();
        List<Contract__c> c = [select Name from Contract__c limit 10];
        
        String testContractNo = '';
        for(Contract__c ctemp :c){
            testContractNo = testContractNo + ctemp.name +',';
        }
        cc.conNumValue = testContractNo;
        cc.calculateStagePayment();
        Test.stopTest();
    }
   
}