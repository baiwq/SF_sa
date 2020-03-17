public class PieBidChadrtController {
	public List<PieWedgeData> pDate{set;get;}
    public PieBidChadrtController(ApexPages.StandardController controller){
        
        quatation__c qua=(quatation__c)controller.getRecord();
        pDate=getPieData(qua.id);
    }
    public List<PieWedgeData> getPieData(String qId) {
        
        List<PieWedgeData> data = new List<PieWedgeData>();
        quatation__c qua = [select id,bidPriceProjectMarginRate__c,bidCommonProjectOwnDevicePercent__c,
                           bidspecialProductCostPercent__c,bidoutsourcingCostPercent__c,bidcompanyTrainAndServiceCost__c,
                           bidprojectRunCostPercent__c,bidprojectRistCostPercent__c,bidprojectBigAmountCostPercent__c from quatation__c where id =:qId limit 1][0];
		//1
        Decimal bidPriceProjectMarginRate=0;
        if(qua.bidPriceProjectMarginRate__c!=null&&qua.bidPriceProjectMarginRate__c>0){
 	  		bidPriceProjectMarginRate=qua.bidPriceProjectMarginRate__c;
            if(bidPriceProjectMarginRate>0){
                data.add(new PieWedgeData('项目毛利率','投标价项目毛利率:'+bidPriceProjectMarginRate+'%', bidPriceProjectMarginRate));
            }else{
                data.add(new PieWedgeData('项目毛利率','投标价项目毛利率:'+bidPriceProjectMarginRate+'%', 0));
            }
            
        }
          //2
        Decimal bidCommonProjectOwnDevicePercent=0;
        if(qua.bidCommonProjectOwnDevicePercent__c!=null&&qua.bidCommonProjectOwnDevicePercent__c!=0){
       		bidCommonProjectOwnDevicePercent=qua.bidCommonProjectOwnDevicePercent__c;
            if(bidCommonProjectOwnDevicePercent>0){
                data.add(new PieWedgeData('常规项目自有装置成本占比','常规项目自有装置成本占比:'+bidCommonProjectOwnDevicePercent+'%', bidCommonProjectOwnDevicePercent));
            }else{
                data.add(new PieWedgeData('常规项目自有装置成本占比','常规项目自有装置成本占比:'+bidCommonProjectOwnDevicePercent+'%', 0));
            }
            
        }
          //3
        Decimal bidspecialProductCostPercent=0;
        if(qua.bidspecialProductCostPercent__c!=null&&qua.bidspecialProductCostPercent__c!=0){
         	bidspecialProductCostPercent=qua.bidspecialProductCostPercent__c;
            if(bidspecialProductCostPercent>0){
                data.add(new PieWedgeData('特殊产品成本占比','特殊产品成本占比:'+bidspecialProductCostPercent+'%', bidspecialProductCostPercent));
            }else{
                data.add(new PieWedgeData('特殊产品成本占比','特殊产品成本占比:'+bidspecialProductCostPercent+'%', 0));
            }
            
        }
          //4
        Decimal bidoutsourcingCostPercent=0;
        if(qua.bidoutsourcingCostPercent__c!=null&&qua.bidoutsourcingCostPercent__c!=0){
       		bidoutsourcingCostPercent=qua.bidoutsourcingCostPercent__c;
            if(bidoutsourcingCostPercent>0){
                data.add(new PieWedgeData('外购成本占比','外购成本占比:'+bidoutsourcingCostPercent+'%', bidoutsourcingCostPercent));
            }else{
                data.add(new PieWedgeData('外购成本占比','外购成本占比:'+bidoutsourcingCostPercent+'%', 0));
            }
            
        }
          //5
        Decimal bidcompanyTrainAndServiceCost=0;
        if(qua.bidcompanyTrainAndServiceCost__c!=null&&qua.bidcompanyTrainAndServiceCost__c!=0){
          	bidcompanyTrainAndServiceCost=qua.bidcompanyTrainAndServiceCost__c;
            if(bidcompanyTrainAndServiceCost>0){
                data.add(new PieWedgeData('公司对外培训及服务成本占比','公司对外培训及服务成本占比:'+bidcompanyTrainAndServiceCost+'%', bidcompanyTrainAndServiceCost));
            }else{
                data.add(new PieWedgeData('公司对外培训及服务成本占比','公司对外培训及服务成本占比:'+bidcompanyTrainAndServiceCost+'%', 0));
            }
            
        }
          //6
        Decimal bidprojectRunCostPercent=0;
        if(qua.bidprojectRunCostPercent__c!=null&&qua.bidprojectRunCostPercent__c!=0){
         	bidprojectRunCostPercent=qua.bidprojectRunCostPercent__c;
            if(bidprojectRunCostPercent>0){
                data.add(new PieWedgeData('项目执行费用成本占比(国际合同专用)','项目执行费用成本占比(国际合同专用):'+bidprojectRunCostPercent+'%', bidprojectRunCostPercent));
            }else{
                data.add(new PieWedgeData('项目执行费用成本占比(国际合同专用)','项目执行费用成本占比(国际合同专用):'+bidprojectRunCostPercent+'%', 0));
            }
            
        }
          //7
        Decimal bidprojectRistCostPercent=0;
        if(qua.bidprojectRistCostPercent__c!=null&&qua.bidprojectRistCostPercent__c!=0){
         	bidprojectRistCostPercent=qua.bidprojectRistCostPercent__c;
            if(bidprojectRistCostPercent>0){
                data.add(new PieWedgeData('项目风险成本占比(国际合同专用)','项目风险成本占比(国际合同专用):'+bidprojectRistCostPercent+'%', bidprojectRistCostPercent));
            }else{
                data.add(new PieWedgeData('项目风险成本占比(国际合同专用)','项目风险成本占比(国际合同专用):'+bidprojectRistCostPercent+'%', 0));
            }
            
        }
          //8
        Decimal bidprojectBigAmountCostPercent=0;
        if(qua.bidprojectBigAmountCostPercent__c!=null&&qua.bidprojectBigAmountCostPercent__c!=0){
         	bidprojectBigAmountCostPercent=qua.bidprojectBigAmountCostPercent__c;
            if(bidprojectBigAmountCostPercent>0){
                data.add(new PieWedgeData('项目大额费用成本占比','项目大额费用成本占比:'+bidprojectBigAmountCostPercent+'%', bidprojectBigAmountCostPercent));
            }else{
                data.add(new PieWedgeData('项目大额费用成本占比','项目大额费用成本占比:'+bidprojectBigAmountCostPercent+'%', 0));
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