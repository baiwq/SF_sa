trigger ContractCollectBeforeInsert on Contract__c (before insert,before update) {
    Set<Id> ownerIds = new Set<Id>();
    Set<Id> reviewIds = new Set<Id>();
    Set<Id> oppIds = new Set<Id>();
    for(Contract__c cc:trigger.new){
        System.debug('CY======>CC2222:'+cc.OpportinutyType1__c);
        if(cc.OpportinutyType1__c == '集招/集采' && cc.amount__c == null)
        {
            cc.amount__c.addError('集招/集采类型的合同，必须填写合同金额！');
        }
        else if(cc.OpportinutyType1__c == '集招/集采' && cc.accountManager__c == null){
            ownerIds.add(cc.ownerId);
            reviewIds.add(cc.reviewNumber__c);
            oppIds.add(cc.opportunity__c);
        }
    }

    if(ownerIds != null && ownerIds.size() > 0)
    {
        Map<Id,User> userMap = new Map<Id,User>([SELECT Id,center__c,Province__c,department__c from User where Id IN: ownerIds]);
        Map<Id,contractreview__c> reviewMap = new Map<Id,contractreview__c>([select id, reviewer__c, notOutsourcing__c,QuatationCreatedBy__c,contractAmount__c,
                            One__c,Two__c,Three__c,Four__c,Five__c,Six__c,SalesCenter__c,PerformanceOrNot__c,
                            ProductType__c,FinalUserIndustry__c,FinalUserGroup__c,bidPackage__c,ProjectCategory__c,
                            IndustrySecondLevel__c,ContractName__c,SignedBy__c,ContractSupplyDate__c,
                            SignCompany__c,SignTeamCenter__c,SignTeamProvince__c,SignTeamDepartment__c,
                            ContractType__c,DeliveryPerson__c,DeliveryTeamCenter__c,DeliveryTeamProvince__c,
                            DeliveryTeamDepartment__c,BidBatch__c,FrameworkAgreement__c,ExchangeRate__c,Currency__c,
                            WarrantyPeriod__c,SalesDepartment__c,SalesProvince__c,AccountManager__c,
                            SalesTeamCenter__c,SalesTeamProvince__c,SalesTeamDepartment__c,AccountName__c,
                            solutionURLCPQContractPrice__c,orderIdCPQ__c,contractProjectGrossProfitMargin__c ,contractProjectGrossProfit__c ,
                                                standardProjectGrossProfitMarginContract__c ,standardProjectGrossProfitContract__c  from contractreview__c where id IN: reviewIds]);
        Map<Id,Opportunity> OpportunityMap = new Map<Id,Opportunity>([Select id,tenderScheme__c,tenderProducer__c,centralizedBid__c,country__c ,province__c,
                            implementationStation__c,voltageLevel__c,buildType__c,capacity__c,AccountId
                            from Opportunity where id in: oppIds]);
        for(Contract__c cc:trigger.new){
            if(cc.OpportinutyType1__c == '集招/集采' && cc.accountManager__c == null){

                contractreview__c cr;
                if(cc.reviewNumber__c!=null ){
                    cr = reviewMap.get(cc.reviewNumber__c);
                }
                Opportunity opty;
                if(cc.opportunity__c!=null){
                    opty = OpportunityMap.get(cc.opportunity__c);
                
                }
                    
                System.debug('CY=====dddddd=====>CC');
                if(cr!=null){
                    System.debug('CY===222222222===>CC:'+cc.OpportinutyType1__c);
                    User ownerUser = userMap.get(cc.ownerId);
                    //合同价项目毛利率
                    cc.contractProjectGrossProfitMargin__c = cr.contractProjectGrossProfitMargin__c ;
                    //合同价项目毛利润
                    cc.contractProjectGrossProfit__c = cr.contractProjectGrossProfit__c ;
                    //合同阶段标准价项目毛利率
                    cc.standardProjectGrossProfitMarginContract__c = cr.standardProjectGrossProfitMarginContract__c ;
                    //合同阶段标准价项目毛利润
                    cc.standardProjectGrossProfitContract__c = cr.standardProjectGrossProfitContract__c ;
                    //订单号
                    cc.orderIdCPQ__c = cr.orderIdCPQ__c;
                    //链接
                    cc.viewCPQURL__c = cr.solutionURLCPQContractPrice__c;
                    //业务单元 SalesCenter__c
                    cc.salesCenter__c = ownerUser.center__c;
                    //产品类别 ProductType__c
                    //cc.productType__c = cr.ProductType__c;
                    //最终用户所属行业 FinalUserIndustry__c
                    cc.finalUserIndustry__c = cr.FinalUserIndustry__c;
                    //最终用户所属集团 FinalUserGroup__c
                    cc.finalUserGroup__c = cr.FinalUserGroup__c;
                    //最终用户行业二级分类  IndustrySecondLevel__c
                    cc.industrySecondLevel__c = cr.IndustrySecondLevel__c;
                    //合同名称  ContractName__c
                    //cc.contractName__c = cr.ContractName__c;
                    //合同金额
                    //cc.amount__c = cr.contractAmount__c;
                    //合同签订人  SignedBy__c
                    cc.signedBy__c = ownerUser.Id;
                    //合同签订供货日期  ContractSupplyDate__c
                    //cc.contractSupplyDate__c = cr.ContractSupplyDate__c;
                    //合同签订公司  SignCompany__c
                    cc.subCompany__c = cr.SignCompany__c;
                    //合同签订团队(中心)  SignTeamCenter__c
                    cc.signTeamCenter__c = ownerUser.center__c;
                    //合同签订团队(省区)  SignTeamProvince__c
                    cc.signTeamProvince__c = ownerUser.Province__c;
                    //合同签订团队(部门)  SignTeamDepartment__c
                    cc.signTeamDepartment__c = ownerUser.department__c;
                    //合同类型  ContractType__c
                    //cc.contractType__c = cr.ContractType__c;
                    //履约执行人 DeliveryPerson__c
                    cc.deliveryPerson__c = ownerUser.Id;
                    //履约执行团队(中心)  DeliveryTeamCenter__c
                    cc.deliveryTeamCenter__c = ownerUser.center__c;
                    //履约执行团队(省区) DeliveryTeamProvince__c
                    cc.deliveryTeamProvince__c = ownerUser.Province__c;
                    //履约执行团队(部门)  DeliveryTeamDepartment__c
                    cc.deliveryTeamDepartment__c = ownerUser.department__c;
                    //投标批次  BidBatch__c
                    cc.bidBatch__c = cr.BidBatch__c;
                    //框架协议编号  FrameworkAgreement__c
                    cc.frameworkAgreement__c = cr.FrameworkAgreement__c;
                    //汇率  ExchangeRate__c
                    cc.exchangeRate__c = cr.ExchangeRate__c;
                    //货币单位  Currency__c
                    cc.currency__c = cr.Currency__c;
                    //质保期  WarrantyPeriod__c
                    //cc.warrantyPeriod__c = cr.WarrantyPeriod__c;
                    //销售大区  SalesDepartment__c
                    cc.salesDepartment__c = ownerUser.department__c;
                    //销售省区  SalesProvince__c
                    cc.salesProvince__c = ownerUser.Province__c;
                    //销售项目主责人  AccountManager__c
                    cc.accountManager__c = ownerUser.Id;
                    //销售项目团队(中心)  SalesTeamCenter__c
                    cc.salesTeamCenter__c = ownerUser.center__c;
                    //销售项目团队(省区)  SalesTeamProvince__c
                    cc.salesTeamProvince__c = ownerUser.Province__c;
                    //销售项目团队(部门)  SalesTeamDepartment__c
                    cc.salesTeamDepartment__c = ownerUser.department__c;
                    //标包 bidPackage__c
                    cc.packageNumber__c = cr.bidPackage__c;
                    //是否计入销售业绩  PerformanceOrNot__c
                    cc.performanceOrNot__c = cr.PerformanceOrNot__c;
                    //工程类别
                    //cc.projectType__c = cr.ProjectCategory__c;

                    //客户信息 2019.12.13
                    cc.account__c = cr.AccountName__c;
                }
                //得到业务机会上的字段信息
                if(opty!=null){
                    //标书-方案编号 tenderScheme__c
                    cc.tenderScheme__c = opty.tenderScheme__c;
                    //标书制作人  tenderProducer__c
                    cc.tenderProducer__c = opty.tenderProducer__c;
                    //是否集中招标  centralizedBid__c
                    cc.centralizedBid__c = opty.centralizedBid__c;
                    //项目实施所在国家  country__c
                    cc.country__c = opty.country__c;
                    //项目实施所在省份  province__c
                    //cc.province__c = opty.province__c;
                    //项目实施所在厂站  implementationStation__c
                    //cc.implementationStation__c = opty.implementationStation__c;
                    //电压等级  voltageLevel__c
                    //cc.voltageLevel__c = opty.voltageLevel__c;
                    //建设类型  buildType__c
                    //cc.buildType__c = opty.buildType__c;
                    //容量(MW) capacity__c
                    //cc.capacity__c = opty.capacity__c;
                    //工程类别  projectType__c
                
                    //客户
                    //cc.account__c = opty.AccountId;
                }                
            }
            System.debug('=======contract======'+cc);
        }
    }
    
}