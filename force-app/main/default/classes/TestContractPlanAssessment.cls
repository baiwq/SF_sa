@isTest()
public class TestContractPlanAssessment{
    @testSetup static void CreateData(){

//创建用户
       
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test', 
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心', contractAdmin__c = Userinfo.getUserId());
      insert u1;

      

//创建年度计划
      Plan__c p1= new Plan__c();
      p1.OwnerId = u1.id;
      p1.year__c = String.valueof(system.now().Year());
      p1.departmentName__c = '个人';
      insert p1;
   

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
      



     
      
        contractFee__c  fee= new contractFee__c(OwnerId=u1.id,opportunityName__c=o1.id, bidtype__c='集招',Projecttype__c='备品备件',accountType__c='电网');
        insert fee;
        fee.bidtype__c = '省招';
        update fee;
        contractFee__c  fee2= new contractFee__c(OwnerId=u1.id,opportunityName__c=o1.id, bidtype__c='集招',Projecttype__c='备品备件',accountType__c='电网');
        insert fee2;
        
    }
    static testMethod void TestinsertFee(){
        contractFee__c s = [select id from contractFee__c where bidtype__c ='集招' limit 1];
        s.bidtype__c = '省招';
        update s;
    }
    
   
}