public with sharing class SFOrderController{
   public List<invoice__c> INList{get;set;}
   public List<receipt__c> REList{get;set;}
   public List<SFOrder> RTSList{get;set;} 
   public Integer ListSize;
   public Integer pageSize = 20;  //每页显示的最大记录条数
   public Integer pageNumber = 0;   //页数
   public Integer threshold;
   public Integer offset;
   public Boolean PreviousStatus{get;set;}
   public Boolean NextStatus{get;set;}
   public set<Id> IDs;
   public String PickListVal{get;set;}
   public String SendOrder{get;set;}
   public String ConfirmOrder{get;set;}
   public String CancelOrder{get;set;}
   //public String InterfaceName{get;set;}
   //public Boolean Rendered{get;set;}
   public SFOrderController(){
      PickListVal = 'All';
      setPagination(PickListVal);
      getRecords(PickListVal);
      system.debug('ListSize-->'+ ListSize);
   }
   
   public void setPagination(String orgCode){
       
      if(orgCode == 'All'){
          system.debug('setPaginationorgCode--All>'+ orgCode);
         ListSize = [Select id from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true and kuaidi__c='顺丰' and sendOrderStatusSF__c!='成功' and (invoiceCompanyCode__c ='CC01' or invoiceCompanyCode__c ='CC03') and CreatedDate >=2017-07-21T00:00:01.000Z ].size()+
             [Select id from receipt__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNotSF__c =true and kuaidi__c='顺丰' and sendOrderStatusSF__c!='成功' and CreatedDate>=2017-07-21T00:00:01.000Z].size();
      }else if(orgCode == 'invoiceCC01'){
          system.debug('setPaginationorgCode--invoice>'+ orgCode);
         ListSize = [Select id from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true and kuaidi__c='顺丰' and sendOrderStatusSF__c!='成功' and invoiceCompanyCode__c ='CC01' and CreatedDate >=2017-07-21T00:00:01.000Z].size();
      }else if(orgCode == 'invoiceCC03'){
          system.debug('setPaginationorgCode--invoice>'+ orgCode);
         ListSize = [Select id from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true and kuaidi__c='顺丰' and sendOrderStatusSF__c!='成功' and invoiceCompanyCode__c ='CC03' and CreatedDate >=2017-07-21T00:00:01.000Z].size();
      }else if(orgCode == 'receive'){
          system.debug('setPaginationorgCode--receive>'+ orgCode);
         ListSize=[Select id from receipt__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNotSF__c =true and kuaidi__c='顺丰' and sendOrderStatusSF__c!='成功' and CreatedDate>=2017-07-21T00:00:01.000Z].size();
      }  
      
//获取分页状态
      threshold = Integer.valueOf(Math.FLOOR(ListSize/pageSize));
      Integer surplus = Math.mod(ListSize, pageSize);
      if(surplus == 0){
        threshold --;
      }
      System.Debug('threshold:' + threshold);
      PreviousStatus = true;
      NextStatus = true;
      if(threshold > 0){
         NextStatus = false;
      }     
   }
   
   public void getRecords(String orgCode){
      system.debug('getRecordsorgCode-->'+ orgCode);
      offset = pageNumber * pageSize; 
      if(orgCode == 'All'){
          system.debug('getRecordsorgCode--All>'+ orgCode);
          INList = [Select id,Name,accountName__c, expressNumber__c,orderIDSF__c, applyByName__c, applyPhone__c, receiver__c, receiverPhone__c, receiverCompany__c, invoiceCompanyCode__c,
                 shippingAddress__c from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true
                 and sendOrderStatusSF__c!='成功' and kuaidi__c='顺丰' and (invoiceCompanyCode__c ='CC01' or invoiceCompanyCode__c ='CC03') and CreatedDate >=2017-07-21T00:00:01.000Z order by Name desc limit :pageSize offset :offset];
          REList =[Select id,Name,accountName__c,orderNumberSF__c,orderIDSF__c, applyByName__c, applyPhone__c, receiverSF__c, receiverPhoneSF__c, receiverCompany__c,
                 shippingAddressSF__c from receipt__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNotSF__c =true and sendOrderStatusSF__c!='成功' and kuaidi__c='顺丰'
                 and CreatedDate>=2017-07-21T00:00:01.000Z order by Name desc limit :pageSize offset :offset];
          RTSList =new List<SFOrder>{};
      	  if(INList.size()>0){
          	for(Integer a=0; a < INList.size(); a++){
              SFOrder INS= new SFOrder();
              INS.flag = false;
              //Ins.InterfaceStatus=InterfaceName;
              INS.RecordId = INList[a].id;
              INS.OrderID=INList[a].orderIDSF__c;
              INS.OrderNumberSF=INList[a].expressNumber__c;
              INS.ObjectName = INList[a].Name;
              INS.ObjectAPIName='invoice__c';
              INS.AccountName = INList[a].accountName__c; 
              INS.ApplyName = INList[a].applyByName__c;   
              INS.ApplyPhone = INList[a].applyPhone__c; 
              if(INList[a].invoiceCompanyCode__c == 'CC03'){
                    
                   INS.ApplyAddress = '北京四方继保工程技术有限公司';
              	   INS.ApplyCompany = '河北省保定市北三环5999号';
                    
              }else{
                  INS.ApplyAddress = '北京市海淀区上地四街9号';
              	  INS.ApplyCompany = '北京四方继保公司';
              }
                    
                    
              
              INS.ReceptName = INList[a].receiver__c;
              INS.ReceptPhone = INList[a].receiverPhone__c;
              INS.ReceptAddress = INList[a].shippingAddress__c;
              
              INS.ReceptCompany = INList[a].receiverCompany__c;
              INS.InvoiceCompanyCode = INList[a].invoiceCompanyCode__c;
 
                
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
           
              RTSList.add(INS);  
          	}
      	}
      	if(REList.size()>0){
          for(Integer b=0;b<REList.size();b++){
              SFOrder RES= new SFOrder();
              RES.flag = false;
              //RES.InterfaceStatus=InterfaceName;
              RES.OrderID=REList[b].orderIDSF__c;
              RES.OrderNumberSF=REList[b].orderNumberSF__c;
              RES.RecordId = REList[b].id;
              RES.ObjectName = REList[b].Name;
              RES.ObjectAPIName='receipt__c';
              RES.AccountName=REList[b].accountName__c;
              RES.ApplyName = REList[b].applyByName__c;   
              RES.ApplyPhone = REList[b].applyPhone__c; 
              RES.ApplyAddress = '北京市海淀区上地四街9号';
              RES.ApplyCompany = '北京四方继保公司';
              RES.ReceptName = REList[b].receiverSF__c;
              RES.ReceptPhone = REList[b].receiverPhoneSF__c;
              RES.ReceptAddress = REList[b].shippingAddressSF__c;
              RES.ReceptCompany = REList[b].receiverCompany__c ;
              //RES.OrgCode = REList[b].shippingAddress__c;
              //RES.OrgCode = REList[b].shippingAddress__c;
              //RES.OrgCode = REList[b].shippingAddress__c;
           
              RTSList.add(RES); 
          	}
      	}
      }else if(orgCode=='invoiceCC01'){
          system.debug('getRecordsorgCode--invoice>'+ orgCode);
          INList = [Select id,invoiceCompanyCode__c,Name,expressNumber__c,accountName__c ,orderIDSF__c, applyByName__c, applyPhone__c, receiver__c, receiverPhone__c, receiverCompany__c, 
                 shippingAddress__c from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true and sendOrderStatusSF__c!='成功' and kuaidi__c='顺丰' 
                 and invoiceCompanyCode__c ='CC01' and CreatedDate >=2017-07-21T00:00:01.000Z order by Name desc limit :pageSize offset :offset];
          RTSList =new List<SFOrder>{};
      	  if(INList.size()>0){
          	for(Integer a=0; a < INList.size(); a++){
              SFOrder INS= new SFOrder();
              INS.flag = false;
              //Ins.InterfaceStatus=InterfaceName;
              INS.RecordId = INList[a].id;
              INS.OrderID=INList[a].orderIDSF__c;
              INS.OrderNumberSF=INList[a].expressNumber__c;
              INS.ObjectName = INList[a].Name;
              INS.ObjectAPIName='invoice__c';
              INS.AccountName = INList[a].accountName__c; 
              INS.ApplyName = INList[a].applyByName__c;   
              INS.ApplyPhone = INList[a].applyPhone__c; 
              INS.ApplyAddress = '北京市海淀区上地四街9号';
              INS.ApplyCompany = '北京四方继保公司';
              INS.ReceptName = INList[a].receiver__c;
              INS.ReceptPhone = INList[a].receiverPhone__c;
              INS.ReceptAddress = INList[a].shippingAddress__c;
              
              INS.ReceptCompany = INList[a].receiverCompany__c;
                
              //新增开票标识，CC01为北京开票，CC03为保定开票
              INS.InvoiceCompanyCode = INList[a].invoiceCompanyCode__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
           
              RTSList.add(INS);  
          	}
      	}
      
      }else if(orgCode=='invoiceCC03'){
          system.debug('getRecordsorgCode--invoice>'+ orgCode);
          INList = [Select id,Name,invoiceCompanyCode__c,accountName__c ,expressNumber__c,orderIDSF__c, applyByName__c, applyPhone__c, receiver__c, receiverPhone__c, receiverCompany__c, 
                 shippingAddress__c from invoice__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNot__c=true and sendOrderStatusSF__c!='成功' and kuaidi__c='顺丰' 
                 and invoiceCompanyCode__c ='CC03' and CreatedDate >=2017-07-21T00:00:01.000Z order by Name desc limit :pageSize offset :offset];
          RTSList =new List<SFOrder>{};
      	  if(INList.size()>0){
          	for(Integer a=0; a < INList.size(); a++){
              SFOrder INS= new SFOrder();
              INS.flag = false;
              //Ins.InterfaceStatus=InterfaceName;
              INS.RecordId = INList[a].id;
              INS.OrderID=INList[a].orderIDSF__c;
              INS.OrderNumberSF=INList[a].expressNumber__c;
              INS.ObjectName = INList[a].Name;
              INS.ObjectAPIName='invoice__c';
              INS.AccountName = INList[a].accountName__c; 
              INS.ApplyName = INList[a].applyByName__c;   
              INS.ApplyPhone = INList[a].applyPhone__c; 
              INS.ApplyAddress = '北京四方继保工程技术有限公司';
              INS.ApplyCompany = '河北省保定市北三环5999号';
              INS.ReceptName = INList[a].receiver__c;
              INS.ReceptPhone = INList[a].receiverPhone__c;
              INS.ReceptAddress = INList[a].shippingAddress__c;
              INS.InvoiceCompanyCode = INList[a].invoiceCompanyCode__c;

              INS.ReceptCompany = INList[a].receiverCompany__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
              //INS.OrgCode = INList[a].shippingAddress__c;
           
              RTSList.add(INS);  
          	}
      	}
      
      }else if(orgCode=='receive'){
          system.debug('getRecordsorgCode--receive>'+ orgCode);
          REList = [Select id,Name,accountName__c,orderNumberSF__c,orderIDSF__c, applyByName__c, applyPhone__c, receiverSF__c, receiverPhoneSF__c, receiverCompany__c,
                 shippingAddressSF__c from receipt__c where approvalStatus__c ='审批通过' and endSF__c=false and postOrNotSF__c =true and sendOrderStatusSF__c!='成功' and kuaidi__c='顺丰' 
                 and CreatedDate>=2017-07-21T00:00:01.000Z     order by Name desc limit :pageSize offset :offset];
          RTSList =new List<SFOrder>{};
      	  if(REList.size()>0){
          	for(Integer b=0;b<REList.size();b++){
              SFOrder RES= new SFOrder();
              RES.flag = false;
              //RES.InterfaceStatus=InterfaceName;
              RES.OrderID=REList[b].orderIDSF__c;
              RES.OrderNumberSF=REList[b].orderNumberSF__c;
              RES.RecordId = REList[b].id;
              RES.ObjectName = REList[b].Name;
              RES.ObjectAPIName='receipt__c';
              RES.AccountName=REList[b].accountName__c;
              RES.ApplyName = REList[b].applyByName__c;   
              RES.ApplyPhone = REList[b].applyPhone__c; 
              RES.ApplyAddress = '北京市海淀区上地四街9号';
              RES.ApplyCompany = '北京四方继保公司';
              RES.ReceptName = REList[b].receiverSF__c;
              RES.ReceptPhone = REList[b].receiverPhoneSF__c;
              RES.ReceptAddress = REList[b].shippingAddressSF__c;
              RES.ReceptCompany = REList[b].receiverCompany__c ;
              //RES.OrgCode = REList[b].shippingAddress__c;
              //RES.OrgCode = REList[b].shippingAddress__c;
              //RES.OrgCode = REList[b].shippingAddress__c;
           
              RTSList.add(RES); 
          	}
      	}
      }
      
      System.debug('RRPList:'+INList.size());
      
      System.debug('RTSList:'+RTSList.size());
      if(pageNumber > 0){
         PreviousStatus = false;
      }else{
         PreviousStatus = true;
      }
      if(pageNumber < threshold){
         NextStatus = false;
      }else{
         NextStatus = true;
      }
   }
   
   
   public PageReference SaveS(){
       
      System.Debug('RTSListtest:' + RTSList);
      for(SFOrder temp:RTSList){
          
          if(temp.flag){
              if(temp.InvoiceCompanyCode == 'CC03'){
                 SOSPControllerGoSFClass.createOrderToSF_BD(temp.RecordId, temp.ObjectAPIName, temp.ApplyName, temp.ApplyPhone, temp.ApplyAddress, temp.ApplyCompany, temp.ReceptName, temp.ReceptPhone, temp.ReceptAddress, temp.ReceptCompany);
              }else{
                 SOSPControllerGoSFClass.createOrderToSF(temp.RecordId, temp.ObjectAPIName, temp.ApplyName, temp.ApplyPhone, temp.ApplyAddress, temp.ApplyCompany, temp.ReceptName, temp.ReceptPhone, temp.ReceptAddress, temp.ReceptCompany);
              }
              
             //m.put(temp.ReturnId, datetime.newinstance(temp.DateA.year(), temp.DateA.month(), temp.DateA.day()).format('yyyyMMdd'));
          }
      }
      //returnPoolToSAP reSap = new returnPoolToSAP();
      //reSap.returnPoolToSAP(m);
      getRecords(PickListVal);
      return null;
   }
   public PageReference Refresh(){
      this.setPagination(PickListVal);
      this.getRecords(PickListVal);
      return null;
   }
   
   public PageReference Previous() {
        pageNumber = pageNumber - 1; 
        this.getRecords(PickListVal); 
        return null;
    }
    
    public PageReference Next() {
        pageNumber = pageNumber + 1;
        this.getRecords(PickListVal); 
        return null;
    }
   
   class SFOrder{
      public boolean flag{get;set;}
      //public String InterfaceStatus{get;set;}
      public String RecordId{get;set;}
      public string ObjectName{get;set;}
      public string ObjectAPIName{get;set;}
      public string OrderID{get;set;}
      public string OrderNumberSF{get;set;}
      public string AccountName{get;set;}
      public string ApplyName{get;set;}
      public string ApplyPhone{get;set;}
      public string ApplyAddress{get;set;}
      public String ApplyCompany{get;set;}
      public String ReceptName{get;set;}
      public String ReceptPhone{get;set;}
      public String ReceptAddress{get;set;}
      public String ReceptCompany{get;set;}
      public String InvoiceCompanyCode{get;set;}

   }
}