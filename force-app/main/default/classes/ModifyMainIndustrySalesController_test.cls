@isTest(seeAllData=true)
public with sharing class ModifyMainIndustrySalesController_test {
    public static testMethod void test1() {

         User u2 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'yangming@sf-auto.com',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        insert u2;

        User u1 = [SELECT Id,Name from User WHERE IsActive = true Limit 1];
        Opportunity o1 = [SELECT Id,Name,AccountId from Opportunity WHERE RecordType.Name != '小额订单' AND StageName = '赢单' Limit 1];

        
        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会无合同' limit 1];
        Contract__c cc2 = new Contract__c();  //有合同
        cc2.account__c= o1.AccountId;
        cc2.signedby__c= u1.id;
        cc2.deliveryPerson__c = u1.id;
        cc2.accountManager__c = u1.id;
        cc2.tenderScheme__c = '1234';
        cc2.opportunity__c = o1.id;
        cc2.ownerid = u1.id;
        cc2.amount__c = 100000;
        cc2.MainProductGroup__c = '	输变电业务单元-电网控制事业部';
        cc2.returnAmountAll__c = 1;
        cc2.incomeConfirmDate__c = Date.today();
        cc2.RecordTypeId = ContractRecordType1.id;
        cc2.salesDepartment__c = '华东区';
        cc2.salesProvince__c = '江苏-电厂';
        cc2.deliveryTeamDepartment__c   = '东北区';
        cc2.deliveryTeamProvince__c = '黑龙江';
        cc2.deliveryTeamCenter__c = '销售中心';
        cc2.approvalStatus__c = '草稿';
        cc2.cpywdyfzr__c = UserInfo.getUserId();
        INSERT cc2;

        StaffingTables__c st = new StaffingTables__c();
        st.name = '直流输电及电力电子业务单元';
        st.LeadingCadre__c = UserInfo.getUserId();

        StaffingTables__c st2 = new StaffingTables__c();
        st2.name = '发电及用电业务单元-公共电力事业部';
        st2.LeadingCadre__c = u2.Id;

        Apexpages.currentPage().getParameters().put('dataId',cc2.Id);
        ModifyMainIndustrySalesController ms = new ModifyMainIndustrySalesController();
        ms.newFieldValue = '发电及用电业务单元-公共电力事业部';
        ms.GetApprover();
        ms.SaveData();
    }
}