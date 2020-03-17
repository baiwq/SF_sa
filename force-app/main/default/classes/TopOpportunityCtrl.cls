public class TopOpportunityCtrl{
    public ID RecordId{get;set;}
    //填写标记
    public String fi1{get;set;}
    public String fi2{get;set;}
    public String fi3{get;set;}
    public String fi4{get;set;}
    public String fi5{get;set;}
    public String fi6{get;set;}
    public String fi7{get;set;}  
    //分页标记 
    public Integer pageNumber{get;set;}    //页数
    public Integer pageSize{get;set;}      //每页显示的最大记录条数
    public String  OffsetStatusPrevious{get;set;} //String前一页按钮
    public String  OffsetStatusNext{get;set;}     //String后一页按钮
    public Boolean OffsetStatusPreviousCom{get;set;} //Bool前一页按钮
    public Boolean OffsetStatusNextCom{get;set;} //Bool后一页按钮
    //TopIndex
    public String PhotoUrl{get;set;}
    public String Name{get;set;}
    public String UEmail{get;set;}
    public String PName{get;set;}  
    public String A{get;set;}
    public String B{get;set;}
    public String C{get;set;}
    public String D{get;set;}
    //买点卖点匹配表   
    public List<SPMaddIndex> SPMList{get;set;}
    public Integer row1{get;set;}   
    //商务竞争态势分析表
    public List<BCSaddIndex> BCSList{get;set;}
    public Integer row2{get;set;}
    //技术竞争态势分析表
    public List<TCSaddIndex> TCSList{get;set;}
    public Integer row3{get;set;}
    //行动计划表
    public List<APaddIndex> APList{get;set;}
    public Integer row4{get;set;}
    //谈判计划表
    public List<NSaddIndex> NSList{get;set;}
    public Integer row5{get;set;}
    //商务谈判
    public List<BNSaddIndex> BNSList{get;set;}
    public Integer row6{get;set;}
    //技术谈判
    public List<TNSaddIndex> TNSList{get;set;}
    public Integer row7{get;set;}
    //显示为只读/编辑
    public boolean f1{get;set;}
    public boolean f2{get;set;}
    public boolean f3{get;set;}
    public boolean f4{get;set;}
    public boolean f5{get;set;}
    public boolean f6{get;set;}
    public boolean f7{get;set;}    
    //组织结构图
    public String mainContent{get;set;}
    public String mainContent2{get;set;}
    public List<Contact> CList;
    public Map<String,Contact> MapCList;
    public Set<String> WriteIds;
    String tempCircle;
    String department;
    String phone;
    String email;
    String workStatus;
    String gender;  
    //基本信息
    public Opportunity o{get;set;}
    public PanelValue pv{get;set;}
    public List<OptyStatus> OSList{get;set;}
    public List<OpportunityTeamMember> OTMList{get;set;}
    public List<commisionUser__c> CUList{get;set;}
    public List<quatation__c> QList{get;set;}
    //构造函数
    public TopOpportunityCtrl(ApexPages.StandardController controller) {
         pageNumber = 0;
         pageSize = 5;
         RecordId = ApexPages.currentPage().getParameters().get('id');       //业务机会ID 
        //基本信息
         o = [Select id, account.category__c ,Name, Owner.id,Owner.Email,Owner.Name,Owner.UserName,Owner.FullPhotoUrl, level1center__c, level2Department__c, level3Province__c,expectBidDate__c, Probability, expectAmount__c, AccountId, opportunityNumber__c, Account.Name,classification__c, rating__c, projectType__c, voltageLevel__c, buildType__c, opportunityIndustry__c, industrySecondLevel__c, CloseDate,StageName, opportunityScore__c,
                 projectStage__c,accountIndustry__c,country__c,province__c,implementationStation__c,projectOwner__c,salesProjectManager__c,promoter__c,bidCompany__c,projectDesigner__c,designAccount__c,contractorAccount__c,operationTime__c from Opportunity where id = :RecordId];
         PhotoUrl =  o.Owner.FullPhotoUrl;
         Name = o.Owner.Name;
         UEmail = o.Owner.Email;
         PName = '/apex/TopBasicInfo?id='+RecordId;
         
        //组织关系图   
        ContactChartCtrl(o.accountId);
        
         
         A = 'active';              
         pv = new PanelValue();         
         if(o.expectBidDate__c != null)
             pv.Days = String.valueOf(System.today().daysBetween(o.expectBidDate__c));
         else{
             pv.Days = 'N/A';
         } 
         if(o.CloseDate != null){
             pv.Days2 = String.valueOf(System.today().daysBetween(o.CloseDate));
         }else{
             pv.Days2 = 'N/A';
         }                 
         if(o.Probability != null)
            pv.WinChance = String.valueOf(o.Probability);
         else
            pv.WinChance ='N/A';
            
         List<OpportunityTeamMember> OTList = [Select id from OpportunityTeamMember where OpportunityId = :RecordId];
         pv.TeamTotal = OTList.size();
                
         if(o.expectAmount__c != null){
            o.expectAmount__c = o.expectAmount__c/10000;
            pv.Amount = String.valueOf(o.expectAmount__c.setScale(2, RoundingMode.HALF_UP));
         }else
            pv.Amount ='N/A';
                        
         
         List<AggregateResult> ARList = [SELECT sum(contractAmountRMB__c) from Contract__c where account__c =:o.AccountId and contractReceptDate__c != null and cancelMark__c = '否'];
         if(ARList[0].get('expr0') != null){
            Decimal tep = Double.valueOf(ARList[0].get('expr0'))/10000;
            pv.TotalContractAmount = tep.setScale(2, RoundingMode.HALF_UP);
         }else
            pv.TotalContractAmount = 0;
            
         OSList = new List<OptyStatus>();
         OptyStatus OS1 = new OptyStatus();
         OptyStatus OS2 = new OptyStatus();
         OptyStatus OS3 = new OptyStatus();
         OptyStatus OS4 = new OptyStatus();
         OS1.OStage = '业绩分配比例';
         OS2.OStage = '投标评审';
         OS3.OStage = '报价管理';
         OS4.OStage = '合同评审';
         
         
         
         
         //业绩分配比例
         List<commisionSplit__c> cs = [select id,approvalStatus__c from commisionSplit__c where opportunity__c =:RecordId and approvalStatus__c = :'审批通过' limit 1];
         if(cs.size() == 1){
            CUList = [select id,member__c,performanceProportion__c from commisionUser__c where commisionSplit__c =:cs[0].id];
            OS1.OStatus = true;
         }else
            OS1.OStatus = false;
         
         //投标评审
         List<bidReview__c> BRList = [Select id,approvalStatus__c from bidReview__c where Opportunity__c =:RecordId and approvalStatus__c = :'审批通过'];
         if(BRList.size() > 0)
            OS2.OStatus = true;
         else
            OS2.OStatus = false;
         //报价   
         List<quatation__c> QTTList = [Select id,approvalStatus__c from quatation__c where Opportunity__c =:RecordId and approvalStatus__c = '审批通过'];
         if(QTTList.size() > 0)
            OS3.OStatus = true;
         else
            OS3.OStatus = false;
         //合同评审   
         List<contractreview__c> CVList = [Select id,approvalStatus__c from contractreview__c where Opportunity__c =:RecordId and approvalStatus__c = '审批通过'];
         if(CVList.size() > 0)
            OS4.OStatus = true;
         else
            OS4.OStatus = false;
          
         OSList.add(OS1);
         OSList.add(OS2);
         OSList.add(OS3);
         OSList.add(OS4);
        
        //报价
        QList = [select id,name,bidPriceProjectMarginRate__c,bidPriceProjectMargin__c,biddingTotalPrice__c,outsourcingCostPercent__c,commonProjectOwnEquipmentBiddingPrice__c,specialProductBiddingPrice__c,ownSoftBiddingPrice__c,outsourcingBiddingPrice__c,outsourcingServiceBiddingPrice__c,outsourcingArchitectureCostBiddingPrice__c,companyTrainServiceBiddingPrice__c from quatation__c where opportunity__c =:recordId and approvalStatus__c = '审批通过'];
       
        
        getTeamMember(recordId);
        
        
                
        //第一张表 买点卖点匹配表 
        SPMList = new List<SPMaddIndex>();
        List<sellPointMatching__c> aList1 = [select id,name,opportunity__c,sellingPoint__c,buyingPoint__c,valuePoint__c,importance__c,matchPercentage__c,guideDirection__c from sellPointMatching__c where opportunity__c =:RecordId order by createdDate];
        if(aList1.size()==0){
            fi1 = '×买点卖点匹配表';
        }else{
            fi1= '√买点卖点匹配表';
        }
        for(integer i=0;i<aList1.size();i++){           
            SPMaddIndex wa = new SPMaddIndex();                   
            wa.index = i;
            wa.record = aList1[i];            
            SPMList.add(wa);
        }
        //第二张表  商务态势分析表
        BCSList = new List<BCSaddIndex>();
        List<businessCompeteStatus__c> aList2 = [select id,name,opportunity__c,competitor__c,accountRelationship__c,priceHistory__c,deliverDate__c,dealHistory__c,other__c from businessCompeteStatus__c where opportunity__c =:RecordId order by createdDate];
        if(aList2.size()==0){
            fi2 = '×商务态势分析表';
        }else{
            fi2= '√商务态势分析表';
        }
        for(integer i=0;i<aList2.size();i++){
            BCSaddIndex wa = new BCSaddIndex();
            wa.index = i;
            wa.record = aList2[i];            
            BCSList.add(wa);
        }
        //第三张表  技术态势分析表
        TCSList = new List<TCSaddIndex>();
        List<technologyCompeteStatus__c> aList3 = [select id,name,opportunity__c,competitor__c,afterService__c,companyStatus__c,productTechniquePlan__c,quality__c from technologyCompeteStatus__c where opportunity__c =:RecordId order by createdDate];
        if(aList3.size()==0){
            fi3 = '×技术态势分析表';
        }else{
            fi3= '√技术态势分析表';
        }
        for(integer i=0;i<aList3.size();i++){
            TCSaddIndex wa = new TCSaddIndex();
            wa.index = i;
            wa.record = aList3[i];            
            TCSList.add(wa);
        }
        //第四张表  行动计划表
        APList = new List<APaddIndex>();
        List<actionPlan__c> aList4 = [select id,name,opportunity__c,successStandard__c,keyTaskDestription__c,timeStage__c,resourceAndCoordination__c,completionAndRisk__c,responsibility__c from actionPlan__c where opportunity__c =:RecordId order by createdDate];
        if(aList4.size()==0){
            fi4 = '×行动计划表';
        }else{
            fi4= '√行动计划表';
        }
        for(integer i=0;i<aList4.size();i++){
            APaddIndex wa = new APaddIndex();
            wa.index = i;
            wa.record = aList4[i];            
            APList.add(wa);
        }
        //第五张表  谈判计划表
        NSList = new List<NSaddIndex>();
        List<negotationStrategy__c> aList5 = [select id,name,opportunity__c,goal__c,date__c,location__c,negotiateBy__c,result__c from negotationStrategy__c where opportunity__c =:RecordId order by createdDate];
        if(aList5.size()==0){
            fi5 = '×谈判计划表';
        }else{
            fi5= '√谈判计划表';
        }
        for(integer i=0;i<aList5.size();i++){
            NSaddIndex wa = new NSaddIndex();
            wa.index = i;
            wa.record = aList5[i];            
            NSList.add(wa);
        }
        //第六张表  商务谈判计划表
        BNSList = new List<BNSaddIndex>();
        List<businessNegotiationStrategy__c> aList6 = [select id,name,opportunity__c,quotePlan__c,strategyTechnique__c,payment__c,deliverDate__c,accountRequirement__c,other__c,bottomLine__c,transportPlan__c from businessNegotiationStrategy__c where opportunity__c =:RecordId order by createdDate];
        if(aList6.size()==0){
            fi6 = '×商务谈判计划表';
        }else{
            fi6= '√商务谈判计划表';
        }
        for(integer i=0;i<aList6.size();i++){
            BNSaddIndex wa = new BNSaddIndex();
            wa.index = i;
            wa.record = aList6[i];            
            BNSList.add(wa);
        }
        //第七张表  技术谈判计划表
        TNSList = new List<TNSaddIndex>();
        List<techniqueNegotiationStrategy__c> aList7 = [select id,name,opportunity__c,productTechniquePlan__c,strategyTechnique__c,servicePlan__c,accountRequirement__c,bottomLine__c,checkStandard__c from techniqueNegotiationStrategy__c where opportunity__c =:RecordId order by createdDate];
        if(aList7.size()==0){
            fi7 = '×技术谈判计划表';
        }else{
            fi7= '√技术谈判计划表';
        }
        for(integer i=0;i<aList7.size();i++){
            TNSaddIndex wa = new TNSaddIndex();
            wa.index = i;
            wa.record = aList7[i];            
            TNSList.add(wa);
        }             
        f1 = false;
        f2 = false;
        f3 = false;
        f4 = false;
        f5 = false;
        f6 = false;
        f7 = false;           
    }
    //项目小组成员
   public void getTeamMember(ID mid){
       //项目小组成员
         Integer offset = pageNumber * pageSize;
         OTMList = [select id,UserId,TeamMemberRole,User.department__c from OpportunityTeamMember where OpportunityId =:mid limit :pageSize offset :offset];
         if(pageNumber < 1 ){ //查询记录在一个页面中可以显示完全，则previous按钮 无法click 
             OffsetStatusPrevious = 'disabled';
             OffsetStatusPreviousCom = false;
         }else{   //否则可以点击下一页
             OffsetStatusPrevious = ''; 
             OffsetStatusPreviousCom = true;
         }     
         if(OTMList.size() < pageSize){//如果当前页记录数量小于最大数量 则Next按钮 无法click 
             OffsetStatusNext = 'disabled';
             OffsetStatusNextCom = false;
         }else{   //否则可以点击下一页
             OffsetStatusNext = '';
             OffsetStatusNextCom = true;
         }      
   }
    
    //TopIndex
   public void MA(){
      PName = '/apex/TopBasicInfo?id='+RecordId;
      ActiveCtrl('A');
   }
   
   public void MB(){
      PName = '/apex/topOrganization?id='+RecordId;   
      ActiveCtrl('A');
   }
   public void MC(){
      PName = '/apex/TopProjectOwnerOrganization?id='+ RecordId;
      ActiveCtrl('A');
   }
   public void table1(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t1';   
       ActiveCtrl('B');
   }
   public void table2(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t2';
       ActiveCtrl('B');
   }
   public void table3(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t3';
       ActiveCtrl('B');
   }
   public void table4(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t4';
       ActiveCtrl('B');
   }
   public void table5(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t5';
       ActiveCtrl('B');
   }
   public void table6(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t6';
       ActiveCtrl('B');
   }
   public void table7(){
       PName = '/apex/TopSevenTable?id='+RecordId+'#t7';
       ActiveCtrl('B');
   }
   public void attachment(){
       PName = '/apex/TopAttachment';
       ActiveCtrl('D');
   }
   public void ActiveCtrl(String str){
       if(str == 'A'){
           A = 'active';
           B = '';
           C = '';
           D = '';
       }else if(str == 'B'){ 
           A = '';
           B = 'active';
           C = '';
           D = '';
       }else if(str == 'C'){ 
           A = '';
           B = '';
           C = 'active';
           D = '';
       }else if(str == 'D'){ 
           A = '';
           B = '';
           C = '';
           D = 'active'; 
       } 
   }
    //基本信息
    class PanelValue{
       public String Days{get;set;}
       public String Days2{get;set;}
       public String WinChance{get;set;}
       public Integer TeamTotal{get;set;}
       public String Amount{get;set;}
       public String MLL{get;set;}
       public Decimal TotalContractAmount{get;set;}
    }
    
    class OptyStatus{
       public String OStage{get;set;}
       public Boolean OStatus{get;set;}
    }     
    
    //买点卖点匹配表
    public PageReference SPMsave() {   
        AddOneRecordHelper.SPMsave(SPMList);  
        f1 = false;         
        return null;               
    }
    public void SPMremove(){
        SPMList = AddOneRecordHelper.SPMremove(row1,SPMList);
        if(SPMList.size() == 0){
            f1 = false;
        }
        if(SPMList.size() > ([select id from sellPointMatching__c  where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f1 = true;
        }else{
            for(integer i=0;i<SPMList.size();i++){
                if(SPMList[i].spmSign == true){
                    f1 = true;
                    break;
                }else{
                    f1 = false;
                }
            }           
        }
    }   
    public void SPMadd(){
        SPMList = AddOneRecordHelper.SPMadd(SPMList);
        if(SPMList.size() > ([select id from sellPointMatching__c  where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            SPMList[SPMList.size()-1].tempSPM = true;
            SPMList[SPMList.size()-1].spmSign = true;
        }
        f1 = true;
    }
    public void SPMeditOne(){
        AddOneRecordHelper.SPMedit(row1,SPMList);
        f1 = true;
    }
    public class SPMaddIndex{
        public boolean tempSPM{get;set;}  // fi
        public boolean spmSign{get;set;}  // 单条记录只读
        public Integer index {get;set;}
        public sellPointMatching__c record {get;set;}
        
    }      
    //商务竞争态势表
    public PageReference BCSsave() {   
        AddOneRecordHelper.BCSsave(BCSList);  
        f2 = false;   
        return null;
    }
    public void BCSremove(){
        BCSList = AddOneRecordHelper.BCSremove(row2,BCSList);
        if(BCSList.size() == 0){
            f2 = false;
        }
        if(BCSList.size() > ([select id from businessCompeteStatus__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f2 = true;
        }else{
            for(integer i=0;i<BCSList.size();i++){
                if(BCSList[i].bcsSign == true){
                    f2 = true;
                    break;
                }else{
                    f2 = false;
                }
            } 
        }
    }
    public void BCSadd(){
        BCSList = AddOneRecordHelper.BCSadd(BCSList);
        if(BCSList.size() > ([select id from businessCompeteStatus__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            BCSList[BCSList.size()-1].tempBCS = true;
            BCSList[BCSList.size()-1].bcsSign = true;
        }
        f2 = true;
    }
    public void BCSeditOne(){
        AddOneRecordHelper.BCSedit(row2,BCSList);
        f2 = true;
    }
    public class BCSaddIndex{
        public boolean tempBCS{get;set;}
        public boolean bcsSign{get;set;}
        public Integer index {get;set;}       
        public businessCompeteStatus__c record {get;set;}
    }  
    //技术竞争态势表
    public PageReference TCSsave() {   
        AddOneRecordHelper.TCSsave(TCSList);    
        f3 = false; 
        return null;
    }
    public void TCSremove(){
        TCSList = AddOneRecordHelper.TCSremove(row3,TCSList);
        if(TCSList.size() == 0){
            f3 = false;
        }
        if(TCSList.size() > ([select id from technologyCompeteStatus__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f3 = true;
        }else{
            for(integer i=0;i<TCSList.size();i++){
                if(TCSList[i].tcsSign == true){
                    f3 = true;
                    break;
                }else{
                    f3 = false;
                }
            } 
        }
    }
    public void TCSadd(){
        TCSList = AddOneRecordHelper.TCSadd(TCSList);
        if(TCSList.size() > ([select id from technologyCompeteStatus__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            TCSList[TCSList.size()-1].tempTCS = true;
            TCSList[TCSList.size()-1].tcsSign = true;
        }
        f3 = true;
    }
    public void TCSeditOne(){
        AddOneRecordHelper.TCSedit(row3,TCSList);
        f3 = true;
    }
    public class TCSaddIndex{
        public boolean tempTCS{get;set;}
        public boolean tcsSign{get;set;}
        public Integer index {get;set;}        
        public technologyCompeteStatus__c record {get;set;}
    }
    //行动计划表
    public PageReference APsave() {   
        AddOneRecordHelper.APsave(APList);       
        f4 = false;  
        return null;
    }
    public void APremove(){
        APList = AddOneRecordHelper.APremove(row4,APList);
        if(APList.size() == 0){
            f4 = false;
        }
        if(APList.size() > ([select id from actionPlan__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f4 = true;
        }else{
            for(integer i=0;i<APList.size();i++){
                if(APList[i].apSign == true){
                    f4 = true;
                    break;
                }else{
                    f4 = false;
                }
            } 
        }
    }
    public void APadd(){
        APList = AddOneRecordHelper.APadd(APList);
        if(APList.size() > ([select id from actionPlan__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            APList[APList.size()-1].tempAP = true;
            APList[APList.size()-1].apSign = true;
        }
        f4 = true;
    }
    public void APeditOne(){
        AddOneRecordHelper.APedit(row4,APList);
        f4 = true;
    }
    public class APaddIndex{
        public boolean tempAP{get;set;}
        public boolean apSign{get;set;}
        public Integer index {get;set;}
        public actionPlan__c record {get;set;}
    }
    //谈判计划表
    public PageReference NSsave() {   
        AddOneRecordHelper.NSsave(NSList); 
        f5 = false;   
        return null;
    }
    public void NSremove(){
        NSList = AddOneRecordHelper.NSremove(row5,NSList);
        if(NSList.size() == 0){
            f5 = false;
        }
        if(NSList.size() > ([select id from negotationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f5 = true;
        }else{
            for(integer i=0;i<NSList.size();i++){
                if(NSList[i].nsSign == true){
                    f5 = true;
                    break;
                }else{
                    f5 = false;
                }
            } 
        }
    }
    public void NSadd(){
        NSList = AddOneRecordHelper.NSadd(NSList);
        if(NSList.size() > ([select id from negotationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            NSList[NSList.size()-1].tempNS = true;
            NSList[NSList.size()-1].nsSign = true;
        }
        f5 = true;
    }
    public void NSeditOne(){
        AddOneRecordHelper.NSedit(row5,NSList);
        f5 = true;
    }
    public class NSaddIndex{
        public boolean tempNS{get;set;}
        public boolean nsSign{get;set;}
        public Integer index {get;set;}
        public negotationStrategy__c record {get;set;}
    }
    //商务谈判计划表
    public PageReference BNSsave() {   
        AddOneRecordHelper.BNSsave(BNSList);   
        f6 = false;   
        return null;
    }
    public void BNSremove(){
        BNSList = AddOneRecordHelper.BNSremove(row6,BNSList);
        if(BNSList.size() == 0){
            f6 = false;
        }
        if(BNSList.size() > ([select id from businessNegotiationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f6 = true;
        }else{
            for(integer i=0;i<BNSList.size();i++){
                if(BNSList[i].bnsSign == true){
                    f6 = true;
                    break;
                }else{
                    f6 = false;
                }
            } 
        }
    }
    public void BNSadd(){
        BNSList = AddOneRecordHelper.BNSadd(BNSList);
        if(BNSList.size() > ([select id from businessNegotiationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            BNSList[BNSList.size()-1].tempBNS = true;
            BNSList[BNSList.size()-1].bnsSign = true;
        }
        f6 = true;
    }
    public void BNSeditOne(){
        AddOneRecordHelper.BNSedit(row6,BNSList);
        f6 = true;
    }
    public class BNSaddIndex{
        public boolean tempBNS{get;set;}
        public boolean bnsSign{get;set;}
        public Integer index {get;set;}
        public businessNegotiationStrategy__c record {get;set;}
    }
    //技术谈判计划表
    public PageReference TNSsave() {   
        AddOneRecordHelper.TNSsave(TNSList);   
        f7 = false;  
        return null;
    }
    public void TNSremove(){
        TNSList = AddOneRecordHelper.TNSremove(row7,TNSList);
        if(TNSList.size() == 0){
            f7 = false;
        }
        if(TNSList.size() > ([select id from techniqueNegotiationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            f7 = true;
        }else{
            for(integer i=0;i<TNSList.size();i++){
                if(TNSList[i].tnsSign == true){
                    f7 = true;
                    break;
                }else{
                    f7 = false;
                }
            } 
        }
    }
    public void TNSadd(){
        TNSList = AddOneRecordHelper.TNSadd(TNSList);
        if(TNSList.size() > ([select id from techniqueNegotiationStrategy__c where opportunity__c =:ApexPages.currentPage().getParameters().get('id')].size())){
            TNSList[TNSList.size()-1].tempTNS = true;
            TNSList[TNSList.size()-1].tnsSign = true;
        }
        f7 = true;
    }
    public void TNSeditOne(){
        AddOneRecordHelper.TNSedit(row7,TNSList);
        f7 = true;
    }
    public class TNSaddIndex{
        public boolean tempTNS{get;set;}
        public boolean tnsSign{get;set;}
        public Integer index {get;set;}
        public techniqueNegotiationStrategy__c record {get;set;}
    } 
    //分页
    public PageReference previous(){ //上一页 函数 操作
        pageNumber = pageNumber - 1;  
        if (pageNumber < 0)  
            return null;             
        else{
            getTeamMember(recordId);
        }       
        return null;
    }   
    public PageReference next(){ //下一页 函数 操作
        pageNumber = pageNumber + 1;         
        getTeamMember(recordId);         
        return null;
    }  
    //组织结构图
    public void ContactChartCtrl(ID tempId){ 
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
       
       CList = [Select id,Name,maturity__c,decisionRole__c,buyStyle__c,Department,Phone,Email,workStatus__c,gender__c,Title,ReportsToId,Account.Name,coreCircle__c from Contact  where AccountId = :tempId];
       
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
             return;
          } 
       }
    }
 }