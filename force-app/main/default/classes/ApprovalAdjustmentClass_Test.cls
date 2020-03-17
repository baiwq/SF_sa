@isTest(seeAllData=true)
private class ApprovalAdjustmentClass_Test {
    static testMethod void testMethod1() 
    {
        Account a = [SELECT Id,Name FROM Account Limit 1];
        salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                            expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                            projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务',MainIndustrySales__c = '发电业务');
        insert s1;

        s1.MainIndustrySales__c = '配用电业务';
        UPDATE s1;
    }

    static testMethod void testMethod2() 
    {
        Opportunity o1 = [SELECT Id,Name from Opportunity Limit 1];
        //创建投标评审
        RecordType bidReviewType = [Select id from RecordType where SobjectType =:'bidReview__c' and Name =:'投标评审' limit 1];
        bidReview__c brc = new bidReview__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',RecordTypeId = bidReviewType.id,CloseDate__c = System.today(),projectClassification__c ='招标项目');
        brc.MainIndustrySales__c = '配用电业务';
        insert brc;
        brc.MainIndustrySales__c = '发电业务';
        UPDATE brc;
    }

    static testMethod void testMethod3() 
    {
        Opportunity o1 = [SELECT Id,Name from Opportunity WHERE RecordType.Name != '小额订单' Limit 1];
        bidReview__c brc = [SELECT Id,Name from bidReview__c WHERE approvalStatus__c = '审批通过' Limit 1];
        quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',/*RecordTypeId = quatationType.id,*/bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
        qtc.MainIndustrySales__c = '配用电业务';
        insert qtc;
        qtc.MainIndustrySales__c = '发电业务';
        UPDATE qtc;
        //创建投标评审
        contractreview__c cttw = new contractreview__c(opportunity__c=o1.id,approvalStatus__c='草稿',
                                                        quatation__c=qtc.id,contractAmount__c=111,active__c='有效',
                                                        isUpdate__c='不需要修改',applyImportantProject__c='否');
        cttw.MainIndustrySales__c = '配用电业务';
        insert cttw;
        cttw.MainIndustrySales__c = '发电业务';
        UPDATE cttw;
    }

    static testMethod void testMethod4() 
    {
        User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'yangming@sf-auto.com',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
        insert u1;
        contract__c cc = [SELECT Id,Name from contract__c Limit 1];
        ProjectTask__c pp = new ProjectTask__c();
        pp.contract__c = cc.Id;
        pp.projectManagementEngineer__c = '测试经理1';
        pp.domainUser__c='yangming';
        INSERT pp;
        RecordType recordType1 = [Select id from RecordType where SobjectType = 'contractchange__c' and Name = '合同金额变更' limit 1];
        contractchange__c ctcc = new contractchange__c(RecordTypeId = recordType1.Id,contract__c=cc.id,applyBy__c='设计院',secondChanged__c='是',accountChanged__c='是',contractNameChanged__c='是',paymentTermChanged__c='是',warrantyChanged__c='是',changeContent__c='234',approvalStatus__c='提交待审批');
        ctcc.MainIndustrySales2__c = '发电业务';
        ctcc.MainIndustrySales__c = '配用电业务';
        ctcc.notCompletelySchedulingExplain__c = '测试测试测试';
        insert ctcc;
        ctcc.MainIndustrySales__c = '公共及智慧安防业务-智慧安防';
        update ctcc;
    }

    static testMethod void testMethod5() 
    {
        List<User> userList = [SELECT Id,Name from User WHERE IsActive = true Limit 8];
        Account a = [SELECT Id,Name FROM Account Limit 1];
        opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
        insert o1;
        List<OpportunityTeamMember> otList = new List<OpportunityTeamMember>();
        for (User u : userList) {
            OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u.Id);
            otList.add(OT);
        }
          insert otList;
        commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
          insert CS;
          List<commisionUser__c> cList = new List<commisionUser__c>();
         for (User u : userList) {
            commisionUser__c cu = new commisionUser__c(commisionSplit__c = cs.id,performanceProportion__c = 10, member__c = u.Id);
            cList.add(cu);
        }
          insert cList;
    }

    static testMethod void testMethod6() 
    {
        User u1 = [SELECT Id,Name from User WHERE IsActive = true Limit 1];
        Account a = [SELECT Id,Name FROM Account WHERE bankAccount__c != NULL Limit 1];
        Opportunity o1 = [SELECT Id,Name from Opportunity WHERE RecordType.Name != '小额订单' AND StageName = '赢单' Limit 1];

        
        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
        Contract__c cc2 = new Contract__c();  //有合同
        cc2.account__c= a.id;
        cc2.signedby__c= u1.id;
        cc2.deliveryPerson__c = u1.id;
        cc2.accountManager__c = u1.id;
        cc2.tenderScheme__c = '1234';
        cc2.opportunity__c = o1.id;
        cc2.ownerid = u1.id;
        cc2.amount__c = 100000;
        cc2.returnAmountAll__c = 1;
        cc2.incomeConfirmDate__c = Date.today();
        cc2.RecordTypeId = ContractRecordType1.id;
        cc2.salesDepartment__c = '华东区';
        cc2.salesProvince__c = '江苏-电厂';
        cc2.deliveryTeamDepartment__c   = '东北区';
        cc2.deliveryTeamProvince__c = '黑龙江';
        cc2.deliveryTeamCenter__c = '销售中心';
        cc2.approvalStatus__c = '审批通过';

        Contract__c cc3 = new Contract__c();  //有合同
        cc3.account__c= a.id;
        cc3.signedby__c= u1.id;
        cc3.deliveryPerson__c = u1.id;
        cc3.accountManager__c = u1.id;
        cc3.tenderScheme__c = '1234';
        cc3.opportunity__c = o1.id;
        cc3.ownerid = u1.id;
        cc3.amount__c = 100000;
        cc3.contractReceptDate__c = Date.today();
        cc3.returnAmountAll__c = 1;
        cc3.RecordTypeId = ContractRecordType1.id;
        cc3.salesDepartment__c = '华东区';
        cc3.salesProvince__c = '江苏-电厂';
        cc3.deliveryTeamDepartment__c   = '东北区';
        cc3.deliveryTeamProvince__c = '黑龙江';
        cc3.deliveryTeamCenter__c = '销售中心';
        cc3.approvalStatus__c = '审批通过';
        
        Contract__c cc1 = new Contract__c();  //有合同
        cc1.account__c= a.id;
        cc1.signedby__c= u1.id;
        cc1.deliveryPerson__c = u1.id;
        cc1.accountManager__c = u1.id;
        cc1.tenderScheme__c = '1234';
        cc1.opportunity__c = o1.id;
        cc1.ownerid = u1.id;
        cc1.amount__c = 100000;
        cc1.contractReceptDate__c = Date.today();
        cc1.incomeConfirmDate__c = Date.today();
        cc1.returnAmountAll__c = 1;
        cc1.RecordTypeId = ContractRecordType1.id;
        cc1.salesDepartment__c = '华东区';
        cc1.salesProvince__c = '江苏-电厂';
        cc1.deliveryTeamDepartment__c   = '东北区';
        cc1.deliveryTeamProvince__c = '黑龙江';
        cc1.deliveryTeamCenter__c = '销售中心';
        cc1.approvalStatus__c = '审批通过';

        List<Contract__c> conList = new List<Contract__c>();
        conList.add(cc1);
        conList.add(cc2);
        conList.add(cc3);
        INSERT conList;

        //创建开票
        invoice__c i= new invoice__c(approvalStatus__c = '草稿',invoiceStatus__c = '正常',invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyBy__c = u1.Id,applyDate__c = System.today(), account__c = a.Id,shippingAddress__c = '北京',receiver__c = '张三');
        insert i;
        //创建开票项
        invoiceItem__c ii1 = new invoiceItem__c(contract__c = cc1.id, applicationID__c = '123', customerName__c = '123',sumAmount__c = '123',invoiceStatus__c = '123', sendBackTime__c ='2017-01-01 01:01:01',importTime__c = '2017-01-01 01:01:01',tax__c = '123',combineFlag__c = '123',invoiceType__c = 's',invoiceNumber__c ='123',invoiceCode__c ='123',invoice__c = i.id);
        invoiceItem__c ii2 = new invoiceItem__c(contract__c = cc2.id, applicationID__c = '123', customerName__c = '123',sumAmount__c = '123',invoiceStatus__c = '123', sendBackTime__c ='2017-01-01 01:01:01',importTime__c = '2017-01-01 01:01:01',tax__c = '123',combineFlag__c = '123',invoiceType__c = 's',invoiceNumber__c ='123',invoiceCode__c ='123',invoice__c = i.id);
        invoiceItem__c ii3 = new invoiceItem__c(contract__c = cc3.id, applicationID__c = '123', customerName__c = '123',sumAmount__c = '123',invoiceStatus__c = '123', sendBackTime__c ='2017-01-01 01:01:01',importTime__c = '2017-01-01 01:01:01',tax__c = '123',combineFlag__c = '123',invoiceType__c = 's',invoiceNumber__c ='123',invoiceCode__c ='123',invoice__c = i.id);
        List<invoiceItem__c> invoiceItemList = new List<invoiceItem__c>();
        invoiceItemList.add(ii1);
        invoiceItemList.add(ii2);
        invoiceItemList.add(ii3);
        insert invoiceItemList;

        i.approvalStatus__c = '提交待审批';
        update i;
    }

    static testMethod void testMethod7() 
    {
        User u1 = [SELECT Id,Name from User WHERE IsActive = true Limit 1];
        Account a = [SELECT Id,Name FROM Account WHERE bankAccount__c != NULL Limit 1];
        Opportunity o1 = [SELECT Id,Name from Opportunity WHERE RecordType.Name != '小额订单' AND StageName = '赢单' Limit 1];
        quatation__c  qtc = new quatation__c(opportunity__c = o1.Id,approvalStatus__c='审批通过',/*RecordTypeId = quatationType.id,*/bidType__c ='集中投标',QuotationProductCategory__c='常规产品',outsourcingPayment__c='无外购');
        qtc.MainIndustrySales__c = '配用电业务';
        insert qtc;
        contractreview__c cttw = new contractreview__c(opportunity__c=o1.id,approvalStatus__c='审批通过',
                                                        quatation__c=qtc.id,contractAmount__c=111,active__c='有效',
                                                        isUpdate__c='不需要修改',applyImportantProject__c='否');
        cttw.MainIndustrySales__c = '配用电业务';
        insert cttw;

        attachment__c att = new attachment__c(type__c='中标通知',documentName__c='文件名称',isValid__c='有效',attachmentURL__c='URL',notes__c='备注',contractReview__c=cttw.Id);
        insert att;

        bidCost__c bcs = new bidCost__c(costCenter__c = '22222222',approvalStatus__c='草稿',amount__c=111,
                                        account__c=a.id,opportunity__c=o1.id,
                                        bidNumber__c='1111',invoiceReturnDate__c=System.today(),remittanceMethod__c='支票',
                                        company__c='北京四方继保自动化股份有限公司',Reason__c='ee3',payComment__c='123',contractreview__c=cttw.Id);
        insert bcs;

        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
        Contract__c cc2 = new Contract__c();  //有合同
        cc2.account__c= a.id;
        cc2.signedby__c= u1.id;
        cc2.deliveryPerson__c = u1.id;
        cc2.accountManager__c = u1.id;
        cc2.tenderScheme__c = '1234';
        cc2.opportunity__c = o1.id;
        cc2.ownerid = u1.id;
        cc2.amount__c = 100000;
        cc2.returnAmountAll__c = 1;
        cc2.incomeConfirmDate__c = Date.today();
        cc2.RecordTypeId = ContractRecordType1.id;
        cc2.salesDepartment__c = '华东区';
        cc2.salesProvince__c = '江苏-电厂';
        cc2.deliveryTeamDepartment__c   = '东北区';
        cc2.deliveryTeamProvince__c = '黑龙江';
        cc2.deliveryTeamCenter__c = '销售中心';
        cc2.approvalStatus__c = '草稿';
        cc2.reviewNumber__c = cttw.Id;
        insert cc2;
    }

    static testMethod void testMethod8() 
    {
        User u1 = [SELECT Id,Name from User WHERE IsActive = true Limit 1];
        Account a = [SELECT Id,Name FROM Account WHERE bankAccount__c != NULL Limit 1];
        Opportunity o1 = [SELECT Id,Name from Opportunity WHERE RecordType.Name != '小额订单' AND StageName = '赢单' Limit 1];
        
        RecordType ContractRecordType1 = [Select id from RecordType where SobjectType =:'Contract__c' and Name =:'有机会有合同' limit 1];
        Contract__c cc2 = new Contract__c();  //有合同
        cc2.account__c= a.id;
        cc2.signedby__c= u1.id;
        cc2.deliveryPerson__c = u1.id;
        cc2.accountManager__c = u1.id;
        cc2.tenderScheme__c = '1234';
        cc2.opportunity__c = o1.id;
        cc2.ownerid = u1.id;
        cc2.amount__c = 100000;
        cc2.returnAmountAll__c = 1;
        cc2.incomeConfirmDate__c = Date.today();
        cc2.RecordTypeId = ContractRecordType1.id;
        cc2.salesDepartment__c = '华东区';
        cc2.salesProvince__c = '江苏-电厂';
        cc2.deliveryTeamDepartment__c   = '东北区';
        cc2.deliveryTeamProvince__c = '黑龙江';
        cc2.deliveryTeamCenter__c = '销售中心';
        cc2.approvalStatus__c = '草稿';
        insert cc2;

        guaranteeLetter__c glt1 = new guaranteeLetter__c(bidNumber__c='121',approvalStatus__c='草稿',contract__c=cc2.id,reason__c='123',type__c='履约保证金',costCenterNumber__c='1111',company__c='北京四方继保自动化股份有限公司',amount__c=123,operator__c=u1.id,invoiceReturnDate__c=System.today(),remittanceWay__c='电汇',notes__c='231312');
        guaranteeLetter__c glt2 = new guaranteeLetter__c(bidNumber__c='121',approvalStatus__c='草稿',contract__c=cc2.id,reason__c='123',type__c='履约保证金',costCenterNumber__c='1111',company__c='北京四方继保自动化股份有限公司',amount__c=123,operator__c=u1.id,invoiceReturnDate__c=System.today(),remittanceWay__c='电汇',notes__c='231312');
        guaranteeLetter__c glt3 = new guaranteeLetter__c(bidNumber__c='121',approvalStatus__c='草稿',contract__c=cc2.id,reason__c='123',type__c='履约保证金',costCenterNumber__c='1111',company__c='北京四方继保自动化股份有限公司',amount__c=123,operator__c=u1.id,invoiceReturnDate__c=System.today(),remittanceWay__c='电汇',notes__c='231312');
        List<guaranteeLetter__c> gltList = new List<guaranteeLetter__c>();
        gltList.add(glt1);
        gltList.add(glt2);
        gltList.add(glt3);
        insert gltList;

        for (guaranteeLetter__c g : gltList) {
            g.approvalStatus__c = '审批通过';
        }
        update gltList;
    }

    static testMethod void testMethod9() 
    {
        User u1 = [SELECT Id,Name from User WHERE IsActive = true Limit 1];
        Account a = [SELECT Id,Name FROM Account WHERE bankAccount__c != NULL Limit 1];
        Opportunity o1 = [SELECT Id,Name from Opportunity WHERE RecordType.Name != '小额订单' AND StageName = '赢单' Limit 1];
        
        tbbaozhengjin__c tbbzj = new tbbaozhengjin__c(type__c ='投标保证金',approvalStatus__c='审批通过',
                                                        remittanceNumber__c=1111,account__c=a.id,rate__c=2.2,
                                                        opportunity__c=o1.id,peymentDate__c=System.today(),
                                                        company__c='北京四方继保自动化股份有限公司',costCenterNumber__c='222',
                                                        operator__c=u1.id,invoiceReturnDate__c=System.today(),
                                                        remittanceWay__c = '电汇',reason__c='1111',payComment__c='231313');
        insert tbbzj;
    }
}