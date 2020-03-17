global class scheduleDateList {
    global class Contract{
        webservice String contractNOC;
        webservice String scheduleDateC;
        webservice String completelyDeliverDateC;
    }
    global class returnCls{
        webservice String success;
        webservice String faultstring;
    }

    webservice static returnCls scheduleDateList(List<Contract> item){
        returnCls cls = new returnCls();
        List<String> suList = new List<String>();
        List<Contract__c> CListW = new List<Contract__c>(); //定义计算合同质保期变量
        try{
            List<String> numList = new List<String>();
            Map<String,Contract> numMap = new Map<String,Contract>();
            Map<String,Contract> delMap = new Map<String,Contract>();
            
            for(Contract c: item){
                numList.add(c.contractNOC);
                numMap.put(c.contractNOC, c);
                delMap.put(c.contractNOC, c);
            }
            
            List<Contract__c> cList = [select id, contractNO__c,scheduleDate__c,completelyDeliverDate__c from Contract__c where contractNO__c in :numList ];
            for(Contract__c cc : cList){
                Contract CObject=numMap.get(cc.contractNO__c);
                if(CObject.scheduleDateC != null){
                    if(!CObject.scheduleDateC.trim().equals('')&&(cc.scheduleDate__c==null||cc.scheduleDate__c.trim().equals(''))){
                        cc.scheduleDate__c = CObject.scheduleDateC.substring(0, 10);
                    }
                    
                } 
               
               //发货日期有值 则不传
                if(CObject.completelyDeliverDateC != null && !CObject.completelyDeliverDateC.trim().equals('') && cc.completelyDeliverDate__c == null){
                    cc.completelyDeliverDate__c = date.valueOf(CObject.completelyDeliverDateC.substring(0, 10));
                }
                delMap.remove(cc.contractNO__c);
                suList.add(cc.contractNO__c);
            }
            if(cList.size()>0){
                update cList;
            } 
            if(delMap.size()>0){
                String str = '';
                for(String key : delMap.keySet()){
                    str=str+','+key;
                }
                String sumContractNo = str.substring(1, str.length()-1);
                cls.success='N';
                cls.faultstring='合同：'+sumContractNo+'同步失败';
                
                String nos ='';
                if(suList.size() > 0){
                   for(String no : suList){
                      nos = nos + no + ',' ;
                   }   
                }
                LogClass.returnLog('成功','已处理','【PS推送排产日期接口】' + ' 成功推送成功合同: ' + nos  + ' 系统找不到合同: '+ sumContractNo ,'正常');
            }else{
                if(suList.size()==item.size()&&suList.size()>0){
                    String nos ='';
                    if(suList.size() > 0){
                       for(String no : suList){
                           nos = nos + no + ',' ;
                       }   
                    }
                    cls.success='S';
                    LogClass.returnLog('成功','已处理','【PS推送排产日期接口】' + ' 成功推送成功合同: ' + nos ,'正常');
                }            
            }
              //重新计算质保期
            CListW = [Select id, Name from Contract__c where contractNO__c in :numList];
            new Cal_Warranty_Date().updateWarrantyStageDate(CListW);
        }catch(Exception e){
            cls.success='F';
            cls.faultstring=e.getMessage();
            LogClass.returnLog('失败','未处理','【PS推送排产日期接口】Sosp返回错误信息：' + e.getMessage(),'重要');
        }
        
        return cls;
    }
}