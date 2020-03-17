public with sharing class KanbanConsole{
   public List<SubmitPanel> SPList{get;set;}
   public List<SubmitPanel> SPListToMe{get;set;}
   public List<LoginPanel> LoginHis{get;set;}
   
   public String InputStr{get;set;}
   public String ApprovalStr1{get;set;}
   public String ApprovalStr2{get;set;}
   
   public Integer C_Amount_All{get;set;}
   public Integer C_Return_All{get;set;}
   public Decimal C_ARpercentage{get;set;}
   public Integer C_Lead_All{get;set;}
   public Integer C_Opp_All{get;set;}
   public Decimal C_LOpercentage{get;set;}
   public Integer C_Contract_All{get;set;}
   public Decimal C_OCpercentage{get;set;}
   
   public String P_Contract{get;set;}
   public String P_Return{get;set;}
   
   public String U_LastName{get;set;}
   public String U_FirstName{get;set;}
   public String U_Department1{get;set;}
   
   public Id currentUserId;
   Date ThisYearFirstDate;
   public Set<Id> UserIdSet = new Set<Id>();
   
//构造方法   
   public KanbanConsole(){
      ThisYearFirstDate = date.newInstance(2017, 1, 1);
      currentUserId = Userinfo.getUserId();
      exec(currentUserId);
   }
   
   public void exec(ID UserId){
      User CurrentU = [Select id, Email, LastName, FirstName from User where Id = :UserId];
      U_LastName = CurrentU.LastName;
      U_FirstName = CurrentU.FirstName;
      U_Department1 = CurrentU.Email;
      
   
      getApprovalList(UserId);
      Set<Id> UserTestSet = new Set<Id>();
      UserTestSet.add(UserId);
      AllUserId(UserTestSet);
      
      try{
         C_Amount_All = Math.round(Double.valueOf([SELECT sum(contractAmountRMB__c) from Contract__c where accountManager__c in :UserIdSet and active__c != :'合同取消' and contractOrNot__c = :'有' and signDate__c >= :ThisYearFirstDate][0].get('expr0'))/10000);
      }catch(exception e){
         C_Amount_All = 0;
         System.Debug('C_Amount_All :此用户没有记录!');
      }
      
      try{
         C_Return_All = Math.round(Double.valueOf([SELECT sum(returnAmount__c) from Contract__c where deliveryPerson__c in :UserIdSet and active__c != :'合同取消' and contractOrNot__c = :'有' and signDate__c >= :ThisYearFirstDate][0].get('expr0'))/10000);
      }catch(exception e){
         C_Return_All = 0;
         System.Debug('C_Return_All :此用户没有记录!');
      }
      
      if(C_Amount_All ==0){
         C_ARpercentage = 0;
      }else{
         C_ARpercentage = ((C_Return_All / Decimal.valueOf(C_Amount_All))*100).SetScale(2);
      }
      
      
      //System.Debug('DDD:' + C_Return_All);
      //System.Debug('DDD:' + C_Amount_All);
      //System.Debug('DDD:' + C_ARpercentage);
      
      try{
         C_Lead_All = Integer.valueOf([SELECT count(id) from salesLeads__c where OwnerId in :UserIdSet and CreatedDate >= :ThisYearFirstDate][0].get('expr0'));
      }catch(exception e){
         C_Lead_All = 0;
         System.Debug('C_Lead_All :此用户没有记录!');
      }
      
      try{
         C_Opp_All = Integer.valueOf([SELECT count(id) from Opportunity where OwnerId in :UserIdSet and CreatedDate >= :ThisYearFirstDate][0].get('expr0'));
      }catch(exception e){
         C_Opp_All = 0;
         System.Debug('C_Opp_All :此用户没有记录!');
      }
      
      if(C_Lead_All ==0){
         C_LOpercentage = 0;
      }else{
         C_LOpercentage = ((C_Opp_All / Decimal.valueOf(C_Lead_All))*100).SetScale(2);
      }
      
      try{
         C_Contract_All = Integer.valueOf([SELECT count(id) from Contract__c where accountManager__c in :UserIdSet and active__c != :'合同取消' and contractOrNot__c = :'有' and signDate__c >= :ThisYearFirstDate][0].get('expr0'));
      }catch(exception e){
         C_Contract_All = 0;
         System.Debug('C_Contract_All :此用户没有记录!');
      }
      
      if(C_Opp_All ==0){
         C_OCpercentage = 0;
      }else{
         C_OCpercentage = ((C_Contract_All / Decimal.valueOf(C_Opp_All))*100).SetScale(2); 
      }
      //System.Debug('PPPPPPP');
      String currentYear = String.valueOf(System.today().year());
      List<Plan__c> pL = [Select id, percentOfContract__c, percentOfReturn__c, summary_Contract__c, summary_Return__c from Plan__c where OwnerId =:UserId and year__c =:currentYear limit 1];
      
      if(pL.size() ==0){
         P_Contract = '无数据';
         P_Return = '无数据';
      }else{
         P_Contract = String.valueOf(pL[0].percentOfContract__c);
         P_Return = String.valueOf(pL[0].percentOfReturn__c);
      }
      
      getLoginHisLocation(UserId);
   }
   
//得到当前用户所有汇报线上下属   
   public void AllUserId(Set<Id> USet){
      List<User> Upremier = [Select id from User where ManagerId in :USet and isActive = true];
      
      for(ID s:USet){
         UserIdSet.add(s);
      }
      
      Integer UpremierSize = Upremier.size();
      if(UpremierSize == 0){
         //System.Debug('BBB:' + UserIdSet); 
      }else{
         Set<Id> UserAgainSet = new Set<Id>();
         for(User u:Upremier){
            UserAgainSet.add(u.id);
         }
         
         AllUserId(UserAgainSet);
      }
   }
   
   public void Trans(){
      //初始化
      String UN_Str;
      UserIdSet.clear();
      Organization o = [Select isSandbox from Organization limit 1];
      
      if(o.isSandbox){
         UN_Str = InputStr + '@sf-auto.com.' + UserInfo.getUserName().substringAfterLast('.');
      }else{
         UN_Str = InputStr + '@sf-auto.com';
      }
      
      
      System.Debug('UN_Str:' + UN_Str );
      List<User> ActUList = [Select Id from User where username =:UN_Str and IsActive = true];
      if (ActUList.size() == 1){
         currentUserId = ActUList[0].Id;
         exec(ActUList[0].Id);
      }else{
         Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.FATAL, '没有找到小伙伴'));
      }
      
   }
   
//审批列表  
   public void getApprovalList(ID UserId){
      List<ProcessInstanceStep> PISList = [Select id, CreatedDate, ProcessInstanceId, ProcessInstance.TargetObjectId, ProcessInstance.TargetObject.Name, ProcessInstance.Status from ProcessInstanceStep where OriginalActorId = :UserId and StepStatus = 'Started' and ProcessInstance.TargetObjectId != null order by CreatedDate desc limit 30];
      System.Debug('SSS:' + PISList.size() );
      SPList= new List<SubmitPanel>();
      integer tempRowId = 1;
      
      for(ProcessInstanceStep pis:PISList){
         SubmitPanel SP = new SubmitPanel();
         SP.sid = pis.id;
         SP.rowId = tempRowId;
         SP.startDate = (pis.CreatedDate).format('yyyy-MM-dd kk:mm:ss');
         SP.objectName = StringTranz((ID.valueOf(pis.ProcessInstance.TargetObjectId)).getSObjectType().getDescribe().getLabel());
         SP.orginalId = pis.ProcessInstance.TargetObjectId;
         SP.orginalName = StringTranz(pis.ProcessInstance.TargetObject.Name);
         SP.approvalStatus = pis.ProcessInstance.Status;
         SPList.add(SP);
         tempRowId++;
      }
      
      List<ProcessInstanceStep> PISListToMe = [Select id, CreatedDate, StepStatus, ProcessInstanceId, ProcessInstance.TargetObjectId, ProcessInstance.TargetObject.Name, ProcessInstance.Status from ProcessInstanceStep where ActorId = :UserId and StepStatus != 'Started' and ProcessInstance.TargetObjectId != null order by CreatedDate desc limit 30];
      SPListToMe= new List<SubmitPanel>();
      integer tempRowIdToMe = 1;
      for(ProcessInstanceStep pis:PISListToMe){
         SubmitPanel SPToMe = new SubmitPanel();
         SPToMe.sid = pis.id;
         SPToMe.rowId = tempRowIdToMe;
         SPToMe.startDate = (pis.CreatedDate).format('yyyy-MM-dd kk:mm:ss');
         SPToMe.objectName = StringTranz((ID.valueOf(pis.ProcessInstance.TargetObjectId)).getSObjectType().getDescribe().getLabel());
         SPToMe.orginalId = pis.ProcessInstance.TargetObjectId;
         SPToMe.orginalName = StringTranz(pis.ProcessInstance.TargetObject.Name);
         SPToMe.approvalStatus = pis.StepStatus;
         SPToMe.finalStatus = pis.ProcessInstance.Status;
         SPListToMe.add(SPToMe);
         tempRowIdToMe++;
      }
      
      ApprovalStr1 = JSON.serialize(SPList); 
      ApprovalStr2 = JSON.serialize(SPListToMe); 
   }
   
//字符过长，截取字符串，添加省略号
   public String StringTranz(String strPre){
      if(strPre.length() > 12){
         return strPre.substring(0,12)+'..';
      }
      return strPre;
   }
   
//转化审批状态
   public String ApprovalStrTranz(String strPre){
     if(strPre == 'Pending'){
        return '审批中';
     }else if(strPre == 'Rejected'){
        return '拒绝';
     }else if(strPre == 'Approved'){
        return '通过';
     }else{
        return strPre;
     }
   }
   
//转化国家代码
   public String CountryStrTranz(String strPre){
     if(strPre == 'CN'){
        return '中国';
     }else if(strPre == 'US'){
        return '美国';
     }else{
        return strPre;
     }
   }
   
   public void getLoginHisLocation(Id userId){
      List<LoginHistory> LHList= [SELECT Id, UserId, LoginGeo.Latitude,LoginGeo.Longitude,Status,SourceIp,Application,CountryIso,LoginTime from LoginHistory where UserId = :userId order by LoginTime desc limit 100];
      LoginHis = new List<LoginPanel>();
      integer tempRowIdToMe = 1;
      for(LoginHistory lh:LHList){
         LoginPanel LPTEMP = new LoginPanel();
         LPTEMP.Sid = lh.id;
         LPTEMP.RowId = tempRowIdToMe;
         LPTEMP.UserId = lh.UserId;
         LPTEMP.Lat = lh.LoginGeo.Latitude;
         LPTEMP.Lon = lh.LoginGeo.Longitude;
         LPTEMP.Status = lh.Status;
         LPTEMP.SourceIp = lh.SourceIp;
         LPTEMP.Application = lh.Application;
         LPTEMP.CountryIso = CountryStrTranz(lh.CountryIso);
         LPTEMP.LoginTime = (lh.LoginTime).format('yyyy-MM-dd kk:mm:ss');
         LPTEMP.AddressStreet = BaiduMapGeoWS.GetAddress(lh.LoginGeo.Latitude,lh.LoginGeo.Longitude);
         LoginHis.add(LPTEMP);
         tempRowIdToMe++;
      }
   }
   
//审批历史类  
   Class SubmitPanel{
      public String sid{get;set;}
      public Integer rowId{get;set;}
      public String startDate{get;set;}
      public String objectName{get;set;}
      public String orginalId{get;set;}
      public String orginalName{get;set;}
      public String approvalStatus{get;set;}
      public String finalStatus{get;set;}
   }
   
//登录历史类  
   Class LoginPanel{
      public String Sid{get;set;}
      public Integer RowId{get;set;}
      public String UserId{get;set;}
      public Decimal Lat{get;set;}
      public Decimal Lon{get;set;}
      public String Status{get;set;}
      public String SourceIp{get;set;}
      public String Application{get;set;}
      public String CountryIso{get;set;}
      public String LoginTime{get;set;}
      public String AddressPrivince{get;set;}
      public String AddressCity{get;set;}
      public String AddressStreet{get;set;}
   }

}