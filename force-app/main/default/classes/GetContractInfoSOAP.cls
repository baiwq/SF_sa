/*  功能：2018.8.1 新增字段：
        合同状态
        履约执行人
        回款比例
        记录类型
        容量
        合同价项目毛利率
        开票总金额
        开票总额比例
        所有人
        合同签订团队(中心)
        合同签订团队(部门)
        合同签订团队(省区)
        履约执行团队(中心)
        履约执行团队(部门)
        履约执行团队(省区)

 * 
 */
global class GetContractInfoSOAP{
    
    global class pList{
        
        webService  Datetime    CRETEAD_DATE;
        webService  String  CONTRACT_NO;
        webService  String  SIGNCUSTOMER_CODE;
        webService  String  SIGNCUSTOMER_NAME;
        webService  String  PROJECT_NAME;
        //付款单位
        webService  String  PAYCUSTOMER_NAME;
        webService  String  PAYCUSTOMER_CODE; 
        
        webService  Decimal CONTRACT_AMOUNT;
        webService  Decimal ESTIMATE_AMOUNT;
        webService  String  PECUNIARY_UNIT;
        webService  Decimal EXCHANGE_RATE;
        webService  Decimal RMB_AMOUNT;
        webService  String  PROJECT_TYPE_CODE;
        webService  String  PROJECT_TYPE_NAME;
        webService  String  CONTRACT_TYPE_CODE;
        webService  String  CONTRACT_TYPE;
        webService  String  VOLTAGE_LEVEL_CODE;
        webService  String  VOLTAGE_LEVEL;
        webService  String  VOLUME;
        webService  Date    SIGNED_DATE;
        webService  Date    DELIVERY;        
        webService  String  OURSIGNINGE_NUM;
        webService  String  OURSIGNING_NAME;
        webService  String  SALES_ORG_CODE;
        webService  String  SALES_ORG_NAME;
        webService  String  PROVINCE_CODE;
        webService  String  PROVINCE_NAME;
        webService  String  REGION_CODE;
        webService  String  REGION_NAME;
        webService  String  CUSTOMERBUSINESS_LINKER;
        webService  String  CUSTOMERBUSINESS_PHONE;
        webService  String  CUSTOMERFAX;
        webService  String  RECEIVEINVOICE_CUSTOMER_CODE;
        webService  String  RECEIVEINVOICE_CUSTOMER_NAME;
        webService  String  PAY_TYPE_CODE;
        webService  String  PAY_TYPE_NAME;
        webService  String  RATIO_PAY_CODE;
        webService  String  RATIO_PAY_NAME;
        webService  Date    AGREEMENT_DATE;
        webService  Date    CONTRACT_DATE;
        webService  String  COMPANY_CODE;
        webService  String  COMPANY_NAME;
        webService  String  BUSINESS_CODE;
        webService  String  BUSINESS_NAME;
        webService  String  CUSTOMER_INDUSTRY_CODE;
        webService  String  CUSTOMER_INDUSTRY_NAME;
        webService  String  CANCEL_MARK;
        webService  String  CONTRACT_REMARK;
        webService  Date    REVIEW_DATE;
        webService  String  REVIEW_CODE;
        webService  String  END_CUSTOMER_INDUSTRY_CODE;
        webService  String  END_CUSTOMER_INDUSTRY_NAME;
        webService  String  END_CUSTOMER_GROUPS_CODE;
        webService  String  END_CUSTOMER_GROUPS_NAME;
        webService  String  IS_SCHEDULING_CONTRACT;
        webService  String  CUSTOMER_CONTRACT_NO;
        webService  String  OURBUSINESSMAN_NUM;
        webService  String  OURBUSINESSMAN_NAME;
        webService  Date    CONTRACT_EXPECTED_DATE;
        webService  Date    USER_SURE_SUPPLY_DATE;
        webService  String  TECHNICAL_CONTACT_NAME;
        webService  String  TECHNICAL_CONTACT_TEL;
        webService  String  DESIGN_INSTITUTE_LINKER;
        webService  String  DESIGN_INSTITUTE_LINKERPHONE;
        webService  String  THIRD_PARTY_LINKER;
        webService  String  THIRD_PARTY_LINKERPHONE;
        webService  String  PROPOSAL_NO;
        webService  String  PROPOSAL_BATCH;
        webService  String  PROJECT_DESIGN_DIRECTOR;
        webService  String  PROJECT_COUNTRY_NO;
        webService  String  PROJECT_COUNTRY;
        webService  String  PROJECT_PROVINCE_NO;
        webService  String  PROJECT_PROVINCE;
        webService  String  SCHEDULING_BASE;
        webService  Date    CONTRACT_CHANGED_DATE;
        webService  String  INFRASTRUCTURE_TYPE_CODE;
        webService  String  INFRASTRUCTURE_TYPE_NAME;
        webService  String  PROJECT_SUBSTATION;
        webService  String  FRAMWORK_AGREEMENT_NO;
        webService  String  FILING_NO;
        webService  String  FINANCIAL_FILED_NUM;
        webService  String  FINANCIAL_FILED_NAME;
        webService  Date    FINANCIAL_FILE_DATE;
        webService  Date    PLANPRODUCTDATE;
        webService  Date    DELIVERDATE;
        webService  String  PECUNIARY_UNIT_CODE;
        webService  String  PECUNIARY_UNIT_NAME;
        webService  String  TENDER_PRODUCER_CODE;
        webService  String  TENDER_PRODUCER_NAME;
        webService  String  IS_TOTAL_DISCHARGE;
        webService  String  INCOMPLETE_REASON;
        webService  Datetime  CREATED_ON_DT;
        webService  Datetime  CHANGED_ON_DT;
        webService  String  CONTRACT_URL;
        webService  String WARRANTYPERIOD;
        webService  String OPPORTUNITYNUMBER;
        //新增行业二级
        webService  String IndustrySecondLevel;
        //新增合同评审9个字段
        webService  String  technologyReviewContent;
        webService  String  technologyReviewSuggestion;
        webService  String  technologyReviewExpert;
        webService  String  technologyFinalReviewSuggestion;
        webService  String  outsourcingReviewContent;
        webService  String  outsourcingReviewSuggestion;
        webService  String  outsourcingReviewExpert;
        webService  String  outsourcingFinalReviewSuggestion;
        webService  String  projectClassification;
        
        //质保期  20200103增加
        webService  String  CONTRACTWARRANTYPERIOD;
        //新增合同上俩个字段
        //客户风险等级
        webservice  String accountRiskLevel; 
        //是否重点工程项目
        webservice Boolean keyProject;
        //2017-11-29新增字段
        //产品类别
        webservice String productType;
        //合同取消
        webservice String contractCancel;
        //合同审批通过日期
        webservice Date approvalDate;
        //交期备注说明
        webservice String comments;
        //是否集中招标
        webservice Boolean centralizedBid;
        //是否计入销售业绩
        webservice Boolean performanceOrNot;
        //业务机会名称
        webservice String opportunityName;
        //父业务机会名称
        webservice String fatherOpportunityName;
        //重点工程项目编号
        webservice String MPNumber;
        //业务机会记录类型
        webservice String opportunityRecordType;
        //2017.12.13 新增已回总金额
        webservice Decimal returnAmount;
        //2018.1.8 新增客户信用等级
        webservice String creditLevel;
        //2018.8.1 新增字段
        //合同状态
        webservice String active;
        //履约执行人
        webservice String deliveryPersonName;
        //回款比例
        webservice Decimal returnProportion;
        //记录类型
        webservice String RecordTypeName;
        //容量已存在
        //webservice String capacity;
        //合同价项目毛利率
        webservice Decimal contractProjectGrossProfitMargin;
        //开票总金额
        webservice Decimal invoiceSumAmount;
        //开票总额比例
        webservice Decimal invoicePercent;
        //所有人
        webservice String ownerName;
        //合同签订团队(中心)
        webservice String signTeamCenter;
        //合同签订团队(部门)
        webservice String signTeamDepartment;
        //合同签订团队(省区)
        webservice String signTeamProvince;
        //履约执行团队(中心)
        webservice String deliveryTeamCenter;
        //履约执行团队(部门)
        webservice String deliveryTeamDepartment;
        //履约执行团队(省区)
        webservice String deliveryTeamProvince;
        
        //主责事业部
        webservice String MainProductGroup;
        
        

    }
    public List<pList> sPlist{get;set;}
     
    global class contractList{
        webService List<queryContractInfo> contractList;
        
        public contractList(Datetime START_DTIME,Datetime END_DTIME){
            queryContractInfo contractListDetail = new queryContractInfo (START_DTIME,END_DTIME);
            contractList = new List<queryContractInfo>();
            contractList.add(contractListDetail);
        }
    }
    
    global class queryContractInfo {

        webService List<pList> contractInfo;
        public queryContractInfo(Datetime START_DTIME,Datetime END_DTIME){
            system.debug('START_DTIME---'+START_DTIME);
            List<String> noList = new List<String>();
            contractInfo = new List<pList>();           
            List<Contract__c> contractInfoList = [ Select opportunity__r.opportunityRecordType__c,opportunity__r.fatherOpportunityName__c,productType__c,contractCancel__c,
                                                  approvalDate__c,comments__c,centralizedBid__c,performanceOrNot__c,MPnumber__r.Name, returnAmount__c,creditLevel__c,
                                                  accountRiskLevel__c, MP__c ,technologyReviewContent__c,technologyReviewSuggestion__c ,
                                                  technologyReviewExpert__c ,technologyFinalReviewSuggestion__c ,outsourcingReviewContent__c ,
                                                  outsourcingReviewSuggestion__c ,outsourcingReviewExpert__c ,outsourcingFinalReviewSuggestion__c ,
                                                  projectClassification__c  ,CreatedDate, industrySecondLevel__c,opportunityNumber__c,contractName__c ,
                                                  salesCenter__c,salesDepartment__c,salesProvince__c,contractNO__c,SAPID__c,accountName__c,
                                                  opportunityName__c,amount__c,currency__c,exchangeRate__c,contractAmountRMB__c,projectTypeCode__c,
                                                  projectType__c,contractTypeCode__c,contractType__c,voltageLevelCode__c,voltageLevel__c,capacity__c,
                                                  signDate__c,contractSupplyDate__c,signedByCode__c,signedbyName__c,salesOrgNameCode__c,salesOrgName__c,
                                                  salesTeamProvinceCode__c,salesTeamProvince__c,salesTeamDepartmentCode__c,salesTeamDepartment__c,
                                                  contactPerson1__c,contactPerson1Phone__c,accountFax__c,payType__c,paymentRatio__c,protocolReceptDate__c,
                                                  contractReceptDate__c,subCompanyCode__c,subCompany__c,salesTeamCenterCode__c,salesTeamCenter__c,
                                                  cancelMark__c,accountIndustryCode__c,accountIndustry__c,contractNote__c,reviewDate__c,reviewName__c,
                                                  finalUserIndustryCode__c,finalUserIndustry__c,finalUserGroupCode__c,finalUserGroup__c,contractOrNot__c,
                                                  customerContractCode__c,deliveryPersonCode__c,contractPreReturnDate__c,
                                                  userConfirmDate__c,technologyContact__c,technologyContactPhone__c,designInstitute__c,
                                                  designInstitutePhone__c,manufacturerContract__c,manufacturerContractPhone__c,tenderScheme__c,
                                                  bidBatch__c ,countryCode__c,country__c,provinceCode__c,province__c,schedulingBasis__c,changeDate__c,
                                                  buildTypeCode__c,buildType__c,implementationStation__c,frameworkAgreement__c,archiveNumber__c,
                                                  archiveByCode__c,archiveByName__c,archiveDate__c,scheduleDate__c ,completelyDeliverDate__c,
                                                  currencyCode__c,tenderProducerCode__c,tenderProducerName__c,totalDischarge__c,incompleteReason__c,
                                                  LastModifiedDate,contractUrl__c,warrantyPeriod__c,accountManagerName__c,accountManagerCode__c ,
                                                  active__c,deliveryPersonName__c, returnProportion__c , RecordTypeName__c, contractProjectGrossProfitMargin__c ,
                                                  invoiceSumAmount__c , invoicePercent__c ,Owner.LastName,Owner.FirstName, signTeamCenter__c ,
                                                  signTeamDepartment__c ,signTeamProvince__c ,contractWarrantyPeriod__c,deliveryTeamCenter__c ,deliveryTeamDepartment__c ,
                                                  deliveryTeamProvince__c,MainProductGroup__c  
                                                  from Contract__c where LastModifiedDate >= :START_DTIME and LastModifiedDate <= :END_DTIME and approvalPsDate__c != null and historicalContractDentity__c = false order by LastModifiedDate limit 400];
            System.Debug('合同库访问: 数据量: '+ contractInfoList.size());
            System.Debug('合同库访问: 开始时间: '+ START_DTIME );
            System.Debug('合同库访问: 结束时间: '+ END_DTIME );
            for(Contract__c pl:contractInfoList ){
                pList sList = new pList();
                //合同评审9个字段
                sList.technologyReviewContent = pl.technologyReviewContent__c ;
                sList.technologyReviewSuggestion = pl.technologyReviewSuggestion__c  ;
                sList.technologyReviewExpert = pl.technologyReviewExpert__c ;
                sList.technologyFinalReviewSuggestion = pl.technologyFinalReviewSuggestion__c  ;
                sList.outsourcingReviewContent = pl.outsourcingReviewContent__c ;
                sList.outsourcingReviewSuggestion = pl.outsourcingReviewSuggestion__c  ;
                sList.outsourcingReviewExpert = pl.outsourcingReviewExpert__c ;
                sList.outsourcingFinalReviewSuggestion = pl.outsourcingFinalReviewSuggestion__c ;
                sList.projectClassification = pl.projectClassification__c ;
                //付款单位
                sList.PAYCUSTOMER_NAME = pl.accountName__c;
                sList.PAYCUSTOMER_CODE =   pl.SAPID__c;
                
                sList.CRETEAD_DATE  =   pl.CreatedDate;
                sList.CONTRACT_NO   =   pl.contractNO__c;
                sList.SIGNCUSTOMER_CODE =   pl.SAPID__c;
                sList.SIGNCUSTOMER_NAME =   pl.accountName__c;
                sList.PROJECT_NAME  =   pl.contractName__c;
                sList.CONTRACT_AMOUNT   =   pl.amount__c;
                sList.ESTIMATE_AMOUNT = pl.amount__c;
                sList.PECUNIARY_UNIT    =   pl.currency__c;
                sList.EXCHANGE_RATE =   pl.exchangeRate__c;
                if(pl.RecordTypeName__c =='安全服务合同'||pl.RecordTypeName__c =='安全服务合同审批通过'){
                    sList.RMB_AMOUNT    =   pl.contractAmountRMB__c==0?1:(pl.contractAmountRMB__c==null?1:pl.contractAmountRMB__c);
                }else{
                    sList.RMB_AMOUNT    =   pl.contractAmountRMB__c;
                }
                
               sList.PROJECT_TYPE_CODE = pl.projectTypeCode__c;
                sList.PROJECT_TYPE_NAME =   pl.projectType__c;
                sList.CONTRACT_TYPE_CODE =   pl.contractTypeCode__c;
                sList.CONTRACT_TYPE =   pl.contractType__c;
                sList.VOLTAGE_LEVEL_CODE =   pl.voltageLevelCode__c;
                sList.VOLTAGE_LEVEL =   pl.voltageLevel__c;
                sList.VOLUME    =   pl.capacity__c;
                sList.SIGNED_DATE = pl.signDate__c;
                sList.DELIVERY  =   pl.contractSupplyDate__c;
                sList.OURSIGNINGE_NUM   =   pl.signedByCode__c;
                sList.OURSIGNING_NAME   =   pl.signedbyName__c;
                //销售组织、编码
                sList.SALES_ORG_CODE    =   pl.salesOrgNameCode__c;
                sList.SALES_ORG_NAME    =   pl.salesOrgName__c;
                //
                sList.PROVINCE_CODE     =   pl.salesTeamProvinceCode__c;
                //sList.PROVINCE_CODE     =   '718';
                //sList.PROVINCE_NAME =   '云南-电厂';
                sList.PROVINCE_NAME =   pl.salesProvince__c;
                sList.REGION_CODE   =   pl.salesTeamDepartmentCode__c;
                sList.REGION_NAME   =   pl.salesDepartment__c;
                //sList.REGION_NAME   =   '南网事业部';
                //sList.REGION_CODE   =   '0003';
                sList.CUSTOMERBUSINESS_LINKER   =   pl.contactPerson1__c;
                sList.CUSTOMERBUSINESS_PHONE    =   pl.contactPerson1Phone__c;
                sList.CUSTOMERFAX   =   pl.accountFax__c;
                //开票单位为空
                sList.RECEIVEINVOICE_CUSTOMER_CODE  =   '';
                sList.RECEIVEINVOICE_CUSTOMER_NAME  =   '';
                //付款类型CODE 等于 付款比例  和李工沟通过
                sList.PAY_TYPE_CODE =   '1000:2000:3000:4000:5000:6000';
                sList.PAY_TYPE_NAME =   pl.payType__c;
                sList.RATIO_PAY_CODE    =   '';
                //付款类型CODE 等于 付款比例  和李工沟通过
                sList.RATIO_PAY_NAME    =   pl.paymentRatio__c;
                sList.AGREEMENT_DATE    =   pl.protocolReceptDate__c;
                sList.CONTRACT_DATE =   pl.contractReceptDate__c;
                sList.COMPANY_CODE  =   pl.subCompanyCode__c;
                sList.COMPANY_NAME  =   pl.subCompany__c;
                sList.BUSINESS_CODE =   pl.salesTeamCenterCode__c;
                sList.BUSINESS_NAME =   pl.salesCenter__c;
                sList.CUSTOMER_INDUSTRY_CODE    =   pl.accountIndustryCode__c;
                sList.CUSTOMER_INDUSTRY_NAME    =   pl.accountIndustry__c;
                //合同取消状态-待定
                sList.CANCEL_MARK=  pl.cancelMark__c;
                sList.CONTRACT_REMARK   =   ( pl.contractNote__c == null ? '' : pl.contractNote__c);
                sList.REVIEW_DATE   =   pl.reviewDate__c;
                sList.REVIEW_CODE   =   pl.reviewName__c;
                sList.END_CUSTOMER_INDUSTRY_CODE    =   pl.finalUserIndustryCode__c;
                sList.END_CUSTOMER_INDUSTRY_NAME    =   pl.finalUserIndustry__c;
                sList.END_CUSTOMER_GROUPS_CODE  =   pl.finalUserGroupCode__c;
                sList.END_CUSTOMER_GROUPS_NAME  =   pl.finalUserGroup__c;
                sList.IS_SCHEDULING_CONTRACT    =   pl.contractOrNot__c;
                sList.CUSTOMER_CONTRACT_NO  =   pl.customerContractCode__c;
                sList.OURBUSINESSMAN_NUM    =   pl.accountManagerCode__c;
                sList.OURBUSINESSMAN_NAME   =   pl.accountManagerName__c;
                sList.CONTRACT_EXPECTED_DATE    =   pl.contractPreReturnDate__c;
                sList.USER_SURE_SUPPLY_DATE =   pl.userConfirmDate__c;
                sList.TECHNICAL_CONTACT_NAME    =   pl.technologyContact__c;
                sList.TECHNICAL_CONTACT_TEL =   pl.technologyContactPhone__c;
                sList.DESIGN_INSTITUTE_LINKER   =   pl.designInstitute__c;
                sList.DESIGN_INSTITUTE_LINKERPHONE  =   pl.designInstitutePhone__c;
                sList.THIRD_PARTY_LINKER    =   pl.manufacturerContract__c;
                sList.THIRD_PARTY_LINKERPHONE   =   pl.manufacturerContractPhone__c;
                sList.PROPOSAL_NO   =   pl.tenderScheme__c;
                sList.PROPOSAL_BATCH    =   pl.bidBatch__c;
                sList.PROJECT_COUNTRY_NO    =   pl.countryCode__c;
                sList.PROJECT_COUNTRY   =   pl.country__c;
                sList.PROJECT_PROVINCE_NO   =   pl.provinceCode__c;
                sList.PROJECT_PROVINCE  =   pl.province__c;
                sList.SCHEDULING_BASE   =   pl.schedulingBasis__c;
                sList.CONTRACT_CHANGED_DATE =   pl.changeDate__c;
                sList.INFRASTRUCTURE_TYPE_CODE  =   pl.buildTypeCode__c;
                sList.INFRASTRUCTURE_TYPE_NAME  =   pl.buildType__c;
                sList.PROJECT_SUBSTATION    =   pl.implementationStation__c;
                sList.FRAMWORK_AGREEMENT_NO =   pl.frameworkAgreement__c;
                sList.FILING_NO =   pl.archiveNumber__c;
                sList.FINANCIAL_FILED_NUM   =   pl.archiveByCode__c;
                sList.FINANCIAL_FILED_NAME  =   pl.archiveByName__c;
                sList.FINANCIAL_FILE_DATE   =   pl.archiveDate__c;
                if(pl.scheduleDate__c==null || pl.scheduleDate__c.trim() == '' ){
                    sList.PLANPRODUCTDATE   =  null;
                }else{
                    sList.PLANPRODUCTDATE   =  Date.parse(pl.scheduleDate__c);        
                }
                
                sList.DELIVERDATE   =   pl.completelyDeliverDate__c;
                sList.PECUNIARY_UNIT_CODE   =   pl.currencyCode__c;
                sList.PECUNIARY_UNIT_NAME   =   pl.currency__c;
                sList.TENDER_PRODUCER_CODE  =   pl.tenderProducerCode__c;
                sList.TENDER_PRODUCER_NAME  =   pl.tenderProducerName__c;
                sList.IS_TOTAL_DISCHARGE    =   pl.totalDischarge__c;
                //未完全排产原因
                sList.INCOMPLETE_REASON =   pl.incompleteReason__c;
                sList.CREATED_ON_DT =   pl.CreatedDate;
                sList.CHANGED_ON_DT =   pl.LastModifiedDate;
                sList.CONTRACT_URL  =   pl.contractUrl__c;
                //质保金返回周期
                sList.WARRANTYPERIOD  =  pl.warrantyPeriod__c;
                //质保期
                sList.CONTRACTWARRANTYPERIOD  =  pl.contractWarrantyPeriod__c;
                
                
                sList.OPPORTUNITYNUMBER = pl.opportunityNumber__c;
                //新增行业二级分类
                sList.IndustrySecondLevel = pl.industrySecondLevel__c;
                //新增客户风险等级
                sList.accountRiskLevel = pl.accountRiskLevel__c ;
                //新增是否是重点工程项目
                sList.keyProject = pl.MP__c ;
                //2017-11-29新增字段
                //产品类别
                sList.productType=pl.productType__c;
                //合同取消
                sList.contractCancel=pl.contractCancel__c;
                //合同审批通过日期
                sList.approvalDate=pl.approvalDate__c;
                //交期备注说明
                sList.comments=pl.comments__c;
                //是否集中招标
                sList.centralizedBid=pl.centralizedBid__c;
                //是否计入销售业绩
                sList.performanceOrNot=pl.performanceOrNot__c;
                //业务机会名称
                sList.opportunityName=pl.opportunityName__c;
                //父业务机会名称
                sList.fatherOpportunityName=pl.opportunity__r.fatherOpportunityName__c;
                //重点工程项目编号
                sList.MPNumber=pl.MPnumber__r.Name;
                //业务机会记录类型
                sList.opportunityRecordType = pl.opportunity__r.opportunityRecordType__c;
                //已回总金额
                sList.returnAmount =pl.returnAmount__c;
                //客户信用等级
                sList.creditLevel = pl.creditLevel__c;
                
                //2018.8.1新增字段
                sList.active=pl.active__c;
                //履约执行人
                sList.deliveryPersonName=pl.deliveryPersonName__c;
                //回款比例
                sList.returnProportion=(pl.returnProportion__c==null?0:pl.returnProportion__c)/100;
                //记录类型
                sList.RecordTypeName=pl.RecordTypeName__c;
                //容量已存在
                //sList.capacity;
                //合同价项目毛利率
                sList.contractProjectGrossProfitMargin=(pl.contractProjectGrossProfitMargin__c==null?0:pl.contractProjectGrossProfitMargin__c)/100;
                //开票总金额
                sList.invoiceSumAmount=pl.invoiceSumAmount__c;
                //开票总额比例
                sList.invoicePercent=(pl.invoicePercent__c==null?0:pl.invoicePercent__c)/100;
                //所有人
                sList.ownerName=pl.Owner.LastName+(pl.Owner.FirstName==null?'':pl.Owner.FirstName);
                //合同签订团队(中心)
                sList.signTeamCenter=pl.signTeamCenter__c;
                //合同签订团队(部门)
                sList.signTeamDepartment=pl.signTeamDepartment__c;
                //合同签订团队(省区)
                sList.signTeamProvince=pl.signTeamProvince__c;
                //履约执行团队(中心)
                sList.deliveryTeamCenter=pl.deliveryTeamCenter__c;
                //履约执行团队(部门)
                sList.deliveryTeamDepartment=pl.deliveryTeamDepartment__c;
                //履约执行团队(省区)
                sList.deliveryTeamProvince=pl.deliveryTeamProvince__c;
                
                //主责事业部
                sList.MainProductGroup=pl.MainProductGroup__c;

                
                contractInfo.add(sList);
                noList.add(pl.contractNO__c);
            }
            if(contractInfoList.size()>0&&contractInfoList.size()==noList.size()){
                String mess='';
                for(String no : noList){
                    mess+=no+',';
                }
                if(mess.length()>0){
                    mess=mess.substring(0, mess.length()-1);
                    logClass.returnLog('成功', '已处理', '【获取合同信息接口】合同中间库成功抽取合同：'+mess, '正常');
                }   
            }
        }
    }
    
    webservice static contractList queryContract(Datetime START_DTIME,Datetime END_DTIME){

        contractList contractList = new contractList(START_DTIME,END_DTIME);

        return contractList ;
    }
}