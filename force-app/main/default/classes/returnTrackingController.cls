public with sharing class returnTrackingController{
    public List<paymentTerm__c> Panel1List{get;set;}//销售可填写的付款条目
    public List<paymentTerm__c> Panel2List{get;set;}//销售填写完成的付款条目
    public List<paymentTerm__c> Panel3List{get;set;}//销售可填写的定向合同付款条目
    public List<paymentTerm__c> Panel4List{get;set;}//销售可更新的定向合同付款条目
    public List<paymentTerm__c> Panel5List{get;set;}//query付款条目
    public List<paymentTerm__c> Panel6List{get;set;}//query付款条目
    
    public Integer tempSize{get;set;}// 当前数据条目数  
    
    public String Panel2RecordId{get;set;}//删除input记录ID 
    public String Panel4RecordId{get;set;}//删除dir input记录ID 
        
    public String str{get;set;} //销售填报表单 查询关键字
   
    public String acceptStr{get;set;} 
    public String salesStr{get;set;}

    public String activePanel1{get;set;}  //Panel的活跃标记
    public String activePanel2{get;set;}  //Panel2的活跃标记  
    public String activePanel3{get;set;}  //Panel3的活跃标记
    public String activePanel4{get;set;}  //Panel4的活跃标记
    public String activePanel5{get;set;}  //Panel5的活跃标记
    public String activePanel6{get;set;}  //Panel6的活跃标记
    
    public String textShow{get;set;}  //文字提示标记
    
    public Integer pageNumber{get;set;}    //页数
    public Integer pageSize{get;set;}      //每页显示的最大记录条数
    
    public String  OffsetStatusPrevious{get;set;} //String前一页按钮
    public String  OffsetStatusNext{get;set;}     //String后一页按钮
    public Boolean OffsetStatusPreviousCom{get;set;} //Bool前一页按钮
    public Boolean OffsetStatusNextCom{get;set;} //Bool后一页按钮
       
    public String CurrentUserId{get;set;}
    public String LastDateString{get;set;}
    public String CurrentDateString{get;set;}
    public String NextDateString{get;set;}
    public Integer LastToYear{get;set;}
    public Integer LastToMonth{get;set;}
    public Integer CurrentYear{get;set;}
    public Integer CurrentMonth{get;set;}
    public Integer NextToYear{get;set;}
    public Integer NextToMonth{get;set;}
    
    public String textStr{get;set;}
            
    //构造函数
    public returnTrackingController(){              
        activePanel1 = 'active';   
        textStr = '可根据客户名称，机会名称，合同号模糊查询/也可以批量输入合同号，以逗号隔开';     
        pageSize = 30; 
        pageNumber = 0;    
        textShow = 'block';      
        getProfileValue(); 
        DateHelper();
        Search();        
    }   
    public void DateHelper(){
        CurrentUserId = Userinfo.getUserId();
        LastToYear   = System.today().addMonths(-1).year();
        LastToMonth  = System.today().addMonths(-1).month();
        CurrentYear  = System.today().year();
        CurrentMonth = System.today().month();
        NextToYear   = System.today().addMonths(1).year();
        NextToMonth  = System.today().addMonths(1).month();
        LastDateString    = LastToYear  + '年' + LastToMonth  + '月';
        CurrentDateString = CurrentYear + '年' + CurrentMonth + '月';
        NextDateString    = NextToYear  + '年' + NextToMonth  + '月';             
    }    
    public void getProfileValue(){
        Profile p = [select id,name from Profile where id = :UserInfo.getProfileId()][0];
        if(p.name.contains('系统管理员')){
            acceptStr = 'inline';
            salesStr = 'inline';
        }else if(p.name.contains('回款管理工程师')){
            acceptStr = 'inline';
            salesStr = 'none';
        }else{
            acceptStr = 'none';
            salesStr = 'inline';
        }       
    }   
    public void clickPanel1(){
          pageNumber = 0;         
          activePanel1 = 'active';
          textShow = 'block'; 
          activePanel2 = '';
          activePanel3 = '';
          activePanel4 = '';
          activePanel5 = '';
          activePanel6 = '';
          textStr = '可根据客户名称，机会名称，合同号模糊查询/也可以批量输入合同号，以逗号隔开';
          str = null;
          Search();            
      }
      public void clickPanel2(){
          pageNumber = 0;                        
          activePanel1 = '';
          activePanel2 = 'active';
          textShow = 'block'; 
          activePanel3 = '';
          activePanel4 = '';
          activePanel5 = '';
          activePanel6 = ''; 
          str = null;
          textStr = '可根据客户名称，机会名称，合同号模糊查询/也可以批量输入合同号，以逗号隔开';
          Search();            
      }
      public void clickPanel3(){
          pageNumber = 0;      
          activePanel1 = '';
          activePanel2 = '';
          activePanel3 = 'active';
          textShow = 'block'; 
          activePanel4 = '';
          activePanel5 = '';
          activePanel6 = '';
          str = null;
          textStr = '可根据客户名称，机会名称，合同号模糊查询/也可以批量输入合同号，以逗号隔开';
          Search();  
      }
      public void clickPanel4(){
          pageNumber = 0;        
          activePanel1 = '';
          activePanel2 = '';
          activePanel3 = '';
          activePanel4 = 'active';
          textShow = 'block'; 
          activePanel5 = '';
          activePanel6 = '';
          str = null;
          textStr = '可根据客户名称，机会名称，合同号模糊查询/也可以批量输入合同号，以逗号隔开';
          Search(); 
      }
      public void clickPanel5(){
          pageNumber = 0;           
          activePanel1 = '';
          activePanel2 = '';
          activePanel3 = '';
          activePanel4 = '';
          activePanel5 = 'active';
          textShow = 'block'; 
          activePanel6 = '';
          str = null;
          textStr = '请输入合同号查询/也可以批量输入合同号，以逗号隔开';
          Search(); 
      }
      public void clickPanel6(){
          pageNumber = 0;                            
          activePanel1 = '';
          activePanel2 = '';
          activePanel3 = '';
          activePanel4 = '';
          activePanel5 = '';
          activePanel6 = 'active';
          textShow = 'none'; 
          str = null;
          textStr = '请输入合同号查询/也可以批量输入合同号，以逗号隔开';
          Search(); 
      }
    public void Search(){ //根据关键字进行查询
        String queryStr; 
        Integer offset = pageNumber * pageSize;
        if(str == null||str == ''){
            if(activePanel1=='active'){
                queryStr = 'select id,stageEndsDate__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where surplusMoney__c > 0 and contract__r.deliveryPerson__c = \''+ UserInfo.getUserId() + '\' and contract__r.active__c = \'履约中\' and inputAmount__c = null and inputDate__c = null order by contract__r.Name limit ' + pageSize + ' offset ' + offset;
                Panel1List = Database.query(queryStr);
                tempSize = Panel1List.size();
            }else if(activePanel2=='active'){
                queryStr = 'select id,stageEndsDate__c,overMark__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__r.deliveryPerson__c = \''+ UserInfo.getUserId() + '\' and inputDate__c != null and inputAmount__c != null order by contract__r.Name limit ' + pageSize + ' offset ' + offset;
                Panel2List = Database.query(queryStr);
                tempSize = Panel2List.size();
            }else if(activePanel3=='active'){
                queryStr = 'select id,stageEndsDate__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where directionalTask__c = true and surplusMoney__c > 0 and contract__r.deliveryPerson__c = \''+ UserInfo.getUserId() + '\' and contract__r.active__c = \'履约中\' and inputAmount__c = null and inputDate__c = null order by contract__r.Name limit ' + pageSize + ' offset ' + offset;
                Panel3List = Database.query(queryStr);
                tempSize = Panel3List.size();
            }else if(activePanel4=='active'){
                queryStr = 'select id,stageEndsDate__c,overMark__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__r.deliveryPerson__c = \''+ UserInfo.getUserId() + '\' and inputDate__c != null and inputAmount__c != null and directionalTask__c = true order by contract__r.Name limit ' + pageSize + ' offset ' + offset;
                Panel4List = Database.query(queryStr);
                tempSize = Panel4List.size();
            }else if(activePanel5=='active'){
                Panel5List = null;
                tempSize = 0;
            }else if(activePanel6=='active'){
                Panel6List = null;
                tempSize = 0;
            }          
        }else{
            if(str.length() < 2){
                System.debug('关键字长度不能小于2');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'请输入长度大于2的关键词'));
            }else{
                Set<ID> idSet = new getContractIdSetFromStr().getIdSet(str);
                if(activePanel1=='active'){          
                    Panel1List = [select id,stageEndsDate__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__c in:idSet and surplusMoney__c > 0  and contract__r.active__c = '履约中' and inputAmount__c = null and inputDate__c = null order by contract__r.Name limit :pageSize offset :offset];
                    tempSize = Panel1List.size();
                }else if(activePanel2=='active'){
                    Panel2List =  [select stageEndsDate__c,overMark__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__c in:idSet and contract__r.deliveryPerson__c =:UserInfo.getUserId() and inputDate__c != null and inputAmount__c != null order by contract__r.Name limit :pageSize offset :offset];       
                    tempSize = Panel2List.size();                   
                }else if(activePanel3=='active'){
                    Panel3List = [select stageEndsDate__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__c in:idSet and directionalTask__c = true and surplusMoney__c > 0 and  contract__r.deliveryPerson__c =:UserInfo.getUserId() and contract__r.active__c = '履约中' and inputAmount__c = null and inputDate__c = null order by contract__r.Name limit :pageSize offset :offset];     
                    tempSize = Panel3List.size();                   
                }else if(activePanel4=='active'){
                    Panel4List =  [select stageEndsDate__c,overMark__c,contract__r.Name,contract__r.account__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,returnStage__c,inputAmount__c,inputDate__c from paymentTerm__c where contract__c in:idSet and directionalTask__c = true and surplusMoney__c > 0 and  contract__r.deliveryPerson__c =:UserInfo.getUserId() and contract__r.active__c = '履约中' and inputAmount__c != null and inputDate__c != null order by contract__r.Name limit :pageSize offset :offset];  
                    tempSize = Panel4List.size();                  
                }else if(activePanel5=='active'){
                    Set<ID> cidSet = new Set<ID>();     
                    String[] sList = str.subString(0,str.length()).split(','); 
                    for(contract__c con:[select id from contract__c where name in :sList]){                
                       cidSet.add(con.id);            
                    }   
                    Panel5List = [select inputDate__c,inputAmount__c,contract__r.Name,contract__r.accountName__c,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,percentage__c,surplusMoney__c,stageDate__c,directionalTask__c,description__c,returnStage__c,paymentProceduresDate__c,paymentProceduresAmount__c,paymentProceduresType__c from paymentTerm__c where contract__c in:cidSet and contract__r.deliveryPerson__c =:UserInfo.getUserId() order by contract__r.Name limit :pageSize offset :offset];                                
                    tempSize = Panel5List.size();
                }else if(activePanel6=='active'){
                    Set<ID> cidSet = new Set<ID>();     
                    String[] sList = str.subString(0,str.length()).split(',');                
                    for(contract__c con:[select id from contract__c where name in :sList]){                
                        cidSet.add(con.id);            
                    }                  
                    Panel6List = [select contract__r.Name,contract__r.contractName__c,contract__r.receiveRiskLevel__c,stage__c,surplusMoney__c,inputAmount__c,inputDate__c,directionalTask__c ,description__c,returnStage__c,paymentProceduresDate__c, solution__c,reason__c,updateRecord__c,updateReformDate__c,unNormalReturnAdjustDate__c from paymentTerm__c
                        where contract__c in:cidSet order by contract__r.Name limit :pageSize offset :offset]; 
                    tempSize = Panel6List.size();
                }                                
            }
        }
       if(pageNumber < 1 ){ //查询记录在一个页面中可以显示完全，则previous按钮 无法click 
            OffsetStatusPrevious = 'disabled';
            OffsetStatusPreviousCom = false;
        }else{   //否则可以点击下一页
            OffsetStatusPrevious = ''; 
            OffsetStatusPreviousCom = true;
        }     
        if(tempSize < pageSize){//如果当前页记录数量小于最大数量 则Next按钮 无法click 
            OffsetStatusNext = 'disabled';
            OffsetStatusNextCom = false;
        }else{   //否则可以点击下一页
            OffsetStatusNext = '';
            OffsetStatusNextCom = true;
        }      
    }       
    public PageReference SavePanel1(){
        try{
        for(paymentTerm__c p:Panel1List){
            if(p.inputAmount__c == null && p.inputDate__c == null){
                continue;
            }else{
                update p;
            }
        }            
        Search();           
        }catch(DMLexception e){ }
        return null;
    }  
    public PageReference SavePanel2(){
        try{  
        for(paymentTerm__c p:Panel3List){
            if(p.inputAmount__c == null && p.inputDate__c == null){
                continue;
            }else{
                update p;
            }
        }
        Search();   
        }catch(DMLexception e){}
        return null;
    }   
    public PageReference SavePanel5(){
        try{  
        update Panel5List; 
        Search();
        }catch(DMLexception e){}
        return null;
    }
    public PageReference SavePanel6(){
        try{  
            update Panel6List;
            Search();
        }catch(DMLexception e){}
        return null;
    }        
    public PageReference deletePanel2(){        
        paymentTerm__c dp = [select id,inputAmount__c,inputDate__c from paymentTerm__c where id = :Panel2RecordId];
        dp.inputAmount__c = null;
        dp.inputDate__c = null;
        update dp;       
        Search();    
        return null;
    }    
    public PageReference deletePanel4(){        
        paymentTerm__c dp = [select id,inputAmount__c,inputDate__c from paymentTerm__c where id = :Panel4RecordId];
        dp.inputAmount__c = null;
        dp.inputDate__c = null;
        update dp;
        Search();  
        return null;
    }    
    public PageReference previous(){ //上一页 函数 操作
        pageNumber = pageNumber - 1;  
        if (pageNumber < 0)  
            return null;             
        else{
            Search();
        }       
        return null;
    }   
    public PageReference next(){ //下一页 函数 操作
        pageNumber = pageNumber + 1;         
        Search();        
        return null;
    }
}