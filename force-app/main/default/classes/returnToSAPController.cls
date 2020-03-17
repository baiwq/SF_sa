public with sharing class returnToSAPController{
   public List<returnPool__c> RPList{get;set;}
   public List<ReturnSAP> RTSList{get;set;} 
   public Integer ListSize;
   public Integer pageSize = 20;  //每页显示的最大记录条数
   public Integer pageNumber = 0;   //页数
   public Integer threshold;
   public Integer offset;
   public Boolean PreviousStatus{get;set;}
   public Boolean NextStatus{get;set;}
   public set<Id> IDs;
   public String PickListVal{get;set;}
   
   public Integer LastYear;
   public Integer LastMonth;
   public Integer LastLastYear;
   public Integer LastLastMonth;

   
   public returnToSAPController(){
   
//得到上月的月份、年份   
      LastYear = System.today().addMonths(-1).year();
      LastMonth = System.today().addMonths(-1).month();
//得到上上月的月份、年份       
      LastLastYear = System.today().addMonths(-2).year();
      LastLastMonth = System.today().addMonths(-2).month();
      
      PickListVal = 'All';
      setPagination(PickListVal);
      getRecords(PickListVal);
   }
   
   public void setPagination(String orgCode){
      if(orgCode == 'All'){
         ListSize = [Select id, accountName__c, account__c, Name, finishedAmount__c, CreatedDate, LastModifiedDate, ConfirmTime__c from returnPool__c where finishedConfirm__c = true and finalSynchronizationStatus__c = false and finishPercent__c >=100 and forceStop__c = false and category__c =:'货款' and temporaryIsExcited__c = false order by ConfirmTime__c].size();
      }else{
         ListSize = [Select id, accountName__c, account__c, Name, finishedAmount__c, CreatedDate, LastModifiedDate, ConfirmTime__c from returnPool__c where finishedConfirm__c = true and finalSynchronizationStatus__c = false and finishPercent__c >=100 and forceStop__c = false and returnCompanyCode__c =:orgCode and category__c = :'货款' and temporaryIsExcited__c = false order by ConfirmTime__c].size();
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
      offset = pageNumber * pageSize; 
      if(orgCode == 'All'){
         RPList = [Select id, accountName__c, account__c, Name, finishedAmount__c, CreatedDate, LastModifiedDate, date__c, ConfirmTime__c, returnCompanyCode__c from returnPool__c where finishedConfirm__c = true and finalSynchronizationStatus__c = false and finishPercent__c >=100 and forceStop__c = false and category__c = :'货款' and temporaryIsExcited__c = false order by ConfirmTime__c desc limit :pageSize offset :offset];
      }else{
         RPList = [Select id, accountName__c, account__c, Name, finishedAmount__c, CreatedDate, LastModifiedDate, date__c, ConfirmTime__c, returnCompanyCode__c from returnPool__c where finishedConfirm__c = true and finalSynchronizationStatus__c = false and finishPercent__c >=100 and forceStop__c = false and returnCompanyCode__c =:orgCode and category__c = :'货款' and temporaryIsExcited__c = false order by ConfirmTime__c desc limit :pageSize offset :offset];
      }
      
      System.debug('RRPList:'+RPList.size());
      RTSList =new List<ReturnSAP>{};
      for(Integer a=0; a < RPList.size(); a++){
           ReturnSAP RTS= new ReturnSAP();
           RTS.flag = false;
           RTS.Amount = RPList[a].finishedAmount__c;
           RTS.ReturnId = RPList[a].id;
           RTS.ReturnName = RPList[a].Name;
           RTS.AccountName = RPList[a].accountName__c;   
           RTS.AccountId = RPList[a].account__c; 
           RTS.ArrivedDate = String.ValueOf(RPList[a].date__c);
           RTS.ConfirmDate = RPList[a].ConfirmTime__c.format('yyyy-MM-dd hh:mm:ss');
           RTS.OrgCode = RPList[a].returnCompanyCode__c;
           RTS.DateA = date.newInstance( RPList[a].date__c.year(), RPList[a].date__c.month(), 1).addMonths(1).addDays(-1);
           RTSList.add(RTS);  
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
      System.Debug('RTSList:' + RTSList);
      Map<String,String> m = new Map<String,String>();
      for(ReturnSAP temp:RTSList){
          if(temp.flag){
             m.put(temp.ReturnId, datetime.newinstance(temp.DateA.year(), temp.DateA.month(), temp.DateA.day()).format('yyyyMMdd'));
          }
      }
      returnPoolToSAP reSap = new returnPoolToSAP();
      reSap.returnPoolToSAP(m);
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
   
   class ReturnSAP{
      public boolean flag{get;set;}
      public decimal Amount{get;set;}
      public string ReturnName{get;set;}
      public string ReturnId{get;set;}
      public string AccountName{get;set;}
      public string AccountId{get;set;}
      public String ArrivedDate{get;set;}
      public String ConfirmDate{get;set;}
      public String OrgCode{get;set;}
      public Date DateA{get;set;}
   }
}