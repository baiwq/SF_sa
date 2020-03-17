/* 
    功能：Top项目测试类
*/
@isTest
public class TestTopOpportunityClass{
    static testMethod void TestPage(){
            User u1 = new User(LastName = '测试用户名称',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                           email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                           ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
            insert u1;
            User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                           email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                           ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id , contractAdmin__c = Userinfo.getUserId());
            insert u2;
        
            User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                           email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                           ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u2.id , contractAdmin__c = Userinfo.getUserId());
            insert u3;
            Account a = new Account(Name = '测试客户名称',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
            insert a;
            salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                                expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                                projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                                projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',
                                                MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
            insert s1;
       

           Contact c1 = new Contact(LastName ='sam', AccountId = a.Id,maturity__c='铁杆儿',decisionRole__c='审批者',buyStyle__c='技术',Department='IT',Phone='110202403',Email='143@qq.com',workStatus__c='在职',gender__c='男',Title='经理');
            insert c1;
           Contact c2 = new Contact(LastName='东飞',AccountId = a.Id,maturity__c='铁杆儿',decisionRole__c='审批者',buyStyle__c='技术',Department='IT',Phone='110202033',Email='113@qq.com',workStatus__c='在职',gender__c='男',Title='经理',ReportsToId=c1.id);
            insert c2;
           Contact c3 = new Contact(LastName = '何鸿',AccountId = a.Id,maturity__c='铁杆儿',decisionRole__c='审批者',buyStyle__c='技术',Department='IT',Phone='110240203',Email='323@qq.com',workStatus__c='在职',gender__c='男',Title='经理',ReportsToId=c1.id);
            insert c3;  
           Contact c4 = new Contact(LastName = '艳新',AccountId = a.Id,maturity__c='铁杆儿',decisionRole__c='审批者',buyStyle__c='技术',Department='IT',Phone='110202032',Email='455@qq.com',workStatus__c='在职',gender__c='男',Title='职员',ReportsToId=c2.id);
            insert c4;
           Contact c5 = new Contact(LastName = '杨明',AccountId = a.Id,maturity__c='铁杆儿',decisionRole__c='审批者',buyStyle__c='技术',Department='IT',Phone='110202031',Email='333@qq.com',workStatus__c='在职',gender__c='男',Title='职员',ReportsToId=c3.id);
            insert c5;
       
          opportunity o1 = new opportunity(MainProductGroup__c='发电及用电业务单元-电站事业部',MainIndustrySales__c ='输变电业务',ProductGroup__c ='发电及用电业务单元-电站事业部',Name = '测试机会名称', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, projectOwner__c = a.id,actualbidamount__c = 10,expectBidDate__c=Date.today().addDays(7),Probability = 20);
          insert o1;

          OpportunityTeamMember otm = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
          insert otm;

          bidReview__c brc = new bidReview__c(MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,departmentmanager__c = u1.Id,SalesIndustoryManager__c = u1.Id,Opportunity__c =o1.id,approvalStatus__c ='审批通过');
          insert brc;        
        
        sellPointMatching__c spm = new sellPointMatching__c(opportunity__c = o1.id,sellingPoint__c='价格',matchPercentage__c='高',buyingPoint__c='aa',valuePoint__c='aa');
        insert spm;        
        
        businessCompeteStatus__c bcs = new businessCompeteStatus__c(opportunity__c = o1.id);
        insert bcs;
        
        technologyCompeteStatus__c tcs = new technologyCompeteStatus__c(opportunity__c = o1.id);
        insert tcs;
        
        actionPlan__c apc = new actionPlan__c(opportunity__c = o1.id);
        insert apc;
        
        negotationStrategy__c nsc = new negotationStrategy__c(opportunity__c = o1.id);
        insert nsc;
        
        businessNegotiationStrategy__c bns = new businessNegotiationStrategy__c(opportunity__c = o1.id);
        insert bns;
        
        techniqueNegotiationStrategy__c tns = new techniqueNegotiationStrategy__c(opportunity__c = o1.id);
        insert tns;      
        //七张表
        PageReference thePage = Page.TopSevenTable;
        thePage.getParameters().put('id',o1.id);
        Test.setCurrentPage(thePage);
        ApexPages.StandardController aaa = new ApexPages.standardController(o1);        
        TopOpportunityCtrl ac = new TopOpportunityCtrl(aaa);
        ac.row1 = 1;
        ac.row2 = 1;
        ac.row3 = 1;
        ac.row4 = 1;
        ac.row5 = 1;
        ac.row6 = 1;
        ac.row7 = 1;
        ac.SPMeditOne();
        ac.SPMadd();    
        ac.SPMsave();
        ac.SPMremove();
        ac.BCSeditOne();
        ac.BCSadd();    
        ac.BCSsave();
        ac.BCSremove();
        ac.TCSeditOne();
        ac.TCSadd();    
        ac.TCSsave();
        ac.TCSremove();
        ac.APeditOne();
        ac.APadd();    
        ac.APsave();
        ac.APremove();
        ac.NSeditOne();
        ac.NSadd();    
        ac.NSsave();
        ac.NSremove();
        ac.BNSeditOne();
        ac.BNSadd();    
        ac.BNSsave();
        ac.BNSremove();
        ac.TNSeditOne();
        ac.TNSadd();    
        ac.TNSsave();
        ac.TNSremove();
         
        //topIndex  杨明                   
         ac.MA();
         ac.MB();
         ac.MC();
         ac.table1();
         ac.table2();
         ac.table3();
         ac.table4();
         ac.table5();
         ac.table6();
         ac.table7();
         ac.Attachment();
        
        //测试组织结构图  杨明
        
        ac.ContactChartCtrl(o1.id);
        String bid = c4.id;
        String toldid = c1.id;
        ContactChartHelper.updateRecord(bid,toldid);
                           
        TopProjectOwnerChartCtrl tp = new TopProjectOwnerChartCtrl();
       
    }
       
}