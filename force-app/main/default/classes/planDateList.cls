/*
 * Block comments with details of changes
 *  修改:任艳新 2018-5-8 接口新增字段“项目开工点”
 *  修改:任艳新 2018-5-18 修改如果出过来字段值为空时赋值空 
 */
global class planDateList
{
    global class statusTracking{
        webService String contractNoc;
        webService String designPlanFinish;
        webService String designActualFinish;
        webService String devicePlanFinish;
        webService String deviceActualFinish;
        webService String buyPlanFinish;
        webService String buyActualFinish;
        webService String paperPlanFinish;
        webService String paperActualFinish;

        webService String deviceGonePlanFinish;
        webService String deviceGoneActualFinish;
        webService String buyGonePlanFinish;
        webService String buyGoneActualFinish;
        webService String cabinetPlanFinish;
        webService String cabinetActualFinish;

        webService String sendPlanFinish;
        webService String sendActualFinish;
        webService String sendFinishPlanFinish;
        webService String sendFinishActualFinish;
        webService String factoryPlanFinished;
        webService String factoryActualFinished;
        
        //新增字段项目开工点2018-5-8 By 任艳新
        webservice String projectWorkingDate;
    }
    
    global class returnCls{
        webService String success;
        webService String faultstring;
    }
    
    webservice static returnCls planDateList(List<statusTracking> item){
        returnCls cls = new returnCls();
        List<String> suList = new List<String>();
        
        List<Contract__c> CListW = new List<Contract__c>(); //定义计算合同质保期变量
        try{     
            List<String> tConList = new List<String>();
            
            Map<String,statusTracking>  tMap= new Map<String,statusTracking>();
            for(statusTracking m:item){     
                tConList.add(m.contractNoc);
                tMap.put(m.contractNoc,m);
            }
            
            //计算合同质保期
            CListW = [Select id, Name from Contract__c where contractNO__c in :tConList];
            
            
            List<statusTracking__c> sConList = new List<statusTracking__c>();
            sConList = [select id,contractNumber__c,designPlanFinish__c,designActualFinish__c,devicePlanFinish__c,deviceActualFinish__c,
                        buyPlanFinish__c,buyActualFinish__c,paperPlanFinish__c,paperActualFinish__c,deviceGonePlanFinish__c,
                        deviceGoneActualFinish__c,buyGonePlanFinish__c,buyGoneActualFinish__c,cabinetPlanFinish__c,cabinetActualFinish__c,
                        sendPlanFinish__c,sendActualFinish__c,sendFinishPlanFinish__c,sendFinishActualFinish__c,factoryPlanFinished__c,
                        factoryActualFinished__c,projectWorkingDate__c from statusTracking__c where contractNumber__c in :tConList];
            for(statusTracking__c s:sConList){    
                statusTracking ssObject = tMap.get(s.contractNumber__c);
                if(ssObject.designPlanFinish != null&&ssObject.designPlanFinish.trim() !=''){
                    s.designPlanFinish__c = date.valueOf(ssObject.designPlanFinish);    
                }else{
                    s.designPlanFinish__c = null;
                }
                if(ssObject.designActualFinish != null&&ssObject.designActualFinish.trim() != ''){
                    s.designActualFinish__c = date.valueOf(ssObject.designActualFinish);
                }else{
                    s.designActualFinish__c =null;
                }
                if(ssObject.devicePlanFinish != null&&ssObject.devicePlanFinish.trim() !=''){
                    s.devicePlanFinish__c = date.valueOf(ssObject.devicePlanFinish);
                }else{
                    s.devicePlanFinish__c = null;
                }
                if(ssObject.deviceActualFinish != null &&ssObject.deviceActualFinish.trim() !=''){
                    s.deviceActualFinish__c = date.valueOf(ssObject.deviceActualFinish);
                }else{
                    s.deviceActualFinish__c = null;
                }
                if(ssObject.buyPlanFinish != null&&ssObject.buyPlanFinish.trim() != ''){
                    s.buyPlanFinish__c = date.valueOf(ssObject.buyPlanFinish);
                }else{
                    s.buyPlanFinish__c = null;
                }
                if(ssObject.buyActualFinish != null&&ssObject.buyActualFinish.trim() != ''){
                    s.buyActualFinish__c = date.valueOf(ssObject.buyActualFinish);
                }else{
                    s.buyActualFinish__c = null;
                }
                if(ssObject.paperPlanFinish != null&&ssObject.paperPlanFinish.trim() != ''){
                    s.paperPlanFinish__c = date.valueOf(ssObject.paperPlanFinish);
                }else{
                    s.paperPlanFinish__c = null;
                }
                if(ssObject.paperActualFinish != null&&ssObject.paperActualFinish.trim() != ''){
                    s.paperActualFinish__c = date.valueOf(ssObject.paperActualFinish);
                }else{
                    s.paperActualFinish__c = null;
                }
                if(ssObject.deviceGonePlanFinish != null&&ssObject.deviceGonePlanFinish.trim() != ''){
                    s.deviceGonePlanFinish__c = date.valueOf(ssObject.deviceGonePlanFinish);
                }else{
                    s.deviceGonePlanFinish__c = null;
                }
                if(ssObject.deviceGoneActualFinish != null&&ssObject.deviceGoneActualFinish.trim() != ''){
                    s.deviceGoneActualFinish__c = date.valueOf(ssObject.deviceGoneActualFinish);
                }else{
                    s.deviceGoneActualFinish__c = null;
                }
                if(ssObject.buyGonePlanFinish != null&&ssObject.buyGonePlanFinish.trim() != ''){
                    s.buyGonePlanFinish__c = date.valueOf(ssObject.buyGonePlanFinish);
                }else{
                    s.buyGonePlanFinish__c = null;
                }
                if(ssObject.buyGoneActualFinish != null&&ssObject.buyGoneActualFinish.trim() != ''){
                    s.buyGoneActualFinish__c = date.valueOf(ssObject.buyGoneActualFinish);
                }else{
                    s.buyGoneActualFinish__c = null;
                }

                if(ssObject.cabinetPlanFinish != null&&ssObject.cabinetPlanFinish.trim() != ''){
                    s.cabinetPlanFinish__c = date.valueOf(ssObject.cabinetPlanFinish);
                }else{
                    s.cabinetPlanFinish__c = null;
                }
                if(ssObject.cabinetActualFinish != null&&ssObject.cabinetActualFinish.trim() != ''){
                    s.cabinetActualFinish__c = date.valueOf(ssObject.cabinetActualFinish);
                }else{
                    s.cabinetActualFinish__c = null;
                }
                if(ssObject.sendPlanFinish != null&&ssObject.sendPlanFinish.trim() != ''){
                    s.sendPlanFinish__c = date.valueOf(ssObject.sendPlanFinish);
                }else{
                    s.sendPlanFinish__c = null;
                }
                if(ssObject.sendActualFinish != null&&ssObject.sendActualFinish.trim() != ''){
                    s.sendActualFinish__c = date.valueOf(ssObject.sendActualFinish);
                }else{
                    s.sendActualFinish__c = null;
                }
                if(ssObject.sendFinishPlanFinish != null&&ssObject.sendFinishPlanFinish.trim() != ''){
                    s.sendFinishPlanFinish__c = date.valueOf(ssObject.sendFinishPlanFinish);
                }else{
                    s.sendFinishPlanFinish__c = null;
                }
                if(ssObject.sendFinishActualFinish != null&&ssObject.sendFinishActualFinish.trim() != ''){
                    s.sendFinishActualFinish__c = date.valueOf(ssObject.sendFinishActualFinish);
                }else{
                    s.sendFinishActualFinish__c = null;
                }
                if(ssObject.factoryPlanFinished != null&&ssObject.factoryPlanFinished.trim() != ''){
                    s.factoryPlanFinished__c = date.valueOf(ssObject.factoryPlanFinished);
                }else{
                    s.factoryPlanFinished__c = null;
                }
                if(ssObject.factoryActualFinished != null&&ssObject.factoryActualFinished.trim() != ''){
                    s.factoryActualFinished__c = date.valueOf(ssObject.factoryActualFinished);
                }else{
                    s.factoryActualFinished__c = null;
                }
                if(ssObject.projectWorkingDate != null&&ssObject.projectWorkingDate.trim()!=''){
                    s.projectWorkingDate__c = date.valueOf(ssObject.projectWorkingDate);
                }else{
                    s.projectWorkingDate__c = null;
                }
                suList.add(s.contractNumber__c);
            }
            update sConList;
            new Cal_Warranty_Date().updateWarrantyStageDate(CListW);
            cls.success = 'S';
        }
        catch(Exception e){
            cls.success = 'F';
            cls.faultstring = e.getMessage();
            LogClass.returnLog('失败','未处理','【PS推送履约执行状态】' + e.getMessage(),'重要');
        }
        String NoStep = '';
        if(suList.size()>0){
            for(String no : suList){
               NoStep =  NoStep + no + ';';
            } 
            LogClass.returnLog('成功','已处理','【PS推送履约执行状态】' + '合同号:'+ NoStep,'正常');    
        }
        return cls;
    }
}