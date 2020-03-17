public class ContractReviewPieStandController {
    public List<PieWedgeData> pDate{set;get;}
        public ContractReviewPieStandController(ApexPages.StandardController controller){
            
            contractreview__c qua=(contractreview__c)controller.getRecord();
            pDate=getPieData(qua.id);
        }
        public List<PieWedgeData> getPieData(String qId) {
            
            List<PieWedgeData> data = new List<PieWedgeData>();
            contractreview__c qua = [select id,contractProjectGrossProfitMargin__c,commonProjectOwnDevicePercent__c,
                               specialProductCostPercent__c,outsourcingCostPercent__c,companyTrainAndServiceCostPercent__c,
                               contractProjectRunCostPercent__c,contractProjectRistCostPercent__c,contractProjectBigAmountCostPercent__c from contractreview__c where id =:qId limit 1][0];
            //1
            Decimal contractProjectGrossProfitMargin=0;
            if(qua.contractProjectGrossProfitMargin__c!=null&&qua.contractProjectGrossProfitMargin__c!=0){
                contractProjectGrossProfitMargin=qua.contractProjectGrossProfitMargin__c;
                if(contractProjectGrossProfitMargin>0){
                    data.add(new PieWedgeData('项目毛利率','项目毛利率:'+contractProjectGrossProfitMargin+'%', contractProjectGrossProfitMargin));
                }else{
                    data.add(new PieWedgeData('项目毛利率','项目毛利率:'+contractProjectGrossProfitMargin+'%', 0));
                }
                
            }
              //2
            Decimal commonProjectOwnDevicePercent=0;
            if(qua.commonProjectOwnDevicePercent__c!=null&&qua.commonProjectOwnDevicePercent__c!=0){
                commonProjectOwnDevicePercent=qua.commonProjectOwnDevicePercent__c;
                if(commonProjectOwnDevicePercent>0){
                    data.add(new PieWedgeData('常规项目自有装置成本占比','常规项目自有装置成本占比:'+commonProjectOwnDevicePercent+'%', commonProjectOwnDevicePercent));
                }else{
                    data.add(new PieWedgeData('常规项目自有装置成本占比','常规项目自有装置成本占比:'+commonProjectOwnDevicePercent+'%', 0));
                }
                
            }
              //3
            Decimal specialProductCostPercent=0;
            if(qua.specialProductCostPercent__c!=null&&qua.specialProductCostPercent__c!=0){
                specialProductCostPercent=qua.specialProductCostPercent__c;
                if(specialProductCostPercent>0){
                    data.add(new PieWedgeData('特殊产品成本占比','特殊产品成本占比:'+specialProductCostPercent+'%', specialProductCostPercent));
                }else{
                    data.add(new PieWedgeData('特殊产品成本占比','特殊产品成本占比:'+specialProductCostPercent+'%', 0));
                }
                
            }
              //4
            Decimal outsourcingCostPercent=0;
            if(qua.outsourcingCostPercent__c!=null&&qua.outsourcingCostPercent__c!=0){
                outsourcingCostPercent=qua.outsourcingCostPercent__c;
                if(outsourcingCostPercent>0){
                    data.add(new PieWedgeData('外购成本占比','外购成本占比:'+outsourcingCostPercent+'%', outsourcingCostPercent));
                }else{
                    data.add(new PieWedgeData('外购成本占比','外购成本占比:'+outsourcingCostPercent+'%', 0));
                }
                
            }
              //5
            Decimal companyTrainAndServiceCostPercent=0;
            if(qua.companyTrainAndServiceCostPercent__c!=null&&qua.companyTrainAndServiceCostPercent__c!=0){
                companyTrainAndServiceCostPercent=qua.companyTrainAndServiceCostPercent__c;
                if(companyTrainAndServiceCostPercent>0){
                    data.add(new PieWedgeData('公司对外培训及服务成本占比','公司对外培训及服务成本占比:'+companyTrainAndServiceCostPercent+'%', companyTrainAndServiceCostPercent));
                }else{
                    data.add(new PieWedgeData('公司对外培训及服务成本占比','公司对外培训及服务成本占比:'+companyTrainAndServiceCostPercent+'%', 0));
                }
                
            }
              //6
            Decimal contractProjectRunCostPercent=0;
            if(qua.contractProjectRunCostPercent__c!=null&&qua.contractProjectRunCostPercent__c!=0){
                contractProjectRunCostPercent=qua.contractProjectRunCostPercent__c;
                if(contractProjectRunCostPercent>0){
                    data.add(new PieWedgeData('合同供货范围项目执行成本占比(国际合同专用)','合同供货范围项目执行成本占比(国际合同专用):'+contractProjectRunCostPercent+'%', contractProjectRunCostPercent));
                }else{
                    data.add(new PieWedgeData('合同供货范围项目执行成本占比(国际合同专用)','合同供货范围项目执行成本占比(国际合同专用):'+contractProjectRunCostPercent+'%', 0));
                }
                
            }
              //7
            Decimal contractProjectRistCostPercent=0;
            if(qua.contractProjectRistCostPercent__c!=null&&qua.contractProjectRistCostPercent__c!=0){
                contractProjectRistCostPercent=qua.contractProjectRistCostPercent__c;
                if(contractProjectRistCostPercent>0){
                    data.add(new PieWedgeData('合同供货范围项目风险成本占比(国际合同专用)','合同供货范围项目风险成本占比(国际合同专用):'+contractProjectRistCostPercent+'%', contractProjectRistCostPercent));
                }else{
                    data.add(new PieWedgeData('合同供货范围项目风险成本占比(国际合同专用)','合同供货范围项目风险成本占比(国际合同专用):'+contractProjectRistCostPercent+'%', 0));
                }
                
            }
              //8
            Decimal contractProjectBigAmountCostPercent=0;
            if(qua.contractProjectBigAmountCostPercent__c!=null&&qua.contractProjectBigAmountCostPercent__c!=0){
                contractProjectBigAmountCostPercent=qua.contractProjectBigAmountCostPercent__c;
                if(contractProjectBigAmountCostPercent>0){
                    data.add(new PieWedgeData('合同供货范围项目大额费用成本占比','合同供货范围项目大额费用成本占比:'+contractProjectBigAmountCostPercent+'%', contractProjectBigAmountCostPercent));
                }else{
                    data.add(new PieWedgeData('合同供货范围项目大额费用成本占比','合同供货范围项目大额费用成本占比:'+contractProjectBigAmountCostPercent+'%', 0));
                }
                
            }        
        
            
            return data;
        }
    
        // Wrapper class
        public class PieWedgeData {
    
            public String name { get; set; }
            public String lablename { get; set; }
            public Decimal data { get; set; }
    
            public PieWedgeData(String name,String lablename, Decimal data) {
                this.name = name;
                this.lablename=lablename;
                this.data = data;
            }
        }
}