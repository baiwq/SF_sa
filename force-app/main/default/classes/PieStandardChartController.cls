public class PieStandardChartController {
    public List<PieWedgeData> pDate{set;get;}
    public PieStandardChartController(ApexPages.StandardController controller){
        
        quatation__c qua=(quatation__c)controller.getRecord();
        pDate=getPieData(qua.id);
    }
    public List<PieWedgeData> getPieData(String qId) {
        
        List<PieWedgeData> data = new List<PieWedgeData>();
        quatation__c qua = [select id,standardProjectGrossProfitMargin__c,commonProjectOwnDevicePercent__c,
                           specialProductCostPercent__c,outsourcingCostPercent__c,companyTrainAndServiceCostPercent__c,
                           projectRunCostPercent__c,projectRistCostPercent__c,projectBigAmountCostPercent__c from quatation__c where id =:qId limit 1][0];
		Decimal standardProjectGrossProfitMargin=0;
        if(qua.standardProjectGrossProfitMargin__c!=null&&qua.standardProjectGrossProfitMargin__c!=0){
 	  		standardProjectGrossProfitMargin=qua.standardProjectGrossProfitMargin__c;
            if(standardProjectGrossProfitMargin>0){
                data.add(new PieWedgeData('标准价项目毛利率','标准价项目毛利率:'+standardProjectGrossProfitMargin+'%', standardProjectGrossProfitMargin));
            }else{
                data.add(new PieWedgeData('标准价项目毛利率','标准价项目毛利率:'+standardProjectGrossProfitMargin+'%', 0));
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
        Decimal projectRunCostPercent=0;
        if(qua.projectRunCostPercent__c!=null&&qua.projectRunCostPercent__c!=0){
         	projectRunCostPercent=qua.projectRunCostPercent__c;
            if(projectRunCostPercent>0){
                data.add(new PieWedgeData('项目执行费用成本占比(国际合同专用)','项目执行费用成本占比(国际合同专用):'+projectRunCostPercent+'%', projectRunCostPercent));
            }else{
                data.add(new PieWedgeData('项目执行费用成本占比(国际合同专用)','项目执行费用成本占比(国际合同专用):'+projectRunCostPercent+'%', 0));
            }
            
        }
          //7
        Decimal projectRistCostPercent=0;
        if(qua.projectRistCostPercent__c!=null&&qua.projectRistCostPercent__c!=0){
         	projectRistCostPercent=qua.projectRistCostPercent__c;
            if(projectRistCostPercent>0){
                data.add(new PieWedgeData('项目风险成本占比(国际合同专用)','项目风险成本占比(国际合同专用):'+projectRistCostPercent+'%', projectRistCostPercent));
            }else{
                data.add(new PieWedgeData('项目风险成本占比(国际合同专用)','项目风险成本占比(国际合同专用):'+projectRistCostPercent+'%', 0));
            }
            
        }
          //8
        Decimal projectBigAmountCostPercent=0;
        if(qua.projectBigAmountCostPercent__c!=null&&qua.projectBigAmountCostPercent__c!=0){
         	projectBigAmountCostPercent=qua.projectBigAmountCostPercent__c;
            if(projectBigAmountCostPercent>0){
                data.add(new PieWedgeData('项目大额费用成本占比','项目大额费用成本占比:'+projectBigAmountCostPercent+'%', projectBigAmountCostPercent));
            }else{
                data.add(new PieWedgeData('项目大额费用成本占比','项目大额费用成本占比:'+projectBigAmountCostPercent+'%', 0));
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