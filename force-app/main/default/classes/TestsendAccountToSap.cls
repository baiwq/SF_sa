@isTest
public class TestsendAccountToSap
{
    static testMethod void TestsendAccountToSap()
    {
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
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
        
        Account a2 = new Account();
        a2.Name='测试0930111111111111111111111111111111111111111111111111111111111111111111111';
        a2.billingNation__c='中国';
        a2.countryCode__c='CN';
        a2.city__c='北京';
        a2.billingState__c='北京';
        a2.billingStreet__c='上的四街';
        a2.postcode__c='010000';
        a2.taxpayerNumber__c = '01pN0000000Pyxd';
        a2.accountStatus__c = '有效';
        a2.approvalStatus__c = '审批通过';
        a2.postcode__c = '000000';
        insert a2;
        //
        Contract__c c = new Contract__c();
        c.subCompany__c='北京四方继保自动化股份有限公司';
        c.subCompanyCode__c='CC008';
        c.account__c=a.Id;
        c.amount__c=1000;
        c.currency__c='人民币';
        c.exchangeRate__c=1.000;
        c.deliveryPerson__c=u1.id;
        c.accountManager__c=u2.id;
        c.signedBy__c=u3.Id;
        c.salesOrgNameCode__c='S003';
        insert c;
        //     
        sendAccountToSap sta = new sendAccountToSap();        
        test.startTest(); 
        sta.sendAccountToSap('合同阶段',a.id,'C',c.subCompanyCode__c,c.salesOrgNameCode__c);
        sta.sendAccountToSap('合同阶段',a2.id,'D',c.subCompanyCode__c,c.salesOrgNameCode__c);
        sta.sendAccountToSap('合同阶段',a2.id,null,c.subCompanyCode__c,c.salesOrgNameCode__c);
        sta.sendAccountToSap('合同阶段','12313','C',c.subCompanyCode__c,c.salesOrgNameCode__c);
        test.stopTest();
    }
}