global with sharing class InvoiceToSAPController{
   public List<invoice__c> IList{get;set;}
   public List<InvoiceSAP> ISList{get;set;} 
   public Integer ListSize;
   public Integer pageSize = 20;  //每页显示的最大记录条数
   public Integer pageNumber = 0;   //页数
   public Integer threshold;
   public Integer offset;
   public Boolean PreviousStatus{get;set;}
   public Boolean NextStatus{get;set;}
   public set<Id> IDs;
   public Boolean SyncFlag{get;set;}
   public String PickListVal{get;set;}

        
   
   public InvoiceToSAPController(){
      PickListVal = 'All';
      setPagination(PickListVal);
      getRecords(PickListVal);
   }
   
   public void setPagination(String orgCode){
      if(orgCode == 'All'){
         ListSize = [select id, name, applyBy__c, invoiceCompanyCode__c , applyByName__c, invoiceAmountSum__c, accountName__c, account__c, applyDepartment__c, taxRate__c, pushSAPStatus__c from invoice__c where pullSKJStatus__c =:'同步成功' and pushSAPStatus__c !=:'同步成功' and forceStop__c = false order by pullSKJTime__c].size();
      }else{
         ListSize = [select id, name, applyBy__c, invoiceCompanyCode__c , applyByName__c, invoiceAmountSum__c, accountName__c, account__c, applyDepartment__c, taxRate__c, pushSAPStatus__c from invoice__c where pullSKJStatus__c =:'同步成功' and pushSAPStatus__c !=:'同步成功' and forceStop__c = false and invoiceCompanyCode__c=:orgCode order by pullSKJTime__c].size();
      }
      
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
      SyncFlag = true;
      offset = pageNumber * pageSize; 
      if(orgCode == 'All'){
         IList = [select id, name, applyBy__c, applyByName__c,invoiceCompanyCode__c, invoiceAmountSum__c, accountName__c, account__c, applyDepartment__c, taxRate__c, pushSAPStatus__c from invoice__c where pullSKJStatus__c =:'同步成功' and pushSAPStatus__c !=:'同步成功' and forceStop__c = false order by pullSKJTime__c desc limit :pageSize offset :offset];
      }else{
         IList = [select id, name, applyBy__c, applyByName__c,invoiceCompanyCode__c, invoiceAmountSum__c, accountName__c, account__c, applyDepartment__c, taxRate__c, pushSAPStatus__c from invoice__c where pullSKJStatus__c =:'同步成功' and pushSAPStatus__c !=:'同步成功' and forceStop__c = false and invoiceCompanyCode__c=:orgCode order by pullSKJTime__c desc limit :pageSize offset :offset];
      }
      
      ISList =new List<InvoiceSAP>{};
      for(Integer a=0; a < IList.size(); a++){
           InvoiceSAP IS= new InvoiceSAP();
           IS.flag = false; 
           IS.RecordId = IList[a].id;
           IS.RecordName = IList[a].Name;
           IS.ApplyBy = IList[a].applyBy__c;
           IS.ApplyByName = IList[a].applyByName__c;
           IS.ApplyByDept = IList[a].applyDepartment__c;
           IS.InvoiceAmountSum = IList[a].invoiceAmountSum__c;
           IS.AccountId = IList[a].account__c; 
           IS.AccountName = IList[a].accountName__c;   
           IS.TaxRate = IList[a].taxRate__c;
           IS.PushSAPStatus = IList[a].pushSAPStatus__c;
           IS.invoiceCompanyCode = IList[a].invoiceCompanyCode__c;
           ISList.add(IS);  
      }
      
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
      System.Debug('ISList:' + ISList);
      IDs = new Set<Id>();
      for(InvoiceSAP temp:ISList){
          if(temp.flag){
            IDs.add(temp.RecordId);
          }
      }
      //SospSendInvoiceToSap SIT = new SospSendInvoiceToSap();
      SospSendInvoiceToSap.SospSendInvoiceToSap(IDs);
      System.Debug('IDs:' + IDs);
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
   
   class InvoiceSAP{
      public Boolean flag{get;set;}
      public string RecordId{get;set;}
      public string RecordName{get;set;}
      public string ApplyBy{get;set;}
      public string ApplyByName{get;set;}
      public string ApplyByDept{get;set;}
      public Decimal InvoiceAmountSum{get;set;}
      public string AccountId{get;set;}
      public string AccountName{get;set;}
      public string TaxRate{get;set;}
      public string PushSAPStatus{get;set;}
      public string invoiceCompanyCode{get;set;}
   }
}