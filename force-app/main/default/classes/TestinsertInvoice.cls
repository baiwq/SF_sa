@isTest
public class TestinsertInvoice
{
    @testSetup static void CreateBaseData(){
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心');
        User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@sifang.sieyuan.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心');
        User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '电力系统销售中心');
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
        a.bankAccount__c='003';
        a.bankBy__c='icbc';
        a.taxpayerNumber__c='112233445566778';
        a.accountStatus__c = '有效';
        a.approvalStatus__c = '审批通过';
        a.postcode__c = '000000';
        insert a;
        //客户无纳税
        Account a2 = new Account();
        a2.Name='测试09310';
        a2.englishName__c='ABV';
        a2.overseasType__c='海外客户';
        a2.bankAccount__c='003';
        a2.bankBy__c='icbc';
        a2.taxpayerNumber__c='119833445566778';
        a2.accountStatus__c = '有效';
        a2.approvalStatus__c = '审批通过';
        a2.postcode__c = '000000';
        insert a2;
        //
        Contract__c c = new Contract__c();
        c.subCompany__c='北京四方继保自动化股份有限公司';
        c.subCompanyCode__c='CC008';
        c.account__c=a.Id;
        c.amount__c=10000000;
        c.currency__c='人民币';
        c.exchangeRate__c=1.000;
        c.deliveryPerson__c=u1.id;
        c.accountManager__c=u2.id;
        c.signedBy__c=u3.Id;
        c.salesOrgNameCode__c='S003';
        c.approvalStatus__c='审批通过';
        insert c; 
    }
    static testMethod void TestinsertInvoice()
    {
        //
        Account a =[select id from Account where Name=:'测试0930' limit 1];
        Contract__c c=[select id from Contract__c where salesOrgNameCode__c=:'S003' limit 1];
        //
        invoice__c i = new invoice__c(account__c=a.Id);
        i.isIncludingTax__c='是';
        i.taxRate__c='0.11';
        i.isWriteList__c='是';
        insert i;
        //
        invoiceitem__c ii = new invoiceitem__c(invoice__c=i.Id,contract__c=c.Id,invoiceAmount__c=50000);
        insert ii;
        //
        goodsName__c gd = new goodsName__c(invoice__c=i.Id,quantity__c=100,amount__c=50000);
        insert gd;
        //发票类型 
        invoice__c i2 = new invoice__c(account__c=a.Id ,invoiceType__c=null);
        i2.isIncludingTax__c='是';
        i2.taxRate__c='0.11';
        i2.isWriteList__c='是';
        insert i2;
        //
        invoiceitem__c ii2 = new invoiceitem__c(invoice__c=i2.Id,contract__c=c.Id,invoiceAmount__c=50000);
        insert ii2;
        insertInvoice sta = new insertInvoice(); 
        test.startTest(); 
        sta.insertInvoice(i.id);
        sta.insertInvoice(i2.id);
        test.stopTest();          
    }
    static testMethod void testInsertInvoiceClass(){
        //无商品
        Account a2 =[select id from Account where Name=:'测试0930' limit 1];
        Contract__c c=[select id from Contract__c where salesOrgNameCode__c=:'S003' limit 1];
        invoice__c i3 = new invoice__c(account__c=a2.Id);       
        i3.isIncludingTax__c='是';
        i3.taxRate__c='0.11';
        i3.isWriteList__c='是';
        insert i3;
        //
        invoiceitem__c ii3 = new invoiceitem__c(invoice__c=i3.Id,contract__c=c.Id,invoiceAmount__c=50000);
        insert ii3;
        insertInvoice sta = new insertInvoice(); 
        test.startTest(); 
        sta.insertInvoice(i3.id);
        test.stopTest(); 
    }
    static testMethod void testInsertInvoiceClass2(){
        //无xiang
        Account a2 =[select id from Account where Name=:'测试0930' limit 1];
        Contract__c c=[select id from Contract__c where salesOrgNameCode__c=:'S003' limit 1];
        invoice__c i3 = new invoice__c(account__c=a2.Id);       
        i3.isIncludingTax__c='是';
        i3.taxRate__c='0.11';
        i3.isWriteList__c='是';
        insert i3;
        i3.approvalStatus__c = '草稿';
        update i3;
        i3.approvalStatus__c = '提交待审批';
        update i3;
        i3.approvalStatus__c = '审批拒绝';
        update i3;
         i3.approvalStatus__c = '审批通过';
        update i3;
         User u3 =[select id from User where LastName = '测试经理3' limit 1];

        i3.applyBy__c = u3.id;
        update i3;
        //
 
        insertInvoice sta = new insertInvoice(); 
        test.startTest(); 
        sta.insertInvoice(i3.id);
        test.stopTest(); 
    }
}