@isTest
public class TestApproveContractCtrl {
 @testSetup static void CreateBaseData(){
//创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '国际业务', Manager = u1);
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u2);
      insert u3;
      String profileid1 = [select id from Profile where name ='A-合同管理员（运营）'][0].id;
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid1,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u4;
      String profileid2 = [select id from Profile where name ='A-项目管理工程师(运营)'][0].id;
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = profileid2,EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u5;


    //创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      
     //创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id,RecordTypeId=[select id from RecordType where SobjectType='Opportunity' and Name='集招/集采'].id, actualbidamount__c = 10);
      insert o1;

     //创建合同评审
       //RecordType contractreviewType = [SELECT Id from RecordType where  SobjectType= :'contractreview__c' and name =:'合同评审'];
     contractreview__c cttw = new contractreview__c(opportunity__c =o1.id,dateOfDeliveryReviewExpert__c=u2.id,sfscghfw__c='是',approvalStatus__c='审批通过',contractAmount__c=111,active__c='有效',isUpdate__c='不需要修改',applyImportantProject__c='否');
     insert cttw;
//创建合同
      //RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.reviewNumber__c  = cttw.id;
      cc.opportunity__c = o1.id;
      cc.tenderScheme__c = '1234';
      cc.ownerid = u1.id;
      cc.amount__c = 100000;
      cc.returnAmountAll__c = 1;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      cc.approvalStatus__c = '审批通过';
      insert cc;  
     
   } 

//合同管理
   static testMethod void tesContractApprove(){
      test.startTest(); 
      Contract__c i = [select id from Contract__c  limit 1];   
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveBidReviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractCtrl acrcl = new ApproveContractCtrl();
       acrcl.confirm();
       test.stopTest(); 
   }
   
    
    //合同管理
   static testMethod void tesContractApprove1(){
      test.startTest(); 
      Contract__c i = [select id from Contract__c  limit 1]; 
      i.updateghfw__c = '123123'; 
      i.sfscghfw__c = '是';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveBidReviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractCtrl acrcl = new ApproveContractCtrl();
       acrcl.confirm();
       test.stopTest(); 
   }
    
    
     //合同管理
   static testMethod void tesContractApprove2(){
      test.startTest(); 
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];      
      i.sfscghfw__c = '否';
      update i;
      Contract__c y = [select id from Contract__c  limit 1];   
      update y;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveBidReviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',y.id);
      
       ApproveContractCtrl acrcl = new ApproveContractCtrl();
       acrcl.confirm();
       test.stopTest(); 
   }
    
      //合同管理
   static testMethod void tesContractApprove3(){
      test.startTest(); 
  
      Contract__c i = [select id,ownerid,deliveryPerson__c from Contract__c  limit 1];
      i.ownerid = i.deliveryPerson__c;
      update i;
   
      PageReference pageRef = Page.ApproveBidReviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractCtrl acrcl = new ApproveContractCtrl();
       acrcl.confirm();
       test.stopTest(); 
   }
  //合同评审
    static testMethod void testContractreviewApprove(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];      
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
    
   static testMethod void testContractreviewApprove1(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];  
      i.sfscghfw__c = '是';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
    
    static testMethod void testContractreviewApprove2(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];  
      i.sfscghfw__c = '否';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
    
    static testMethod void testContractreviewApprove3(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];  
      i.reviewStatus__c = '评审进行中';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
    
    static testMethod void testContractreviewApprove4(){
      test.startTest();
      contractreview__c i = [select id from contractreview__c where active__c='有效' limit 1];  
      i.isSandbox__c = '是';
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
    
    
    static testMethod void testContractreviewApprove5(){
      test.startTest();
      contractreview__c i = [select id,dateOfDeliveryReviewExpert__c from contractreview__c where active__c='有效' limit 1];  
      i.ownerid = i.dateOfDeliveryReviewExpert__c;
      update i;
      User u = [Select id from User limit 1];
      PageReference pageRef = Page.ApproveContractreviewPage;
      Test.setCurrentPage(pageRef);  
      ApexPages.currentPage().getParameters().put('id',i.id);
      
       ApproveContractreviewCtrl actwc = new ApproveContractreviewCtrl(); 
       actwc.confirm();
       test.stopTest(); 
   }
}