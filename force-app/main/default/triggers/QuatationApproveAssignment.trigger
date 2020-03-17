/*
	类名：ApprovalAssignment
	功能：为销售线索上的【销售行业管理代表(Industry_Representative__c)】字段赋值。
	功能逻辑：销售行业管理代表的基础数据维护在【人员配置表】对象中。当线索中的【项目所属行业】和【线索所有人】变更的时候，
			 根据【项目所属行业】和【线索所属部门】查找到【人员配置表】中对应的行业代表。将查到的行业代表赋值给线索上
			 【销售行业管理代表】。
	对应测试类：TestApprovalAssignment
	作者：Jimmy Cao 曹阳-雨花石
	时间：2019-07-09
 */
trigger QuatationApproveAssignment on quatation__c(before insert,before update)
{
    Boolean flag = false;//标记，当trigger为Update触发时，判断是否需要进行销售行业负责人重新复制的逻辑
    if (trigger.isInsert) 
    {
        flag = true;
    }
    else if (trigger.isUpdate) 
    {
	    for (quatation__c qu : (List<quatation__c>)trigger.new) 
	    {
	    	quatation__c old_qu = (quatation__c)trigger.oldMap.get(qu.Id);
	    	if ((qu.MainIndustrySales__c != null && qu.MainIndustrySales__c != old_qu.MainIndustrySales__c) || qu.SalesIndustoryManager__c == null) 
	    	{
	    	    flag = true;
	    	}
	    }
    }

    if (flag) 
    {
    	List<StaffingTables__c> staffList = new List<StaffingTables__c>([SELECT Id,Name,LeadingCadre__c FROM StaffingTables__c WHERE Name != '销售行业管理代表']);
    
    	for (quatation__c qu : (List<quatation__c>)trigger.new) 
    	{
    		for (StaffingTables__c staff : staffList) 
    		{
                if (qu.MainIndustrySales__c != null) {
                    if (staff.Name.contains(qu.MainIndustrySales__c)) 
                    {
                        qu.SalesIndustoryManager__c = staff.LeadingCadre__c;
                    }
                }
    		}
    	}
    }
}