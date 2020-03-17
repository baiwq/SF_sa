global class MonthLastDayCalcFinishAmount implements Schedulable {    
    global void execute(SchedulableContext SC){
        Integer y = System.today().year();//当前年份  
    Integer m = System.today().month();//当前月份
    //月底统计个人回款总金额
    Map<id,Decimal> sMap = new Map<id,Decimal>();
    List<monthStatistics__c> msList = [select idSet__c,sales__c from monthStatistics__c where year__c =:y and month__c =:m and sales__c != null];
    if(msList.size()<1){
        System.debug('无记录');
    }else{
        List<String> sList = msList[0].idSet__c.replace('{','').replace('}','').replace(' ','').split(',');          
        List<AggregateResult> personList = [select contracts__r.deliveryPerson__c,sum(amount__c) from returnItem__c where yearNumber__c =:y and monthNumber__c =:m and contracts__c in:sList group by contracts__r.deliveryPerson__c];  
        if(personList.size()<1) {
            System.debug('无个人记录');
        }else{
            for(AggregateResult ar:personList){
                sMap.put(String.valueOf(ar.get('deliveryPerson__c')),double.valueOf(ar.get('expr0')));
            }
            //System.debug('sMap   '+sMap);
            for(monthStatistics__c ms:msList){
                if(sMap.containsKey(ms.sales__c)){
                    ms.monthFinallyAmount__c = sMap.get(ms.sales__c);
                }
            }
            update msList;
        }
        //月底统计履约省区回款总金额
           
        List<monthStatistics__c> msList2 = [select idSet__c,province__c from monthStatistics__c where year__c =:y and month__c =:m and province__c != null];
        Map<String,Decimal> pMap = new Map<String,Decimal>();
        List<AggregateResult> provinceList = [select contracts__r.deliveryTeamProvince__c,sum(amount__c) from returnItem__c where yearNumber__c =:y and monthNumber__c =:m and contracts__c in:sList group by contracts__r.deliveryTeamProvince__c]; 
        if(provinceList.size()<1 ) {
            System.debug('无省区记录');
        }else{
        for(AggregateResult ar:provinceList){
            pMap.put(String.valueOf(ar.get('deliveryTeamProvince__c')),double.valueOf(ar.get('expr0')));
        }
        //System.debug('pMap   '+pMap);
        for(monthStatistics__c ms:msList2){          
            if(pMap.containsKey(ms.province__c)){
                ms.monthFinallyAmount__c = pMap.get(ms.province__c);
            }
        }
        update msList2;
        }
        //月底统计履约部门回款总金额       
        List<monthStatistics__c> msList3 = [select idSet__c,department__c from monthStatistics__c where year__c =:y and month__c =:m and department__c != null];
        Map<String,Decimal> dMap = new Map<String,Decimal>();
        List<AggregateResult> departmentList = [select contracts__r.deliveryTeamDepartment__c,sum(amount__c) from returnItem__c where yearNumber__c =:y and monthNumber__c =:m and contracts__c in:sList group by contracts__r.deliveryTeamDepartment__c];     
        if(departmentList.size() <1){
            System.debug('无大区记录');
        }else{
        for(AggregateResult ar:departmentList){
            dMap.put(String.valueOf(ar.get('deliveryTeamDepartment__c')),double.valueOf(ar.get('expr0')));
        }
        //System.debug('dMap   '+dMap);
        for(monthStatistics__c ms:msList3){          
            if(dMap.containsKey(ms.department__c)){
                ms.monthFinallyAmount__c = dMap.get(ms.department__c);              
            }
        }        
        update msList3;
        }
        //月底统计履约中心回款总金额       
        List<monthStatistics__c> msList4 = [select idSet__c,center__c from monthStatistics__c where year__c =:y and month__c =:m and center__c != null];
        Map<String,Decimal> cMap = new Map<String,Decimal>();
        List<AggregateResult> centerList = [select contracts__r.deliveryTeamCenter__c,sum(amount__c) from returnItem__c where yearNumber__c =:y and monthNumber__c =:m and contracts__c in:sList group by contracts__r.deliveryTeamCenter__c];     
        if(centerList.size()<1){
            System.debug('无中心记录');
        }else{
        for(AggregateResult ar:centerList){
            cMap.put(String.valueOf(ar.get('deliveryTeamCenter__c')),double.valueOf(ar.get('expr0')));
        }
        //System.debug('cMap   '+cMap);
        for(monthStatistics__c ms:msList4){          
            if(cMap.containsKey(ms.center__c)){
                ms.monthFinallyAmount__c = cMap.get(ms.center__c);              
            }
        }
        update msList4;
        }
    }
    }
    
}