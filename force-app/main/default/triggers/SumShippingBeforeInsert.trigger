/*
	类名：SumShippingBeforeInsert
	功能：统计发货所有人所属省区所有时间的无合同发货汇总金额

	对应测试类：TestSumShippingBeforeInsert
	作者：Mark 柏文强-雨花石
	时间：2019-11-15
 */
trigger SumShippingBeforeInsert on shipping__c(before insert,before update) 
{
	System.debug('进入SumShippingBeforeInsert！');
	Set<String> strSet = new Set<String>();
	// if(strSet.contains('SumShippingBeforeInsert'))
	// {
	// 	return;
	// }
	// else
	// {
	// 	strSet.add('SumShippingBeforeInsert');
	// }
	Map<String,Decimal> amountMap = new Map<String,Decimal>();
    // provinceSet
    Set<String> provinceSet = new Set<String>();
    for(shipping__c ship:Trigger.new)
    {
    	provinceSet.add(ship.province__c);
    }

    System.debug('provinceSet=='+provinceSet);

    List<shipping__c> shipList = [select Id,province__c,noReturnContractAmount__c from shipping__c where province__c In:provinceSet and contractOrNot__c='无' and approvalStatus__c='审批通过'];
    
	if(shipList.size()>0)
	{
		System.debug('有值！');
	    for (shipping__c ship : shipList) 
	    {
	    	System.debug('为返回值='+ship.noReturnContractAmount__c);
	    	Decimal noReturnContractAmount=0;
	    	if(String.isNotBlank(ship.province__c))
	    	{
	    		if(amountMap.containsKey(ship.province__c))
	    		{
	    			noReturnContractAmount = amountMap.get(ship.province__c);
	    			noReturnContractAmount = noReturnContractAmount + ship.noReturnContractAmount__c;
	    			amountMap.put(ship.province__c, noReturnContractAmount);
	    		}
	    		else
	    		{
	    			amountMap.put(ship.province__c,ship.noReturnContractAmount__c);
	    		}
	    	}
	    }

	    for(shipping__c ship:Trigger.new)
	    {
	    	if(amountMap.containsKey(ship.province__c))
	    	{
	    		ship.summaryOfDeliveryAmount__c = amountMap.get(ship.province__c);
	    	}
	    }
	}

}