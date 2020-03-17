/*
	类名：guaranteeLetterNumUnderContract
	功能：汇总该履约保证金对应的合同的已经审批通过的履约保证金申请次数
	对应测试类：guaranteeLetterNumUnderContract_Test
	覆盖率：
	作者：Mark 柏文强-雨花石
	时间：2019-12-20
 */
trigger guaranteeLetterNumUnderContract on guaranteeLetter__c(before insert) 
{
	// 合同 key 集合
    Set<Id> conIdSet = new Set<Id>();
    // List<guaranteeLetter__c> guaList = new List<guaranteeLetter__c>();
    for (guaranteeLetter__c guaLetter : Trigger.new) 
    {
    	if(guaLetter.contract__c!=null)
    	{
    		conIdSet.add(guaLetter.contract__c);
    	}
    }

    Map<Id,Contract__c> conMap = new Map<Id,Contract__c>([select Id,(select Id from contractGuaranteeLetter__r where approvalStatus__c='审批通过') from Contract__c where Id In:conIdSet]);

    for (guaranteeLetter__c guaLetter : Trigger.new) 
    {
    	if(guaLetter.contract__c!=null)
    	{
    		contract__c con = conMap.get(guaLetter.contract__c);
    		if(con.contractGuaranteeLetter__r!=null)
    		{
    			Integer num = con.contractGuaranteeLetter__r.size();
    			guaLetter.contractGuaHandleTimes__c = Double.valueOf(num); 
    			// guaList.add(guaLetter);
    		}
    	}
    }
    // update guaList;
}