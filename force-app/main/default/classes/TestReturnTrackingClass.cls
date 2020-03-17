@isTest
public class TestReturnTrackingClass{
    static testMethod void CreateData(){
        User u1 = new User(LastName = '测试用户名称',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        insert u1;
        Account a = new Account(Name = '测试客户名称',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
        insert a;
        salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                            expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                            projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',
                                            MainIndustrySales__c = '配用电业务',cpywdyfzr__c = u1.Id,Department_Manager__c = u1.Id,Industry_Representative__c = u1.Id);
        insert s1;
        opportunity o1 = new opportunity(Name = '测试机会名称', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
        insert o1;
        Contract__c cc = new Contract__c();  //有合同
        cc.account__c= a.id;
        cc.deliveryPerson__c = u1.id;  
        cc.tenderScheme__c = '1234';
        cc.opportunity__c = o1.id;    
        cc.amount__c = 100000;
        cc.scheduleDate__c = '2017-05-30';
        cc.userConfirmDate__c = System.today();
        cc.salesDepartment__c = '华东区';
        cc.salesProvince__c = '江苏-电厂';
        cc.deliveryTeamDepartment__c   = '东北区';
        cc.deliveryTeamProvince__c = '黑龙江';
        cc.deliveryTeamCenter__c = '销售中心';
        insert cc; 
        
        List<paymentTerm__c> ptList = new List<paymentTerm__c>();
        String[] stageItem = new List<String>{'预收','提货','到货','调试','投运','质保'};
        for(Integer i=0; i<stageItem.size(); i++){
            ptList.add(new paymentTerm__c(stage__c = stageItem.get(i), contract__c = cc.id, collectionStatus__c = '未回款', No__c = i+1,percentage__c = 15));
        } 
        insert ptList;    
        //测试SetID方法                     
        new getContractIdSetFromStr().getIdSet('测试'); 
        //测试controller 
        returnTrackingController rtc = new returnTrackingController();
        rtc.DateHelper();
        rtc.getProfileValue();
       
        rtc.clickPanel2();
        rtc.clickPanel3();
        rtc.clickPanel4();
        rtc.clickPanel5();
        rtc.clickPanel6();  
        rtc.clickPanel1();      
        rtc.str = '测试';
        rtc.Search();      
        rtc.SavePanel1();
        rtc.SavePanel2();         
        rtc.Panel2RecordId = String.valueOf([select id from paymentTerm__c limit 1].id);
        rtc.Panel4RecordId = String.valueOf([select id from paymentTerm__c limit 1].id);
        rtc.deletePanel2();
        rtc.deletePanel4();
        rtc.previous();
        rtc.next();      
        returnTrackingController rtc2 = new returnTrackingController();                
        rtc2.clickPanel2();         
        rtc2.str = '测试';
        rtc2.Search();    
        returnTrackingController rtc3 = new returnTrackingController();                
        rtc3.clickPanel3();         
        rtc3.str = '测试';
        rtc3.Search();     
        returnTrackingController rtc4 = new returnTrackingController();                
        rtc4.clickPanel4();         
        rtc4.str = '测试';
        rtc4.Search();  
        returnTrackingController rtc5 = new returnTrackingController();                
        rtc5.clickPanel5();         
        rtc5.str = '测试';
        rtc5.Search();  
        returnTrackingController rtc6 = new returnTrackingController();                
        rtc6.clickPanel6();         
        rtc6.str = '测试';
        rtc6.Search();  
    }
   
}