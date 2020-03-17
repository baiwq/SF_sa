/*
  测试类：TestQuatationAfterInsert
  功能  ：报价管理 公式字段代入
  覆盖率：98%
 */
trigger QuatationGetFormulaValue on quatation__c (after insert,after update) {
  
    for(quatation__c q:Trigger.new){
        try{
            if(Trigger.isInsert){
                     List<quatation__c> ccList= new List<quatation__c>();
                       quatation__c quaclone =q.clone(true,true);
                //标准价 
                       //标准价出厂毛利率
                       quaclone.standardPriceGrossProfitMargin__c = q.standardPriceGrossProfitMarginFormula__c;
                       //标准价出厂毛利润
                       quaclone.standardPriceGrossProfit__c = q.standardPriceGrossProfitFormula__c;
                       //标准价模拟净利润
                       quaclone.standardSimulationNetProfit__c = q.standardSimulationNetProfitFormula__c;
                       //标准价模拟净利润率
                       quaclone.standardSimulationNetProfitPercent__c = q.standardSimulationNetProfitPercentFormu__c;
                       if(q.MainProductGroup__c != '发电及用电业务单元-电站事业部')
                       {
                        //标准价项目毛利润
                        quaclone.standardProjectGrossProfit__c = q.standardProjectGrossProfitFormula__c;
                        //标准价项目毛利率
                        quaclone.standardProjectGrossProfitMargin__c = q.standardProjectGrossProfitMarginFormula__c;
                      }
                      
                      // 2019.12.16 修改：当主责事业部为发电及用电业务单元-电站事业部的时候，不赋值
                       if(q.MainProductGroup__c == '发电及用电业务单元-电站事业部')
                       {
                        //标准价项目毛利润
                        quaclone.standardProjectGrossProfit__c = null;
                        //标准价项目毛利率
                        quaclone.standardProjectGrossProfitMargin__c = null;
                       }
                       //常规项目自有装置成本(不含特殊产品)
                       quaclone.commonProjectOwnDeviceCost__c = q.commonProjectOwnDeviceCostFormula__c;
                       //常规项目自有装置成本占比
                       quaclone.commonProjectOwnDevicePercent__c = q.commonProjectOwnDevicePercentFormula__c;
                       //公司对外培训及服务成本
                       quaclone.companyTrainAndServiceCost__c = q.companyTrainAndServiceCostFormula__c;
                       //公司对外培训及服务成本占比
                       quaclone.companyTrainAndServiceCostPercent__c = q.companyTrainAndServiceCostPercentFormula__c;
                       //特殊产品成本
                       quaclone.specialProductCost__c = q.specialProductCostFormula__c ;
                       //特殊产品成本占比
                       quaclone.specialProductCostPercent__c= q.specialProductCostPercentFormula__c;
                       //外购成本
                       quaclone.outsourcingCost__c = q.outsourcingCostFormula__c;
                       //外购成本占比
                       quaclone.outsourcingCostPercent__c = q.outsourcingCostPercentFormula__c;
                       //项目大额费用成本占比
                       quaclone.projectBigAmountCostPercent__c = q.projectBigAmountCostPercentFormula__c;
                       //项目风险成本占比(国际合同专用)
                       quaclone.projectRistCostPercent__c = q.projectRistCostPercentFormula__c;
                       //项目执行费用成本占比(国际合同专用)
                       quaclone.projectRunCostPercent__c = q.projectRunCostPercentFormula__c;
                //投标价
                       //(投标价)常规项目自有装置成本占比
                       quaclone.bidCommonProjectOwnDevicePercent__c = q.bidCommonProjectOwnDevicePercentFormula__c;
                       //(投标价)公司对外培训及服务成本占比
                       quaclone.bidcompanyTrainAndServiceCost__c = q.bidcompanyTrainAndServiceCostFul__c;
                       //(投标价)特殊产品成本占比
                       quaclone.bidspecialProductCostPercent__c = q.bidspecialProductCostPercentFul__c;
                       //(投标价)外购成本占比
                       quaclone.bidoutsourcingCostPercent__c = q.bidoutsourcingCostPercentFul__c;
                       //(投标价)项目大额费用成本占比
                       quaclone.bidprojectBigAmountCostPercent__c = q.bidprojectBigAmountCostPercentFul__c;
                       //(投标价)项目风险成本占比(国际合同专用)
                       quaclone.bidprojectRistCostPercent__c = q.bidprojectRistCostPercentFul__c;
                       //(投标价)项目执行费用成本占比(国际合同专用)
                       quaclone.bidprojectRunCostPercent__c = q.bidprojectRunCostPercentFul__c;
                       //常规项目自有装置投标价折扣(不含特殊产品)
                       quaclone.commonProjectOwnEquipmentBidPriceDctFml__c = q.commonProjectOwnEquipmentBiddingPriceDCT__c;
                       //公司对外培训及服务投标价折扣
                       quaclone.companyTrainServiceBiddingPriceDct__c = q.companyTrainServiceBiddingPriceDctFul__c;
                       //特殊产品投标价折扣
                       quaclone.specialProductBiddingPriceDCT__c = q.specialProductBiddingPriceDCTFul__c;
                       //投标报价总价
                       quaclone.biddingTotalPrice__c = q.biddingTotalPriceFormula__c;
                       // modifyDate 2019.12.16
                       // 添加 有效业绩
                       quaclone.effectivePerformance__c = q.effectivePerformanceFormula__c;
                       //投标报价总价折扣
                       quaclone.biddingTotalPriceDct__c = q.biddingTotalPriceDctFul__c;
                       //投标价出厂毛利率
                       quaclone.bidPriceFactoryMarginRate__c = q.bidPriceFactoryMarginRateFul__c;
                       //投标价出厂毛利润
                       quaclone.bidPriceFactoryMargin__c = q.bidPriceFactoryMarginFul__c;
                       //投标价模拟净利润
                       quaclone.bidSimulationNetProfit__c = q.bidSimulationNetProfitFul__c;
                       //投标价模拟净利润率
                       quaclone.bidSimulationNetProfitPercent__c = q.bidSimulationNetProfitPercentFul__c;
                       //投标价项目毛利率
                       quaclone.bidPriceProjectMarginRate__c = q.bidPriceProjectMarginRateFul__c;
                       //投标价项目毛利润
                       quaclone.bidPriceProjectMargin__c = q.bidPriceProjectMarginFul__c;
                       //投标阶段标准报价总价
                       quaclone.standardTotalPrice__c = q.standardTotalPriceFormula__c;
                       //modifyDate  2019.12.16
                       //添加 有效业绩标准价总价
                       quaclone.perfomanceStandardTotalPrice__c = q.perfomanceStandardTotalPriceFormula__c;

                       //外购材料投标价折扣
                       quaclone.outsourcingBiddingPriceDct__c = q.outsourcingBiddingPriceDCTFul__c;
                       //外购服务费用投标价折扣
                       quaclone.outsourcingServiceBiddingPriceDct__c = q.outsourcingServiceBiddingPriceDctFul__c;
                       //外购建筑施工费用投标价折扣
                       quaclone.outsourcingArchitectureCostBidPriceDct__c = q.outsourcingArchitectureCostBidPriceDctFu__c;
                       //自有软件投标价折扣
                       quaclone.ownSoftBiddingPriceDCT__c = q.ownSoftBiddingPriceDCTFul__c; 
                       ccList.add(quaclone);                  
                       if(ccList.size()>0){
                           update ccList;
                       }
            }
            if(Trigger.isUpdate){
                quatation__c oldq = Trigger.oldMap.get(q.id);
                if(q.standardPriceGrossProfitMarginFormula__c != oldq.standardPriceGrossProfitMarginFormula__c||
                      q.standardPriceGrossProfitFormula__c != oldq.standardPriceGrossProfitFormula__c||
                      q.standardSimulationNetProfitFormula__c != oldq.standardSimulationNetProfitFormula__c||
                      q.standardSimulationNetProfitPercentFormu__c != oldq.standardSimulationNetProfitPercentFormu__c||
                      q.standardProjectGrossProfitMarginFormula__c != oldq.standardProjectGrossProfitMarginFormula__c||
                      q.standardProjectGrossProfitFormula__c != oldq.standardProjectGrossProfitFormula__c||
                      q.commonProjectOwnDeviceCostFormula__c != oldq.commonProjectOwnDeviceCostFormula__c||
                      q.commonProjectOwnDevicePercentFormula__c != oldq.commonProjectOwnDevicePercentFormula__c||
                      q.companyTrainAndServiceCostFormula__c != oldq.companyTrainAndServiceCostFormula__c||
                      q.companyTrainAndServiceCostPercentFormula__c != oldq.companyTrainAndServiceCostPercentFormula__c||
                      q.specialProductCostFormula__c != oldq.specialProductCostFormula__c||
                      q.specialProductCostPercentFormula__c != oldq.specialProductCostPercentFormula__c||
                      q.outsourcingCostFormula__c != oldq.outsourcingCostFormula__c||
                      q.outsourcingCostPercentFormula__c != oldq.outsourcingCostPercentFormula__c||
                      q.projectBigAmountCostPercentFormula__c != oldq.projectBigAmountCostPercentFormula__c||
                      q.projectRunCostPercentFormula__c != oldq.projectRunCostPercentFormula__c||
                      q.bidCommonProjectOwnDevicePercentFormula__c != oldq.bidCommonProjectOwnDevicePercentFormula__c||
                      q.bidcompanyTrainAndServiceCostFul__c != oldq.bidcompanyTrainAndServiceCostFul__c||
                      q.bidspecialProductCostPercentFul__c != oldq.bidspecialProductCostPercentFul__c||
                      q.bidoutsourcingCostPercentFul__c != oldq.bidoutsourcingCostPercentFul__c||
                      q.bidprojectBigAmountCostPercentFul__c != oldq.bidprojectBigAmountCostPercentFul__c||
                      q.bidprojectRistCostPercentFul__c != oldq.bidprojectRistCostPercentFul__c||
                      q.bidprojectRunCostPercentFul__c != oldq.bidprojectRunCostPercentFul__c||
                      q.commonProjectOwnEquipmentBiddingPriceDCT__c != oldq.commonProjectOwnEquipmentBiddingPriceDCT__c||
                      q.companyTrainServiceBiddingPriceDctFul__c != oldq.companyTrainServiceBiddingPriceDctFul__c||
                      q.specialProductBiddingPriceDCTFul__c != oldq.specialProductBiddingPriceDCTFul__c||
                      q.biddingTotalPriceFormula__c != oldq.biddingTotalPriceFormula__c||
                      q.biddingTotalPriceDctFul__c != oldq.biddingTotalPriceDctFul__c||
                      q.bidPriceFactoryMarginRateFul__c != oldq.bidPriceFactoryMarginRateFul__c||
                      q.bidPriceFactoryMarginFul__c != oldq.bidPriceFactoryMarginFul__c||
                      q.bidSimulationNetProfitFul__c != oldq.bidSimulationNetProfitFul__c||
                      q.bidSimulationNetProfitPercentFul__c != oldq.bidSimulationNetProfitPercentFul__c||
                      q.bidPriceProjectMarginRateFul__c != oldq.bidPriceProjectMarginRateFul__c||
                      q.bidPriceProjectMarginFul__c != oldq.bidPriceProjectMarginFul__c||
                      q.standardTotalPriceFormula__c != oldq.standardTotalPriceFormula__c||
                      q.outsourcingBiddingPriceDCTFul__c != oldq.outsourcingBiddingPriceDCTFul__c||
                      q.outsourcingServiceBiddingPriceDctFul__c != oldq.outsourcingServiceBiddingPriceDctFul__c||
                      q.outsourcingArchitectureCostBidPriceDctFu__c != oldq.outsourcingArchitectureCostBidPriceDctFu__c||
                      q.ownSoftBiddingPriceDCTFul__c != oldq.ownSoftBiddingPriceDCTFul__c||
                      q.standardProjectGrossProfitFormula__c !=oldq.standardProjectGrossProfitFormula__c||
                      q.standardProjectGrossProfitMarginFormula__c !=oldq.standardProjectGrossProfitMarginFormula__c||
                      q.effectivePerformanceFormula__c !=oldq.effectivePerformanceFormula__c
                     ){
                       List<quatation__c> ccList= new List<quatation__c>();
                       quatation__c quaclone =q.clone(true,true);
                //标准价 
                       //标准价出厂毛利率
                       quaclone.standardPriceGrossProfitMargin__c = q.standardPriceGrossProfitMarginFormula__c;
                       //标准价出厂毛利润
                       quaclone.standardPriceGrossProfit__c = q.standardPriceGrossProfitFormula__c;
                       //标准价模拟净利润
                       quaclone.standardSimulationNetProfit__c = q.standardSimulationNetProfitFormula__c;
                       //标准价模拟净利润率
                       quaclone.standardSimulationNetProfitPercent__c = q.standardSimulationNetProfitPercentFormu__c;
                      if(q.MainProductGroup__c != '发电及用电业务单元-电站事业部')
                      {
                        //标准价项目毛利润
                        quaclone.standardProjectGrossProfit__c = q.standardProjectGrossProfitFormula__c;
                        //标准价项目毛利率
                        quaclone.standardProjectGrossProfitMargin__c = q.standardProjectGrossProfitMarginFormula__c;
                      }
                       // 2019.12.16 修改：当主责事业部为发电及用电业务单元-电站事业部的时候，不赋值
                       if(q.MainProductGroup__c == '发电及用电业务单元-电站事业部')
                       {
                        //标准价项目毛利润
                        quaclone.standardProjectGrossProfit__c = null;
                        //标准价项目毛利率
                        quaclone.standardProjectGrossProfitMargin__c = null;
                       }
                       //常规项目自有装置成本(不含特殊产品)
                       quaclone.commonProjectOwnDeviceCost__c = q.commonProjectOwnDeviceCostFormula__c;
                       //常规项目自有装置成本占比
                       quaclone.commonProjectOwnDevicePercent__c = q.commonProjectOwnDevicePercentFormula__c;
                       //公司对外培训及服务成本
                       quaclone.companyTrainAndServiceCost__c = q.companyTrainAndServiceCostFormula__c;
                       //公司对外培训及服务成本占比
                       quaclone.companyTrainAndServiceCostPercent__c = q.companyTrainAndServiceCostPercentFormula__c;
                       //特殊产品成本
                       quaclone.specialProductCost__c = q.specialProductCostFormula__c ;
                       //特殊产品成本占比
                       quaclone.specialProductCostPercent__c= q.specialProductCostPercentFormula__c;
                       //外购成本
                       quaclone.outsourcingCost__c = q.outsourcingCostFormula__c;
                       //外购成本占比
                       quaclone.outsourcingCostPercent__c = q.outsourcingCostPercentFormula__c;
                       //项目大额费用成本占比
                       quaclone.projectBigAmountCostPercent__c = q.projectBigAmountCostPercentFormula__c;
                       //项目风险成本占比(国际合同专用)
                       quaclone.projectRistCostPercent__c = q.projectRistCostPercentFormula__c;
                       //项目执行费用成本占比(国际合同专用)
                       quaclone.projectRunCostPercent__c = q.projectRunCostPercentFormula__c;
                      //投标价
                       //(投标价)常规项目自有装置成本占比
                       quaclone.bidCommonProjectOwnDevicePercent__c = q.bidCommonProjectOwnDevicePercentFormula__c;
                       //(投标价)公司对外培训及服务成本占比
                       quaclone.bidcompanyTrainAndServiceCost__c = q.bidcompanyTrainAndServiceCostFul__c;
                       //(投标价)特殊产品成本占比
                       quaclone.bidspecialProductCostPercent__c = q.bidspecialProductCostPercentFul__c;
                       //(投标价)外购成本占比
                       quaclone.bidoutsourcingCostPercent__c = q.bidoutsourcingCostPercentFul__c;
                       //(投标价)项目大额费用成本占比
                       quaclone.bidprojectBigAmountCostPercent__c = q.bidprojectBigAmountCostPercentFul__c;
                       //(投标价)项目风险成本占比(国际合同专用)
                       quaclone.bidprojectRistCostPercent__c = q.bidprojectRistCostPercentFul__c;
                       //(投标价)项目执行费用成本占比(国际合同专用)
                       quaclone.bidprojectRunCostPercent__c = q.bidprojectRunCostPercentFul__c;
                       //常规项目自有装置投标价折扣(不含特殊产品)
                       quaclone.commonProjectOwnEquipmentBidPriceDctFml__c = q.commonProjectOwnEquipmentBiddingPriceDCT__c;
                       //公司对外培训及服务投标价折扣
                       quaclone.companyTrainServiceBiddingPriceDct__c = q.companyTrainServiceBiddingPriceDctFul__c;
                       //特殊产品投标价折扣
                       quaclone.specialProductBiddingPriceDCT__c = q.specialProductBiddingPriceDCTFul__c;
                       //投标报价总价
                       quaclone.biddingTotalPrice__c = q.biddingTotalPriceFormula__c;
                       // modifyDate 2019.12.16
                       // 添加 有效业绩
                       quaclone.effectivePerformance__c = q.effectivePerformanceFormula__c;
                       //投标报价总价折扣
                       quaclone.biddingTotalPriceDct__c = q.biddingTotalPriceDctFul__c;
                       //投标价出厂毛利率
                       quaclone.bidPriceFactoryMarginRate__c = q.bidPriceFactoryMarginRateFul__c;
                       //投标价出厂毛利润
                       quaclone.bidPriceFactoryMargin__c = q.bidPriceFactoryMarginFul__c;
                       //投标价模拟净利润
                       quaclone.bidSimulationNetProfit__c = q.bidSimulationNetProfitFul__c;
                       //投标价模拟净利润率
                       quaclone.bidSimulationNetProfitPercent__c = q.bidSimulationNetProfitPercentFul__c;
                       //投标价项目毛利率
                       quaclone.bidPriceProjectMarginRate__c = q.bidPriceProjectMarginRateFul__c;
                       //投标价项目毛利润
                       quaclone.bidPriceProjectMargin__c = q.bidPriceProjectMarginFul__c;
                       //投标阶段标准报价总价
                       quaclone.standardTotalPrice__c = q.standardTotalPriceFormula__c;
                       //modifyDate  2019.12.16
                       //添加 有效业绩标准价总价
                       quaclone.perfomanceStandardTotalPrice__c = q.perfomanceStandardTotalPriceFormula__c;
                       //外购材料投标价折扣
                       quaclone.outsourcingBiddingPriceDct__c = q.outsourcingBiddingPriceDCTFul__c;
                       //外购服务费用投标价折扣
                       quaclone.outsourcingServiceBiddingPriceDct__c = q.outsourcingServiceBiddingPriceDctFul__c;
                       //外购建筑施工费用投标价折扣
                       quaclone.outsourcingArchitectureCostBidPriceDct__c = q.outsourcingArchitectureCostBidPriceDctFu__c;
                       //自有软件投标价折扣
                       quaclone.ownSoftBiddingPriceDCT__c = q.ownSoftBiddingPriceDCTFul__c;                   
                       ccList.add(quaclone);
                       if(ccList.size()>0){
                           update ccList;
                       }
                }
            }
        }catch(exception e){
            System.Debug('EEE'); 
        }     
    }
}