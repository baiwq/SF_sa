public class GetContractStPlanDate{
    public Boolean GetContractStPlanDate(String startDt,String endDt){
        List<Log__c> logList = new List<Log__c>();
        Log__c l = new Log__c();
        String ReturnContractNO = '';
        String ExistContractNO = '';
        List<Contract__c> CListW = new List<Contract__c>(); //定义计算合同质保期变量
        system.debug('endDt----'+endDt);
        try{
            EspFindbytime.ESP_findByTimeSOAP esbObject = new EspFindbytime.ESP_findByTimeSOAP();
            EspFindbytime.SmcOutputRootTYpe returnInfo = new EspFindbytime.SmcOutputRootTYpe();
           	esbObject.timeout_x = 90000;
            returnInfo = esbObject.ESP_findByTime(startDt,endDt);

            if(returnInfo.resultFlag=='S'){
                List<EspFindbytime.contractListType> contractList = returnInfo.contractList;
                if(contractList.size()>0){                
                    Map<String,String> sMap1 = new Map<String,String>();
                    Map<String,String> sMap2 = new Map<String,String>();
                    Map<String,String> sMap3 = new Map<String,String>();
                    Map<String,String> sMap4 = new Map<String,String>();
                    Map<String,String> sMap5 = new Map<String,String>();
                    List<String> conList = new List<String>();
                    for(EspFindbytime.contractListType item:contractList){
                        String contractNo = item.contractNumber;
                        conList.add(contractNo);
                        
                        ReturnContractNO = ReturnContractNO + contractNo;
                        List<String> sList = new List<String>();
                        if(item.debugStartDate!=null){
                            sMap1.put(contractNo,item.debugStartDate.substring(0,10));
                        }
                        if(item.debugFinishDate!=null){
                            sMap2.put(contractNo,item.debugFinishDate.substring(0,10));
                        }
                        if(item.runDate!=null){
                            sMap3.put(contractNo,item.runDate.substring(0,10));
                        }
                        if(item.expectStartDate!=null){
                            sMap4.put(contractNo,item.expectStartDate.substring(0,10));
                        }
                        if(item.expectEndDate!=null){
                            sMap5.put(contractNo,item.expectEndDate.substring(0,10));
                        }
                    }
                    //更新系统
                    List<statusTracking__c> statusList = new List<statusTracking__c>();
                    statusList = [SELECT id,contractNumber__c,debugActualFinish__c,debugFinishActualFinish__c,postActualFinish__c,debugPlanFinish__c,postPlanFinish__c FROM statusTracking__c where contractNumber__c in :conList];
                    if(statusList.size()>0){
                        for(statusTracking__c s:statusList){  
                            ExistContractNO = ExistContractNO + s.contractNumber__c + '; ';
                            
                            if(sMap1.get(s.contractNumber__c)!=null){
                                s.debugActualFinish__c = Date.valueOf(sMap1.get(s.contractNumber__c));
                            }                      
                            if(sMap2.get(s.contractNumber__c)!=null){
                                s.debugFinishActualFinish__c = Date.valueOf(sMap2.get(s.contractNumber__c));
                            }
                            if(sMap3.get(s.contractNumber__c)!=null){
                                s.postActualFinish__c = Date.valueOf(sMap3.get(s.contractNumber__c));
                            }
                            if(sMap4.get(s.contractNumber__c)!=null){
                                s.debugPlanFinish__c = Date.valueOf(sMap4.get(s.contractNumber__c));
                            }
                            if(sMap5.get(s.contractNumber__c)!=null){
                                s.postPlanFinish__c = Date.valueOf(sMap5.get(s.contractNumber__c));
                            }
                        } 
                        update statusList;
                        
                        //重新计算质保期
                        CListW = [Select id, Name from Contract__c where contractNO__c in :conList];
                        new Cal_Warranty_Date().updateWarrantyStageDate(CListW);
                        
                        l = LogClass.reLog('成功','已处理','【获取工程服务信息】成功。开始日期：' + startDt + '，结束日期：' + endDt +' 条数:' + contractList.size() + ' 返回合同号为: ' +  ReturnContractNO + ', SOSP存在合同号为: ' +  ExistContractNO + ',', '正常');
                        logList.add(l);
                     }
                }else{                                      
                    l = LogClass.reLog('成功','已处理','【获取工程服务信息】成功。开始日期：' + startDt + '，结束日期：' + endDt + '，返回的信息列表为空','正常');
                    logList.add(l);
                }
                
            }else{
                LogClass.returnLog('失败','未处理','【获取工程服务信息】Esp返回信息失败。开始日期：' + startDt + '，结束日期：' + endDt + '，失败原因1：' + returnInfo.message,'重要');
                return false;
            }
            LogClass.insertLog(logList);
            return true;
        }catch(Exception e){
            LogClass.returnLog('失败','未处理','【获取工程服务信息】Sosp获取工程服务信息失败。开始日期：' + startDt + '，结束日期：' + endDt + '，失败原因2：' + e.getMessage(),'重要');            
            return false;
        }
        
    }
}