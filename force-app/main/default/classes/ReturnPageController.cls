public with sharing class ReturnPageController{
   public List<returnPool__c> LPList{get;set;}  //回款管理
   public List<Contract__c> CCList{get;set;}  //合同
   public List<returnItem__c> RIList{get;set;} //回款拆分项
   public List<tbbaozhengjin__c> BCList{get;set;}  //投标保证金
   public List<guaranteeLetter__c> LYList{get;set;}  //履约保证金
   public Decimal LPRecordPercent{get;set;} 
   public ID AccountId;
   public Decimal WaitingAssign{get;set;}  
   
   public Integer pageSize{get;set;}      //每页显示的最大记录条数
   public Integer pageNumber{get;set;}    //页数
   public String  OffsetStatusPrevious{get;set;} //String前一页按钮
   public String  OffsetStatusNext{get;set;}     //String后一页按钮
   public Boolean OffsetStatusPreviousCom{get;set;} //Bool前一页按钮
   public Boolean OffsetStatusNextCom{get;set;} //Bool后一页按钮
   
  
   public boolean ContractPanel{get;set;}  //合同panel
   public boolean bidCostPanel{get;set;}   //投标panel
   public boolean LYCostPanel{get;set;} 
   public String activePanel1{get;set;}    //Panel Active Class标记
   public String activePanel2{get;set;}    //
   public String activePanel3{get;set;}
   public Boolean flagButton1{get;set;}   //合同界面提交按钮
   public Boolean flagButton2{get;set;}   //投标费用提交按钮
   public Boolean flagButton3{get;set;}
   public Decimal EachValue{get;set;}
   public String EachValue2{get;set;}
   public String  CValues1{get;set;}
   public String  CValues2{get;set;}
   public String  CValues3{get;set;}
   
   public ID RecordId;                    //当前记录的Id
   
   public ReturnPageController(){
     pageSize = 10; 
     pageNumber = 0;    
     ContractPanel = true;
     bidCostPanel = false;
     LYCostPanel = false;
     activePanel1 = 'active';
     activePanel2 = '';
     activePanel3 = '';
     
     RecordId = ApexPages.currentPage().getParameters().get('id');   //得到当前记录ID
     getCurrentRecord(RecordId);
     getContractRecord();
     getFinishRecord(RecordId);
     //getOpportunityRecord();
  }
  
   public void getCurrentRecord(String poolId){//获得当前回款记录页面信息
     LPList = [Select id, Name, amount__c, date__c, account__c, accountName__c, finishPercent__c, finishedAmount__c, needAssignAmount__c, createdDate__c, CreatedById from returnPool__c where id = :poolId];
     if(LPList.size() == 1){
       AccountId = LPList[0].account__c;
       if(AccountId == null){
          Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.FATAL, '请先关联上客户!'));
       }else{
          LPRecordPercent = LPList[0].finishPercent__c;
          WaitingAssign = LPList[0].needAssignAmount__c;
       }
     }else{
       Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, '页面出现错误数据,请检查您的操作! + 加载'));
     }
   }
   
   public void getContractRecord(){ //得到合同详细信息
       Integer offset = pageNumber * pageSize;  //offset为页数乘以最大值 ？
       //查询该客户下的所有 存在未回款金额 的合同，按合同创建时间倒序排序
       CCList = [Select id, Name, oldContractNumber__c, accountName__c, noReturnContractAmount__c, amount__c, account__c, deliveryPerson__c from Contract__c where account__c =:AccountId and noReturnContractAmount__c > 0 order by CreatedDate limit :pageSize offset :offset];  //需要加判断语句
       if(CCList.size() == 0){//没有记录则无法提交 此时提交按钮不能click
          flagButton1 = false;
       }else{
          flagButton1 = true;
       }

       if(pageNumber < 1 ){ //查询记录在一个页面中可以显示完全，则previous按钮 无法click 
          OffsetStatusPrevious = 'disabled';
          OffsetStatusPreviousCom = false;
       }else{
          OffsetStatusPrevious = '';
          OffsetStatusPreviousCom = true;
       }
       
       if(CCList.size() < pageSize ){//如果当前页记录数量小于最大数量 则Next按钮 无法click 
          OffsetStatusNext = 'disabled';
          OffsetStatusNextCom = false;
       }else{//否则可以点击下一页
          OffsetStatusNext = '';
          OffsetStatusNextCom = true;
       }
       
   }  
   
   public void getTBRecord(){ 
       Integer offset = pageNumber * pageSize; 
       BCList = [Select id, Name, amount__c, accountID__c, surplus__c, accountName__c, opportunity__r.Name,opportunity__c from tbbaozhengjin__c where accountID__c =:AccountId and returnOrNot__c = false and type__c =:'投标保证金' and approvalStatus__c =:'审批通过' order by CreatedDate limit :pageSize offset :offset];
       if(BCList.size() == 0){
          flagButton2 = false;
       }else{
          flagButton2 = true;
       }
       if(pageNumber < 1 ){ //查询记录在一个页面中可以显示完全，则previous按钮 无法click 
          OffsetStatusPrevious = 'disabled'; 
          OffsetStatusPreviousCom = false;
       }else{//否则previous按钮可以click
          OffsetStatusPrevious = '';
          OffsetStatusPreviousCom = true;
       }
       
       System.Debug('BCList.size():' + BCList.size());
       System.Debug('pageSize:' + pageSize);
       
       if(BCList.size() < pageSize ){//如果当前页记录数量小于最大数量 则Next按钮 无法click 
          OffsetStatusNext = 'disabled';
          OffsetStatusNextCom = false;
       }else{//否则可以点击下一页
          OffsetStatusNext = '';
          OffsetStatusNextCom = true;
       }
       
   }
   
   public void getLYRecord(){ 
       Integer offset = pageNumber * pageSize; 
       LYList = [Select id, Name, amount__c, accountID__c, surplus__c, accountName__c, contract__r.Name, contract__c from guaranteeLetter__c where accountID__c =:AccountId and returnOrNot__c = false and type__c =:'履约保证金' and approvalStatus__c =:'审批通过' order by CreatedDate limit :pageSize offset :offset];
       if(LYList.size() == 0){
          flagButton3 = false;
       }else{
          flagButton3 = true;
       }
       if(pageNumber < 1 ){
          OffsetStatusPrevious = 'disabled'; 
          OffsetStatusPreviousCom = false;
       }else{//否则previous按钮可以click
          OffsetStatusPrevious = '';
          OffsetStatusPreviousCom = true;
       }
       
       if(LYList.size() < pageSize ){
          OffsetStatusNext = 'disabled';
          OffsetStatusNextCom = false;
       }else{//否则可以点击下一页
          OffsetStatusNext = '';
          OffsetStatusNextCom = true;
       }
       
   }
  
   public PageReference previous(){ //上一页 函数 操作
        pageNumber = pageNumber - 1;  
        if (pageNumber < 0)  
            return null;  
            
        if(ContractPanel){ //如果是合同的panel
          getContractRecord();
        }else if(bidCostPanel){
          getTBRecord();
        }else{
          getLYRecord();
        }
  
        EachValue = null;
        EachValue2 = null;
        return null;
    }
    
   public PageReference next(){ //下一页 函数 操作
      pageNumber = pageNumber + 1;  
      
      if(ContractPanel){ //如果是合同的panel
         getContractRecord(); 
      }else if(bidCostPanel){
         getTBRecord();
      }else{
         getLYRecord();
      }
        
      EachValue = null ;
      EachValue2 = null;
      return null;
   } 
        
   
   public void getFinishRecord(String poolId){
      RIList = [Select id, Name, contracts__c,contractName__c, LYBaozhengjing__c, LYBaozhengjing__r.Name, bidCost__c, bidCost__r.Name, returnUser__c, contracts__r.oldContractNumber__c, returnDate__c, recordTypeName__c, amount__c from returnItem__c where returnPool__c = :poolId order by CreatedDate desc];
   }
   
   public void clickContract(){
      pageNumber = 0; 
      ContractPanel = true;
      bidCostPanel = false;
      LYCostPanel = false;
      activePanel1 = 'active';
      activePanel2 = '';
      activePanel3 = '';
      getContractRecord();  
   }

   public void clickBidCost(){
       pageNumber = 0; 
       ContractPanel = false;
       bidCostPanel = true;
       LYCostPanel = false;
       activePanel1 = '';
       activePanel2 = 'active';
       activePanel3 = '';
       getTBRecord();
   }
   
   public void clickLYCost(){
       pageNumber = 0; 
       ContractPanel = false;
       bidCostPanel = false;
       LYCostPanel = true;
       activePanel1 = '';
       activePanel2 = '';
       activePanel3 = 'active';
       getLYRecord();
   }
   

   public PageReference commitContractRecord(){//
      if(CValues1 == null||CValues1 == ''){
         Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, '页面出现错误,请检查您的操作并刷新页面! + 回款'));
      }else{
         List<String> TempValueList = CValues1.subString(0,CValues1.length() - 1).split(',');
         List<returnItem__c> riList = new List<returnItem__c>();
      
         if(TempValueList.size() > 0){
            for(Integer i=0; i< TempValueList.size(); i++){
               returnItem__c ri = new returnItem__c();
               ri.RecordTypeId = [Select id from RecordType where Name =:'合同回款' and SobjectType = :'returnItem__c'].id;
               ri.contracts__c = TempValueList[i].subString(0 ,TempValueList[i].indexOf('@'));
               ri.amount__c = Double.valueOf(TempValueList[i].subString(TempValueList[i].indexOf('@') + 1 ,TempValueList[i].indexOf('#')));
               ri.comments__c = TempValueList[i].subString(TempValueList[i].indexOf('#') + 1 ,TempValueList[i].indexOf('✈'));
               ri.returnUser__c = TempValueList[i].subString(TempValueList[i].indexOf('✈') + 1 ,TempValueList[i].length());
               ri.returnDate__c = System.today();
               ri.returnPool__c = LPList[0].Id;
               riList.add(ri);  
            }
            insert riList;
         }
         getCurrentRecord(RecordId);
         getFinishRecord(RecordId);
         getContractRecord();
      }
      return null;
   }
   
   public PageReference commitBidRecord(){
      if(CValues2 == null||CValues2 == ''){
         Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, '页面出现错误,请检查您的操作并刷新页面! + 投标'));
      }else{
         List<String> TempValueList = CValues2.subString(0,CValues2.length() - 1).split(',');
         List<returnItem__c> riList = new List<returnItem__c>();
      
         if(TempValueList.size() > 0){
            for(Integer i=0; i< TempValueList.size(); i++){
               returnItem__c ri = new returnItem__c();
               ri.RecordTypeId = [Select id from RecordType where Name =:'投标保证金清分' and SobjectType = :'returnItem__c'].id;
               ri.bidCost__c = TempValueList[i].subString(0 ,TempValueList[i].indexOf('@'));
               ri.amount__c = Double.valueOf(TempValueList[i].subString(TempValueList[i].indexOf('@') + 1 ,TempValueList[i].length()));
               ri.returnDate__c = System.today();
               ri.returnPool__c = LPList[0].Id;
               riList.add(ri);
            }
            insert riList;
         }
         
         getCurrentRecord(RecordId);
         getFinishRecord(RecordId);
         getTBRecord();
      }
      return null;
   }
   
   public PageReference commitLYRecord(){
      if(CValues3 == null||CValues3 == ''){
         Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.ERROR, '页面出现错误,请检查您的操作并刷新页面! + 履约'));
      }else{
         List<String> TempValueList = CValues3.subString(0,CValues3.length() - 1).split(',');
         List<returnItem__c> riList = new List<returnItem__c>();
      
         if(TempValueList.size() > 0){
            for(Integer i=0; i< TempValueList.size(); i++){
               returnItem__c ri = new returnItem__c();
               ri.RecordTypeId = [Select id from RecordType where Name =:'履约保证金清分' and SobjectType = :'returnItem__c'].id;
               ri.LYBaozhengjing__c = TempValueList[i].subString(0 ,TempValueList[i].indexOf('@'));
               ri.amount__c = Double.valueOf(TempValueList[i].subString(TempValueList[i].indexOf('@') + 1 ,TempValueList[i].length()));
               ri.returnDate__c = System.today();
               ri.returnPool__c = LPList[0].Id;
               riList.add(ri);
            }
            insert riList;
         }
         getCurrentRecord(RecordId);
         getFinishRecord(RecordId);
         getLYRecord();
      }
      return null;
   }
}