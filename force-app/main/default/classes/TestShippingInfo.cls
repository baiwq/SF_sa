@isTest
public class TestShippingInfo{
   public static testMethod void TestShippingInfo(){
      String startDtime = '2016-01-01 00:00:06';
      String endDtime = '2016-10-01 00:00:00';

      User u1 = new User(LastName = '张2三1',Alias = '测试5', UserName = 'yu03@tranzvision.sifang.sf',
                   email = 'zserd@tranzvision.sifang.sf',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      User u12 = new User(LastName = '李2四2',Alias = 'yica6', UserName = 'yu01@tranzvision.sifang.sf',
                   email = 'lisiyid@tranzvision.sifang.sf',COMMUNITYNICKNAME = 'test2', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u12;
      
      Account acc = new Account();
      acc.Name='yuds测试客户';
      acc.taxpayerNumber__c = '01pN0000000PyMd';
      acc.bankAccount__c = '123';
      acc.bankBy__c = '工商';
      acc.billingPhone__c ='1231232131';
      acc.approvalStatus__c = '审批通过';
      acc.accountStatus__c = '有效';
      acc.postcode__c = '000000';
      insert acc;
      
      Opportunity o = new Opportunity();
      o.AccountId = acc.Id;
      o.name='测试机会0810';
      o.StageName = '赢单';
      o.CloseDate = System.today();
      o.actualbidamount__c = 10;
      insert o; 
 
      Contract__c con = new Contract__c();
      con.amount__c = 100000;
      con.subCompany__c = '北京四方继保自动化股份有限公司';
      con.account__c = acc.id;
      con.signedBy__c = u1.id;
      con.deliveryPerson__c = u12.id;
      con.accountManager__c = u1.id;    
      con.approvalPsDate__c = date.valueof('2016-09-20');
      con.contractReceptDate__c = date.valueof('2016-09-20');
      con.opportunity__c = o.id;
      insert con;
      
      shipping__c s=new shipping__c();
      s.contracts__c=con.id;
      s.approvalDate__c=con.approvalPsDate__c;
      insert s;

      Test.startTest();
      shippingInfo.queryShipping(startDtime,endDtime);
      shippingInfo.queryShipping('as','sa');
      test.stopTest();
   }
}