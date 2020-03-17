@isTest(seeAlldata = true)
public with sharing class AttenmentUpdateContract_test {

    static testMethod void testSalesLeadsApprove1(){

	    System.Test.startTest();
	    User u1 = [select Id,Profile.Name from User where Profile.Name = 'A-客户经理' limit 1];
	    User u2 = [select Id,Profile.Name from User where Profile.Name = 'A-合同管理员（运营）' limit 1];

	    Opportunity o1 = [select Id,opportunityRecordType__c from Opportunity where StageName = '赢单' limit 1];
	    Account a = [select Id from Account where accountStatus__c = '有效' limit 1];
	    quatation__c qtc = [select Id from quatation__c where approvalStatus__c='审批通过' limit 1];
	    bidReview__c brc = [select Id from bidReview__c where approvalStatus__c='审批通过' limit 1];

	    Contract__c cc1 = [select Id from Contract__c where approvalStatus__c='审批通过' limit 1];

	    contractreview__c cttw = [select Id from contractreview__c where approvalStatus__c='审批通过' and active__c='有效' and opportunity__c=:o1.Id limit 1];

	    notCommonOutsourcing__c ncoc = [select Id from notCommonOutsourcing__c limit 1];

	    shipping__c shipping = [select Id from shipping__c where approvalStatus__c = '审批通过' limit 1];

	    RecordType contractchangeType = [SELECT Id from RecordType where  SobjectType= :'contractchange__c' and name =:'供货范围变更'];
	    contractchange__c ctcc = new contractchange__c(RecordTypeId =contractchangeType.id,contract__c=cc1.id,changeContent__c='222',totalDischarge__c =true,applyBy__c='设计院',contractAdmin__c=u2.id,approvalStatus__c='提交待审批');  
        ctcc.MainIndustrySales2__c = '输变电业务';
        ctcc.MainProductGroup__c = '输变电业务单元-电网保护自动化事业部';
        insert ctcc;
        
        //创建报价附件   
        List<attachment__c> attList = new List<attachment__c>();   
        attachment__c atc1 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',quatation__c = qtc.id,contract__c = cc1.Id,contractReview__c=cttw.Id,ChangeNum__c=1,contractChange__c = ctcc.Id);
        insert atc1;
        atc1.attachmentURL__c='www.456.com';
    
        atc1.ChangeNum__c = 2;
        update atc1;


        attachment__c atc2 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contract__c = cc1.id,bidReview__c = brc.Id);
        attList.add(atc2);
        attachment__c atc3 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contract__c = cc1.id,notCommonOutsourcing__c = ncoc.Id);
        attList.add(atc3);
        attachment__c atc4 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contractReview__c=cttw.Id);
        attList.add(atc4);
        attachment__c atc5 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contract__c = cc1.id);
        attList.add(atc5);
        attachment__c atc6 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contract__c = cc1.id,quatation__c = qtc.id);
        attList.add(atc6);
        attachment__c atc7 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',shipping__c = shipping.Id);
        attList.add(atc7);
        attachment__c atc8 = new attachment__c(type__c ='供货范围清单',isValid__c = '有效',documentName__c='2222',attachmentURL__c='www.123.com',notes__c ='222',contractChange__c = ctcc.Id);
        attList.add(atc8);

        insert attList;

        update attList;
      	System.Test.stopTest();  
   	}
}