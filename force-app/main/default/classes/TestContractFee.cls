@isTest
/***
*测试ContractFee
*创建人：付肖
*创建时间：2020-1-8
***/
public class TestContractFee {
@testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u1);
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u2);
      insert u3;
      String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u3);
      insert u4;
      String profileid2 = [select id from Profile where name ='A-项目管理工程师(运营)'][0].id;
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', Manager = u3);
      insert u5;

//创建年度计划   
      List<Plan__c> pList = new List<Plan__c>();
      Plan__c p1= new Plan__c();
      p1.OwnerId = u1.id;
      p1.year__c = '2020';
      p1.departmentName__c = '个人';
      pList.add(p1);
  
      insert pList;

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
                                           MainIndustrySales__c = '发电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(projectOwner__c =  a1b.Id,Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
    
    
       contractFee__c cfeec = new contractFee__c(Account__c = a.id,Field10__c =11.00, other__c=11.00,OwnerId = u1.id,InitialState__c='草稿',approveState__c='审批通过',opportunityName__c=o1.id,bidtype__c='集招',accountType__c='电网',Projecttype__c='EPC',Field1__c='是',contractReceive__c=System.today(),estimateDeliverDate__c=System.today(),To90time__c=System.today(),receivetim__c=System.today(),agency__c='212',agreementNumber__c='QWE2222',agencyPayment__c='213',specifyAmount__c=123,paymentPercentage__c='2312');
       insert cfeec;
    
       
       ExpenseCustomerInfo__c  ec = new ExpenseCustomerInfo__c(contractFee__c =cfeec.id,Account__c = a.id);
       insert ec;
    
       RecordType cfeecType = [SELECT Id from RecordType where  SobjectType= :'contractFee__c' and name =:'节日活动'];
       cfeec.RecordTypeId =  cfeecType.id;
       cfeec.InitialState__c = '提交待审批';
       update cfeec;
        
       ExpenseCustomerInfo__c  ec1 = new ExpenseCustomerInfo__c(contractFee__c =cfeec.id,Account__c = a1b.Id);
       insert ec1;
    
       cfeec.InitialState__c = '初评通过';
       update cfeec;
       update ec1;
     
       cfeec.opportunityName__c = null;
       update cfeec;
     
       ExpenseCustomerInfo__c  ec11 = new ExpenseCustomerInfo__c(contractFee__c =cfeec.id,Account__c = a.id);
       insert ec11;
   } 

//合同评审
    static testMethod void testContractreviewApprove(){
      test.startTest();
     
       test.stopTest(); 
   }

    
    static testMethod void test234(){
      test.startTest();
        contractFee__c cf =[select id,name,OwnerCode__c from contractFee__c where approveState__c=:'审批通过' limit 1];
        User u1=[select id from User where LastName = '测试经理1' limit 1];
        //getServiceContractCost  gs1 = new getServiceContractCost();
        //gs1.getContractCostList('123','123');
        getServiceContractCost.getContractCostList(cf.name, cf.OwnerCode__c);
        getServiceContractCost.getContractCostInfo(cf.name);
        //getContractCostList.
       test.stopTest(); 
   }
}