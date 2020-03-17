global class shippingInfo {
    global class Shipping{
        webservice String contractNumberC;
        webservice String applyStatusCodeC;
        webservice String approvalDateC;
    }
    public List<Shipping> shipList{get;set;}
    global class getList{
        webservice List<Shipping> item;
        String stemp =''; //日志备注
        public getList(String startDtime,String endDtime){
            try{
                Datetime sTime =Datetime.valueOf(startDtime);
                Datetime eTime = Datetime.valueOf(endDtime);
                List<String> idList=new List<String>();  //时间段内 所有合同号
                List<String> ContractNoList = new List<String>();  //时间段内 所有合同号
                List<AggregateResult> c=[SELECT contracts__c from shipping__c where approvalDate__c >=:sTime and approvalDate__c <=:eTime group by contracts__c];
                for(AggregateResult ar:c){
                    idList.add(String.valueOf(ar.get('contracts__c')));
                }
                
                List<AggregateResult> AB=[SELECT contracts__c,count(id) from shipping__c where approvalDate__c >=:sTime and approvalDate__c <=:eTime and contracts__c in :idList group by contracts__c];
                Map<String,String> ma = new Map<String,String>(); // 合同号<-> 发货申请次数值
                for(AggregateResult a : AB){
                    ma.put(String.valueOf(a.get('contracts__c')), String.valueOf(a.get('expr0')));
                }
                
                List<shipping__c> sList = [select Name, contracts__c, contractNumber__c, approvalDate__c from shipping__c where approvalDate__c >= :sTime and approvalDate__c <= :eTime order by approvalDate__c desc];
                item = new List<Shipping>();
                Map<String,String> m = new Map<String,String>();
                for(shipping__c s : sList){
                    stemp = stemp + s.contractNumber__c + ';';
                    System.Debug('DDD:' + stemp);
                    if(!m.containsKey(s.contractNumber__c)){
                        Shipping sh = new Shipping();
                        sh.contractNumberC=s.contractNumber__c;
                        sh.applyStatusCodeC=ma.get(s.contracts__c);
                        sh.approvalDateC=s.approvalDate__c.format('yyyy-MM-dd kk:mm:ss');
                        item.add(sh);
                        m.put(s.contractNumber__c,s.Name);
                    }                    
                }
                System.Debug('CCCC:' + stemp);
                LogClass.returnLog('成功','已处理','【PS获取发货申请信息】：开始时间'+ startDtime +' 结束时间：' + endDtime + '正常.合同号为: ' + stemp, '正常');  
            }catch(Exception e){
                LogClass.returnLog('失败','未处理',e.getMessage(),'重要');
            }
        }
    }

    webservice static getList queryShipping(String startDtime,String endDtime){
        getList shipping = new getList( startDtime, endDtime);   
        return shipping;
    }
}