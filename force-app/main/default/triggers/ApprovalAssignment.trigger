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
trigger ApprovalAssignment on salesLeads__c(before insert,before update) 
{
	Set<String> mainIndustrySalesSet = new Set<String>(); //所属行业集合
	Set<String> level2DepartmentSet = new Set<String>(); //所属部门集合
	//人员配置表中的部门为空时，为部门无法匹配到时的默认代表。
	level2DepartmentSet.add(null);
	if (trigger.isInsert) 
	{
		for (salesLeads__c lead : (List<salesLeads__c>)trigger.new) 
		{
			if (lead.MainIndustrySales__c != null) 
			{
				String mainIndustrySales = lead.MainIndustrySales__c;
				//项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
				if (mainIndustrySales.contains('-'))
				{
					mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
				}
				mainIndustrySalesSet.add(lead.MainIndustrySales__c);
				mainIndustrySalesSet.add(mainIndustrySales);
			}

			if (lead.level2Department__c != null) 
			{
			    level2DepartmentSet.add(lead.level2Department__c);
			}
		}
	}
	else if (trigger.isUpdate) 
	{
		for (salesLeads__c lead : (List<salesLeads__c>)trigger.new) 
		{
			salesLeads__c old_lead = (salesLeads__c)trigger.oldMap.get(lead.Id);
			if (
				(lead.MainIndustrySales__c != null && lead.MainIndustrySales__c != old_lead.MainIndustrySales__c)
				||(Lead.OwnerId != null && lead.OwnerId != old_lead.OwnerId)
				|| Lead.Industry_Representative__c == null
				) 
			{
				if (lead.MainIndustrySales__c != null) 
				{
				    String mainIndustrySales = lead.MainIndustrySales__c;
					//项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
					if (mainIndustrySales.contains('-'))
					{
						mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
					}
					mainIndustrySalesSet.add(lead.MainIndustrySales__c);
					mainIndustrySalesSet.add(mainIndustrySales);
					level2DepartmentSet.add(lead.level2Department__c);
				}
			}
		}
	}


	if (mainIndustrySalesSet != null && mainIndustrySalesSet.size() > 0 
		&& level2DepartmentSet != null && level2DepartmentSet.size() > 0) 
	{
	    Map<String,StaffingTables__c> staffMap = new Map<String,StaffingTables__c>();//Map<行业-部门,配置表数据>
		for (StaffingTables__c staff : [SELECT Id,Name,Industry__c,LeadingCadre__c,Department__c 
												FROM StaffingTables__c 
												WHERE Industry__c IN: mainIndustrySalesSet 
														OR Department__c IN: level2DepartmentSet])
		{
			staffMap.put(staff.Industry__c+'-'+staff.Department__c, staff);
		}
		System.debug('=====mainIndustrySalesSet:'+mainIndustrySalesSet);
		System.debug('=====level2DepartmentSet:'+level2DepartmentSet);
		System.debug('=====staffMap:'+staffMap);
		for (salesLeads__c lead : (List<salesLeads__c>)trigger.new) 
		{
			String staffKey = lead.MainIndustrySales__c + '-' + lead.level2Department__c;
			String staffKey2 = lead.MainIndustrySales__c + '-' + null;
			if (staffMap.containsKey(staffKey)) 
			{
				System.debug('======staffKey:'+staffKey);
			    lead.Industry_Representative__c = staffMap.get(staffKey).LeadingCadre__c;
			}
			else if (staffMap.containsKey(staffKey2))
			{
				System.debug('======staffKey:'+staffKey2);
			    lead.Industry_Representative__c = staffMap.get(staffKey2).LeadingCadre__c;
			}
		}
	}
}