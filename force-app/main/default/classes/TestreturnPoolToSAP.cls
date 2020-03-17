@isTest
public class TestreturnPoolToSAP
{
    @testSetup static void CreateBaseData(){
        //创建用户
      User u1 = new User(LastName = '测试经理1',Alias = '测试1', UserName = 'sunx1@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test1', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心');
      insert u1;
      
      User u2 = new User(LastName = '测试经理2',Alias = '测试2', UserName = 'sunx2@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test23', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u1);
      insert u2;
      
      User u3 = new User(LastName = '测试经理3',Alias = '测试3', UserName = 'sunx3@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test3', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u2);
      insert u3;
      
      User u4 = new User(LastName = '测试经理4',Alias = '测试4', UserName = 'sunx4@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test4', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u4;
      
      User u5 = new User(LastName = '测试经理5',Alias = '测试5', UserName = 'sunx5@tranzvision.sifang.test',
                   email = 'sunx@tranzvision.sifang',COMMUNITYNICKNAME = 'test5', LanguageLocaleKey='en_US', LocaleSidKey='en_US',
                   ProfileId = UserInfo.getProfileId(),EmailEncodingKey='UTF-8', TimeZoneSidKey='America/Los_Angeles', center__c = '销售中心', Manager = u3);
      insert u5;

//创建客户
      Account a = new Account(Name = 'A111111111111111111111111111111111111111111111111111111111111111111111111111111111111111',Industry = '电力',category__c = 'A',Rating = '1',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;
      
//创建联系人
      Contact c = new Contact(LastName ='孙权', AccountId = a.Id);
      insert c;
      
//创建潜在客户
      Lead l1 = new Lead(Status = '未转化',Email = '123@sifang.com',account__c = a.Id, owner__c = u1.Id, Lastname = '张', Company = '四方继保',contact__c = c.Id, stationLevel__c = '20kV',expectBidDate__c = system.today(), pathBy__c ='公共媒体', expectAmount__c = 10000, Description = 'aaa');
      insert l1;
      l1.Status = '重复';
      update l1;
      l1.Status = '已转化';
      update l1;
      
//创建销售线索
      salesLeads__c s1 = new salesLeads__c(Name = 'S1NAME',requirements__c = 'xxx', pathBy__c = '公共媒体', account__c = a.Id,industry__c ='国网总部',estimatedAmount__c = 10000.00,
                                            expectBidDate__c = system.today(),projectStage__c = '内部立项',projectGoal__c = '获得利润',stationLevel__c = '35kV',
                                            projectCategory__c ='常规项目',projectLevel__c = '一般项目',bidLanguage__c ='中文',projectTrackingStrategy__c ='123',
                                            projectTrackingPlan__c ='123',deliverWorkRange__c = '服务');
      insert s1;

//创建业务机会
      opportunity o1 = new opportunity(Name = 'O1NAME', StageName = '赢单', projectStage__c ='内部立项',expectAmount__c = 10000.00,CloseDate = Date.today().addDays(7), AccountId =a.id, actualbidamount__c = 10);
      insert o1;
      
//创建投标保证金
      tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o1.Id,type__c = '投标保证金',operator__c = u1.Id, account__c =a.id,amount__c = 100000,remittanceWay__c ='电汇',company__c='北京四方继保自动化股份有限公司', approvalStatus__c = '审批通过');
      insert t1;   
      
//创建机会点成员
      OpportunityTeamMember OT = new OpportunityTeamMember(OpportunityId = o1.id, TeamMemberRole ='销售经理',UserId = u3.id);
      insert OT;
    
//创建业绩分配比例及成员
      commisionSplit__c CS = new commisionSplit__c(opportunity__c = o1.id);
      insert CS;
      
      commisionUser__c cu = [Select id, performanceProportion__c from commisionUser__c limit 1];     
      cu.performanceProportion__c = 0.9;
      update cu;
      
      CS.approvalStatus__c = '审批通过';
      update CS;
    
//创建合同
      Contract__c cc = new Contract__c();  //有合同
      cc.account__c= a.id;
      cc.signedby__c= u1.id;
      cc.deliveryPerson__c = u2.id;
      cc.accountManager__c = u3.id;
      cc.updateCode__c = '1234';
      cc.opportunity__c = o1.id;
      cc.ownerid = u1.id;
      cc.amount__c = 10000000;
      cc.returnAmountAll__c = 1;
      cc.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc.deliveryTeamCenter__c='销售中心';
      cc.deliveryTeamDepartment__c='东北区';
      cc.deliveryTeamProvince__c='吉林';
      cc.salesDepartment__c = '华东区';
      cc.salesProvince__c = '江苏-电厂';
      insert cc; 
      Contract__c cc2 = new Contract__c();  //有合同
      cc2.account__c= a.id;
      cc2.signedby__c= u1.id;
      cc2.deliveryPerson__c = u2.id;
      cc2.accountManager__c = u3.id;
      cc2.updateCode__c = '12345';
      cc2.opportunity__c = o1.id;
      cc2.ownerid = u1.id;
      cc2.amount__c = 100000;
      cc2.returnAmountAll__c = 1;
      cc2.contractReceptDate__c = date.newInstance(2016, 2, 17);
      cc2.incomeConfirmDate__c=system.today();
      cc2.deliveryTeamCenter__c='销售中心';
      cc2.deliveryTeamDepartment__c='东北区';
      cc2.deliveryTeamProvince__c='吉林';
      cc2.salesDepartment__c = '华东区';
      cc2.salesProvince__c = '江苏-电厂';
      insert cc2; 
//创建履约保证金
      guaranteeLetter__c g1 = new guaranteeLetter__c(contract__c = cc.Id,amount__c =100000,type__c = '履约保证金',company__c='北京四方继保自动化股份有限公司', approvalStatus__c = '审批通过');
      insert g1;
    }
    static testMethod void TestreturnPoolToSAP()
    {
        test.startTest();
      Account acc1 = [Select id from Account limit 1];
      User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
      User user2 = [Select id from User where username =:'sunx3@tranzvision.sifang.test' limit 1];
      RecordType type11 = [Select id from RecordType where SobjectType =:'returnPool__c' and Name =:'电汇' limit 1];
      RecordType type12 = [Select id from RecordType where SobjectType =:'returnPool__c' and Name =:'承兑汇票' limit 1];
      RecordType type21 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'合同回款' limit 1];
      RecordType type22 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'利息' limit 1];
      RecordType type23 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'投标保证金清分' limit 1];
      
      opportunity o =[select id from opportunity where Name = :'O1NAME' limit 1];
        
      Contract__c c1 = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
      Contract__c c2 = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c, incomeConfirmDate__c from Contract__c where updateCode__c = :'12345' limit 1]; 
      
      //投标
      //tbbaozhengjin__c t1 = new tbbaozhengjin__c(opportunity__c = o.Id,operator__c = user1.Id, account__c =acc1.id,amount__c = 10000,remittanceWay__c ='电汇',type__c='投标保证金' );
      //insert t1; 
      tbbaozhengjin__c t1 = [select id from tbbaozhengjin__c where opportunity__c = :o.Id limit 1 ];
      //创建履约保证金
      //guaranteeLetter__c g1 = new guaranteeLetter__c(contract__c = c1.Id,amount__c =10000,type__c = '履约保证金');
      //insert g1;
      guaranteeLetter__c g1 = [select id from guaranteeLetter__c where contract__c = :c1.Id limit 1];
      returnPool__c rp1 = new returnPool__c(account__c = acc1.Id, amount__c =30000,RecordTypeId = type11.id ,
      receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='货款');
      returnPool__c rp2 = new returnPool__c(account__c = acc1.Id, amount__c =30000,RecordTypeId = type12.id ,
      receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='货款',type1__c='商业承兑汇票');
      returnPool__c rp3 = new returnPool__c(account__c = acc1.Id, amount__c =30000,RecordTypeId = type12.id ,
      receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='货款',type1__c='银行承兑汇票');  
      
      returnPool__c rpTB2 = new returnPool__c(account__c = acc1.Id, amount__c =30000,RecordTypeId = type11.id ,
      receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='投标保证金',type1__c='银行承兑汇票');
      returnPool__c rpTB3 = new returnPool__c(account__c = acc1.Id, amount__c =30000,RecordTypeId = type12.id ,
      receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='投标保证金',type1__c='银行承兑汇票');
     
          
        List<returnPool__c> RPList = new List<returnPool__c>();
        RPList.add(rp1);
        RPList.add(rp2);
        RPList.add(rp3);
       
        RPList.add(rpTB2);
        RPList.add(rpTB3);
        
        insert RPList;
        returnItem__c rim11 = new returnItem__c(returnPool__c = rp2.Id, amount__c = 1000, RecordTypeId = type21.id, contracts__c =c1.id, returnUser__c = user1.id  );
        returnItem__c rim12 = new returnItem__c(returnPool__c = rp2.Id, amount__c = 1000, RecordTypeId = type21.id, contracts__c =c2.id, returnUser__c = user1.id  );
        //returnItem__c rim13 = new returnItem__c(returnPool__c = rp1.Id, amount__c = 1000, RecordTypeId = type21.id, contracts__c =c1.id, returnUser__c = user1.id  );
        List<returnItem__c> riList = new List<returnItem__c>();
        riList.add(rim11);
        riList.add(rim12);
       // riList.add(rim13);
        insert riList;
        //测投标
        //1 利息
        
        //2 转履约
        //returnItem__c rim25 = new returnItem__c(returnPool__c = rpTB2.Id, amount__c = 1000, RecordTypeId = type23.id,  returnUser__c = user1.id ,bidCost__c=t1.id  );
        //returnItem__c rim26 = new returnItem__c(returnPool__c = rpTB2.Id, amount__c = -1000, RecordTypeId = type23.id, contracts__c =c1.id, returnUser__c = user1.id ,bidCost__c=t1.id ,TtransferL__c=true,LYBaozhengjing__c=g1.Id );

        
        Map<String,String> aMap1 = new Map<String,String>();
        Map<String,String> aMap2 = new Map<String,String>();
        Map<String,String> aMap3 = new Map<String,String>();
        
       
        
        aMap1.put(rp1.id,'20161010');
        aMap2.put(rp2.id,'20161010');
        aMap3.put(rp3.id,'20161010');
        
        //aMap6.put(rpTB2.id,'20161010');
        
        System.debug('aaMap1:'+aMap1.size());
        returnPoolToSAP sta = new returnPoolToSAP();
        
        sta.returnPoolToSAP(aMap1);
        sta.returnPoolToSAP(aMap2);
        //sta.returnPoolToSAP(aMap3);
        //sta.returnPoolToSAP(aMap4);
        //sta.returnPoolToSAP(aMap5);
        //sta.returnPoolToSAP(aMap6); 
        test.stopTest();     
    }
    
    static testMethod void testReturn2(){
        test.startTest();
        Account acc1 = [Select id from Account limit 1];
        User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
        opportunity o =[select id from opportunity where Name = :'O1NAME' limit 1];
        
        Contract__c c1 = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
        tbbaozhengjin__c t1 = [select id from tbbaozhengjin__c where opportunity__c = :o.Id limit 1 ];
        guaranteeLetter__c g1 = [select id from guaranteeLetter__c where contract__c = :c1.Id limit 1];
        RecordType type23 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'投标保证金清分' limit 1];
        returnPool__c rpTB2 = new returnPool__c(account__c = acc1.Id, amount__c =30000,
                                    receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='投标保证金',type1__c='银行承兑汇票');
        insert rpTB2;
        returnItem__c rim25 = new returnItem__c(returnPool__c = rpTB2.Id, amount__c = 1000, RecordTypeId = type23.id,  returnUser__c = user1.id ,bidCost__c=t1.id  );
        returnItem__c rim26 = new returnItem__c(returnPool__c = rpTB2.Id, amount__c = -1000, RecordTypeId = type23.id, contracts__c =c1.id, returnUser__c = user1.id ,bidCost__c=t1.id ,TtransferL__c=true,LYBaozhengjing__c=g1.Id );
        List<returnItem__c> riList2 = new List<returnItem__c>();
        riList2.add(rim25);
        riList2.add(rim26);
        insert riList2;
        Map<String,String> aMap6 = new Map<String,String>();
        aMap6.put(rpTB2.id, '20161010');
        returnPoolToSAP sta = new returnPoolToSAP();        
        
        sta.returnPoolToSAP(aMap6);
        test.stopTest();
    }
    static testMethod void testReturn3(){
        test.startTest();
        Account acc1 = [Select id from Account limit 1];
        User user1 = [Select id from User where username =:'sunx4@tranzvision.sifang.test' limit 1];
        opportunity o =[select id from opportunity where Name = :'O1NAME' limit 1];
        
        Contract__c c1 = [Select id, approvalStatus__c,signedby__c, deliveryPerson__c, accountManager__c from Contract__c where updateCode__c = :'1234' limit 1];
        tbbaozhengjin__c t1 = [select id from tbbaozhengjin__c where opportunity__c = :o.Id limit 1 ];
        guaranteeLetter__c g1 = [select id from guaranteeLetter__c where contract__c = :c1.Id limit 1];
        RecordType type23 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'投标保证金清分' limit 1];
        RecordType type22 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'利息' limit 1];
        returnPool__c rpTB1 = new returnPool__c(account__c = acc1.Id, amount__c =30000 ,
        receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='投标保证金',type1__c='银行承兑汇票');
                //lvyue
        RecordType type24 = [Select id from RecordType where SobjectType =:'returnItem__c' and Name =:'履约保证金清分' limit 1];
        
        returnPool__c rpLV = new returnPool__c(account__c = acc1.Id, amount__c =30000 ,
                receiptOrNot__c='是',returnCompanyCode__c='CC01',date__c= date.valueOf('2016-01-01'),bankofissue__c='北京工商银行',category__c='履约保证金',type1__c='银行承兑汇票');
        List<returnPool__c> RPList = new List<returnPool__c>();
        RPList.add(rpTB1);
        RPList.add(rpLV);
        insert RPList;
        returnItem__c rim21 = new returnItem__c(returnPool__c = rpTB1.Id, amount__c = 1000, RecordTypeId = type23.id,  returnUser__c = user1.id ,bidCost__c=t1.id  );
        returnItem__c rim22 = new returnItem__c(returnPool__c = rpTB1.Id, amount__c = -1000, RecordTypeId = type23.id,  returnUser__c = user1.id ,bidCost__c=t1.id ,TtranzferZ__c=true );
        returnItem__c rim24 = new returnItem__c(returnPool__c = rpTB1.Id, amount__c = 1000, RecordTypeId = type23.id,  returnUser__c = user1.id ,bidCost__c=t1.id  );
        returnItem__c rim23 = new returnItem__c(returnPool__c = rpTB1.Id, amount__c = -1000, RecordTypeId = type22.id,  returnUser__c = user1.id ,bidCost__c=t1.id );

       returnItem__c rim31 = new returnItem__c(returnPool__c = rpLV.Id, amount__c = 1000, RecordTypeId = type24.id, contracts__c =c1.id, returnUser__c = user1.id ,LYBaozhengjing__c=g1.Id );
        List<returnItem__c> riList3 = new List<returnItem__c>();
        riList3.add(rim31);
        insert riList3;
        List<returnItem__c> riList2 = new List<returnItem__c>();
        riList2.add(rim21);
        riList2.add(rim22);
        riList2.add(rim24);
        riList2.add(rim23);
        //riList2.add(rim25);
        //riList2.add(rim26);
        insert riList2;

        Map<String,String> aMap4 = new Map<String,String>();
        Map<String,String> aMap5 = new Map<String,String>();
        aMap4.put(rpTB1.id,'20161010');
        aMap5.put(rpLV.id,'20161010');
        returnPoolToSAP sta = new returnPoolToSAP();
        
        sta.returnPoolToSAP(aMap4);
        sta.returnPoolToSAP(aMap5);
        //sta.returnPoolToSAP(aMap3);
        //sta.returnPoolToSAP(aMap4);
        //sta.returnPoolToSAP(aMap5);
        //sta.returnPoolToSAP(aMap6); 
        test.stopTest(); 
    }
}