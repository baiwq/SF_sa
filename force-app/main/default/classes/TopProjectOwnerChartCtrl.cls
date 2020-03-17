public Class TopProjectOwnerChartCtrl{

    public String mainContent{get;set;}
    public List<Contact> CList;
    public Map<String,Contact> MapCList;
    public Set<String> WriteIds;
    String tempCircle;
    String department;
    String phone;
    String email;
    String workStatus;
    String gender;
    
    public TopProjectOwnerChartCtrl(){
       String AccountName;
       String startNodeId;
       String startNodeName;
       String startNodeTitle;
       Boolean endFindflag = false;
       WriteIds = new Set<String>();
       String startDepartment;
       String startPhone;
       String startEmail;
       String startWorkStatus;
       String startGender;
       Integer startEventNum;
       String startDecisionRole;
       String startBuyStyle;
       String startMaturity;
       
       String RecordId = [Select projectOwner__c from opportunity where id=:ApexPages.currentPage().getParameters().get('id') limit 1].projectOwner__c;
       CList = [Select id,Name,maturity__c,decisionRole__c,buyStyle__c,Department,Phone,Email,workStatus__c,gender__c,Title,ReportsToId,Account.Name,coreCircle__c from Contact where AccountId = :RecordId];
       
       MapCList = new Map<String,Contact>();
       for(Contact c:CList){
          MapCList.put(c.id,c);
          if(c.ReportsToId == null && !endFindflag){
              endFindflag = true;
              AccountName = c.Account.Name;
              startNodeId = c.id;
              startNodeName = c.Name;
              startNodeTitle = c.Title;
              startGender = c.gender__c;
              startDecisionRole=c.decisionRole__c;
              startBuyStyle =c.buyStyle__c;
              startMaturity =c.maturity__c;
              if(c.Department == null){
                 startDepartment = '无';
              }else{
                 startDepartment =c.Department;
              }
              if(c.Phone == null){
                 startPhone = '无';
              }else{
                  startPhone = c.Phone;
              }
              if(c.Email == null){
                  startEmail = '无';
              }else{
                  startEmail =c.Email ;
              }
              if(c.workStatus__c == null){
                  startWorkStatus = '无';
              }else{
                  startWorkStatus = c.workStatus__c;
              }
              if(c.coreCircle__c)
                  tempCircle = 'inner';
              else
                  tempCircle = 'outer';
          }
       }
        startEventNum =[select id from event where WhoId =:startNodeId].size();
       string tempcontent = '{' + '"name": "' + AccountName + '", "title": "' + 'N/A' + '","phone": "","email": "","workStatus": "","gender": "","department": "","eventNum": "", "rid": "' + 'AccountId' + '"' + ' ,"children": [';
       tempcontent = tempcontent + '{' + '"name": "' + startNodeName + '", "title": "' + startNodeTitle + '","className": "' + tempCircle + '","phone": "' + startPhone+ '", "decisionRole": "' + startDecisionRole + '","buyStyle": "' + startBuyStyle+ '","maturity": "' + startMaturity+ '","eventNum": "' + startEventNum+ '","email": "' + startEmail+'","workStatus": "' +startWorkStatus+'","gender": "'+startGender+'","department": "' +startDepartment+ '", "rid": "' + startNodeId + '"';
       WriteIds.add(startNodeId);
       GetContentValue(startNodeId,null,tempcontent);
    }

    public void GetContentValue(String id,string managerId,String content){
       Boolean childrenFlag = false;
       Boolean siblingFlag = false;
       String writeKey;
       Integer eventNum;

       for(String str1:MapCList.keyset()){
           if(MapCList.get(str1).ReportsToId == id && (!WriteIds.contains(str1))){
              childrenFlag = true;
              writeKey = str1;
              break;
           }
       }
       
       if(!childrenFlag){
           for(String str2:MapCList.keyset()){
               if(MapCList.get(str2).ReportsToId == managerId && (!WriteIds.contains(str2))){
                   siblingFlag = true;
                   writeKey = str2;
                   break;
               }
           }
       }
       
       if(writeKey != null){
           if(MapCList.get(writeKey).Department == null){
             department = '无';
           }else{
             department = MapCList.get(writeKey).Department;
           }
           if(MapCList.get(writeKey).Phone == null){
              phone = '无';
           }else{
              phone = MapCList.get(writeKey).Phone;
           }
           if(MapCList.get(writeKey).Email == null){
              email = '无';
           }else{
              email = MapCList.get(writeKey).Email;
           }
           if(MapCList.get(writeKey).workStatus__c == null){
              workStatus = '无';
           }else{
              workStatus = MapCList.get(writeKey).workStatus__c;
           }
             gender = MapCList.get(writeKey).gender__c;
           if(MapCList.get(writeKey).coreCircle__c)
               tempCircle = 'inner';
           else
               tempCircle = 'outer'; 
                      
           eventNum =[select id from event where WhoId =:writeKey].size();
           
           if(childrenFlag){
               content = content + ',"children": [{';
               content = content + '"name": "' + MapCList.get(writeKey).Name + '", "title": "' + MapCList.get(writeKey).Title + '","className": "' + tempCircle + '","department": "' + department+ '","phone": "' + phone+ '","decisionRole": "' + MapCList.get(writeKey).decisionRole__c+ '","buyStyle": "' + MapCList.get(writeKey).buyStyle__c+ '","maturity": "' + MapCList.get(writeKey).maturity__c+ '","eventNum": "' + eventNum+ '","email": "' + email+ '","workStatus": "' + workStatus+ '","gender": "' + gender+ '","rid": "' + MapCList.get(writeKey).id + '"';
               WriteIds.add(writeKey);
           }else{
               content = content + '},{';
               content = content + '"name": "' + MapCList.get(writeKey).Name + '", "title": "' + MapCList.get(writeKey).Title + '","className": "' + tempCircle + '","department": "' + department+ '","phone": "' + phone+ '","decisionRole": "' + MapCList.get(writeKey).decisionRole__c+ '","buyStyle": "' + MapCList.get(writeKey).buyStyle__c+ '","maturity": "' + MapCList.get(writeKey).maturity__c+ '","eventNum": "' + eventNum+ '","email": "' + email+ '","workStatus": "' + workStatus+ '","gender": "' + gender+ '","rid": "' + MapCList.get(writeKey).id + '"';
               WriteIds.add(writeKey);
           }
           GetContentValue(writeKey,MapCList.get(writeKey).ReportsToId,content);
       }
       
       if(writeKey == null){
          if(managerId != null){
             content = content + '}]';
             GetContentValue(managerId,MapCList.get(managerId).ReportsToId,content);
          }
          else{
             content = content + '}]}';
             mainContent = content;
             system.debug('888888888888888888888'+mainContent);
             return;
          } 
       }
    }
}