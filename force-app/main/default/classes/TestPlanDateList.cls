@isTest
public class TestPlanDateList {
    public static testMethod void TestPlanDateList(){
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@sifang.sieyuan.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        List<User> uList = new List<User>();
        uList.add(u1);
        uList.add(u2);
        uList.add(u3);
        insert uList;
        //
        Account a = new Account();
        a.Name='测试0930';
        a.englishName__c='ABV';
        a.overseasType__c='海外客户';
        a.taxpayerNumber__c = '01pN0000000PyMd';
        a.accountStatus__c = '有效';
        a.approvalStatus__c = '审批通过';
        a.postcode__c = '000000';
        insert a;
        //
        Contract__c c = new Contract__c();
        c.subCompany__c='北京四方继保自动化股份有限公司';
        c.account__c= a.Id;
        c.amount__c=1000;
        c.currency__c='人民币';
        c.exchangeRate__c=1.000;
        c.deliveryPerson__c=u1.id;
        c.accountManager__c=u2.id;
        c.signedBy__c=u3.Id;
        insert c;
        //
        statusTracking__c  s= new statusTracking__c();
        s.contract__c=c.Id;
        insert s ; 
        //
        statusTracking__c[] s1 = [select contractNumber__c from statusTracking__c where id= :s.id LIMIT 1];
        //
        PlanDateList.statusTracking sta = new PlanDateList.statusTracking();
              sta.contractNoc=s1[0].contractNumber__c;
              sta.designPlanFinish='2016-01-01';
              sta.designActualFinish='2016-01-01';
              sta.devicePlanFinish='2016-02-16';
              sta.deviceActualFinish='2016-02-25';
              sta.buyPlanFinish='2016-01-16';
              sta.buyActualFinish='2016-01-17';
              sta.paperPlanFinish='2016-02-16';
              sta.paperActualFinish='2016-02-18';
              sta.deviceGonePlanFinish='2016-03-08';
              sta.deviceGoneActualFinish='2016-03-08';
              sta.buyGonePlanFinish='2016-04-10';
              sta.buyGoneActualFinish='2016-04-16';
              sta.cabinetPlanFinish='2016-04-16';
              sta.cabinetActualFinish='2016-02-16';
              sta.sendPlanFinish='2016-02-10';
              sta.sendActualFinish='2016-02-10';
              sta.sendFinishPlanFinish='2016-02-16';
              sta.sendFinishActualFinish='2016-02-14';
              sta.factoryPlanFinished='2016-10-01';
              sta.factoryActualFinished='2016-09-22';
        List<PlanDateList.statusTracking> sConList = new List<PlanDateList.statusTracking>();
            sConList.add(sta);
            Test.startTest();
        PlanDateList.PlanDateList(sConList);
             test.stopTest();
    }
}