@isTest
public class TestWebserviceScheduleDateList {
    public static testMethod void testScheduleDateList(){
        
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
        Account a = new Account();
        a.Name='测试0830';
        a.englishName__c='ABV';
        a.overseasType__c='海外客户';
        a.taxpayerNumber__c = '01pN0000000PyMd';
        a.accountStatus__c = '有效';
        a.approvalStatus__c = '审批通过';
        a.postcode__c = '000000';
        insert a;
        
        Contract__c c = new Contract__c();
        //c.Name='测试0830';
        c.subCompany__c='北京四方继保自动化股份有限公司';
        c.account__c=a.Id;
        c.amount__c=1000;
        c.currency__c='人民币';
        c.exchangeRate__c=1.000;
        c.deliveryPerson__c=u1.id;
        c.accountManager__c=u2.id;
        c.signedBy__c=u3.Id;
        insert c;
        
        Contract__c[] c1 = [select contractNO__c from Contract__c where id= :c.id LIMIT 1];
        scheduleDateList.Contract con = new scheduleDateList.Contract();
        con.contractNOC=c1[0].contractNO__c;
        con.completelyDeliverDateC='2016-09-09';
        con.scheduleDateC='2016-09-10';
        List<scheduleDateList.Contract> cList = new List<scheduleDateList.Contract>();
        cList.add(con);
        //scheduleDateList s = new scheduleDateList();
        Test.startTest();
        scheduleDateList.scheduleDateList(cList);
        test.stopTest();
    }
}