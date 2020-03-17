trigger ContractChangeGetMLL on contractchange__c (before insert) {
    
        for(contractchange__c cc : Trigger.new){
            if(cc.contract__c !=null){

                Contract__c con =[select id,orderIdCPQ__c,contractProjectGrossProfitMargin__c,contractProjectGrossProfit__c,
                                    standardProjectGrossProfitMarginContract__c,standardProjectGrossProfitContract__c from Contract__c where id=:cc.contract__c];
                
                //合同阶段合同价项目毛利率
                cc.contractProjectGrossProfitMargin__c = con.contractProjectGrossProfitMargin__c;
                //合同阶段合同价项目毛利润
                cc.contractProjectGrossProfit__c = con.contractProjectGrossProfit__c;
                //合同阶段标准价项目毛利率
                cc.standardProjectGrossProfitMarginContrac__c = con.standardProjectGrossProfitMarginContract__c;
                //合同阶段标准价项目毛利润
                cc.standardProjectGrossProfitContract__c = con.standardProjectGrossProfitContract__c;
                //订单号
                cc.orderIdCPQ__c = con.orderIdCPQ__c;
            }
        }       
    
}