public class ContractReviewBarController {
	public List<PieWedgeData> pDate{set;get;}
    public ContractReviewBarController(ApexPages.StandardController controller ){
        contractreview__c qua=(contractreview__c)controller.getRecord();
        pDate=getPieData(qua.id);
    }
	public List<PieWedgeData> getPieData(String qId) {
        
        List<PieWedgeData> data = new List<PieWedgeData>();
        contractreview__c qua = [select id,cCommonProjectOwnEquipmentStandardPrice__c ,cCommonProjectOwnEquipmentBiddingPrice__c,
                                 cSpecialProductStandardPrice__c,cSpecialProductBiddingPrice__c,
                                 cOwnSoftStandardPrice__c,cOwnSoftBiddingPrice__c,
                                 cOutsourcingStandardPrice__c,cOutsourcingBiddingPrice__c,
                                 cOutsourcingServiceStandardPrice__c,cOutsourcingServiceBiddingPrice__c,
                                 cOSArchitectureCostStandardPrice__c,cOutsourcingArchitectureCostBiddingPrice__c,
                                 cCompanyTrainServiceStandardPrice__c,cCompanyTrainServiceBiddingPrice__c,
                                 contractStandardTotalPrice__c,contractPriceTotal__c,
                                 commonProjectOwnEquipmentcontracPriceDct__c ,specialProductContractPriceDct__c ,
                                 ownSoftContractPriceDct__c ,outsourcingContractPriceDct__c,
                                 outsourcingServiceContractPriceDct__c ,outsourcingArchitectureCostConPriceDct__c ,
                                 companyTrainServiceContractPriceDct__c ,contractPriceTotalDct__c 
   
                            from contractreview__c where id =:qId limit 1][0];
		Decimal commonProjectOwnEquipmentcontracPriceDct=0;
        if(qua.commonProjectOwnEquipmentcontracPriceDct__c !=null){
 	  		commonProjectOwnEquipmentcontracPriceDct=qua.commonProjectOwnEquipmentcontracPriceDct__c ;
        }
        Decimal cCommonProjectOwnEquipmentStandardPrice=0;
        if(qua.cCommonProjectOwnEquipmentStandardPrice__c !=null){
            cCommonProjectOwnEquipmentStandardPrice=qua.cCommonProjectOwnEquipmentStandardPrice__c;
        }
        Decimal cCommonProjectOwnEquipmentBiddingPrice=0;
        if(qua.cCommonProjectOwnEquipmentBiddingPrice__c!=null){
            cCommonProjectOwnEquipmentBiddingPrice=qua.cCommonProjectOwnEquipmentBiddingPrice__c;
        }
          //2
        Decimal specialProductContractPriceDct=0;
        if(qua.specialProductContractPriceDct__c  !=null){
       		specialProductContractPriceDct=qua.specialProductContractPriceDct__c  ;
        }
        Decimal cSpecialProductStandardPrice=0;
        if(qua.cSpecialProductStandardPrice__c!=null){
            cSpecialProductStandardPrice=qua.cSpecialProductStandardPrice__c;
        }
        Decimal cSpecialProductBiddingPrice=0;
        if(qua.cSpecialProductBiddingPrice__c!=null){
            cSpecialProductBiddingPrice=qua.cSpecialProductBiddingPrice__c;
        }
          //3
        Decimal ownSoftContractPriceDct=0;
        if(qua.ownSoftContractPriceDct__c  !=null){
         	ownSoftContractPriceDct=qua.ownSoftContractPriceDct__c  ;
        }
        Decimal cOwnSoftStandardPrice=0;
        if(qua.cOwnSoftStandardPrice__c!=null){
            cOwnSoftStandardPrice=qua.cOwnSoftStandardPrice__c;
        }
        Decimal cOwnSoftBiddingPrice=0;
        if(qua.cOwnSoftBiddingPrice__c!=null){
            cOwnSoftBiddingPrice=qua.cOwnSoftBiddingPrice__c;
        }
          //4
        Decimal outsourcingContractPriceDct=0;
        if(qua.outsourcingContractPriceDct__c  !=null){
       		outsourcingContractPriceDct=qua.outsourcingContractPriceDct__c  ;
        }
        Decimal cOutsourcingStandardPrice=0;
        if(qua.cOutsourcingStandardPrice__c!=null){
            cOutsourcingStandardPrice=qua.cOutsourcingStandardPrice__c;
        }
        Decimal cOutsourcingBiddingPrice=0;
        if(qua.cOutsourcingBiddingPrice__c!=null){
            cOutsourcingBiddingPrice=qua.cOutsourcingBiddingPrice__c;
        }
          //5
        Decimal outsourcingServiceContractPriceDct=0;
        if(qua.outsourcingServiceContractPriceDct__c  !=null){
          	outsourcingServiceContractPriceDct=qua.outsourcingServiceContractPriceDct__c  ;
        }
        Decimal cOutsourcingServiceStandardPrice=0;
        if(qua.cOutsourcingServiceStandardPrice__c!=null){
           cOutsourcingServiceStandardPrice =qua.cOutsourcingServiceStandardPrice__c;
        }
        Decimal cOutsourcingServiceBiddingPrice=0;
        if(qua.cOutsourcingServiceBiddingPrice__c!=null){
            cOutsourcingServiceBiddingPrice=qua.cOutsourcingServiceBiddingPrice__c;
        }
          //6
        Decimal outsourcingArchitectureCostConPriceDct=0;
        if(qua.outsourcingArchitectureCostConPriceDct__c  !=null){
         	outsourcingArchitectureCostConPriceDct=qua.outsourcingArchitectureCostConPriceDct__c  ;
        }
        Decimal cOSArchitectureCostStandardPrice=0;
        if(qua.cOSArchitectureCostStandardPrice__c!=null){
           cOSArchitectureCostStandardPrice =qua.cOSArchitectureCostStandardPrice__c;
        }
        Decimal cOutsourcingArchitectureCostBiddingPrice=0;
        if(qua.cOutsourcingArchitectureCostBiddingPrice__c!=null){
            cOutsourcingArchitectureCostBiddingPrice=qua.cOutsourcingArchitectureCostBiddingPrice__c;
        }
          //7
        Decimal companyTrainServiceContractPriceDct=0;
        if(qua.companyTrainServiceContractPriceDct__c  !=null){
         	companyTrainServiceContractPriceDct=qua.companyTrainServiceContractPriceDct__c  ;
        }
        Decimal cCompanyTrainServiceStandardPrice=0;
        if(qua.cCompanyTrainServiceStandardPrice__c!=null){
            cCompanyTrainServiceStandardPrice=qua.cCompanyTrainServiceStandardPrice__c;
        }
        Decimal cCompanyTrainServiceBiddingPrice=0;
        if(qua.cCompanyTrainServiceBiddingPrice__c!=null){
            cCompanyTrainServiceBiddingPrice=qua.cCompanyTrainServiceBiddingPrice__c;
        }
          //8
        Decimal contractPriceTotalDct=0;
        if(qua.contractPriceTotalDct__c !=null){
         	contractPriceTotalDct=qua.contractPriceTotalDct__c ;
        }
		Decimal contractStandardTotalPrice=0;
        if(qua.contractStandardTotalPrice__c!=null){
            contractStandardTotalPrice=qua.contractStandardTotalPrice__c;
        }
        Decimal contractPriceTotal=0;
        if(qua.contractPriceTotal__c!=null){
            contractPriceTotal=qua.contractPriceTotal__c;
        }
        data.add(new PieWedgeData('合同供货范围合同价总价折扣:'+contractPriceTotalDct+'%','合同阶段标准报价总价:'+contractStandardTotalPrice,'合同供货范围合同价总价:'+contractPriceTotal, contractPriceTotal,contractStandardTotalPrice));
        data.add(new PieWedgeData('公司对外培训及服务合同价折扣:'+companyTrainServiceContractPriceDct+'%','合同供货范围公司对外培训及服务标准价:'+cCompanyTrainServiceStandardPrice,'合同供货范围公司对外培训及服务合同价:'+cCompanyTrainServiceBiddingPrice, cCompanyTrainServiceBiddingPrice,cCompanyTrainServiceStandardPrice));
        data.add(new PieWedgeData('外购建筑施工费用合同价折扣:'+outsourcingArchitectureCostConPriceDct+'%','合同供货范围外购建筑施工费用标准价:'+cOSArchitectureCostStandardPrice,'合同供货范围外购建筑施工费用合同价:'+cOutsourcingArchitectureCostBiddingPrice, cOutsourcingArchitectureCostBiddingPrice,cOSArchitectureCostStandardPrice));
        data.add(new PieWedgeData('外购服务费用合同价折扣:'+outsourcingServiceContractPriceDct+'%','合同供货范围外购服务费用标准价:'+cOutsourcingServiceStandardPrice,'合同供货范围外购服务费用合同价:'+cOutsourcingServiceBiddingPrice, cOutsourcingServiceBiddingPrice,cOutsourcingServiceStandardPrice));
        data.add(new PieWedgeData('外购材料合同价折扣:'+outsourcingContractPriceDct+'%','合同供货范围外购材料标准价:'+cOutsourcingStandardPrice,'合同供货范围外购材料合同价:'+cOutsourcingBiddingPrice, cOutsourcingBiddingPrice,cOutsourcingStandardPrice));
        data.add(new PieWedgeData('自有软件合同价折扣:'+ownSoftContractPriceDct+'%','合同供货范围自有软件标准价:'+cOwnSoftStandardPrice,'合同供货范围自有软件合同价:'+cOwnSoftBiddingPrice, cOwnSoftBiddingPrice,cOwnSoftStandardPrice));
        data.add(new PieWedgeData('特殊产品合同价折扣:'+specialProductContractPriceDct+'%','合同供货范围特殊产品标准价:'+cSpecialProductStandardPrice ,'合同供货范围特殊产品合同价:'+cSpecialProductBiddingPrice, cSpecialProductBiddingPrice,cSpecialProductStandardPrice));
        data.add(new PieWedgeData('常规项目自有装置合同价折扣(不含特殊产品):'+commonProjectOwnEquipmentcontracPriceDct+'%','合同供货范围常规项目自有装置标准价(不含特殊产品):'+cCommonProjectOwnEquipmentStandardPrice ,'合同供货范围常规项目自有装置合同价(不含特殊产品):'+cCommonProjectOwnEquipmentBiddingPrice, cCommonProjectOwnEquipmentBiddingPrice ,cCommonProjectOwnEquipmentStandardPrice));
        
        
        
        
        
        
        
        
        return data;
    }

    // Wrapper class
    public class PieWedgeData {

        public String name { get; set; }
        public String standname { get; set; }
        public String contractname { get; set; }
        public Decimal contractprice { get; set; }
		public Decimal standprice { get; set; }
        public PieWedgeData(String name,String standname,String contractname, Decimal contractprice, Decimal standprice) {
            this.name = name;
            this.standname=standname;
            this.contractname=contractname;
            this.contractprice = contractprice;
            this.standprice = standprice;
            
        }
    }
}