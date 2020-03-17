@isTest(seeAllData=true)
private class guaranteeLetterNumUnderContract_Test {

	// 合同下履约保证金/保函的申请次数
    static testMethod void testMethod1() 
    {
    	contract__c con = [select Id,approvalStatus__c from contract__c where approvalStatus__c= '审批通过' limit 1];
        System.Test.startTest();
        if(con!=null)
        {
        	guaranteeLetter__c gua = new guaranteeLetter__c(type__c= '其它保函',guaLetterName__c = 'ceshi',contract__c =con.Id );
        	insert gua;
        }
        else
        {
        	guaranteeLetter__c gua = new guaranteeLetter__c(type__c= '其它保函',guaLetterName__c = 'ceshi' );
        	insert gua;
        }
        System.Test.stopTest();
    }
}