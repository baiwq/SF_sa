@isTest(seeAllData=true)
public with sharing class TestCheckPending{
    
     @isTest(SeeAllData=true) static void testWebCPQGetCurRate(){
        system.test.startTest();
         
        Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
     	WebCPQGetCurRate.GetCurRateInfo('a0P0I00001KmTjy', 'HT-00029968', '100');
        system.test.stopTest();
    }
    
    
      @isTest(SeeAllData=true) static void testCPQGetCurRate(){
        system.test.startTest();
          Test.setMock(HttpCalloutMock.class, new TestGetCurRate()); 
		  CPQGetCurRate test1  = new CPQGetCurRate();
          test1.GetCurRateInfo('a0P0I00001KmTjy', 'HT-00029968', '100');
       
        system.test.stopTest();
    }
    
    
     @isTest(SeeAllData=true) static void testGetApprovalUser(){
        system.test.startTest();
        GetApprovalUser.GetPendingUserList();
        system.test.stopTest();
    }
        
    @isTest(SeeAllData=true) static void testGetUserAppHistory(){
        system.test.startTest();
        DateTime dt = DateTime.now().addMinutes(-3000);
		DateTime dt1 = DateTime.now();
        GetUserAppHistory.GetUserAppHistoryList('yangjun@sf-auto.com',dt, dt1);

        system.test.stopTest();
    }
    
    @isTest(SeeAllData=true) static void testContractChange(){
        system.test.startTest();
        DealContractChange.ContractChangeVo ContractChangeVo = new DealContractChange.ContractChangeVo();
        ContractChangeVo.ContractChangeId = 'CC-026962';
        ContractChangeVo.InitiationChangeSupply = '123123sdfkma';
        ContractChangeVo.AlterationBasis = '123123sdfkma';
        ContractChangeVo.BOMChangeReasons = '123123sdfkma';
        ContractChangeVo.BOMChangeFile = '123123sdfkma';
   		ContractChangeVo.BOMchangeName = '123123sdfkma';
        DealContractChange.getContractChangeInfo(ContractChangeVo);
        
        
        DealContractChange.ContractChangeVo ContractChangeVo1 = new DealContractChange.ContractChangeVo();
        ContractChangeVo1.ContractChangeId = 'CC-0269';
        DealContractChange.getContractChangeInfo(ContractChangeVo1);
         
        system.test.stopTest();
    }

    @isTest(SeeAllData=true) static void testNotifyOutsourcing(){
        system.test.startTest();
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032700', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032705', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032709', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032704', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032703', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032702', '0050I000008WE7r');
        NotifyOutsourcing.EamilToNotifyOutsourcing('a0P0I00001J240X', 'HT-00024400', 'OT-00032701', '0050I000008WE7r');
       
        system.test.stopTest();
    }
    
    @isTest(SeeAllData=true) static void testGetPending(){
        system.test.startTest();
        Test.setMock(HttpCalloutMock.class, new TestGetToken()); 
     	GetPending.GetPendingList('fuxiao@sf-auto.com.testCPQ');
        GetPending.GetPendingList('yangjun@sf-auto.com');
        system.test.stopTest();
    }

    
     @isTest(SeeAllData=true) static void testServiceContract(){
        system.test.startTest();
        DealServiceContract.ServiceContractSignVo ServiceContractSignVo1 = new DealServiceContract.ServiceContractSignVo();
        //ServiceContractSignVo1.ContractCostCode = 'F-00002585';
         
		 ServiceContractSignVo1.ContractCostCode = 'F-00000002';
        
         ServiceContractSignVo1.ServiceContractSigningNo = '123124124';
         ServiceContractSignVo1.PurchasingContractName = '123124124';
         ServiceContractSignVo1.SupplierName = '123124124';
         ServiceContractSignVo1.IsFrameworkContract = '123124124';
         ServiceContractSignVo1.PurchaseContractAmount = '123124124';
         ServiceContractSignVo1.PurchaseContractsPayment = '123124124';
        DealServiceContract.getServiceContractSign(ServiceContractSignVo1);
         
         DealServiceContract.ServiceContractSignVo ServiceContractSignVo2 = new DealServiceContract.ServiceContractSignVo();
         ServiceContractSignVo2.ContractCostCode = 'channad';
        DealServiceContract.getServiceContractSign(ServiceContractSignVo2);
        system.test.stopTest();
    }
    
    
      @isTest(SeeAllData=true) static void testUpdateCostProcessingScheduleList(){
        system.test.startTest();
        DealServiceContract.CostProcessingSchedule Scheduleing = new DealServiceContract.CostProcessingSchedule();
        //Scheduleing.name = 'F-00002585';
        //Scheduleing.BT_NO = 'F-00002585';
        Scheduleing.name = 'F-00000021';
        Scheduleing.BT_NO = 'F-00000021';
          

        DealServiceContract.CostProcessingSchedule Scheduleing1 = new DealServiceContract.CostProcessingSchedule();
        Scheduleing1.name = 'F-00002585Scheduleing1';
        Scheduleing1.BT_NO = 'F-00002585Scheduleing1';
          
          
        DealServiceContract.CostProcessingSchedule Scheduleing2 = new DealServiceContract.CostProcessingSchedule();
        //Scheduleing2.name = 'F-00002586';
        Scheduleing2.name = 'F-00000002';
     
        Scheduleing2.BT_NO = 'F-00002585Scheduleing1';

        List<DealServiceContract.CostProcessingSchedule> CostProcessingScheduleList = new List<DealServiceContract.CostProcessingSchedule>();
        CostProcessingScheduleList.add(Scheduleing);
        CostProcessingScheduleList.add(Scheduleing1);
        CostProcessingScheduleList.add(Scheduleing2);
        CostProcessingScheduleList.add(Scheduleing);
        CostProcessingScheduleList.add(Scheduleing);
        CostProcessingScheduleList.add(Scheduleing);


        DealServiceContract.UpdateCostProcessingScheduleList(CostProcessingScheduleList);  
        system.test.stopTest();
    }
    
    
    
      @isTest(SeeAllData=true) static void testUpdateCostProcessingScheduleList1(){
        system.test.startTest();
          
        DealServiceContract.CostProcessingSchedule Scheduleing1 = new DealServiceContract.CostProcessingSchedule();
        Scheduleing1.name = 'F-00002585Scheduleing1';
        Scheduleing1.BT_NO = 'F-00002585Scheduleing1';
            
        List<DealServiceContract.CostProcessingSchedule> CostProcessingScheduleList = new List<DealServiceContract.CostProcessingSchedule>();
        CostProcessingScheduleList.add(Scheduleing1);
        DealServiceContract.UpdateCostProcessingScheduleList(CostProcessingScheduleList);  
        system.test.stopTest();
    }
    
    
      @isTest(SeeAllData=true) static void testUpdateCostProcessingScheduleList2(){
        system.test.startTest();
          
        DealServiceContract.CostProcessingSchedule Scheduleing1 = new DealServiceContract.CostProcessingSchedule();
        //Scheduleing1.name = 'F-00000002';
        Scheduleing1.name = 'F-00002586';
        
        List<DealServiceContract.CostProcessingSchedule> CostProcessingScheduleList = new List<DealServiceContract.CostProcessingSchedule>();
        CostProcessingScheduleList.add(Scheduleing1);
        DealServiceContract.UpdateCostProcessingScheduleList(CostProcessingScheduleList);  
        system.test.stopTest();
    }
    
    
    
    @isTest(SeeAllData=true) static void testgetInvoiceServiceContract(){
        system.test.startTest();
          
        DealServiceContract.InvoiceServiceContractVo InvoiceServiceContractVo1 = new DealServiceContract.InvoiceServiceContractVo();
          
        DealServiceContract.getInvoiceServiceContract(InvoiceServiceContractVo1);  
        system.test.stopTest();
    }
    
    
    @isTest(SeeAllData=true) static void testgetInvoiceServiceContract1(){
        system.test.startTest();
          
        DealServiceContract.InvoiceServiceContractVo InvoiceServiceContractVo1 = new DealServiceContract.InvoiceServiceContractVo();
        InvoiceServiceContractVo1.ServiceContractSigningNo = 'F-00002586';
        InvoiceServiceContractVo1.ContractCostCode = 'F-00002586';

        //Scheduleing2.name = 'F-00002586';
        //Scheduleing2.name = 'F-00000002';
        DealServiceContract.getInvoiceServiceContract(InvoiceServiceContractVo1);  
        system.test.stopTest();
    }
  
    
     @isTest(SeeAllData=true) static void testServiceContractCost(){
        system.test.startTest();
          
        getServiceContractCost.getContractCostInfo('F-00000080');
        getServiceContractCost.getContractCostList('F-00000080', '');
        system.test.stopTest();
    }
 
    @isTest(SeeAllData=true) static void testServiceContractCost1(){
        system.test.startTest();
          
        getServiceContractCost.getContractCostInfo('F-00002586');
        getServiceContractCost.getContractCostList('F-00002586', '6421');
        getServiceContractCost.getContractCostInfo('F-00000080');
        getServiceContractCost.getContractCostList('F-00000080', '6421');
        system.test.stopTest();
    }
    
     @isTest(SeeAllData=true) static void testServiceContractCost2(){
        system.test.startTest();
          
        getServiceContractCost.getContractCostInfo('F-00002585');
        getServiceContractCost.getContractCostList('F-00002585', '6421');
        getServiceContractCost.getContractCostInfo('F-00000014');
        getServiceContractCost.getContractCostList('F-00000014', '2084');
        system.test.stopTest();
    }
   static testMethod void testdaibian(){
       //创建客户
      Account a = new Account(Name = 'A1',Industry = '电力',category__c = 'C',Rating = '3',billingNation__c = '中国', enterpriseProperty__c = '国企',taxpayerNumber__c = '01pN0000000PyHM',bankAccount__c = '000001',bankBy__c = '建行', postcode__c ='123442', approvalStatus__c = '审批通过',accountStatus__c = '有效');
      insert a;

      invoice__c i= new invoice__c(invoiceStatus__c = '正常',account__c = a.Id,invoiceType__c = '专用发票',orderCompany__c = 'A公司',applyDate__c = System.today(), shippingAddress__c = '北京',receiver__c = '张三');
      insert i;
      
      PageReference thePage = Page.Appinvoice;
      thePage.getParameters().put('id', i.id);
      Test.setCurrentPage(thePage);
      ApexPages.StandardController sc = new ApexPages.standardController(i);
      CheckPending eblb = new CheckPending(sc);
   }

}