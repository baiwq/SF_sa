@isTest
public class TestSFOrderController {
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
                                            MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
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
       
      RecordType ContractRecordType2 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
      Contract__c cc2 = new Contract__c(); //无合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.tenderScheme__c = '1234日';
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
      invoice__c i= new invoice__c(invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',endSF__c=false,
                                   applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,kuaidi__c='顺丰',
                                   invoiceCompany__c='北京四方继保自动化股份有限公司' ,postOrNot__c =true,shippingAddress__c = '北京',
                                   receiver__c = '张三', receiverPhone__c ='18947051526',receiverCompany__c='123');
       insert i;
      invoice__c i2= new invoice__c(invoiceType__c = '专用发票',orderCompany__c = 'B公司',applyBy__c = u1.Id,
                                    applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',
                                    kuaidi__c='顺丰',endSF__c=false,receiverPhone__c ='18947051526',receiverCompany__c='123',
                                   invoiceCompany__c='北京四方继保工程技术有限公司' ,postOrNot__c =true ,receiver__c = '张三');
       insert i2;
        i2.approvalStatus__c ='审批通过';
        update i2;
      invoiceItem__c ii = new invoiceItem__c(contract__c = cc.id, invoice__c = i.id, invoiceAmount__c = 1000);
      insert ii;
      goodsName__c gn = new goodsName__c(invoice__c = i.id, quantity__c = 1, amount__c = 1000);
      insert gn;
        i.approvalStatus__c ='审批通过';
      i.pullSKJStatus__c = '同步成功';
      update i;
//创建收据
	receipt__c re = new receipt__c(invoiceCompany__c='CC01 北京四方继保自动化股份有限公司',applyBy__c =u1.id,postOrNotSF__c =true,
                                  receiverSF__c ='张三',receiverPhoneSF__c ='18947051526',receiverCompany__c ='123',
                                  shippingAddressSF__c ='北京');
        insert re;
        re.approvalStatus__c ='审批通过';
        update re;
   }
    static testMethod void testSFOrder1(){
      invoice__c i = [Select id,postOrNot__c,kuaidi__c,receiverPhone__c,shippingAddress__c from invoice__c where invoiceCompanyCode__c ='CC03' limit 1];
      
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.SFOrderPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
      SFOrderController  SF = new SFOrderController ();
       SF.setPagination('invoiceCC03');
       SF.getRecords('invoiceCC03');
      SF.Refresh();
        //SF.Previous();
        //SF.Next();
        SF.SaveS();
   }
     static testMethod void testSFOrder2(){
      invoice__c i = [Select id,postOrNot__c,kuaidi__c,receiverPhone__c,shippingAddress__c from invoice__c limit 1];
      receipt__c re = [select id from receipt__c limit 1];
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.SFOrderPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
      SFOrderController  SF = new SFOrderController ();
      SF.setPagination('invoiceCC01');
       SF.getRecords('invoiceCC01');
      SF.Refresh();
      SF.setPagination('receive');
       SF.getRecords('receive');
      SF.Refresh();
        
      
   }
}