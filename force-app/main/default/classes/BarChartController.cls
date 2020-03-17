public class BarChartController {
    public List<PieWedgeData> pDate{set;get;}
    public BarChartController(ApexPages.StandardController controller ){
        quatation__c qua=(quatation__c)controller.getRecord();
        pDate=getPieData(qua.id);
    }
	public List<PieWedgeData> getPieData(String qId) {
        
        List<PieWedgeData> data = new List<PieWedgeData>();
        quatation__c qua = [select id,commonProjectOwnEquipmentBidPriceDctFml__c ,specialProductBiddingPriceDCT__c ,
                           ownSoftBiddingPriceDCT__c ,outsourcingBiddingPriceDct__c ,outsourcingServiceBiddingPriceDct__c ,
                           outsourcingArchitectureCostBidPriceDct__c ,companyTrainServiceBiddingPriceDct__c ,biddingTotalPriceDct__c,
                            commonProjectOwnEquipmentStandardPrice__c ,commonProjectOwnEquipmentBiddingPrice__c ,
                            specialProductStandardPrice__c ,specialProductBiddingPrice__c,
                            ownSoftStandardPrice__c,ownSoftBiddingPrice__c,
                            outsourcingStandardPrice__c,outsourcingBiddingPrice__c,
                            outsourcingServiceStandardPrice__c,outsourcingServiceBiddingPrice__c,
                            outsourcingArchitectureCostStandardPrice__c,outsourcingArchitectureCostBiddingPrice__c,
                            companyTrainServiceStandardPrice__c,companyTrainServiceBiddingPrice__c,
                            standardTotalPrice__c,biddingTotalPrice__c
                            from quatation__c where id =:qId limit 1][0];
		Decimal commonProjectOwnEquipmentBidPriceDctFml=0;
        if(qua.commonProjectOwnEquipmentBidPriceDctFml__c !=null){
 	  		commonProjectOwnEquipmentBidPriceDctFml=qua.commonProjectOwnEquipmentBidPriceDctFml__c ;
        }
        Decimal commonProjectOwnEquipmentStandardPrice=0;
        if(qua.commonProjectOwnEquipmentStandardPrice__c !=null){
            commonProjectOwnEquipmentStandardPrice=qua.commonProjectOwnEquipmentStandardPrice__c;
        }
        Decimal commonProjectOwnEquipmentBiddingPrice=0;
        if(qua.commonProjectOwnEquipmentBiddingPrice__c!=null){
            commonProjectOwnEquipmentBiddingPrice=qua.commonProjectOwnEquipmentBiddingPrice__c;
        }
          //2
        Decimal specialProductBiddingPriceDCT=0;
        if(qua.specialProductBiddingPriceDCT__c !=null){
       		specialProductBiddingPriceDCT=qua.specialProductBiddingPriceDCT__c ;
        }
        Decimal specialProductStandardPrice=0;
        if(qua.specialProductStandardPrice__c!=null){
            specialProductStandardPrice=qua.specialProductStandardPrice__c;
        }
        Decimal specialProductBiddingPrice=0;
        if(qua.specialProductBiddingPrice__c!=null){
            specialProductBiddingPrice=qua.specialProductBiddingPrice__c;
        }
          //3
        Decimal ownSoftBiddingPriceDCT=0;
        if(qua.ownSoftBiddingPriceDCT__c !=null){
         	ownSoftBiddingPriceDCT=qua.ownSoftBiddingPriceDCT__c ;
        }
        Decimal ownSoftStandardPrice=0;
        if(qua.ownSoftStandardPrice__c!=null){
            ownSoftStandardPrice=qua.ownSoftStandardPrice__c;
        }
        Decimal ownSoftBiddingPrice=0;
        if(qua.ownSoftBiddingPrice__c!=null){
            ownSoftBiddingPrice=qua.ownSoftBiddingPrice__c;
        }
          //4
        Decimal outsourcingBiddingPriceDct=0;
        if(qua.outsourcingBiddingPriceDct__c !=null){
       		outsourcingBiddingPriceDct=qua.outsourcingBiddingPriceDct__c ;
        }
        Decimal outsourcingStandardPrice=0;
        if(qua.outsourcingStandardPrice__c!=null){
            outsourcingStandardPrice=qua.outsourcingStandardPrice__c;
        }
        Decimal outsourcingBiddingPrice=0;
        if(qua.outsourcingBiddingPrice__c!=null){
            outsourcingBiddingPrice=qua.outsourcingBiddingPrice__c;
        }
          //5
        Decimal outsourcingServiceBiddingPriceDct=0;
        if(qua.outsourcingServiceBiddingPriceDct__c !=null){
          	outsourcingServiceBiddingPriceDct=qua.outsourcingServiceBiddingPriceDct__c ;
        }
        Decimal outsourcingServiceStandardPrice=0;
        if(qua.outsourcingServiceStandardPrice__c!=null){
           outsourcingServiceStandardPrice =qua.outsourcingServiceStandardPrice__c;
        }
        Decimal outsourcingServiceBiddingPrice=0;
        if(qua.outsourcingServiceBiddingPrice__c!=null){
            outsourcingServiceBiddingPrice=qua.outsourcingServiceBiddingPrice__c;
        }
          //6
        Decimal outsourcingArchitectureCostBidPriceDct=0;
        if(qua.outsourcingArchitectureCostBidPriceDct__c !=null){
         	outsourcingArchitectureCostBidPriceDct=qua.outsourcingArchitectureCostBidPriceDct__c ;
        }
        Decimal outsourcingArchitectureCostStandardPrice=0;
        if(qua.outsourcingArchitectureCostStandardPrice__c!=null){
           outsourcingArchitectureCostStandardPrice =qua.outsourcingArchitectureCostStandardPrice__c;
        }
        Decimal outsourcingArchitectureCostBiddingPrice=0;
        if(qua.outsourcingArchitectureCostBiddingPrice__c!=null){
            outsourcingArchitectureCostBiddingPrice=qua.outsourcingArchitectureCostBiddingPrice__c;
        }
          //7
        Decimal companyTrainServiceBiddingPriceDct=0;
        if(qua.companyTrainServiceBiddingPriceDct__c !=null){
         	companyTrainServiceBiddingPriceDct=qua.companyTrainServiceBiddingPriceDct__c ;
        }
        Decimal companyTrainServiceStandardPrice=0;
        if(qua.companyTrainServiceStandardPrice__c!=null){
            companyTrainServiceStandardPrice=qua.companyTrainServiceStandardPrice__c;
        }
        Decimal companyTrainServiceBiddingPrice=0;
        if(qua.companyTrainServiceBiddingPrice__c!=null){
            companyTrainServiceBiddingPrice=qua.companyTrainServiceBiddingPrice__c;
        }
          //8
        Decimal biddingTotalPriceDct=0;
        if(qua.biddingTotalPriceDct__c !=null){
         	biddingTotalPriceDct=qua.biddingTotalPriceDct__c ;
        }
		Decimal standardTotalPrice=0;
        if(qua.standardTotalPrice__c!=null){
            standardTotalPrice=qua.standardTotalPrice__c;
        }
        Decimal biddingTotalPrice=0;
        if(qua.biddingTotalPrice__c!=null){
            biddingTotalPrice=qua.biddingTotalPrice__c;
        }
        data.add(new PieWedgeData('投标报价总价折扣:'+biddingTotalPriceDct+'%','投标阶段标准报价总价:'+standardTotalPrice,'投标报价总价:'+biddingTotalPrice, biddingTotalPrice,standardTotalPrice));
        data.add(new PieWedgeData('公司对外培训及服务投标价折扣:'+companyTrainServiceBiddingPriceDct+'%','公司对外培训及服务标准价:'+companyTrainServiceStandardPrice,'公司对外培训及服务投标价:'+companyTrainServiceBiddingPrice, companyTrainServiceBiddingPrice,companyTrainServiceStandardPrice));
        data.add(new PieWedgeData('外购建筑施工费用投标价折扣:'+outsourcingArchitectureCostBidPriceDct+'%','外购建筑施工费用标准价:'+outsourcingArchitectureCostStandardPrice,'外购建筑施工费用投标价:'+outsourcingArchitectureCostBiddingPrice, outsourcingArchitectureCostBiddingPrice,outsourcingArchitectureCostStandardPrice));
        data.add(new PieWedgeData('外购服务费用投标价折扣:'+outsourcingServiceBiddingPriceDct+'%','外购服务费用标准价:'+outsourcingServiceStandardPrice,'外购服务费用投标价:'+outsourcingServiceBiddingPrice, outsourcingServiceBiddingPrice,outsourcingServiceStandardPrice));
        data.add(new PieWedgeData('外购材料投标价折扣:'+outsourcingBiddingPriceDct+'%','外购材料标准价:'+outsourcingStandardPrice,'外购材料投标价:'+outsourcingBiddingPrice, outsourcingBiddingPrice,outsourcingStandardPrice));
        data.add(new PieWedgeData('自有软件投标价折扣:'+ownSoftBiddingPriceDCT+'%','自有软件标准价:'+ownSoftStandardPrice,'特殊产品成本占比投标价:'+ownSoftBiddingPrice, ownSoftBiddingPrice,ownSoftStandardPrice));
        data.add(new PieWedgeData('特殊产品投标价折扣:'+specialProductBiddingPriceDCT+'%','特殊产品标准价:'+specialProductStandardPrice ,'特殊产品投标价:'+specialProductBiddingPrice, specialProductBiddingPrice,specialProductStandardPrice));
        data.add(new PieWedgeData('常规项目自有装置投标价折扣(不含特殊产品):'+commonProjectOwnEquipmentBidPriceDctFml+'%','常规项目自有装置标准价(不含特殊产品):'+commonProjectOwnEquipmentStandardPrice ,'常规项目自有装置投标价(不含特殊产品):'+commonProjectOwnEquipmentBiddingPrice, commonProjectOwnEquipmentBiddingPrice ,commonProjectOwnEquipmentStandardPrice));
        
        
        
        
        
        
        
        
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public String standname { get; set; }
        public String bidname { get; set; }
        public Decimal bidprice { get; set; }
		public Decimal standprice { get; set; }
        public PieWedgeData(String name,String standname,String bidname, Decimal bidprice, Decimal standprice) {
            this.name = name;
            this.standname=standname;
            this.bidname=bidname;
            this.bidprice = bidprice;
            this.standprice = standprice;
            
        }
    }
}