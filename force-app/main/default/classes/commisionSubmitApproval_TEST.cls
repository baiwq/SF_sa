@isTest
public class commisionSubmitApproval_TEST {
    @testSetup static void CreateBaseData(){
    //创建用户
      List<User> userList = new List<User>();
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test33', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u3;

      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test43', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u4;

      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test53', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u5;

      User u6 = new User(LastName = '测试经理6',Alias = '测试6', UserName = 'sunx6@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test63', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u6;

      User u7 = new User(LastName = '测试经理7',Alias = '测试7', UserName = 'sunx7@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test73', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u7;

      User u8 = new User(LastName = '测试经理8',Alias = '测试8', UserName = 'sunx8@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test83', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u8;
      User u9 = new User(LastName = '测试经理9',Alias = '测试9', UserName = 'sunx9@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test93', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles');
      insert u9;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), actualbidamount__c = 10);
      o1.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      o1.ProductGroup__c = '输变电业务单元-电网保护自动化事业部';
      o1.MainIndustrySales__c = '输变电业务';
      insert o1;

      
//创建机会点成员
      List<OpportunityTeamMember> OTList = new List<OpportunityTeamMember>();
      OpportunityTeamMember OT1 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u1.id);
      OpportunityTeamMember OT2 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u2.id);
      OTList.add(OT1);
      OTList.add(OT2);
      OpportunityTeamMember OT3 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      OpportunityTeamMember OT4 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u4.id);
      OTList.add(OT3);
      OTList.add(OT4);
      OpportunityTeamMember OT5 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u5.id);
      OpportunityTeamMember OT6 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u6.id);
      OTList.add(OT5);
      OTList.add(OT6);
      OpportunityTeamMember OT7 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u7.id);
      OpportunityTeamMember OT8 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u8.id);
      OTList.add(OT7);
      OTList.add(OT8);
      OpportunityTeamMember OT9 = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u9.id);
      OTList.add(OT9);
      insert OTList;
    
//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
      
    }

    static testMethod void testcommisionUserApprove(){
      test.startTest(); 
        List<OpportunityTeamMember> oppMember = [select Id,userId,TeamMemberRole from OpportunityTeamMember];
        List<User> userList = [SELECT Id,Name from User limit 9];
        commisionSplit__c cs = [SELECT Id,Name from commisionSplit__c Limit 1];
        List<commisionUser__c> cuList = new List<commisionUser__c>();
        commisionUser__c cu = new commisionUser__c();
        cu.performanceProportion__c = 10;
        cu.commisionSplit__c = cs.Id;
        cu.member__c = oppMember.get(0).UserId;
        insert cu;

        commisionUser__c cu1 = new commisionUser__c();
        cu1.performanceProportion__c = 20;
        cu1.member__c = oppMember.get(1).Id;
        cu1.commisionSplit__c = cs.Id;
        cuList.add(cu1);
        commisionUser__c cu2 = new commisionUser__c();
        cu2.member__c = oppMember.get(2).Id;
        cu2.performanceProportion__c = 10;
        cu2.commisionSplit__c = cs.Id;
        cuList.add(cu2);
        commisionUser__c cu3 = new commisionUser__c();
        cu3.member__c = oppMember.get(3).Id;
        cu3.performanceProportion__c = 10;
        cu3.commisionSplit__c = cs.Id;
        cuList.add(cu3);
        commisionUser__c cu4 = new commisionUser__c();
        cu4.member__c = oppMember.get(4).Id;
        cu4.performanceProportion__c = 10;
        cu4.commisionSplit__c = cs.Id;
        cuList.add(cu4);
        commisionUser__c cu5 = new commisionUser__c();
        cu5.member__c = oppMember.get(5).Id;
        cu5.performanceProportion__c = 10;
        cu5.commisionSplit__c = cs.Id;
        cuList.add(cu5);
        commisionUser__c cu6 = new commisionUser__c();
        cu6.member__c = oppMember.get(6).Id;
        cu6.performanceProportion__c = 10;
        cu6.commisionSplit__c = cs.Id;
        cuList.add(cu6);
        commisionUser__c cu7 = new commisionUser__c();
        cu7.member__c = oppMember.get(7).Id;
        cu7.performanceProportion__c = 10;
        cu7.commisionSplit__c = cs.Id;
        cuList.add(cu7);

        commisionUser__c cu8 = new commisionUser__c();
        cu8.member__c = oppMember.get(8).Id;
        cu8.performanceProportion__c = 10;
        cu8.commisionSplit__c = cs.Id;
        cuList.add(cu8);

        try {
            INSERT cuList;
            cu.performanceProportion__c = 20;
            update cu;
        } catch (Exception E) {
            
        }
        test.stopTest();  
   }

    static testMethod void testSalesLeadsApprove(){
      test.startTest(); 
        commisionSplit__c cs = [SELECT Id,Name from commisionSplit__c Limit 1];
        commisionUser__c cu = new commisionUser__c();
        cu.performanceProportion__c = 10;
        cu.commisionSplit__c = cs.Id;
        cu.member__c = UserInfo.getUserId();
        try {
            INSERT cu;
        } catch (Exception E) {
            
        }
        test.stopTest();  
   }

    static testMethod void testSalesLeadsApprove1(){
      test.startTest(); 
        commisionSplit__c cs = [SELECT Id,Name from commisionSplit__c Limit 1];
        commisionUser__c cu = new commisionUser__c();
        cu.performanceProportion__c = 10;
        cu.commisionSplit__c = cs.Id;
        cu.member__c = UserInfo.getUserId();
        try {
            INSERT cu;
        } catch (Exception E) {
            
        }
        test.stopTest();  
   }

   static testMethod void testSalesLeadsApprove2(){
      test.startTest(); 
        User us = [SELECT Id from User where Alias = '测试1'];
        commisionUser__c cu = [SELECT Id , member__c from commisionUser__c Limit 1];
        cu.member__c = us.Id;
        try {
        UPDATE cu;

        } catch (Exception E) {
            
        }
        test.stopTest();  
   }

   static testMethod void testSalesLeadsApprove3(){
      test.startTest(); 
        commisionSplit__c cs = [SELECT Id,Name,approvalStatus__c from commisionSplit__c Limit 1];
        cs.approvalStatus__c = '提交待审批';
        UPDATE cs;
        commisionUser__c cu = [SELECT Id , performanceProportion__c from commisionUser__c Limit 1];
        cu.performanceProportion__c = 20;
        try {
        UPDATE cu;

        } catch (Exception E) {
            
        }
        test.stopTest();  
   }

   static testMethod void testSalesLeadsApprove4(){
      test.startTest(); 
        commisionSplit__c cs = [SELECT Id,Name,approvalStatus__c from commisionSplit__c Limit 1];
        cs.approvalStatus__c = '提交待审批';
        UPDATE cs;
        commisionUser__c cu = [SELECT Id , performanceProportion__c from commisionUser__c Limit 1];
        try {
        DELETE cu;

        } catch (Exception E) {
            
        }
        test.stopTest();  
   }
}