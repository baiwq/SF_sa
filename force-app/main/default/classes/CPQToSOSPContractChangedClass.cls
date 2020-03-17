global class CPQToSOSPContractChangedClass {
    global class Changed{
        webservice String changedName;
        webservice String contractNo;
        webservice String solutionStandardURLCPQ;
        webservice String orderIdCPQ;
        //出口退税率
        webservice Decimal exportRebateRate;
        //标准价
        /*webservice Decimal commonProjectOwnEquipmentStandardPrice;
        webservice Decimal specialProductStandardPrice;
        webservice Decimal ownSoftStandardPrice;
        webservice Decimal outsourcingStandardPrice;
        webservice Decimal outsourcingServiceStandardPrice;
        webservice Decimal outsourcingArchitectureCostStandardPrice;
        webservice Decimal companyTrainServiceStandardPrice;
        webservice Decimal standardTotalPrice;*/
        //特殊产品成本
        webservice Decimal distributionSwitchPrice;
        webservice Decimal CYCUPSPrice;
        webservice Decimal SVG_STATCOM_APFPrice;
        webservice Decimal paidTrainningProductPrice;
        webservice Decimal paidServiceProductPrice;
        webservice Boolean distributionSwitch;
        webservice Boolean CYCUPS;
        webservice Boolean SVG_STATCOM_APF;
        webservice Boolean paidTrainningProduct;
        webservice Boolean paidServiceProduct;
        //成本(缺出厂成本、项目成本)
        webservice Decimal commonProjectOwnDeviceCost;
        webservice Decimal specialProductCost;
        webservice Decimal outsourcingCost;
        webservice Decimal companyTrainAndServiceCost;
        webservice Decimal projectRunCost;
        webservice Decimal projectRistCost;
        //标准价出厂毛利
        webservice Decimal standardPriceGrossProfitContract;
        webservice Decimal standardPriceGrossProfitMarginContract;
        //标准价项目毛利
        webservice Decimal standardProjectGrossProfitContractChange;
        webservice Decimal standardProjectGrossProfitMarginCtrChag;
        //不接的字段6个
        webservice Decimal commonProjectOwnDevicePercentStandard;
        webservice Decimal specialProductCostPercentStandard;
        webservice Decimal outsourcingCostPercentStandard;
        webservice Decimal companyTrainAndServiceCostPercentStandard;
        webservice Decimal projectRunCostPercentStandard;
        webservice Decimal projectRistCostPercentStandard;
        //标准价模拟净利不接
        webservice Decimal standardSimulationNetProfitStandard;
        webservice Decimal standardSimulationNetProfitPercentStandard;
        
        //合同价
        //合同价解决方案链接
        webservice String solutionContractUrlCPQ;
        //合同价标准价
        webservice Decimal cCommonProjectOwnEquipmentStandardPrice;
        webservice Decimal cSpecialProductStandardPrice;
        webservice Decimal cOwnSoftStandardPrice;
        webservice Decimal cOutsourcingStandardPrice;
        webservice Decimal cOutsourcingServiceStandardPrice;
        webservice Decimal cOSArchitectureCostStandardPrice;
        webservice Decimal cCompanyTrainServiceStandardPrice;
        //不接合同标准价总价
        webservice Decimal standardPriceTotal;
        //合同价总价
        webservice Decimal cCommonProjectOwnEquipmentBiddingPrice;
        webservice Decimal cSpecialProductBiddingPrice;
        webservice Decimal cOwnSoftBiddingPrice;
        webservice Decimal cOutsourcingBiddingPrice;
        webservice Decimal cOutsourcingServiceBiddingPrice;
        webservice Decimal cOutsourcingArchitectureCostBiddingPrice;
        webservice Decimal cCompanyTrainServiceBiddingPrice;
        //合同成本项
        webservice Decimal ccommonProjectOwnDeviceCost;
        webservice Decimal cSpecialProductCost;
        webservice Decimal contractOutsourcingCost;
        webservice Decimal cCompanyTrainServiceCost;
        webservice Decimal contractProjectBigAmountCost;
        webservice Decimal contractProjectRunCost;
        webservice Decimal contractProjectRistCost;
        //合同报价折扣
        webservice Decimal commonProjectOwnEquipmentcontracPriceDct;
        webservice Decimal specialProductContractPriceDct;
        webservice Decimal ownSoftContractPriceDct;
        webservice Decimal outsourcingContractPriceDct;
        webservice Decimal outsourcingServiceContractPriceDct;
        webservice Decimal outsourcingArchitectureCostConPriceDct;
        webservice Decimal companyTrainServiceContractPriceDct;
        webservice Decimal contractPriceTotalDct;
        //合同价出厂毛利
        webservice Decimal contractPriceGrossProfit;
        webservice Decimal contractPriceGrossProfitMargin;
        //合同价项目毛利
        webservice Decimal contractChangedProjectGrossProfit;
        webservice Decimal contractChangedProjectGrossProfitMargin;
        
        webservice Decimal commonProjectOwnDevicePercent;
        webservice Decimal specialProductCostPercent;
        webservice Decimal outsourcingCostPercent;
        webservice Decimal companyTrainAndServiceCostPercent;
        webservice Decimal contractProjectRunCostPercent;
        webservice Decimal contractProjectRistCostPercent;
        webservice Decimal contractProjectBigAmountCostPercent;
        //合同价模拟净利
        webservice Decimal contractSimulationNetProfit;
        webservice Decimal contractSimulationNetProfitPercent;
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response setStandardPrice(Changed changed){
        Response resp = new Response();
        try{
           contractchange__c chan =[select id,Name, approvalStatus__c , contract__c,
                solutionURLCPQ__c,solutionURLCPQ2__c ,
                //特殊产品成本
                //distributionSwitch__c,CYCUPS__c,SVG_STATCOM_APF__c,paidTrainningProduct__c,paidServiceProduct__c,
                //distributionSwitchPrice__c,CYCUPSPrice__c,SVG_STATCOM_APFPrice__c,
                //paidTrainningProductPrice__c,paidServiceProductPrice__c,
                //成本
                //标准价出厂毛利润
                //standardPriceGrossProfitContract__c ,standardPriceGrossProfitMarginContract__c ,
                //标准价项目毛利
                standardProjectGrossProfitContractChange__c ,standardProjectGrossProfitMarginCtrChag__c ,
                //合同价标准价
               //cCommonProjectOwnEquipmentStandardPrice__c ,cSpecialProductStandardPrice__c ,
                //cOwnSoftStandardPrice__c,cOutsourcingStandardPrice__c ,
                //cOutsourcingServiceStandardPrice__c ,cOSArchitectureCostStandardPrice__c ,
                //cCompanyTrainServiceStandardPrice__c ,
                //合同价总价
                //cCommonProjectOwnEquipmentBiddingPrice__c ,cSpecialProductBiddingPrice__c ,
                //cOwnSoftBiddingPrice__c ,cOutsourcingBiddingPrice__c ,cOutsourcingServiceBiddingPrice__c ,
                //cOutsourcingArchitectureCostBiddingPrice__c ,cCompanyTrainServiceBiddingPrice__c ,
                //合同成本项
                //ccommonProjectOwnDeviceCost__c ,cSpecialProductCost__c ,contractOutsourcingCost__c ,
                //cCompanyTrainServiceCost__c ,contractProjectBigAmountCost__c ,contractProjectRunCost__c ,contractProjectRistCost__c,
                //合同报价折扣
                //commonProjectOwnEquipmentcontracPriceDct__c ,specialProductContractPriceDct__c ,
                //ownSoftContractPriceDct__c ,outsourcingContractPriceDct__c ,
                //outsourcingServiceContractPriceDct__c ,outsourcingArchitectureCostConPriceDct__c ,
                //companyTrainServiceContractPriceDct__c ,contractPriceTotalDct__c ,
                //合同价出厂毛利
                //contractPriceGrossProfit__c ,contractPriceGrossProfitMargin__c ,
                //合同价项目毛利
                contractChangedProjectGrossProfit__c ,contractChangedProjectGrossProfitMargin__c 
                //commonProjectOwnDevicePercent__c ,specialProductCostPercent__c ,
                //outsourcingCostPercent__c ,companyTrainAndServiceCostPercent__c ,
                //contractProjectRunCostPercent__c ,contractProjectRistCostPercent__c ,contractProjectBigAmountCostPercent__c ,
                //合同价模拟净利
                //contractSimulationNetProfit__c , contractSimulationNetProfitPercent__c 
            from contractchange__c where Name=:changed.changedName and contractNo__c=:changed.contractNo limit 1][0];
            if(chan.approvalStatus__c=='草稿'||chan.approvalStatus__c=='审批拒绝'){
              chan.solutionURLCPQ__c=changed.solutionStandardURLCPQ;
              chan.orderIdCPQ__c=changed.orderIdCPQ;
              /*//特殊产品成本
              chan.distributionSwitchPrice__c=changed.distributionSwitchPrice;
              chan.CYCUPSPrice__c=changed.CYCUPSPrice;
              chan.SVG_STATCOM_APFPrice__c=changed.SVG_STATCOM_APFPrice;
              chan.paidTrainningProductPrice__c=changed.paidTrainningProductPrice;
              chan.paidServiceProductPrice__c=changed.paidServiceProductPrice;
              chan.distributionSwitch__c=changed.distributionSwitch;
              chan.CYCUPS__c=changed.CYCUPS;
              chan.SVG_STATCOM_APF__c=changed.SVG_STATCOM_APF;
              chan.paidTrainningProduct__c=changed.paidTrainningProduct;
              chan.paidServiceProduct__c=changed.paidServiceProduct; 
              //标准价出厂毛利
              chan.standardPriceGrossProfitContract__c=changed.standardPriceGrossProfitContract;
              chan.standardPriceGrossProfitMarginContract__c=changed.standardPriceGrossProfitMarginContract;*/
              //标准价项目毛利
              chan.standardProjectGrossProfitContractChange__c=changed.standardProjectGrossProfitContractChange;
              chan.standardProjectGrossProfitMarginCtrChag__c=changed.standardProjectGrossProfitMarginCtrChag;
              //合同价URL
              chan.solutionURLCPQ2__c=changed.solutionContractUrlCPQ;
              /*//合同价标准价
              chan.cCommonProjectOwnEquipmentStandardPrice__c = changed.cCommonProjectOwnEquipmentStandardPrice;
              chan.cSpecialProductStandardPrice__c = changed.cSpecialProductStandardPrice;
              chan.cOwnSoftStandardPrice__c = changed.cOwnSoftStandardPrice;
              chan.cOutsourcingStandardPrice__c = changed.cOutsourcingStandardPrice;
              chan.cOutsourcingServiceStandardPrice__c = changed.cOutsourcingServiceStandardPrice;
              chan.cOSArchitectureCostStandardPrice__c = changed.cOSArchitectureCostStandardPrice;
              chan.cCompanyTrainServiceStandardPrice__c = changed.cCompanyTrainServiceStandardPrice;
              //合同价总价
              chan.cCommonProjectOwnEquipmentBiddingPrice__c = changed.cCommonProjectOwnEquipmentBiddingPrice;
              chan.cSpecialProductBiddingPrice__c = changed.cSpecialProductBiddingPrice;
              chan.cOwnSoftBiddingPrice__c = changed.cOwnSoftBiddingPrice;
              chan.cOutsourcingBiddingPrice__c = changed.cOutsourcingBiddingPrice;
              chan.cOutsourcingServiceBiddingPrice__c = changed.cOutsourcingServiceBiddingPrice;
              chan.cOutsourcingArchitectureCostBiddingPrice__c = changed.cOutsourcingArchitectureCostBiddingPrice;
              chan.cCompanyTrainServiceBiddingPrice__c = changed.cCompanyTrainServiceBiddingPrice;
              //合同成本项
              chan.ccommonProjectOwnDeviceCost__c = changed.ccommonProjectOwnDeviceCost;
              chan.cSpecialProductCost__c = changed.cSpecialProductCost;
              chan.contractOutsourcingCost__c = changed.contractOutsourcingCost;
              chan.cCompanyTrainServiceCost__c = changed.cCompanyTrainServiceCost;
              chan.contractProjectBigAmountCost__c = changed.contractProjectBigAmountCost;
              chan.contractProjectRunCost__c = changed.contractProjectRunCost;
              chan.contractProjectRistCost__c = changed.contractProjectRistCost;
              //合同报价折扣
              chan.commonProjectOwnEquipmentcontracPriceDct__c = changed.commonProjectOwnEquipmentcontracPriceDct;
              chan.specialProductContractPriceDct__c = changed.specialProductContractPriceDct;
              chan.ownSoftContractPriceDct__c = changed.ownSoftContractPriceDct;
              chan.outsourcingContractPriceDct__c = changed.outsourcingContractPriceDct;
              chan.outsourcingServiceContractPriceDct__c = changed.outsourcingServiceContractPriceDct;
              chan.outsourcingArchitectureCostConPriceDct__c = changed.outsourcingArchitectureCostConPriceDct;
              chan.companyTrainServiceContractPriceDct__c = changed.companyTrainServiceContractPriceDct;
              chan.contractPriceTotalDct__c = changed.contractPriceTotalDct;
              //合同价出厂毛利
              chan.contractPriceGrossProfit__c = changed.contractPriceGrossProfit;
              chan.contractPriceGrossProfitMargin__c = changed.contractPriceGrossProfitMargin;*/
              //合同价项目毛利
              chan.contractChangedProjectGrossProfit__c = changed.contractChangedProjectGrossProfit;
              chan.contractChangedProjectGrossProfitMargin__c = changed.contractChangedProjectGrossProfitMargin;
              /*chan.commonProjectOwnDevicePercent__c = changed.commonProjectOwnDevicePercent;
              chan.specialProductCostPercent__c = changed.specialProductCostPercent;
              chan.outsourcingCostPercent__c = changed.outsourcingCostPercent;
              chan.companyTrainAndServiceCostPercent__c = changed.companyTrainAndServiceCostPercent;
              chan.contractProjectRunCostPercent__c = changed.contractProjectRunCostPercent;
              chan.contractProjectRistCostPercent__c = changed.contractProjectRistCostPercent;
              chan.contractProjectBigAmountCostPercent__c = changed.contractProjectBigAmountCostPercent;
              //合同价模拟净利
              chan.contractSimulationNetProfit__c = changed.contractSimulationNetProfit;
              chan.contractSimulationNetProfitPercent__c = changed.contractSimulationNetProfitPercent;*/
               List<Attachment__c> attas = [select id,viewCPQURL__c from Attachment__c where contractChange__c =:chan.Id and type__c ='供货范围清单' and isValid__c='有效'];
                if(attas.size()==1){
                    if(attas[0].viewCPQURL__c!=null){
                        attas[0].viewCPQURL__c=chan.solutionURLCPQ2__c;
                        update attas[0];
                    }
                    
                }else if(attas.size()==0){
                    Attachment__c a = new Attachment__c();
                    a.documentName__c='进入CPQ查看供货范围清单';
                    a.type__c='供货范围清单';
                    a.contractChange__c=chan.id;
                    a.contract__c=chan.contract__c;
                    a.attachmentURL__c=chan.solutionURLCPQ2__c;
                    a.viewCPQURL__c=chan.solutionURLCPQ2__c;
                    insert a;
                }else{
                
                }
              
              update chan;
             
              logClass.returnLog('成功', '已处理', '【CPQ接口COS005】CPQ系统成功更新合同变更:'+chan.Name, '正常');
              resp.flag='S';
            }else{
                resp.flag='N';
                resp.message='合同变更正在审批中或已审批通过，不能修改';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','【CPQ接口COS004】CPQ系统更新合同变更,异常信息:' + e.getMessage(),'重要');
        }
        return resp;
    }
}