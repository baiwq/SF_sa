trigger ContractBeforeInsert on Contract__c (before insert,after insert,before update) {
    if(trigger.new.size() > 100){
        if(Trigger.isAfter&&Trigger.isInsert){
            
            //新建时添加分享规则
            List<Contract__share> ccsList = new List<Contract__share>();
            for(Contract__c cc:trigger.new){
             //分享给合同签订人 signedby__c
                if(cc.signedby__c != null){
                    ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = cc.signedby__c, ParentId = cc.id));
                }
             //分享给履约执行人 deliveryPerson__c
                if(cc.deliveryPerson__c != null){
                    ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = cc.deliveryPerson__c, ParentId = cc.id));
                }
             //分享给销售项目主责人 accountManager__c
                if(cc.accountManager__c != null){
                    ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = cc.accountManager__c, ParentId = cc.id));
                }  
            }
            insert ccsList;
        }
    }else{
        for(Contract__c cc:trigger.new){
            System.debug('CY======>CC1111:'+cc.OpportinutyType__c);
            contractreview__c cr;
            if(cc.reviewNumber__c!=null){
                cr = [select id, reviewer__c, notOutsourcing__c,QuatationCreatedBy__c,contractAmount__c,
                        One__c,Two__c,Three__c,Four__c,Five__c,Six__c,SalesCenter__c,PerformanceOrNot__c,
                        ProductType__c,FinalUserIndustry__c,FinalUserGroup__c,bidPackage__c,ProjectCategory__c,
                        IndustrySecondLevel__c,ContractName__c,SignedBy__c,ContractSupplyDate__c,
                        SignCompany__c,SignTeamCenter__c,SignTeamProvince__c,SignTeamDepartment__c,
                        ContractType__c,DeliveryPerson__c,DeliveryTeamCenter__c,DeliveryTeamProvince__c,
                        DeliveryTeamDepartment__c,BidBatch__c,FrameworkAgreement__c,ExchangeRate__c,Currency__c,
                        WarrantyPeriod__c,contractWarrantyPeriod__c,SalesDepartment__c,SalesProvince__c,AccountManager__c,
                        SalesTeamCenter__c,SalesTeamProvince__c,SalesTeamDepartment__c,AccountName__c,
                        solutionURLCPQContractPrice__c,orderIdCPQ__c,contractProjectGrossProfitMargin__c ,contractProjectGrossProfit__c ,
                                            standardProjectGrossProfitMarginContract__c ,standardProjectGrossProfitContract__c  from contractreview__c where id=:cc.reviewNumber__c limit 1][0];
            }
            //得到审批流的相关用户  
            if(Trigger.isBefore){
                cc.findManagerRelatedUser__c = cc.managerRelatedUserFormula__c;
            }
            
            if(Trigger.isInsert){
                

                //新建before  2019-01-14 任艳新 优化
                if(Trigger.isBefore){
                    //2018-01-15 新建保存后更改记录类型切换页面布局
                    if(cc.RecordTypeName__c=='免费订单'){
                        cc.RecordTypeId=[Select Id from RecordType where SObjectType=:'Contract__c' and Name =:'免费订单(保存后)'][0].Id;
                    }else if(cc.RecordTypeName__c=='有机会无合同'){
                        cc.RecordTypeId=[Select Id from RecordType where SObjectType=:'Contract__c' and Name =:'有机会无合同(保存后)'][0].Id;
                    }else if(cc.RecordTypeName__c=='有机会有合同'){
                        cc.RecordTypeId=[Select Id from RecordType where SObjectType=:'Contract__c' and Name =:'有机会有合同(保存后)'][0].Id;
                    }
                    
                    

                //得到审批流的相关用户  
                    cc.findManagerRelatedUser__c = cc.managerRelatedUserFormula__c;
                    
                        
                        Opportunity opty;
                        if(cc.opportunity__c!=null){
                            opty =[Select id,tenderScheme__c,tenderProducer__c,centralizedBid__c,country__c ,province__c,
                                    implementationStation__c,voltageLevel__c,buildType__c,capacity__c,AccountId,opportunityRecordType__c
                                from Opportunity where id=:cc.opportunity__c];
                        
                        }
                        System.debug('CC1111====>进入判断条件之前');
                    //得到合同评审上的毛利率
                        if(cr!=null && (opty == null || opty.opportunityRecordType__c != '集招/集采')){

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
                            cc.salesCenter__c = cr.SalesCenter__c;
                            //产品类别 ProductType__c
                            cc.productType__c = cr.ProductType__c;
                            //最终用户所属行业 FinalUserIndustry__c
                            cc.finalUserIndustry__c = cr.FinalUserIndustry__c;
                            //最终用户所属集团 FinalUserGroup__c
                            cc.finalUserGroup__c = cr.FinalUserGroup__c;
                            //最终用户行业二级分类  IndustrySecondLevel__c
                            cc.industrySecondLevel__c = cr.IndustrySecondLevel__c;
                            //合同名称  ContractName__c
                            cc.contractName__c = cr.ContractName__c;
                            //合同金额
                            cc.amount__c = cr.contractAmount__c;
                            //合同签订人  SignedBy__c
                            cc.signedBy__c = cr.SignedBy__c;
                            //合同签订供货日期  ContractSupplyDate__c
                            cc.contractSupplyDate__c = cr.ContractSupplyDate__c;
                            //合同签订公司  SignCompany__c
                            cc.subCompany__c = cr.SignCompany__c;
                            //合同签订团队(中心)  SignTeamCenter__c
                            cc.signTeamCenter__c = cr.SignTeamCenter__c;
                            //合同签订团队(省区)  SignTeamProvince__c
                            cc.signTeamProvince__c = cr.SignTeamProvince__c;
                            //合同签订团队(部门)  SignTeamDepartment__c
                            cc.signTeamDepartment__c = cr.SignTeamDepartment__c;
                            //合同类型  ContractType__c
                            cc.contractType__c = cr.ContractType__c;
                            //履约执行人 DeliveryPerson__c
                            cc.deliveryPerson__c = cr.DeliveryPerson__c;
                            //履约执行团队(中心)  DeliveryTeamCenter__c
                            cc.deliveryTeamCenter__c = cr.DeliveryTeamCenter__c;
                            //履约执行团队(省区) DeliveryTeamProvince__c
                            cc.deliveryTeamProvince__c = cr.DeliveryTeamProvince__c;
                            //履约执行团队(部门)  DeliveryTeamDepartment__c
                            cc.deliveryTeamDepartment__c = cr.DeliveryTeamDepartment__c;
                            //投标批次  BidBatch__c
                            cc.bidBatch__c = cr.BidBatch__c;
                            //框架协议编号  FrameworkAgreement__c
                            cc.frameworkAgreement__c = cr.FrameworkAgreement__c;
                            //汇率  ExchangeRate__c
                            cc.exchangeRate__c = cr.ExchangeRate__c;
                            //货币单位  Currency__c
                            cc.currency__c = cr.Currency__c;
                            //质保金返回周期  WarrantyPeriod__c
                            cc.warrantyPeriod__c = cr.WarrantyPeriod__c;
                            //质保期  contractWarrantyPeriod__c
                            cc.contractWarrantyPeriod__c = cr.contractWarrantyPeriod__c;
                            //销售大区  SalesDepartment__c
                            //cc.salesDepartment__c = cr.SalesDepartment__c;
                            //销售省区  SalesProvince__c
                            //cc.salesProvince__c = cr.SalesProvince__c;
                            //销售项目主责人  AccountManager__c
                            cc.accountManager__c = cr.AccountManager__c;
                            //销售项目团队(中心)  SalesTeamCenter__c
                            cc.salesTeamCenter__c = cr.SalesTeamCenter__c;
                            //销售项目团队(省区)  SalesTeamProvince__c
                            cc.salesTeamProvince__c = cr.SalesTeamProvince__c;
                            //销售项目团队(部门)  SalesTeamDepartment__c
                            cc.salesTeamDepartment__c = cr.SalesTeamDepartment__c;
                            //标包 bidPackage__c
                            cc.packageNumber__c = cr.bidPackage__c;
                            //是否计入销售业绩  PerformanceOrNot__c
                            cc.performanceOrNot__c = cr.PerformanceOrNot__c;
                            //工程类别
                            cc.projectType__c = cr.ProjectCategory__c;

                            //客户信息  2019.12.13
                            cc.account__c = cr.AccountName__c;
                        }
                        //得到业务机会上的字段信息
                        if(opty!=null  &&  opty.opportunityRecordType__c != '集招/集采'){
                            //标书-方案编号 tenderScheme__c
                            cc.tenderScheme__c = opty.tenderScheme__c;
                            //标书制作人  tenderProducer__c
                            cc.tenderProducer__c = opty.tenderProducer__c;
                            //是否集中招标  centralizedBid__c
                            cc.centralizedBid__c = opty.centralizedBid__c;
                            //项目实施所在国家  country__c
                            cc.country__c = opty.country__c;
                            //项目实施所在省份  province__c
                            cc.province__c = opty.province__c;
                            //项目实施所在厂站  implementationStation__c
                            cc.implementationStation__c = opty.implementationStation__c;
                            //电压等级  voltageLevel__c
                            cc.voltageLevel__c = opty.voltageLevel__c;
                            //建设类型  buildType__c
                            cc.buildType__c = opty.buildType__c;
                            //容量(MW) capacity__c
                            cc.capacity__c = opty.capacity__c;
                            //工程类别  projectType__c
                        
                            //客户
                            //cc.account__c = opty.AccountId;
                        }                      
                }
                //新建after  2019-01-14 任艳新 优化
                if(Trigger.isAfter){
                
     
                    //新建时添加分享规则
                    List<Contract__share> ccsList = new List<Contract__share>();
                    //分享给合同签订人 signedby__c
                    if(cc.signedby__c != null){
                        ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = cc.signedby__c, ParentId = cc.id));
                    }
                    //分享给履约执行人 deliveryPerson__c
                    if(cc.deliveryPerson__c != null){
                        ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Edit', UserOrGroupId = cc.deliveryPerson__c, ParentId = cc.id));
                    }
                    //分享给销售项目主责人 accountManager__c
                    if(cc.accountManager__c != null){
                        ccsList.add(new Contract__share(RowCause = Schema.Contract__Share.RowCause.SHARE__c, AccessLevel = 'Read', UserOrGroupId = cc.accountManager__c, ParentId = cc.id));
                    }
             
                    insert ccsList;   

                    //自动创建合同履行状态表           
                    statusTracking__c ST = new statusTracking__c();
                    ST.contract__c = cc.id;
                    insert ST;

                 
                    //预收 提货 到货 调试 投运 质保
                    //新建合同自动创建付款方式
                    List<paymentTerm__c> ptList = new List<paymentTerm__c>();
                    String[] stageItem = new List<String>{'预收','提货','到货','调试','投运','质保'};
                    for(Integer i=0; i<stageItem.size(); i++){
                        Decimal percent =0;
                        if(cr!=null){
                            if(stageItem.get(i)=='预收'){
                                percent =cr.One__c;
                            }else if(stageItem.get(i)=='提货'){
                                percent =cr.Two__c;
                            }else if(stageItem.get(i)=='到货'){
                                percent =cr.Three__c;
                            }else if(stageItem.get(i)=='调试'){
                                percent =cr.Four__c;
                            }else if(stageItem.get(i)=='投运'){
                                percent =cr.Five__c;
                            }else if(stageItem.get(i)=='质保'){
                                percent =cr.Six__c;
                            }
                        }
                        
                        
                        ptList.add(new paymentTerm__c(stage__c = stageItem.get(i), percentage__c=percent,contract__c = cc.id, collectionStatus__c = '未回款', No__c = i+1, statusTracking__c = ST.id));
                    } 
                    insert ptList; 
                    //任艳新 2018-12-03 销售中心50万合同创建后通知合同评审人员
                    //任艳新 2018-12-19 邮件通知标书制作人员 
                    if(cr!=null){
                        
                        system.debug('评审人---'+cr.reviewer__c);
                        system.debug('创建人---'+UserInfo.getLastName());
                        if(cc.contractAmountRMB__c>=500000&&cc.salesTeamCenter__c =='销售中心'&&cr.reviewer__c!=UserInfo.getLastName()){
                            system.debug('成功');
                            EmailTemplate template = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ContractSendEmailToSalesCA' limit 1];
                            List<String> emailList = new List<String>();
                            List<User> userList = [Select id,LastName,Email from User where LastName=:cr.reviewer__c];
                            emailList.add(userList[0].Email);
                            EmailToolClass.sendEmail(emailList,cc.accountManager__c,cc.Id,template.Id);
                        }
                        if(cr.QuatationCreatedBy__c!=null && cc.ownerDepartment__c != '感应加热业务'){
                            List<User> recipientList =[Select id ,Email from User where id=:cr.QuatationCreatedBy__c or id=:cc.accountManager__c];
                            Map<String,String> recipientMap =new Map<String,String>();
                            recipientMap.put(recipientList[0].Id,recipientList[0].Email);
                            if(recipientList.size()==2){
                                recipientMap.put(recipientList[1].Id,recipientList[1].Email);
                            }
                            
                            List<String> toAddress = new List<String>();
                            toAddress.add(recipientMap.get(cr.QuatationCreatedBy__c));
                            String templateBid;
                            if(cr.notOutsourcing__c=='是'){
                                EmailTemplate outsourcingTemplate = [Select id,HtmlValue from EmailTemplate where DeveloperName =:'ContractSendEmailToBid' limit 1];
                                templateBid = outsourcingTemplate.Id;
                                system.debug('QuatationCreatedBy__c---'+cr.QuatationCreatedBy__c);
                                system.debug('recipientMap-----'+recipientMap);
                                system.debug('toAddress-----'+toAddress);
                                system.debug('ccAddress-----'+recipientMap.get(cc.accountManager__c));
                                EmailToolClass.sendEmailBid(toAddress,cc.OwnerId,cc.Id,templateBid,recipientMap.get(cc.accountManager__c));
                            }
                           
                        }
                    }
                                
                    
                    //创建时，带入合同评审上的毛利率及利润
                    if(cr != null){
                        
                       
                        
                        //自动创建供货范围附件 
                        if(cc.orderIdCPQ__c!=null&&cc.orderIdCPQ__c.trim()!=''){
                            List<Attachment__c> attas = [select id from Attachment__c where contractReview__c =:cc.reviewNumber__c and (type__c ='供货范围清单' or type__c = '供货范围清单(拆分后)') and isValid__c='有效'];
                            if(attas.size()==1){
                                //如果合同评审有供货附件更新
                                attas[0].contract__c=cc.id;
                                attas[0].viewCPQURL__c=cr.solutionURLCPQContractPrice__c;
                                update attas[0];
                            }else if(attas.size()==0){
                                Attachment__c a = new Attachment__c();
                                a.documentName__c='进入CPQ查看供货范围清单';
                                a.type__c='供货范围清单';
                                a.contract__c=cc.id;
                                a.attachmentURL__c=cr.solutionURLCPQContractPrice__c;
                                a.viewCPQURL__c=cr.solutionURLCPQContractPrice__c;
                                insert a;
                            }else{
                            
                            }
                        }
                        
                    }
                              
                }
                
            }
            System.debug('=======contract1111======'+cc);
        }
        
    }
}