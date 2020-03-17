/*
	类名：ApprovalAssignmentBidReview
	功能：为投标评审上的【销售行业管理代表(Industry_Representative__c)】字段赋值。
	功能逻辑：销售行业管理代表的基础数据维护在【人员配置表】对象中。当投标评审中的【项目所属行业】和【所有人】变更的时候，
			 根据【项目所属行业】和【所有人所属大区】查找到【人员配置表】中对应的行业代表。将查到的行业代表赋值给投标评审上
			 【销售行业管理代表】。
	对应测试类：TestApprovalAssignment
	作者：Jimmy Cao 曹阳-雨花石
	时间：2019-07-09
 */
trigger ApprovalAssignmentBidReview on bidReview__c(before insert,before update) 
{
    Set<String> mainIndustrySalesSet = new Set<String>(); //所属行业集合
	Set<String> level2DepartmentSet = new Set<String>(); //所属部门集合
	//人员配置表中的部门为空时，为部门无法匹配到时的默认代表。
	level2DepartmentSet.add(null);
	if (trigger.isInsert) 
	{
		for (bidReview__c bidReview : (List<bidReview__c>)trigger.new) 
		{
			if (bidReview.MainIndustrySales__c != null) 
			{
				String mainIndustrySales = bidReview.MainIndustrySales__c;
				//项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
				if (mainIndustrySales.contains('-'))
				{
					mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
				}
				mainIndustrySalesSet.add(bidReview.MainIndustrySales__c);
				mainIndustrySalesSet.add(mainIndustrySales);
			}

			if (bidReview.ownerDepartment__c != null) 
			{
			    level2DepartmentSet.add(bidReview.ownerDepartment__c);
			}
		}
	}
	else if (trigger.isUpdate) 
	{
		for (bidReview__c bidReview : (List<bidReview__c>)trigger.new) 
		{
			bidReview__c old_bidReview = (bidReview__c)trigger.oldMap.get(bidReview.Id);
			if (
				(bidReview.MainIndustrySales__c != null && bidReview.MainIndustrySales__c != old_bidReview.MainIndustrySales__c)
				||(bidReview.OwnerId != null && bidReview.OwnerId != old_bidReview.OwnerId)
				|| bidReview.Industry_Representative__c == null
				) 
			{
				if (bidReview.MainIndustrySales__c != null) {
				    
				    String mainIndustrySales = bidReview.MainIndustrySales__c;
					//项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
					if (mainIndustrySales.contains('-'))
					{
						mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
					}
					mainIndustrySalesSet.add(bidReview.MainIndustrySales__c);
					mainIndustrySalesSet.add(mainIndustrySales);
					level2DepartmentSet.add(bidReview.ownerDepartment__c);
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
													AND Department__c IN: level2DepartmentSet])
		{
			staffMap.put(staff.Industry__c+'-'+staff.Department__c, staff);
		}
		for (bidReview__c bidReview : (List<bidReview__c>)trigger.new) 
		{
			String staffKey = bidReview.MainIndustrySales__c + '-' + bidReview.ownerDepartment__c;
			String staffKey2 = bidReview.MainIndustrySales__c + '-' + null;
			if (staffMap.containsKey(staffKey)) 
			{
			    bidReview.Industry_Representative__c = staffMap.get(staffKey).LeadingCadre__c;
			}
			else if (staffMap.containsKey(staffKey2))
			{
			    bidReview.Industry_Representative__c = staffMap.get(staffKey2).LeadingCadre__c;
			}
		}
	}
}