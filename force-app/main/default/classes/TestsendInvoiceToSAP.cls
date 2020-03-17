@isTest
public class TestsendInvoiceToSAP{


@testSetup static void CreateBaseData(){
  User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@sifang.sieyuan.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
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

  Contract__c c = new Contract__c();
        c.subCompany__c='北京四方继保自动化股份有限公司';
        c.account__c=a.Id;
        c.amount__c=1000000;
        c.currency__c='人民币';
        c.exchangeRate__c=1.000;
        c.deliveryPerson__c=u1.id;
        c.accountManager__c=u2.id;
        c.approvalPsDate__c = date.valueof('2016-09-20');
        c.signedBy__c=u3.Id;
        //c.salesProvince__c='中石化';
        c.approvalStatus__c='审批通过';
        insert c;

  attachment__c att=new attachment__c();
        att.contract__c=c.Id;
        att.documentName__c='商务合同';
        att.attachmentURL__c='www.baidu.com';
        att.type__c='合同文本';
        att.isValid__c='有效';
        insert att; 
 
  invoice__c i1 = new invoice__c(account__c=a.Id);
        i1.isIncludingTax__c='是';
        i1.taxRate__c='0.11';
        i1.isWriteList__c='是';
        insert i1;
        //
        invoiceitem__c ii1 = new invoiceitem__c(invoice__c=i1.Id,contract__c=c.Id,invoiceAmount__c=50000,sendBackTime__c='2016-10-17');
        insert ii1;        

        
  invoice__c i2 = new invoice__c(account__c=a.Id);
        i2.isIncludingTax__c='是';
        i2.taxRate__c='0.11';
        i2.isWriteList__c='是';
        i2.invoiceCompany__c='北京四方继保自动化股份有限公司';
        insert i2;  
        
  invoiceitem__c ii2 = new invoiceitem__c(invoice__c=i2.Id,contract__c=c.Id,invoiceAmount__c=50000,sendBackTime__c='2016-10-10');
        insert ii2; 
}
@isTest static void testSentAccount(){
    List<invoice__c> inc = [select id from invoice__c];
    Test.setMock(WebServiceMock.class, new TestMockInvoiceToSoap ('a'));
     Set<Id> xlist = new Set<Id>();
     xlist.add(inc[0].id);
     xlist.add(inc[1].id);
    sendInvoiceToSAP sta = new sendInvoiceToSAP(); 
    test.startTest(); 
      sta.sendInvoiceToSAP(xlist);
    test.stopTest();
   
}
@isTest static void testSentAccount2(){
    List<invoice__c> inc = [select id from invoice__c];
    Test.setMock(WebServiceMock.class, new TestMockInvoiceToSoap ('b'));
     Set<Id> xlist = new Set<Id>();
     xlist.add(inc[0].id);
     xlist.add(inc[1].id);
    sendInvoiceToSAP sta = new sendInvoiceToSAP(); 
    test.startTest(); 
      sta.sendInvoiceToSAP(xlist);
    test.stopTest();
   
}
}