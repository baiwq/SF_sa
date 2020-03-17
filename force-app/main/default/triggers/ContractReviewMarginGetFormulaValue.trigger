/*
  测试类：TestContractReviewAfterInsert
 */
trigger ContractReviewMarginGetFormulaValue on contractreview__c (after insert,after update) {
    
        try{
            for(contractreview__c cr : Trigger.new){
                if(Trigger.isInsert){
                    List<contractreview__c> crList = new List<contractreview__c>();
                        contractreview__c crclone =cr.clone(true,true);
                    if(cr.recordTypeNew__c!='小额订单'){
                        //标准价
                        //合同供货范围常规项目自有装置标准价(不含特殊产品)
                        
                        crclone.cCommonProjectOwnEquipmentStandardPrice__c = cr.commonProjectOwnEquipmentStandardPrice__c ;
                        system.debug('cCommonProjectOwnEquipmentStandardPrice__c--'+crclone.cCommonProjectOwnEquipmentStandardPrice__c);
                        //合同供货范围特殊产品标准价
                        crclone.cSpecialProductStandardPrice__c = cr.specialProductStandardPrice__c ;
                        //合同供货范围自有软件标准价
                        crclone.cOwnSoftStandardPrice__c = cr.ownSoftStandardPrice__c ;
                        //合同供货范围外购材料标准价
                        crclone.cOutsourcingStandardPrice__c = cr.outsourcingStandardPrice__c ;
                        // 2019.12.19
                        //合同供货范围无效外购材料标准价
                        crclone.cInValidOutsourcingStandardPrice__c = cr.inValidOutsourcingStandardPrice__c ;
                        //合同供货范围外购服务费用标准价
                        crclone.cOutsourcingServiceStandardPrice__c = cr.outsourcingServiceStandardPrice__c ;
                        //合同供货范围外购建筑施工费用标准价
                        crclone.cOSArchitectureCostStandardPrice__c = cr.outsourcingArchitectureCostStandardPrice__c ;
                        //合同供货范围公司对外培训及服务标准价
                        crclone.cCompanyTrainServiceStandardPrice__c = cr.companyTrainServiceStandardPrice__c ;
                    }    
                
                    //常规项目自有装置成本占比
                    crclone.commonProjectOwnDevicePercent__c = cr.commonProjectOwnDevicePercentFormula__c ;
                    //公司对外培训及服务成本占比
                    crclone.companyTrainAndServiceCostPercent__c = cr.companyTrainAndServiceCostPercentFormula__c ;
                    //合同阶段标准价出厂毛利率
                    crclone.standardPriceGrossProfitMarginContract__c = cr.standardPriceGrossProfitMarginContractFu__c ;
                    //合同阶段标准价出厂毛利润
                    crclone.standardPriceGrossProfitContract__c = cr.standardPriceGrossProfitFormulaContract__c ;
                    //合同阶段标准价项目毛利率
                    crclone.standardProjectGrossProfitMarginContract__c = cr.standardProjectGrossProfitMarginContFul__c ;
                    //合同阶段标准价项目毛利润
                    crclone.standardProjectGrossProfitContract__c = cr.standardProjectGrossProfitContractFul__c ;
                    //特殊产品成本占比
                    crclone.specialProductCostPercent__c = cr.specialProductCostPercentFormula__c ;
                    //外购成本占比
                    crclone.outsourcingCostPercent__c = cr.outsourcingCostPercentFormula__c ;
             //合同价
                
             
                    //常规项目自有装置合同价折扣(不含特殊产品)
                    crclone.commonProjectOwnEquipmentcontracPriceDct__c = cr.commonProjectOwnEquipmentConPriceDctFml__c ;
                    //公司对外培训及服务合同价折扣
                    crclone.companyTrainServiceContractPriceDct__c = cr.companyTrainServiceContractPriceDctFul__c ;
                    //合同供货范围常规项目自有装置成本(不含特殊产品)
                    crclone.ccommonProjectOwnDeviceCost__c = cr.ccommonProjectOwnDeviceCostFormula__c ;
                    //合同供货范围公司对外培训及服务成本
                    crclone.cCompanyTrainServiceCost__c = cr.cCompanyTrainServiceCostFormula__c ;
                    //合同供货范围合同价总价折扣
                    crclone.contractPriceTotalDct__c = cr.contractPriceTotalDctFul__c ;
                    //合同供货范围特殊产品成本
                    crclone.cSpecialProductCost__c = cr.cSpecialProductCostFul__c ;
                    //合同供货范围特殊产品合同价
                    crclone.cSpecialProductBiddingPrice__c = cr.specialProductBiddingPrice__c;
                    //合同供货范围外购成本
                    crclone.contractOutsourcingCost__c = cr.contractOutsourcingCostFormula__c ;
                    //合同供货范围项目大额费用成本
                    crclone.contractProjectBigAmountCost__c = cr.contractProjectBigAmountCostFormula__c ;
                    //合同供货范围项目大额费用成本占比
                    crclone.contractProjectBigAmountCostPercent__c = cr.contractProjectBigAmountCostPerceFormula__c ;
                    //合同供货范围项目风险成本(国际合同专用)
                    crclone.contractProjectRistCost__c = cr.contractProjectRistCostFormula__c ;
                    //合同供货范围项目风险成本占比(国际合同专用)
                    crclone.contractProjectRistCostPercent__c = cr.contractProjectRistCostPercentFormula__c ;
                    //合同供货范围项目执行成本(国际合同专用)
                    crclone.contractProjectRunCost__c = cr.contractProjectRunCost__c ;
                    //合同供货范围项目执行成本占比(国际合同专用)
                    crclone.contractProjectRunCostPercent__c = cr.contractProjectRunCostPercentFormula__c ;
                    //合同价出厂毛利率
                    crclone.contractPriceGrossProfitMargin__c = cr.contractPriceGrossProfitMarginFormula__c ;
                    //合同价出厂毛利润
                    crclone.contractPriceGrossProfit__c = cr.contractPriceGrossProfitFormula__c ;
                    //合同价模拟净利润
                    crclone.contractSimulationNetProfit__c = cr.contractSimulationNetProfitFormula__c ;
                    //合同价模拟净利润率
                    crclone.contractSimulationNetProfitPercent__c = cr.contractSimulationNetProfitPercentFormu__c ;
                    //合同价项目毛利率
                    crclone.contractProjectGrossProfitMargin__c = cr.contractProjectGrossProfitMarginFormula__c ;
                    //合同价项目毛利润
                    crclone.contractProjectGrossProfit__c = cr.contractProjectGrossProfitFormula__c ;
                    //特殊产品合同价折扣
                    crclone.specialProductContractPriceDct__c = cr.specialProductContractPriceDCTFul__c ;
                    //外购材料合同价折扣
                    crclone.outsourcingContractPriceDct__c = cr.outsourcingContractPriceDCTFul__c ;
                    //外购服务费用合同价折扣
                    crclone.outsourcingServiceContractPriceDct__c = cr.outsourcingServiceContractPriceDctFul__c ;
                    //外购建筑施工费用合同价折扣
                    crclone.outsourcingArchitectureCostConPriceDct__c = cr.outsourcingArchitectureCostConPriceDctFu__c ;
                    //自有软件合同价折扣
                    crclone.ownSoftContractPriceDct__c = cr.ownSoftContractPriceDCTFul__c ;

                    // 2019.12.19
                    // 合同评审阶段有效业绩标准价总价
                    crclone.ownSoftContractPriceDct__c = cr.ownSoftContractPriceDCTFul__c ;
                    // 合同评审阶段有效业绩字段
                    crclone.cEffectivePerformance__c = cr.cEffectivePerformanceFormula__c ;

              //特殊产品及勾选
                    if(cr.recordTypeNew__c!='小额订单'){
                        quatation__c qua = [select id, solutionURLCPQStandardPrice__c, orderIdCPQ__c ,SVG_STATCOM_APF__c ,SVG_STATCOM_APFPrice__c ,CYCUPS__c ,CYCUPSPrice__c, 
                                          distributionSwitch__c ,distributionSwitchPrice__c ,paidServiceProduct__c ,
                                          paidServiceProductPrice__c ,paidTrainningProduct__c ,paidTrainningProductPrice__c,
                                          commonProjectOwnEquipmentBiddingPrice__c, 
                                          specialProductBiddingPrice__c,
                                          ownSoftBiddingPrice__c,
                                          outsourcingBiddingPrice__c,
                                          outsourcingServiceBiddingPrice__c,
                                          outsourcingArchitectureCostBiddingPrice__c,
                                          companyTrainServiceBiddingPrice__c
                                        from quatation__c where id=:cr.quatation__c limit 1][0];
                        //订单号
                        crclone.orderIdCPQ__c = qua.orderIdCPQ__c;
                        //SVG/STATCOM、柔直换流阀、APF、岸电产品、价格
                        crclone.SVG_STATCOM_APF__c = qua.SVG_STATCOM_APF__c;
                        crclone.SVG_STATCOM_APFPrice__c = qua.SVG_STATCOM_APFPrice__c;
                        //储能、移动供电电源、充电桩、UPS电源产品、价格
                        crclone.CYCUPS__c = qua.CYCUPS__c;
                        crclone.CYCUPSPrice__c = qua.CYCUPSPrice__c;
                        //配电开关、价格
                        crclone.distributionSwitch__c = qua.distributionSwitch__c;
                        crclone.distributionSwitchPrice__c = qua.distributionSwitchPrice__c;
                        //有偿服务产品、价格
                        crclone.paidServiceProduct__c = qua.paidServiceProduct__c;
                        crclone.paidServiceProductPrice__c = qua.paidServiceProductPrice__c;
                        //有偿培训产品
                        crclone.paidTrainningProduct__c = qua.paidTrainningProduct__c;
                        crclone.paidTrainningProductPrice__c = qua.paidTrainningProductPrice__c;
                     //带入投标价
                        //合同供货范围常规项目自有装置合同价(不含特殊产品)
                        crclone.cCommonProjectOwnEquipmentBiddingPrice__c = qua.commonProjectOwnEquipmentBiddingPrice__c ;
                        //合同供货范围特殊产品合同价
                        crclone.cSpecialProductBiddingPrice__c = qua.specialProductBiddingPrice__c ;
                        //合同供货范围自有软件合同价
                        crclone.cOwnSoftBiddingPrice__c = qua.ownSoftBiddingPrice__c ;
                        //合同供货范围外购材料合同价
                        crclone.cOutsourcingBiddingPrice__c = qua.outsourcingBiddingPrice__c ;
                        //合同供货范围外购服务费用合同价
                        crclone.cOutsourcingServiceBiddingPrice__c = qua.outsourcingServiceBiddingPrice__c ;
                        //合同供货范围外购建筑施工费用合同价
                        crclone.cOutsourcingArchitectureCostBiddingPrice__c = qua.outsourcingArchitectureCostBiddingPrice__c ;
                        //合同供货范围公司对外培训及服务合同价
                        crclone.cCompanyTrainServiceBiddingPrice__c = qua.companyTrainServiceBiddingPrice__c ;
                        if(cr.orderIdCPQ__c!=null&&cr.orderIdCPQ__c.trim()!=''){
                            List<Attachment__c> attas = [select id from Attachment__c where quatation__c =:cr.quatation__c and type__c ='供货范围清单' and isValid__c='有效'];
                            if(attas.size()==1){
                                attas[0].contractReview__c=cr.id;
                                update attas[0];
                            }else if(attas.size()==0){
                                Attachment__c a = new Attachment__c();
                                a.documentName__c='进入CPQ查看供货范围清单';
                                a.type__c='供货范围清单';
                                a.contractReview__c=cr.Id;
                                a.quatation__c=cr.quatation__c;
                                a.notes__c=qua.solutionURLCPQStandardPrice__c;
                                insert a;
                            }else{
                            
                            }
                        
                        }
                    }
                    
                    crList.add(crclone);
                        if(crList.size()>0){
                            update crList;
                        }   crList.add(crclone);
                        if(crList.size()>0){
                            update crList;
                        }   
                    
                    
                    
                }
                if(Trigger.isUpdate){
                    system.debug('1111');
                    contractreview__c oldcr = Trigger.oldMap.get(cr.id);
                    if(
                        cr.commonProjectOwnDevicePercentFormula__c!=oldcr.commonProjectOwnDevicePercentFormula__c||
                        cr.companyTrainAndServiceCostPercentFormula__c!=oldcr.companyTrainAndServiceCostPercentFormula__c||
                        cr.standardPriceGrossProfitMarginContractFu__c!=oldcr.standardPriceGrossProfitMarginContractFu__c||
                        cr.standardPriceGrossProfitFormulaContract__c!=oldcr.standardPriceGrossProfitFormulaContract__c||
                        cr.standardProjectGrossProfitMarginContFul__c!=oldcr.standardProjectGrossProfitMarginContFul__c||
                        cr.standardProjectGrossProfitContractFul__c!=oldcr.standardProjectGrossProfitContractFul__c||
                        cr.specialProductCostPercentFormula__c!=oldcr.specialProductCostPercentFormula__c||
                        cr.outsourcingCostPercentFormula__c!=oldcr.outsourcingCostPercentFormula__c||
                        cr.commonProjectOwnEquipmentConPriceDctFml__c!=oldcr.commonProjectOwnEquipmentConPriceDctFml__c||
                        cr.companyTrainServiceContractPriceDctFul__c!=oldcr.companyTrainServiceContractPriceDctFul__c||
                        cr.ccommonProjectOwnDeviceCostFormula__c!=oldcr.ccommonProjectOwnDeviceCostFormula__c||
                        cr.cCompanyTrainServiceCostFormula__c!=oldcr.cCompanyTrainServiceCostFormula__c||
                        cr.contractPriceTotalDctFul__c!=oldcr.contractPriceTotalDctFul__c||
                        cr.cSpecialProductCostFul__c!=oldcr.cSpecialProductCostFul__c||
                        cr.specialProductBiddingPrice__c!=oldcr.specialProductBiddingPrice__c||
                        cr.contractOutsourcingCostFormula__c!=oldcr.contractOutsourcingCostFormula__c||
                        cr.contractProjectBigAmountCostFormula__c!=oldcr.contractProjectBigAmountCostFormula__c||
                        cr.contractProjectBigAmountCostPerceFormula__c!=oldcr.contractProjectBigAmountCostPerceFormula__c||
                        cr.contractProjectRistCostFormula__c!=oldcr.contractProjectRistCostFormula__c||
                        cr.contractProjectRistCostPercentFormula__c!=oldcr.contractProjectRistCostPercentFormula__c||
                        cr.contractProjectRunCost__c!=oldcr.contractProjectRunCost__c||
                        cr.contractProjectRunCostPercentFormula__c!=oldcr.contractProjectRunCostPercentFormula__c||
                        cr.contractPriceGrossProfitMarginFormula__c!=oldcr.contractPriceGrossProfitMarginFormula__c||
                        cr.contractPriceGrossProfitFormula__c!=oldcr.contractPriceGrossProfitFormula__c||
                        cr.contractSimulationNetProfitFormula__c!=oldcr.contractSimulationNetProfitFormula__c||
                        cr.contractSimulationNetProfitPercentFormu__c!=oldcr.contractSimulationNetProfitPercentFormu__c||
                        cr.contractProjectGrossProfitMarginFormula__c!=oldcr.contractProjectGrossProfitMarginFormula__c||
                        cr.contractProjectGrossProfitFormula__c!=oldcr.contractProjectGrossProfitFormula__c||
                        cr.specialProductContractPriceDCTFul__c!=oldcr.specialProductContractPriceDCTFul__c||
                        cr.outsourcingContractPriceDCTFul__c!=oldcr.outsourcingContractPriceDCTFul__c||
                        cr.outsourcingServiceContractPriceDctFul__c!=oldcr.outsourcingServiceContractPriceDctFul__c||
                        cr.outsourcingArchitectureCostConPriceDctFu__c!=oldcr.outsourcingArchitectureCostConPriceDctFu__c||
                        cr.ownSoftContractPriceDCTFul__c!=oldcr.ownSoftContractPriceDCTFul__c||
                        cr.cPerfomanceStandardTotalPriceFormula__c!=oldcr.cPerfomanceStandardTotalPriceFormula__c||
                        cr.cEffectivePerformanceFormula__c!=oldcr.cEffectivePerformanceFormula__c
                        
                    ){
                        List<contractreview__c> crList = new List<contractreview__c>();
                        contractreview__c crclone =cr.clone(true,true);
                    //标准价
                        //常规项目自有装置成本占比
                        crclone.commonProjectOwnDevicePercent__c = cr.commonProjectOwnDevicePercentFormula__c ;
                        //公司对外培训及服务成本占比
                        crclone.companyTrainAndServiceCostPercent__c = cr.companyTrainAndServiceCostPercentFormula__c ;
                        //合同阶段标准价出厂毛利率
                        crclone.standardPriceGrossProfitMarginContract__c = cr.standardPriceGrossProfitMarginContractFu__c ;
                        //合同阶段标准价出厂毛利润
                        crclone.standardPriceGrossProfitContract__c = cr.standardPriceGrossProfitFormulaContract__c ;
                        //合同阶段标准价项目毛利率
                        crclone.standardProjectGrossProfitMarginContract__c = cr.standardProjectGrossProfitMarginContFul__c ;
                        //合同阶段标准价项目毛利润
                        crclone.standardProjectGrossProfitContract__c = cr.standardProjectGrossProfitContractFul__c ;
                        //特殊产品成本占比
                        crclone.specialProductCostPercent__c = cr.specialProductCostPercentFormula__c ;
                        //外购成本占比
                        crclone.outsourcingCostPercent__c = cr.outsourcingCostPercentFormula__c ;
                 //合同价
                        //常规项目自有装置合同价折扣(不含特殊产品)
                        crclone.commonProjectOwnEquipmentcontracPriceDct__c = cr.commonProjectOwnEquipmentConPriceDctFml__c ;
                        //公司对外培训及服务合同价折扣
                        crclone.companyTrainServiceContractPriceDct__c = cr.companyTrainServiceContractPriceDctFul__c ;
                        //合同供货范围常规项目自有装置成本(不含特殊产品)
                        crclone.ccommonProjectOwnDeviceCost__c = cr.ccommonProjectOwnDeviceCostFormula__c ;
                        //合同供货范围公司对外培训及服务成本
                        crclone.cCompanyTrainServiceCost__c = cr.cCompanyTrainServiceCostFormula__c ;
                        //合同供货范围合同价总价折扣
                        crclone.contractPriceTotalDct__c = cr.contractPriceTotalDctFul__c ;
                        //合同供货范围特殊产品成本
                        crclone.cSpecialProductCost__c = cr.cSpecialProductCostFul__c ;
                        //合同供货范围特殊产品合同价
                        //crclone.cSpecialProductBiddingPrice__c = cr.specialProductBiddingPrice__c;
                        //合同供货范围外购成本
                        crclone.contractOutsourcingCost__c = cr.contractOutsourcingCostFormula__c ;
                        //合同供货范围项目大额费用成本
                        //crclone.contractProjectBigAmountCost__c = cr.contractProjectBigAmountCostFormula__c ;
                        //合同供货范围项目大额费用成本占比
                        crclone.contractProjectBigAmountCostPercent__c = cr.contractProjectBigAmountCostPerceFormula__c ;
                        //合同供货范围项目风险成本(国际合同专用)
                        crclone.contractProjectRistCost__c = cr.contractProjectRistCost__c ;
                        //合同供货范围项目风险成本占比(国际合同专用)
                        crclone.contractProjectRistCostPercent__c = cr.contractProjectRistCostPercentFormula__c ;
                        //合同供货范围项目执行成本(国际合同专用)
                        crclone.contractProjectRunCost__c = cr.contractProjectRunCost__c ;
                        //合同供货范围项目执行成本占比(国际合同专用)
                        crclone.contractProjectRunCostPercent__c = cr.contractProjectRunCostPercentFormula__c ;
                        //合同价出厂毛利率
                        crclone.contractPriceGrossProfitMargin__c = cr.contractPriceGrossProfitMarginFormula__c ;
                        //合同价出厂毛利润
                        crclone.contractPriceGrossProfit__c = cr.contractPriceGrossProfitFormula__c ;
                        //合同价模拟净利润
                        crclone.contractSimulationNetProfit__c = cr.contractSimulationNetProfitFormula__c ;
                        //合同价模拟净利润率
                        crclone.contractSimulationNetProfitPercent__c = cr.contractSimulationNetProfitPercentFormu__c ;
                        //合同价项目毛利率
                        crclone.contractProjectGrossProfitMargin__c = cr.contractProjectGrossProfitMarginFormula__c ;
                        //合同价项目毛利润
                        crclone.contractProjectGrossProfit__c = cr.contractProjectGrossProfitFormula__c ;
                        //特殊产品合同价折扣
                        crclone.specialProductContractPriceDct__c = cr.specialProductContractPriceDCTFul__c ;
                        //外购材料合同价折扣
                        crclone.outsourcingContractPriceDct__c = cr.outsourcingContractPriceDCTFul__c ;
                        //外购服务费用合同价折扣
                        crclone.outsourcingServiceContractPriceDct__c = cr.outsourcingServiceContractPriceDctFul__c ;
                        //外购建筑施工费用合同价折扣
                        crclone.outsourcingArchitectureCostConPriceDct__c = cr.outsourcingArchitectureCostConPriceDctFu__c ;
                        //自有软件合同价折扣
                        crclone.ownSoftContractPriceDct__c = cr.ownSoftContractPriceDCTFul__c ;

                        // 2019.12.19
                        // 合同评审阶段有效业绩标准价总价
                        crclone.cPerfomanceStandardTotalPrice__c = cr.cPerfomanceStandardTotalPriceFormula__c ;
                        // 合同评审阶段有效业绩字段
                        crclone.cEffectivePerformance__c = cr.cEffectivePerformanceFormula__c ;
                        crList.add(crclone);
                        if(crList.size()>0){
                            update crList;
                        }                        
                    }
                    
                }
                
            }
        }catch(Exception e){
            
        }
}