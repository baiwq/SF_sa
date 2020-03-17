trigger ContractBeforeUpdate on Contract__c (before update) {
if(trigger.new.size() > 100){
      System.Debug('Contract Batch DMLs, ignore...');
}else{
   for(Contract__c newCC:trigger.new){
      Contract__c oldCC = trigger.oldMap.get(newCC.id);
      //合同评审变化，带出合同评审上的毛利率
      if(newCC.reviewNumber__c!=oldCC.reviewNumber__c){
          contractreview__c cr = [select id, solutionURLCPQContractPrice__c,orderIdCPQ__c,contractProjectGrossProfitMargin__c ,contractProjectGrossProfit__c ,
                                        standardProjectGrossProfitMarginContract__c ,standardProjectGrossProfitContract__c  from contractreview__c where id=:newCC.reviewNumber__c limit 1][0];
                //合同价项目毛利率
                newCC.contractProjectGrossProfitMargin__c = cr.contractProjectGrossProfitMargin__c ;
                //合同价项目毛利润
                newCC.contractProjectGrossProfit__c = cr.contractProjectGrossProfit__c ;
                //合同阶段标准价项目毛利率
                newCC.standardProjectGrossProfitMarginContract__c = cr.standardProjectGrossProfitMarginContract__c ;
                //合同阶段标准价项目毛利润
                newCC.standardProjectGrossProfitContract__c = cr.standardProjectGrossProfitContract__c ;
                //订单号
                newCC.orderIdCPQ__c = cr.orderIdCPQ__c;
                //链接
                newCC.viewCPQURL__c = cr.solutionURLCPQContractPrice__c;
      }
      
// 执行这段代码条件  
/*
voltageLevel__c
projectType__c
contractType__c
subCompany__c
signTeamDepartment__c
signTeamProvince__c
signTeamCenter__c
currency__c
buildType__c
deliveryTeamDepartment__c
deliveryTeamProvince__c
deliveryTeamCenter__c
country__c
province__c
salesTeamDepartment__c
salesTeamProvince__c
salesTeamCenter__c
salesOrgName__c
finalUserGroup__c
finalUserIndustry__c
accountIndustry__c  
*/ 
      if((newCC.approvalPsDate__c != oldCC.approvalPsDate__c)||
         (newCC.approvalStatus__c != oldCC.approvalStatus__c)||
         (newCC.voltageLevel__c != oldCC.voltageLevel__c)||
         (newCC.projectType__c != oldCC.projectType__c)||
         (newCC.contractType__c != oldCC.contractType__c)||
         (newCC.subCompany__c != oldCC.subCompany__c)||
         (newCC.signTeamDepartment__c != oldCC.signTeamDepartment__c)||
         (newCC.signTeamProvince__c != oldCC.signTeamProvince__c)||
         (newCC.signTeamCenter__c != oldCC.signTeamCenter__c)||
         (newCC.currency__c != oldCC.currency__c)||
         (newCC.buildType__c != oldCC.buildType__c)||
         (newCC.deliveryTeamDepartment__c != oldCC.deliveryTeamDepartment__c)||
         (newCC.deliveryTeamProvince__c != oldCC.deliveryTeamProvince__c)||
         (newCC.deliveryTeamCenter__c != oldCC.deliveryTeamCenter__c)||
         (newCC.country__c != oldCC.country__c)||
         (newCC.province__c != oldCC.province__c)||
         (newCC.salesDepartment__c != oldCC.salesDepartment__c)||
         (newCC.salesProvince__c != oldCC.salesProvince__c)||
         (newCC.salesCenter__c != oldCC.salesCenter__c)||
         (newCC.salesOrgName__c != oldCC.salesOrgName__c)||
         (newCC.finalUserGroup__c != oldCC.finalUserGroup__c)||
         (newCC.finalUserIndustry__c != oldCC.finalUserIndustry__c)||
         (newCC.accountIndustry__c != oldCC.accountIndustry__c)||
         (newCC.updateCode__c != oldCC.updateCode__c)){
        
      
      FuncPools FP = new FuncPools();
      Map<String,Map<String,String>> CodeList = new Map<String,Map<String,String>>();
      CodeList = new Map<String,Map<String,String>>(FP.getCodeValues('合同管理'));
      try{
         newCC.voltageLevelCode__c = CodeList.get('电压等级').get(newCC.voltageLevel__c);
         System.Debug('CodeList.get().get(newCC.voltageLevel__c)'+CodeList.get('电压等级').get(newCC.voltageLevel__c));
      }catch(Exception e){
         System.Debug('没有得到 电压等级 的字段编码');
      }
      try{
         newCC.projectTypeCode__c=CodeList.get('工程类别').get(newCC.projectType__c);
         System.Debug('CodeList.get().get(newCC.projectType__c)'+CodeList.get('工程类别').get(newCC.projectType__c));
      }catch(Exception e){
         System.Debug('没有得到 工程类别 的字段编码');
      }
      try{
         newCC.contractTypeCode__c=CodeList.get('合同类型').get(newCC.contractType__c);
         System.Debug('CodeList.get().get(newCC.contractType__c)'+CodeList.get('合同类型').get(newCC.contractType__c));
      }catch(Exception e){
         System.Debug('没有得到 合同类型 的字段编码');
      }
      try{
         newCC.subCompanyCode__c=CodeList.get('合同签订公司').get(newCC.subCompany__c);
         System.Debug('CodeList.get().get(newCC.subCompany__c)'+CodeList.get('合同签订公司').get(newCC.subCompany__c));
      }catch(Exception e){
         System.Debug('没有得到 合同签订公司 的字段编码');
      }
      try{
         newCC.signTeamDepartmentCode__c=CodeList.get('合同签订团队(部门)').get(newCC.signTeamDepartment__c);
         System.Debug('CodeList.get().get(newCC.signTeamDepartment__c)'+CodeList.get('合同签订团队(部门)').get(newCC.signTeamDepartment__c));
      }catch(Exception e){
         System.Debug('没有得到 合同签订团队(部门) 的字段编码');
      }
      try{
         newCC.signTeamProvinceCode__c=CodeList.get('合同签订团队(省区)').get(newCC.signTeamProvince__c);
         System.Debug('CodeList.get().get(newCC.signTeamProvince__c)'+CodeList.get('合同签订团队(省区)').get(newCC.signTeamProvince__c));
      }catch(Exception e){
         System.Debug('没有得到 合同签订团队(省区) 的字段编码');
      }
      try{
         newCC.signTeamCenterCode__c=CodeList.get('合同签订团队(中心)').get(newCC.signTeamCenter__c);
         System.Debug('CodeList.get().get(newCC.signTeamCenter__c)'+CodeList.get('合同签订团队(中心)').get(newCC.signTeamCenter__c));
      }catch(Exception e){
         System.Debug('没有得到 合同签订团队(中心) 的字段编码');
      }
      try{
         newCC.currencyCode__c=CodeList.get('货币单位').get(newCC.currency__c);
         System.Debug('CodeList.get().get(newCC.currency__c)'+CodeList.get('货币单位').get(newCC.currency__c));
      }catch(Exception e){
         System.Debug('没有得到 货币单位 的字段编码');
      }
      try{
         newCC.buildTypeCode__c=CodeList.get('建设类型').get(newCC.buildType__c);
         System.Debug('CodeList.get().get(newCC.buildType__c)'+CodeList.get('建设类型').get(newCC.buildType__c));
      }catch(Exception e){
         System.Debug('没有得到 建设类型 的字段编码');
      }
      try{
         newCC.deliveryTeamDepartmentCode__c=CodeList.get('履约执行团队(部门)').get(newCC.deliveryTeamDepartment__c);
         System.Debug('CodeList.get().get(newCC.deliveryTeamDepartment__c)'+CodeList.get('履约执行团队(部门)').get(newCC.deliveryTeamDepartment__c));
      }catch(Exception e){
         System.Debug('没有得到 履约执行团队(部门) 的字段编码');
      }
      try{
         newCC.deliveryTeamProvinceCode__c=CodeList.get('履约执行团队(省区)').get(newCC.deliveryTeamProvince__c);
         System.Debug('CodeList.get().get(newCC.deliveryTeamProvince__c)'+CodeList.get('履约执行团队(省区)').get(newCC.deliveryTeamProvince__c));
      }catch(Exception e){
         System.Debug('没有得到 履约执行团队(省区) 的字段编码');
      }
      try{
         newCC.deliveryTeamCenterCode__c=CodeList.get('履约执行团队(中心)').get(newCC.deliveryTeamCenter__c);
         System.Debug('CodeList.get().get(newCC.deliveryTeamCenter__c)'+CodeList.get('履约执行团队(中心)').get(newCC.deliveryTeamCenter__c));
      }catch(Exception e){
         System.Debug('没有得到 履约执行团队(中心) 的字段编码');
      }
      try{
         newCC.countryCode__c=CodeList.get('项目实施所在国家').get(newCC.country__c);
         System.Debug('CodeList.get().get(newCC.country__c)'+CodeList.get('项目实施所在国家').get(newCC.country__c));
      }catch(Exception e){
         System.Debug('没有得到 项目实施所在国家 的字段编码');
      }
      try{
         newCC.provinceCode__c=CodeList.get('项目实施所在省份').get(newCC.province__c);
         System.Debug('CodeList.get().get(newCC.province__c)'+CodeList.get('项目实施所在省份').get(newCC.province__c));
      }catch(Exception e){
         System.Debug('没有得到 项目实施所在省份 的字段编码');
      }
      try{
         newCC.salesTeamDepartmentCode__c=CodeList.get('销售大区').get(newCC.salesDepartment__c);
         System.Debug('CodeList.get().get(newCC.salesTeamDepartment__c)'+CodeList.get('销售项目大区').get(newCC.salesDepartment__c));
      }catch(Exception e){
         System.Debug('没有得到 销售项目团队(部门) 的字段编码');
      }
   //销售项目团队-省区比较特殊
      try{
         newCC.salesTeamProvinceCode__c=CodeList.get('销售省区').get(newCC.salesProvince__c);
         System.Debug('CodeList.get().get(newCC.performanceTypeProvince__c)'+CodeList.get('销售省区').get(newCC.salesProvince__c));
      }catch(Exception e){
         System.Debug('没有得到 销售项目团队(省区) 的字段编码');
      }
      try{
         newCC.salesTeamCenterCode__c=CodeList.get('业务单元').get(newCC.salesCenter__c);
         System.Debug('CodeList.get().get(newCC.salesCenter__c)'+CodeList.get('业务单元').get(newCC.salesCenter__c));
      }catch(Exception e){
         System.Debug('没有得到 销售项目团队(中心) 的字段编码');
      }
      /*try{  
         newCC.salesOrgNameCode__c=CodeList.get('销售组织').get(newCC.salesOrgName__c);
         System.Debug('CodeList.get().get(newCC.salesOrgName__c)'+CodeList.get('销售组织').get(newCC.salesOrgName__c));
      }catch(Exception e){
         System.Debug('没有得到 销售组织 的字段编码');
      }*/
      try{
         newCC.finalUserGroupCode__c=CodeList.get('最终用户所属集团').get(newCC.finalUserGroup__c);
         System.Debug('CodeList.get().get(newCC.finalUserGroup__c)'+CodeList.get('最终用户所属集团').get(newCC.finalUserGroup__c));
      }catch(Exception e){
         System.Debug('没有得到 最终用户所属集团 的字段编码');
      }
      try{
         newCC.finalUserIndustryCode__c=CodeList.get('最终用户所属行业').get(newCC.finalUserIndustry__c);
         System.Debug('CodeList.get().get(newCC.finalUserIndustry__c)'+CodeList.get('最终用户所属行业').get(newCC.finalUserIndustry__c));
      }catch(Exception e){
         System.Debug('没有得到 最终用户所属行业 的字段编码');
      }
      try{
         newCC.accountIndustryCode__c=CodeList.get('签约客户行业').get(newCC.accountIndustry__c);
         System.Debug('CodeList.get().get(newCC.accountIndustry__c)'+CodeList.get('签约客户行业').get(newCC.accountIndustry__c));
      }catch(Exception e){
         System.Debug('没有得到 签约客户行业 的字段编码');
      }
      
      }
   }
}
}