// SAM
@isTest
public with sharing class TestFuncClass{
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
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
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
      
//创建Code
      codeRule__c  cr1 = new codeRule__c(objectName__c = 'd', enabledOrNot__c = true, picklistValue__c = 'ds', picklistName__c = 'dsaf');
      insert cr1;
      codeRule__c  cr2 = new codeRule__c(objectName__c = 'd', enabledOrNot__c = true, picklistValue__c = 'ds3', picklistName__c = 'd3saf');
      insert cr2;
   }
    
   static testMethod void testFuncPool(){
      Test.startTest(); 
      User u = [Select id from User where UserName = :'sunx3@tranzvision.sifang.test' limit 1];
      Account a = [Select id from Account where Name =:'A1' limit 1];
      Contract__c c =[Select id from Contract__c where updateCode__c =: '1234' limit 1];
      FuncPools FP = new FuncPools();
      FP.getSalesNoContract(u.id);
      FP.getContractInfo(a.id);
      FP.getEmails('[sam.sun@tranzvision.com]');
      FP.digitUppercase('100.10');
      FP.getCodeValues('d');  
      List<paymentTerm__c> LTList = [Select percentage__c from paymentTerm__c where contract__c = :c.id];
      LTList[0].percentage__c = 10;
      LTList[1].percentage__c = 20;
      LTList[2].percentage__c = 20;
      LTList[3].percentage__c = 10;
      LTList[4].percentage__c = 30;
      LTList[5].percentage__c = 10;
      update LTList;
      FP.SyncPayment(c.id,40000);  
      FP.SyncPayment(c.id,40000); 
      FP.SyncPayment(c.id,20000); 
      Test.stopTest(); 
   } 
/**  
   static testMethod void testFileServer(){
      FileServerToken.TokenServiceSoap TT = new FileServerToken.TokenServiceSoap();
      String ds = TT.GetToken('SOSP','SOSPabcd-1234');
   }
**/
   

   
   
   

}