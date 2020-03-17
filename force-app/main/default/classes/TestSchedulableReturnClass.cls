@isTest
public with sharing class TestSchedulableReturnClass{
    
   static testMethod void testReturnTracking(){
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test', 
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', contractAdmin__c = Userinfo.getUserId());
      insert u1;

      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', ManagerId = u1.id , contractAdmin__c = Userinfo.getUserId());
      insert u2;
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      Contract__c cc = new Contract__c();  //有合同  
      cc.account__c = a.id;   
      cc.deliveryPerson__c = u2.id;    
      cc.amount__c = 100000;    
      cc.deliveryTeamDepartment__c   = '东北区';
      cc.deliveryTeamProvince__c = '黑龙江';
      cc.deliveryTeamCenter__c = '销售中心';
      insert cc;    
      paymentTerm__c pay1 = new paymentTerm__c(contract__c = cc.id,percentage__c = 50, inputAmount__c = 1000,inputDate__c = System.today());
      insert pay1;
      monthStatistics__c mon1 = new monthStatistics__c(monthFifthAmount__c = 1000,idSet__c=cc.id,sales__c = u2.id,year__c = System.today().year(),month__c = System.today().month(),department__c = '华东区',province__c ='浙江',center__c = '销售中心');
      insert mon1;
      returnPool__c rp1 = new returnPool__c(account__c = a.Id,amount__c = 300000);
      insert rp1;
      returnItem__c rim1 = new returnItem__c(returnPool__c = rp1.Id, contracts__c = cc.Id,amount__c = 1000);
      insert rim1;
      
      
        Integer y = System.today().year();//当前年份  
        Integer m = System.today().month();//当前月份
        paymentTerm__c p = [select id,contract__c from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m limit 1];
        String MonthFifthDayCalcInputAmount= System.schedule('MonthFifthDayCalcInputAmount','0 0 0 3 9 ? 2020',new MonthFifthDayCalcInputAmount());
        monthStatistics__c  mo = [select id from monthStatistics__c where month__c =:m  and year__c =:y limit 1];
        String MonthLastDayCalcFinishAmount= System.schedule('MonthLastDayCalcFinishAmount','0 0 0 3 9 ? 2020',new MonthLastDayCalcFinishAmount());
        
    }
   
}