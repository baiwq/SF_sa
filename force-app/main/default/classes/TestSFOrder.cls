@isTest
public class TestSFOrder{
    @testSetup static void CreateBaseData(){   
         System.debug('wwwwwwwwwww+');
       //创建用户  
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test', 
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', contractAdmin__c = Userinfo.getUserId());
      insert u1;

      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id , contractAdmin__c = Userinfo.getUserId());
      insert u2;

      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u2.id , contractAdmin__c = Userinfo.getUserId());
      insert u3;
      
       //创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;

      Account a1b = new Account(Name = 'A1b',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000024PyHM',bankAccount__c = '002001',bankBy__c = '建行', postcode__c ='123342', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a1b;
      
      //创建联系人
      Contact c = new Contact(LastName ='孙权', AccountId = a.Id);
      insert c;
      
     //创建开票
     invoice__c inv = new invoice__c();
     inv.invoiceCompany__c = '北京四方继保工程技术有限公司';
     inv.invoiceType__c = '普通发票';
     inv.isIncludingTax__c = '是';
     inv.account__c = a.id;
     inv.applyBy__c = u1.id; 
     inv.accountPhone__c = '01086555555';
     insert inv;
     
     //创建收据
     RecordType receiptRecordType = [Select id from RecordType where SobjectType =:'receipt__c' and Name =:'非空白收据' limit 1]; 
     receipt__c rece = new receipt__c();
     rece.RecordTypeId = receiptRecordType.id;
     rece.applyBy__c = u1.id;
     rece.receiptAccount__c = a.id;
     rece.wayOfPrint__c = 'A4打印收据';
     rece.moneyType__c = '货款'; 
     rece.payeeUser__c = u1.id;
     rece.content__c = 'tttt';
     rece.recipient__c = '本人领取';
     rece.invoiceCompany__c = 'CC01 北京四方继保自动化股份有限公司';
     rece.companyAddress__c = '北京海淀上地四街四方大厦';
     rece.applyDate__c = System.today();
     rece.wayOfPayment__c = '电汇';
     rece.dateOfPayment__c = System.today();
     
     rece.orderIDSF__c = '22345';
     rece.orderNumberSF__c = '44446';
     rece.orderResultSF__c = '成功';
     rece.notToSendSF__c = '天气';
     rece.errorInterfaceSF__c = '天气';
     rece.sendOrderStatusSF__c = '成功';
     rece.sendOrderTimeSF__c = System.now();    
     insert rece;                       
}
    
    @isTest static void testSOSPToSFOrder(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('a'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    }   
    
     @isTest static void testSOSPToSFOrder2(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('b'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
         test.stopTest(); 
    }
    
     @isTest static void testSOSPToSFOrder3(){
     //receipt__c recei = [Select id,orderIDSF__c,orderNumberSF__c,orderResultSF__c,notToSendSF__c, errorInterfaceSF__c,
                                     //sendOrderStatusSF__c,sendOrderTimeSF__c from receipt__c limit 1][0];
     invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('c'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';                    
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);

         test.stopTest(); 
    }
    
    @isTest static void testSOSPToSFOrder4(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('d'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';                    
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);

        test.stopTest(); 
    }
    @isTest static void testSOSPToSFOrder5(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('a'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    } 
    @isTest static void testSOSPToSFOrder6(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('b'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    } 
    @isTest static void testSOSPToSFOrder7(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('d'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    } 
    
    
    
    @isTest static void testSOSPToSFOrder8(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('a'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    }   
    
     @isTest static void testSOSPToSFOrder9(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('b'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
         test.stopTest(); 
    }
    
     @isTest static void testSOSPToSFOrder10(){
     //receipt__c recei = [Select id,orderIDSF__c,orderNumberSF__c,orderResultSF__c,notToSendSF__c, errorInterfaceSF__c,
                                     //sendOrderStatusSF__c,sendOrderTimeSF__c from receipt__c limit 1][0];
     invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('c'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';                    
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);

         test.stopTest(); 
    }
    
    @isTest static void testSOSPToSFOrder11(){
    invoice__c invo = [select id,invoiceCompany__c, invoiceType__c, isIncludingTax__c, account__c, applyBy__c, accountPhone__c from invoice__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('d'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'invoice__c';
          String ApplyName = invo.applyBy__c;
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';                    
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);

        test.stopTest(); 
    }
    @isTest static void testSOSPToSFOrder12(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('a'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    } 
    @isTest static void testSOSPToSFOrder13(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('b'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);
        test.stopTest(); 
    } 
    @isTest static void testSOSPToSFOrder14(){
    receipt__c invo = [select id  from receipt__c limit 1][0];
        Test.setMock(WebServiceMock.class,new TestMockSOSPToSFOrder('d'));
        //SOSPToSFOrder abcd = new SOSPToSFOrder();
          String recordId = invo.id;
          String ObjectAPIName = 'receipt__c';
          String ApplyName = 're';
          String ApplyPhone = '01086555555';
          String ApplyAddress = '北京';
          String ApplyCompany = '创景';
          String ReceptName = '张三';
          String ReceptPhone = '01086555555';
          String ReceptAddress = '北京';
          String ReceptCompany = '创建咨询';
        test.startTest(); 
        SOSPToSFOrder_BD.createSFOrder(recordId,ObjectAPIName,ApplyName,ApplyPhone,ApplyAddress,ApplyCompany,ReceptName,ReceptPhone,ReceptAddress,ReceptCompany);

        test.stopTest(); 
    } 
}