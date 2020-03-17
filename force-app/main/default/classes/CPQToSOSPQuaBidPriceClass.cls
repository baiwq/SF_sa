global class CPQToSOSPQuaBidPriceClass {
    global class Quatation{
        webservice String Name;
        webservice String orderIdCPQ;
        webservice String solutionURLCPQ2;
        //投标价
        webservice Decimal commonProjectOwnEquipmentBiddingPrice;
        webservice Decimal specialProductBiddingPrice;
        webservice Decimal ownSoftBiddingPrice;
        webservice Decimal outsourcingBiddingPrice;
        webservice Decimal outsourcingServiceBiddingPrice;
        webservice Decimal outsourcingArchitectureCostBiddingPrice;
        webservice Decimal companyTrainServiceBiddingPrice;
        webservice Decimal biddingTotalPrice;
        //特殊成本项（就有一个项目大额费用成本字段字段）
        webservice Decimal projectBigAmountCost;
        //出口退税率
        webservice Decimal exportRebateRate;
        
        //投标折扣
        webservice Decimal commonProjectOwnEquipmentBidPriceDctFml;
        webservice Decimal specialProductBiddingPriceDCT;
        webservice Decimal ownSoftBiddingPriceDCT;
        webservice Decimal outsourcingBiddingPriceDct;
        webservice Decimal outsourcingServiceBiddingPriceDct;
        webservice Decimal outsourcingArchitectureCostBidPriceDct;
        webservice Decimal companyTrainServiceBiddingPriceDct;
        webservice Decimal biddingTotalPriceDct;
        
        //投标价出厂毛利
        webservice Decimal bidPriceFactoryMargin;
        webservice Decimal bidPriceFactoryMarginRate;
        //投标价项目毛利
        webservice Decimal bidPriceProjectMargin;
        webservice Decimal bidPriceProjectMarginRate;
        
        webservice Decimal bidCommonProjectOwnDevicePercent;
        webservice Decimal bidspecialProductCostPercent;
        webservice Decimal bidoutsourcingCostPercent;
        webservice Decimal bidcompanyTrainAndServiceCost;
        webservice Decimal bidprojectRunCostPercent;
        webservice Decimal bidprojectRistCostPercent;
        webservice Decimal bidprojectBigAmountCostPercent;
        //投标价模拟净利
        webservice Decimal bidSimulationNetProfit;
        webservice Decimal bidSimulationNetProfitPercent;
        
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response setBidPrice(Quatation quatation){
        Response resp = new Response();
        try{
            quatation__c  qua =[select id,Name, approvalStatus__c ,
              solutionURLCPQBidPrice__c,
              //出口退税率
              exportRebateRate__c,
             commonProjectOwnEquipmentBiddingPrice__c,
         specialProductBiddingPrice__c,
         ownSoftBiddingPrice__c,
         outsourcingBiddingPrice__c,
         outsourcingServiceBiddingPrice__c,
         outsourcingArchitectureCostBiddingPrice__c,
         companyTrainServiceBiddingPrice__c,
         biddingTotalPrice__c,
        //特殊成本项（就有一个项目大额费用成本字段字段）
         projectBigAmountCost__c,
        
        //投标折扣
         commonProjectOwnEquipmentBidPriceDctFml__c,
         specialProductBiddingPriceDCT__c,
         ownSoftBiddingPriceDCT__c,
         outsourcingBiddingPriceDct__c,
         outsourcingServiceBiddingPriceDct__c,
         outsourcingArchitectureCostBidPriceDct__c,
         companyTrainServiceBiddingPriceDct__c,
         biddingTotalPriceDct__c,
        
        //投标价出厂毛利
         bidPriceFactoryMargin__c,
         bidPriceFactoryMarginRate__c,
        //投标价项目毛利
         bidPriceProjectMargin__c,
         bidPriceProjectMarginRate__c,
        
         bidCommonProjectOwnDevicePercent__c,
         bidspecialProductCostPercent__c,
         bidoutsourcingCostPercent__c,
         bidcompanyTrainAndServiceCost__c,
         bidprojectRunCostPercent__c,
         bidprojectRistCostPercent__c,
         bidprojectBigAmountCostPercent__c,
        //投标价模拟净利
         bidSimulationNetProfit__c,
         bidSimulationNetProfitPercent__c

               
         from quatation__c where Name=:quatation.Name limit 1][0];
            if(qua.approvalStatus__c=='草稿'||qua.approvalStatus__c=='审批拒绝'){
              qua.solutionURLCPQBidPrice__c=quatation.solutionURLCPQ2;
              qua.orderIdCPQ__c=quatation.orderIdCPQ;
              //投标价
            qua.commonProjectOwnEquipmentBiddingPrice__c=quatation.commonProjectOwnEquipmentBiddingPrice;
            qua.specialProductBiddingPrice__c=quatation.specialProductBiddingPrice;
            qua.ownSoftBiddingPrice__c=quatation.ownSoftBiddingPrice;
            qua.outsourcingBiddingPrice__c=quatation.outsourcingBiddingPrice;
            qua.outsourcingServiceBiddingPrice__c=quatation.outsourcingServiceBiddingPrice;
            qua.outsourcingArchitectureCostBiddingPrice__c=quatation.outsourcingArchitectureCostBiddingPrice;
            qua.companyTrainServiceBiddingPrice__c=quatation.companyTrainServiceBiddingPrice;
            qua.biddingTotalPrice__c=quatation.biddingTotalPrice;
            //特殊成本项（就有一个项目大额费用成本字段字段）     
            qua.projectBigAmountCost__c=quatation.projectBigAmountCost;
            //出口退税率
            qua.exportRebateRate__c=quatation.exportRebateRate;                
            //投标折扣      
            qua.commonProjectOwnEquipmentBidPriceDctFml__c=quatation.commonProjectOwnEquipmentBidPriceDctFml;
            qua.specialProductBiddingPriceDCT__c=quatation.specialProductBiddingPriceDCT;
            qua.ownSoftBiddingPriceDCT__c=quatation.ownSoftBiddingPriceDCT;
            qua.outsourcingBiddingPriceDct__c=quatation.outsourcingBiddingPriceDct;
            qua.outsourcingServiceBiddingPriceDct__c=quatation.outsourcingServiceBiddingPriceDct;
            qua.outsourcingArchitectureCostBidPriceDct__c=quatation.outsourcingArchitectureCostBidPriceDct;
            qua.companyTrainServiceBiddingPriceDct__c=quatation.companyTrainServiceBiddingPriceDct;
            qua.biddingTotalPriceDct__c=quatation.biddingTotalPriceDct;
                            
             //投标价出厂毛利       
            qua.bidPriceFactoryMargin__c=quatation.bidPriceFactoryMargin;
            qua.bidPriceFactoryMarginRate__c=quatation.bidPriceFactoryMarginRate;
             //投标价项目毛利       
            qua.bidPriceProjectMargin__c=quatation.bidPriceProjectMargin;
            qua.bidPriceProjectMarginRate__c=quatation.bidPriceProjectMarginRate;
                            
            qua.bidCommonProjectOwnDevicePercent__c=quatation.bidCommonProjectOwnDevicePercent;
            qua.bidspecialProductCostPercent__c=quatation.bidspecialProductCostPercent;
            qua.bidoutsourcingCostPercent__c=quatation.bidoutsourcingCostPercent;
            qua.bidcompanyTrainAndServiceCost__c=quatation.bidcompanyTrainAndServiceCost;
            qua.bidprojectRunCostPercent__c=quatation.bidprojectRunCostPercent;
            qua.bidprojectRistCostPercent__c=quatation.bidprojectRistCostPercent;
            qua.bidprojectBigAmountCostPercent__c=quatation.bidprojectBigAmountCostPercent;
            //投标价模拟净利     
            qua.bidSimulationNetProfit__c=quatation.bidSimulationNetProfit;
            qua.bidSimulationNetProfitPercent__c=quatation.bidSimulationNetProfitPercent;

       
              update qua;
              logClass.returnLog('成功', '已处理', '【CPQ接口COS002】CPQ系统成功更新报价单投标报价:'+quatation.Name, '正常');
              resp.flag='S';
            }else{
                resp.flag='N';
                resp.message='报价单正在审批中或已审批通过，不能修改';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','【CPQ接口COS002】CPQ系统更新报价单投标报价失败,异常信息:' + e.getMessage(),'重要');
        }
        return resp;
    }
}