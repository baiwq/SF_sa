/*
  类名：ContractApprovalFiledSetValue
  功能：为投标评审上的【销售行业管理代表(Industry_Representative__c)】字段赋值。
  功能逻辑：销售行业管理代表的基础数据维护在【人员配置表】对象中。当投标评审中的【项目所属行业】和【所有人】变更的时候，
       根据【项目所属行业】和【所有人所属大区】查找到【人员配置表】中对应的行业代表。将查到的行业代表赋值给投标评审上
       【销售行业管理代表】。
  对应测试类：TestApprovalAssignment
  作者：Jimmy Cao 曹阳-雨花石
  时间：2019-07-09
 */
trigger ContractApprovalFiledSetValue on contractchange__c(before insert,before update) 
{
    Set<String> mainIndustrySalesSet = new Set<String>(); //所属行业集合
    Set<String> level2DepartmentSet = new Set<String>(); //所属部门集合
    //人员配置表中的部门为空时，为部门无法匹配到时的默认代表。
    level2DepartmentSet.add(null);
    if (trigger.isInsert) 
    {
        for (contractchange__c contractchange : (List<contractchange__c>)trigger.new) 
        {
            if(trigger.new.size() < 50)
            {
                //为销售行业负责人（变更前）赋值，copy自：ContractChangeApproveUpdate 
                if(contractchange.LastUpdateIndustryChange__c == null)
                {
                    //主导行业销售
                    String xshyfzrlike = '%'+contractchange.MainIndustrySales2__c+'%';
                    List<StaffingTables__c> Staff_list = [select LeadingCadre__c from StaffingTables__c where name like :xshyfzrlike ];
                    String xshyfzr = '';
                    if(Staff_list.size() > 0){
                        xshyfzr = Staff_list.get(0).LeadingCadre__c;
                        if( xshyfzr != ''){
                            contractchange.LastUpdateIndustryChange__c = xshyfzr;
                        }
                    }
                }
            }

            if (contractchange.MainIndustrySales__c != null) 
            {
                String mainIndustrySales = contractchange.MainIndustrySales__c;
                //项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
                if (mainIndustrySales.contains('-'))
                {
                mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
                }
                mainIndustrySalesSet.add(contractchange.MainIndustrySales__c);
                mainIndustrySalesSet.add(mainIndustrySales);
            }

            if (contractchange.ownerDepartment__c != null) 
            {
                level2DepartmentSet.add(contractchange.ownerDepartment__c);
            }
        }
    }
    else if (trigger.isUpdate) 
    {
        for (contractchange__c contractchange : (List<contractchange__c>)trigger.new) 
        {
            contractchange__c old_contractchange = (contractchange__c)trigger.oldMap.get(contractchange.Id);

            if(trigger.new.size() < 50)
            {
                //为销售行业负责人（变更前）赋值，copy自：ContractChangeApproveUpdate 
                if( contractchange.MainIndustrySales__c!= old_contractchange.MainIndustrySales__c || contractchange.SalesIndustoryManager__c == null || contractchange.LastUpdateIndustryChange__c == null)
                {
                    //主导行业销售
                    String xshyfzrlike = '%'+contractchange.MainIndustrySales2__c+'%';
                    List<StaffingTables__c> Staff_list = [select LeadingCadre__c from StaffingTables__c where name like :xshyfzrlike ];
                    String xshyfzr = '';
                    if(Staff_list.size() > 0){
                        xshyfzr = Staff_list.get(0).LeadingCadre__c;
                        if( xshyfzr != ''){
                            contractchange.LastUpdateIndustryChange__c = xshyfzr;
                        }
                    }
                }
            }

            if (
                (contractchange.MainIndustrySales__c != null && contractchange.MainIndustrySales__c != old_contractchange.MainIndustrySales__c)
                ||(contractchange.OwnerId != null && contractchange.OwnerId != old_contractchange.OwnerId)
                || contractchange.Industry_Representative__c == null
            ) 
            {
                if (contractchange.MainIndustrySales__c != null) 
                {
                    
                    String mainIndustrySales = contractchange.MainIndustrySales__c;
                    //项目所属行业中有部分数据是“-”分隔主行业和子行业的，此处只需要取主行业。
                    if (mainIndustrySales != null && mainIndustrySales.contains('-'))
                    {
                        mainIndustrySales = mainIndustrySales.substring(0, mainIndustrySales.indexOf('-'));
                    }
                    mainIndustrySalesSet.add(contractchange.MainIndustrySales__c);
                    mainIndustrySalesSet.add(mainIndustrySales);
                    level2DepartmentSet.add(contractchange.ownerDepartment__c);
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
        for (contractchange__c contractchange : (List<contractchange__c>)trigger.new) 
        {
            String staffKey = contractchange.MainIndustrySales__c + '-' + contractchange.ownerDepartment__c;
            String staffKey2 = contractchange.MainIndustrySales__c + '-' + null;
            contractchange.DepartmentManager2__c = contractchange.DepartmentManager__c;
            if (staffMap.containsKey(staffKey)) 
            {
            contractchange.Industry_Representative__c = staffMap.get(staffKey).LeadingCadre__c;
            }
            else if (staffMap.containsKey(staffKey2))
            {
            contractchange.Industry_Representative__c = staffMap.get(staffKey2).LeadingCadre__c;
            }
        }
    }
}