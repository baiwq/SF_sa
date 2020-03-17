global class CPQToSOSPQuaStandardPriceClass {
    global class Quatation{
        webservice String Name;
        webservice String solutionURLCPQ;
        webservice String orderIdCPQ;
        //标准价
        webservice Decimal commonProjectOwnEquipmentStandardPrice;
        webservice Decimal specialProductStandardPrice;
        webservice Decimal ownSoftStandardPrice;
        webservice Decimal outsourcingStandardPrice;
        webservice Decimal outsourcingServiceStandardPrice;
        webservice Decimal outsourcingArchitectureCostStandardPrice;
        webservice Decimal companyTrainServiceStandardPrice;
        webservice Decimal standardTotalPrice;
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
        webservice Decimal standardPriceGrossProfit;
        webservice Decimal standardPriceGrossProfitMargin;
        //标准价项目毛利
        webservice Decimal standardProjectGrossProfit;
        webservice Decimal standardProjectGrossProfitMargin;
        //webservice Decimal costPercent;
        webservice Decimal commonProjectOwnDevicePercent;
        webservice Decimal specialProductCostPercent;
        webservice Decimal outsourcingCostPercent;
        webservice Decimal companyTrainAndServiceCostPercent;
        webservice Decimal projectRunCostPercent;
        webservice Decimal projectRistCostPercent;
        //标准价模拟净利
        webservice Decimal standardSimulationNetProfit;
        webservice Decimal standardSimulationNetProfitPercent;
        
    }
    global class Response{
        webservice String flag;
        webservice String message;
    }
    webservice static Response setStandardPrice(Quatation quatation){
        Response resp = new Response();
        try{
            quatation__c  qua =[select id,Name, approvalStatus__c ,
                solutionURLCPQStandardPrice__c,
                commonProjectOwnEquipmentStandardPrice__c,specialProductStandardPrice__c,
                ownSoftStandardPrice__c,outsourcingStandardPrice__c,outsourcingServiceStandardPrice__c,outsourcingArchitectureCostStandardPrice__c,
                companyTrainServiceStandardPrice__c,standardTotalPrice__c,commonProjectOwnDeviceCost__c,specialProductCost__c,outsourcingCost__c,
                companyTrainAndServiceCost__c,projectRunCost__c,projectRistCost__c,standardPriceGrossProfit__c,standardPriceGrossProfitMargin__c,
                standardProjectGrossProfit__c,standardProjectGrossProfitMargin__c,
                //costPercent__c,
                distributionSwitch__c,CYCUPS__c,SVG_STATCOM_APF__c,paidTrainningProduct__c,paidServiceProduct__c,
                commonProjectOwnDevicePercent__c,specialProductCostPercent__c,
                outsourcingCostPercent__c,companyTrainAndServiceCostPercent__c,projectRunCostPercent__c,projectRistCostPercent__c,standardSimulationNetProfit__c,
                standardSimulationNetProfitPercent__c,distributionSwitchPrice__c,CYCUPSPrice__c,SVG_STATCOM_APFPrice__c,paidTrainningProductPrice__c,paidServiceProductPrice__c
             from quatation__c where Name=:quatation.Name limit 1][0];
            if(qua.approvalStatus__c=='草稿'||qua.approvalStatus__c=='审批拒绝'){
              qua.solutionURLCPQStandardPrice__c=quatation.solutionURLCPQ;
              qua.orderIdCPQ__c=quatation.orderIdCPQ;
              //标准价
              qua.commonProjectOwnEquipmentStandardPrice__c=quatation.commonProjectOwnEquipmentStandardPrice;
              qua.specialProductStandardPrice__c=quatation.specialProductStandardPrice;
              qua.ownSoftStandardPrice__c=quatation.ownSoftStandardPrice;
              qua.outsourcingStandardPrice__c=quatation.outsourcingStandardPrice;
              qua.outsourcingServiceStandardPrice__c=quatation.outsourcingServiceStandardPrice;
              qua.outsourcingArchitectureCostStandardPrice__c=quatation.outsourcingArchitectureCostStandardPrice;
              qua.companyTrainServiceStandardPrice__c=quatation.companyTrainServiceStandardPrice;
              qua.standardTotalPrice__c=quatation.standardTotalPrice;
              //特殊产品成本
              qua.distributionSwitchPrice__c=quatation.distributionSwitchPrice;
              qua.CYCUPSPrice__c=quatation.CYCUPSPrice;
              qua.SVG_STATCOM_APFPrice__c=quatation.SVG_STATCOM_APFPrice;
              qua.paidTrainningProductPrice__c=quatation.paidTrainningProductPrice;
              qua.paidServiceProductPrice__c=quatation.paidServiceProductPrice;
              qua.distributionSwitch__c=quatation.distributionSwitch;
              qua.CYCUPS__c=quatation.CYCUPS;
              qua.SVG_STATCOM_APF__c=quatation.SVG_STATCOM_APF;
              qua.paidTrainningProduct__c=quatation.paidTrainningProduct;
              qua.paidServiceProduct__c=quatation.paidServiceProduct;
              //成本(缺出厂成本、项目成本)
              qua.commonProjectOwnDeviceCost__c=quatation.commonProjectOwnDeviceCost;
              qua.specialProductCost__c=quatation.specialProductCost;
              qua.outsourcingCost__c=quatation.outsourcingCost;
              qua.companyTrainAndServiceCost__c=quatation.companyTrainAndServiceCost;
              qua.projectRunCost__c=quatation.projectRunCost;
              qua.projectRistCost__c=quatation.projectRistCost;
              
              
              //标准价出厂毛利
              qua.standardPriceGrossProfit__c=quatation.standardPriceGrossProfit;
              qua.standardPriceGrossProfitMargin__c=quatation.standardPriceGrossProfitMargin;
              //标准价项目毛利
              qua.standardProjectGrossProfit__c=quatation.standardProjectGrossProfit;
              qua.standardProjectGrossProfitMargin__c=quatation.standardProjectGrossProfitMargin;
              //qua.costPercent__c=quatation.costPercent;
              qua.commonProjectOwnDevicePercent__c=quatation.commonProjectOwnDevicePercent;
              qua.specialProductCostPercent__c=quatation.specialProductCostPercent;
              qua.outsourcingCostPercent__c=quatation.outsourcingCostPercent;
              qua.companyTrainAndServiceCostPercent__c=quatation.companyTrainAndServiceCostPercent;
              qua.projectRunCostPercent__c=quatation.projectRunCostPercent;
              qua.projectRistCostPercent__c=quatation.projectRistCostPercent;
              //标准价模拟净利
              qua.standardSimulationNetProfit__c=quatation.standardSimulationNetProfit;
              qua.standardSimulationNetProfitPercent__c=quatation.standardSimulationNetProfitPercent;
              update qua;
              logClass.returnLog('成功', '已处理', '【CPQ接口COS002】CPQ系统成功更新报价单标准报价:'+quatation.Name, '正常');
              resp.flag='S';
            }else{
                resp.flag='N';
                resp.message='报价单正在审批中或已审批通过，不能修改';
              
            }
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','【CPQ接口COS002】CPQ系统更新报价单标准报价失败,异常信息:' + e.getMessage(),'重要');
        }
        return resp;
    }
}