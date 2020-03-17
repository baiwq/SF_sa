public class AddOneRecordHelper {    
    //买点卖点匹配表
    public static List<TopOpportunityCtrl.SPMaddIndex> SPMadd(List<TopOpportunityCtrl.SPMaddIndex> SPMList){
        TopOpportunityCtrl.SPMaddIndex SPMrecord = new TopOpportunityCtrl.SPMaddIndex();
        sellPointMatching__c aa = new sellPointMatching__c();  
        SPMrecord.record = aa;
        SPMrecord.index = SPMList.size();
        SPMList.add(SPMrecord);
        return SPMList;
    }     
    public static void SPMedit(Integer row1,List<TopOpportunityCtrl.SPMaddIndex> SPMList){
        SPMList[row1-1].spmSign = true;        
    }   
    public static List<TopOpportunityCtrl.SPMaddIndex> SPMremove(Integer row1,List<TopOpportunityCtrl.SPMaddIndex> SPMList){                 
        SPMList.remove(row1);
        return SPMList;
    }          
    public static void SPMsave(List<TopOpportunityCtrl.SPMaddIndex> SPMList) {        
        List<sellPointMatching__c> sList = new List<sellPointMatching__c>();
        if(SPMList !=null && !SPMList.isEmpty()){
            for(TopOpportunityCtrl.SPMaddIndex eachRecord:SPMList ){
                sellPointMatching__c SPM = eachRecord.record;
                SPM.opportunity__c = ApexPages.currentPage().getParameters().get('id');
                eachRecord.tempSPM = false;
                eachRecord.spmSign = false;
                sList.add(SPM);                             
            }           
            upsert sList;
        }
        
    }
    //商务竞争态势分析表
    public static List<TopOpportunityCtrl.BCSaddIndex> BCSadd(List<TopOpportunityCtrl.BCSaddIndex> BCSList){
        TopOpportunityCtrl.BCSaddIndex BCSrecord = new TopOpportunityCtrl.BCSaddIndex();
        businessCompeteStatus__c aa = new businessCompeteStatus__c();        
        BCSrecord.record = aa;
        BCSrecord.index = BCSList.size();
        BCSList.add(BCSrecord);
        return BCSList;
    } 
    public static void BCSedit(Integer row2,List<TopOpportunityCtrl.BCSaddIndex> BCSList){
        BCSList[row2-1].bcsSign = true;        
    }  
    public static List<TopOpportunityCtrl.BCSaddIndex> BCSremove(Integer row2,List<TopOpportunityCtrl.BCSaddIndex> BCSList){
        BCSList.remove(row2);
        return BCSList;
    }   
    public static void BCSsave(List<TopOpportunityCtrl.BCSaddIndex> BCSList) {        
        List<businessCompeteStatus__c> sList = new List<businessCompeteStatus__c>();
        if(BCSList !=null && !BCSList.isEmpty()){
            for(TopOpportunityCtrl.BCSaddIndex eachRecord:BCSList ){
                businessCompeteStatus__c BCS = eachRecord.record;
                BCS.opportunity__c = ApexPages.currentPage().getParameters().get('id');
                eachRecord.tempBCS = false;
                eachRecord.bcsSign = false;
                sList.add(BCS);              
            }           
            upsert sList;
        }
    }
    //技术竞争态势分析表
    public static List<TopOpportunityCtrl.TCSaddIndex> TCSadd(List<TopOpportunityCtrl.TCSaddIndex> TCSList){
        TopOpportunityCtrl.TCSaddIndex TCSrecord = new TopOpportunityCtrl.TCSaddIndex();
        technologyCompeteStatus__c aa = new technologyCompeteStatus__c();        
        TCSrecord.record = aa;
        TCSrecord.index = TCSList.size();
        TCSList.add(TCSrecord);
        return TCSList;
    } 
    public static void TCSedit(Integer row3,List<TopOpportunityCtrl.TCSaddIndex> TCSList){
        TCSList[row3-1].tcsSign = true;        
    }
    public static List<TopOpportunityCtrl.TCSaddIndex> TCSremove(Integer row3,List<TopOpportunityCtrl.TCSaddIndex> TCSList){
        TCSList.remove(row3);
        return TCSList;
    }   
    public static void TCSsave(List<TopOpportunityCtrl.TCSaddIndex> TCSList) {        
        List<technologyCompeteStatus__c> sList = new List<technologyCompeteStatus__c>();
        if(TCSList !=null && !TCSList.isEmpty()){
            for(TopOpportunityCtrl.TCSaddIndex eachRecord:TCSList ){
                technologyCompeteStatus__c TCS = eachRecord.record;  
                TCS.opportunity__c = ApexPages.currentPage().getParameters().get('id');  
                eachRecord.tempTCS = false;       
                eachRecord.tcsSign = false;  
                sList.add(TCS);              
            }           
            upsert sList;
        }
    }
    //行动计划表
    public static List<TopOpportunityCtrl.APaddIndex> APadd(List<TopOpportunityCtrl.APaddIndex> APList){
        TopOpportunityCtrl.APaddIndex APrecord = new TopOpportunityCtrl.APaddIndex();
        actionPlan__c aa = new actionPlan__c();        
        APrecord.record = aa;
        APrecord.index = APList.size();
        APList.add(APrecord);
        return APList;
    } 
    public static void APedit(Integer row4,List<TopOpportunityCtrl.APaddIndex> APList){
        APList[row4-1].apSign = true;        
    }
    public static List<TopOpportunityCtrl.APaddIndex> APremove(Integer row4,List<TopOpportunityCtrl.APaddIndex> APList){
        APList.remove(row4);
        return APList;
    }   
    public static void APsave(List<TopOpportunityCtrl.APaddIndex> APList) {        
        List<actionPlan__c> sList = new List<actionPlan__c>();
        if(APList !=null && !APList.isEmpty()){
            for(TopOpportunityCtrl.APaddIndex eachRecord:APList ){
                actionPlan__c AP = eachRecord.record;     
                AP.opportunity__c = ApexPages.currentPage().getParameters().get('id');     
                eachRecord.tempAP = false;   
                eachRecord.apSign = false;  
                sList.add(AP);              
            }           
            upsert sList;
        }
    }
    //谈判计划表
    public static List<TopOpportunityCtrl.NSaddIndex> NSadd(List<TopOpportunityCtrl.NSaddIndex> NSList){
        TopOpportunityCtrl.NSaddIndex NSrecord = new TopOpportunityCtrl.NSaddIndex();
        negotationStrategy__c aa = new negotationStrategy__c();        
        NSrecord.record = aa;
        NSrecord.index = NSList.size();
        NSList.add(NSrecord);
        return NSList;
    } 
    public static void NSedit(Integer row5,List<TopOpportunityCtrl.NSaddIndex> NSList){
        NSList[row5-1].nsSign = true;        
    }
    public static List<TopOpportunityCtrl.NSaddIndex> NSremove(Integer row5,List<TopOpportunityCtrl.NSaddIndex> NSList){
        NSList.remove(row5);
        return NSList;
    }   
    public static void NSsave(List<TopOpportunityCtrl.NSaddIndex> NSList) {        
        List<negotationStrategy__c> sList = new List<negotationStrategy__c>();
        if(NSList !=null && !NSList.isEmpty()){
            for(TopOpportunityCtrl.NSaddIndex eachRecord:NSList ){
                negotationStrategy__c NS = eachRecord.record;  
                NS.opportunity__c = ApexPages.currentPage().getParameters().get('id');    
                eachRecord.tempNS = false;
                eachRecord.nsSign = false;         
                sList.add(NS);              
            }           
            upsert sList;
        }
    }

    //商务谈判计划表
    public static List<TopOpportunityCtrl.BNSaddIndex> BNSadd(List<TopOpportunityCtrl.BNSaddIndex> BNSList){
        TopOpportunityCtrl.BNSaddIndex BNSrecord = new TopOpportunityCtrl.BNSaddIndex();
        businessNegotiationStrategy__c aa = new businessNegotiationStrategy__c();        
        BNSrecord.record = aa;
        BNSrecord.index = BNSList.size();
        BNSList.add(BNSrecord);
        return BNSList;
    } 
    public static void BNSedit(Integer row6,List<TopOpportunityCtrl.BNSaddIndex> BNSList){
        BNSList[row6-1].bnsSign = true;        
    }
    public static List<TopOpportunityCtrl.BNSaddIndex> BNSremove(Integer row6,List<TopOpportunityCtrl.BNSaddIndex> BNSList){
        BNSList.remove(row6);
        return BNSList;
    }   
    public static void BNSsave(List<TopOpportunityCtrl.BNSaddIndex> BNSList) {        
        List<businessNegotiationStrategy__c> sList = new List<businessNegotiationStrategy__c>();
        if(BNSList !=null && !BNSList.isEmpty()){
            for(TopOpportunityCtrl.BNSaddIndex eachRecord:BNSList ){
                businessNegotiationStrategy__c BNS = eachRecord.record;   
                BNS.opportunity__c = ApexPages.currentPage().getParameters().get('id');      
                eachRecord.tempBNS = false; 
                eachRecord.bnsSign = false;           
                sList.add(BNS);              
            }           
            upsert sList;
        }
    }


    //技术谈判计划表
    public static List<TopOpportunityCtrl.TNSaddIndex> TNSadd(List<TopOpportunityCtrl.TNSaddIndex> TNSList){
        TopOpportunityCtrl.TNSaddIndex TNSrecord = new TopOpportunityCtrl.TNSaddIndex();
        techniqueNegotiationStrategy__c aa = new techniqueNegotiationStrategy__c();        
        TNSrecord.record = aa;
        TNSrecord.index = TNSList.size();
        TNSList.add(TNSrecord);
        return TNSList;
    } 
    public static void TNSedit(Integer row7,List<TopOpportunityCtrl.TNSaddIndex> TNSList){
        TNSList[row7-1].tnsSign = true;        
    }
    public static List<TopOpportunityCtrl.TNSaddIndex> TNSremove(Integer row7,List<TopOpportunityCtrl.TNSaddIndex> TNSList){
        TNSList.remove(row7);
        return TNSList;
    }      
    public static void TNSsave(List<TopOpportunityCtrl.TNSaddIndex> TNSList) {        
        List<techniqueNegotiationStrategy__c> sList = new List<techniqueNegotiationStrategy__c>();
        if(TNSList !=null && !TNSList.isEmpty()){
            for(TopOpportunityCtrl.TNSaddIndex eachRecord:TNSList ){
                techniqueNegotiationStrategy__c TNS = eachRecord.record;     
                TNS.opportunity__c = ApexPages.currentPage().getParameters().get('id');  
                eachRecord.tempTNS = false;      
                eachRecord.tnsSign = false; 
                sList.add(TNS);              
            }           
            upsert sList;
        }
    }
}