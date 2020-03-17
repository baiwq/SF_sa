global class CPQToSOSPContractreviewClass {
    global class Review{
        webservice String revName;
        webservice String quaName;
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
        /*webservice Decimal commonProjectOwnDeviceCost;
        webservice Decimal specialProductCost;
        webservice Decimal outsourcingCost;
        webservice Decimal companyTrainAndServiceCost;
        webservice Decimal projectRunCost;
        webservice Decimal projectRistCost;*/
        //标准价出厂毛利
        webservice Decimal standardPriceGrossProfitContract;
        webservice Decimal standardPriceGrossProfitMarginContract;
        //标准价项目毛利
        webservice Decimal standardProjectGrossProfitContract;
        webservice Decimal standardProjectGrossProfitMarginContract;
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
        webservice Decimal contractProjectGrossProfit;
        webservice Decimal contractProjectGrossProfitMargin;
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
    webservice static Response setStandardPrice(Review review){
        Response resp = new Response();
        try{
           contractreview__c  revi =[select id,Name, approvalStatus__c ,solutionURLCPQStandardPrice__c,solutionURLCPQContractPrice__c ,
                //出口退税率
                exportRebateRate__c,
                //特殊产品成本
                distributionSwitch__c,CYCUPS__c,SVG_STATCOM_APF__c,paidTrainningProduct__c,paidServiceProduct__c,
                distributionSwitchPrice__c,CYCUPSPrice__c,SVG_STATCOM_APFPrice__c,
                paidTrainningProductPrice__c,paidServiceProductPrice__c,
                //标准价出厂毛利润
                standardPriceGrossProfitContract__c ,standardPriceGrossProfitMarginContract__c ,
                //标准价项目毛利
                standardProjectGrossProfitContract__c ,standardProjectGrossProfitMarginContract__c ,
             //合同价标准价
                cCommonProjectOwnEquipmentStandardPrice__c ,cSpecialProductStandardPrice__c ,
                cOwnSoftStandardPrice__c,cOutsourcingStandardPrice__c ,
                cOutsourcingServiceStandardPrice__c ,cOSArchitectureCostStandardPrice__c ,
                cCompanyTrainServiceStandardPrice__c ,
            //合同价总价
                cCommonProjectOwnEquipmentBiddingPrice__c ,cSpecialProductBiddingPrice__c ,
                cOwnSoftBiddingPrice__c ,cOutsourcingBiddingPrice__c ,cOutsourcingServiceBiddingPrice__c ,
                cOutsourcingArchitectureCostBiddingPrice__c ,cCompanyTrainServiceBiddingPrice__c ,
            //合同成本项
                ccommonProjectOwnDeviceCost__c ,cSpecialProductCost__c ,contractOutsourcingCost__c ,
                cCompanyTrainServiceCost__c ,contractProjectBigAmountCost__c ,contractProjectRunCost__c ,contractProjectRistCost__c,
            //合同报价折扣
                commonProjectOwnEquipmentcontracPriceDct__c ,specialProductContractPriceDct__c ,
                ownSoftContractPriceDct__c ,outsourcingContractPriceDct__c ,
                outsourcingServiceContractPriceDct__c ,outsourcingArchitectureCostConPriceDct__c ,
                companyTrainServiceContractPriceDct__c ,contractPriceTotalDct__c ,
            //合同价出厂毛利
                contractPriceGrossProfit__c ,contractPriceGrossProfitMargin__c ,
            //合同价项目毛利
                contractProjectGrossProfit__c ,contractProjectGrossProfitMargin__c ,
                commonProjectOwnDevicePercent__c ,specialProductCostPercent__c ,
                outsourcingCostPercent__c ,companyTrainAndServiceCostPercent__c ,
                contractProjectRunCostPercent__c ,contractProjectRistCostPercent__c ,contractProjectBigAmountCostPercent__c ,
            //合同价模拟净利
                contractSimulationNetProfit__c , contractSimulationNetProfitPercent__c 
        from contractreview__c where Name=:review.revName and quatationName__c=:review.quaName limit 1][0];
            if(revi.approvalStatus__c=='草稿'||revi.approvalStatus__c=='审批拒绝'){
              revi.solutionURLCPQStandardPrice__c=Review.solutionStandardURLCPQ;
              revi.orderIdCPQ__c=Review.orderIdCPQ;
              //出口退税率
              revi.exportRebateRate__c=Review.exportRebateRate;
              //特殊产品成本
              revi.distributionSwitchPrice__c=Review.distributionSwitchPrice;
              revi.CYCUPSPrice__c=Review.CYCUPSPrice;
              revi.SVG_STATCOM_APFPrice__c=Review.SVG_STATCOM_APFPrice;
              revi.paidTrainningProductPrice__c=Review.paidTrainningProductPrice;
              revi.paidServiceProductPrice__c=Review.paidServiceProductPrice;
              revi.distributionSwitch__c=Review.distributionSwitch;
              revi.CYCUPS__c=Review.CYCUPS;
              revi.SVG_STATCOM_APF__c=Review.SVG_STATCOM_APF;
              revi.paidTrainningProduct__c=Review.paidTrainningProduct;
              revi.paidServiceProduct__c=Review.paidServiceProduct; 
              //标准价出厂毛利
              revi.standardPriceGrossProfitContract__c=Review.standardPriceGrossProfitContract;
              revi.standardPriceGrossProfitMarginContract__c=Review.standardPriceGrossProfitMarginContract;
              //标准价项目毛利
              revi.standardProjectGrossProfitContract__c=Review.standardProjectGrossProfitContract;
              revi.standardProjectGrossProfitMarginContract__c=Review.standardProjectGrossProfitMarginContract;
              //合同价URL
              revi.solutionURLCPQContractPrice__c=Review.solutionContractUrlCPQ;
              //合同价标准价
              revi.cCommonProjectOwnEquipmentStandardPrice__c = Review.cCommonProjectOwnEquipmentStandardPrice;
              revi.cSpecialProductStandardPrice__c = Review.cSpecialProductStandardPrice;
              revi.cOwnSoftStandardPrice__c = Review.cOwnSoftStandardPrice;
              revi.cOutsourcingStandardPrice__c = Review.cOutsourcingStandardPrice;
              revi.cOutsourcingServiceStandardPrice__c = Review.cOutsourcingServiceStandardPrice;
              revi.cOSArchitectureCostStandardPrice__c = Review.cOSArchitectureCostStandardPrice;
              revi.cCompanyTrainServiceStandardPrice__c = Review.cCompanyTrainServiceStandardPrice;
            //合同价总价
              revi.cCommonProjectOwnEquipmentBiddingPrice__c = Review.cCommonProjectOwnEquipmentBiddingPrice;
              revi.cSpecialProductBiddingPrice__c = Review.cSpecialProductBiddingPrice;
              revi.cOwnSoftBiddingPrice__c = Review.cOwnSoftBiddingPrice;
              revi.cOutsourcingBiddingPrice__c = Review.cOutsourcingBiddingPrice;
              revi.cOutsourcingServiceBiddingPrice__c = Review.cOutsourcingServiceBiddingPrice;
              revi.cOutsourcingArchitectureCostBiddingPrice__c = Review.cOutsourcingArchitectureCostBiddingPrice;
              revi.cCompanyTrainServiceBiddingPrice__c = Review.cCompanyTrainServiceBiddingPrice;
            //合同成本项
              revi.ccommonProjectOwnDeviceCost__c = Review.ccommonProjectOwnDeviceCost;
              revi.cSpecialProductCost__c = Review.cSpecialProductCost;
              revi.contractOutsourcingCost__c = Review.contractOutsourcingCost;
              revi.cCompanyTrainServiceCost__c = Review.cCompanyTrainServiceCost;
              revi.contractProjectBigAmountCost__c = Review.contractProjectBigAmountCost;
              revi.contractProjectRunCost__c = Review.contractProjectRunCost;
              revi.contractProjectRistCost__c = Review.contractProjectRistCost;
            //合同报价折扣
              revi.commonProjectOwnEquipmentcontracPriceDct__c = Review.commonProjectOwnEquipmentcontracPriceDct;
              revi.specialProductContractPriceDct__c = Review.specialProductContractPriceDct;
              revi.ownSoftContractPriceDct__c = Review.ownSoftContractPriceDct;
              revi.outsourcingContractPriceDct__c = Review.outsourcingContractPriceDct;
              revi.outsourcingServiceContractPriceDct__c = Review.outsourcingServiceContractPriceDct;
              revi.outsourcingArchitectureCostConPriceDct__c = Review.outsourcingArchitectureCostConPriceDct;
              revi.companyTrainServiceContractPriceDct__c = Review.companyTrainServiceContractPriceDct;
              revi.contractPriceTotalDct__c = Review.contractPriceTotalDct;
            //合同价出厂毛利
              revi.contractPriceGrossProfit__c = Review.contractPriceGrossProfit;
              revi.contractPriceGrossProfitMargin__c = Review.contractPriceGrossProfitMargin;
            //合同价项目毛利
              revi.contractProjectGrossProfit__c = Review.contractProjectGrossProfit;
              revi.contractProjectGrossProfitMargin__c = Review.contractProjectGrossProfitMargin;
              revi.commonProjectOwnDevicePercent__c = Review.commonProjectOwnDevicePercent;
              revi.specialProductCostPercent__c = Review.specialProductCostPercent;
              revi.outsourcingCostPercent__c = Review.outsourcingCostPercent;
              revi.companyTrainAndServiceCostPercent__c = Review.companyTrainAndServiceCostPercent;
              revi.contractProjectRunCostPercent__c = Review.contractProjectRunCostPercent;
              revi.contractProjectRistCostPercent__c = Review.contractProjectRistCostPercent;
              revi.contractProjectBigAmountCostPercent__c = Review.contractProjectBigAmountCostPercent;
            //合同价模拟净利
              revi.contractSimulationNetProfit__c = Review.contractSimulationNetProfit;
              revi.contractSimulationNetProfitPercent__c = Review.contractSimulationNetProfitPercent;
              
              update revi;
             
              logClass.returnLog('成功', '已处理', '【CPQ接口COS004】CPQ系统成功更新合同评审:'+revi.Name, '正常');
              resp.flag='S';
            }else{
                resp.flag='N';
                resp.message='合同评审正在审批中或已审批通过，不能修改';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','【CPQ接口COS004】CPQ系统更新合同评审失败,异常信息:' + e.getMessage(),'重要');
        }
        return resp;
    }
}