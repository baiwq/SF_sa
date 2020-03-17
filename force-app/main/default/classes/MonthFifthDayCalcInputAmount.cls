global class MonthFifthDayCalcInputAmount implements Schedulable {

    global void execute(SchedulableContext SC){
    
        Integer y = System.today().year();//当前年份  
        Integer m = System.today().month();//当前月份
        String idSetString = '';//合同ID
        
        List<paymentTerm__c> pList = [select id,contract__c from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m];
        for(paymentTerm__c pa:pList){
            idSetString = idSetString + ',' + pa.contract__c;
        }      
        
        List<monthStatistics__c> msList = new List<monthStatistics__c>();              
        List<AggregateResult> salesList = [select contract__r.deliveryPerson__c,sum(inputAmount__c) from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m group by contract__r.deliveryPerson__c];
        //System.debug('saleslist   '+ saleslist);  
        
        for(AggregateResult s:salesList){
            if(s.get('deliveryPerson__c') != null){
                monthStatistics__c ms = new monthStatistics__c();
                ms.sales__c = String.valueOf(s.get('deliveryPerson__c'));
                ms.monthFifthAmount__c = double.valueOf(s.get('expr0'));
                ms.year__c = y;
                ms.month__c = m;
                ms.idSet__c = idSetString;
                msList.add(ms);
            }
        }
        //System.debug('msList   '+ msList);    
        List<AggregateResult> provinceList = [select contract__r.deliveryTeamProvince__c,sum(inputAmount__c) from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m group by contract__r.deliveryTeamProvince__c];
        for(AggregateResult s:provinceList){
            if(s.get('deliveryTeamProvince__c') != null){
                monthStatistics__c ms = new monthStatistics__c();
                ms.province__c = String.valueOf(s.get('deliveryTeamProvince__c'));
                ms.monthFifthAmount__c = double.valueOf(s.get('expr0'));
                ms.year__c = y;
                ms.month__c = m;
                ms.idSet__c = idSetString;
                msList.add(ms);
            }
        } 
        List<AggregateResult> departmentList = [select contract__r.deliveryTeamDepartment__c,sum(inputAmount__c) from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m group by contract__r.deliveryTeamDepartment__c];
        for(AggregateResult s:departmentList){
            if(s.get('deliveryTeamDepartment__c') != null){
                monthStatistics__c ms = new monthStatistics__c();
                ms.department__c = String.valueOf(s.get('deliveryTeamDepartment__c'));
                ms.monthFifthAmount__c = double.valueOf(s.get('expr0'));
                ms.year__c = y;
                ms.month__c = m;
                ms.idSet__c = idSetString;
                msList.add(ms);
            }
        } 
        List<AggregateResult> centerList = [select contract__r.deliveryTeamCenter__c,sum(inputAmount__c) from paymentTerm__c where yearNumber__c =:y and monthNumber__c =:m group by contract__r.deliveryTeamCenter__c];       
        for(AggregateResult s:centerList){
            if(s.get('deliveryTeamCenter__c') != null){
                monthStatistics__c ms = new monthStatistics__c();
                ms.center__c = String.valueOf(s.get('deliveryTeamCenter__c'));
                ms.monthFifthAmount__c = double.valueOf(s.get('expr0'));
                ms.year__c = y;
                ms.month__c = m;
                ms.idSet__c = idSetString;
                msList.add(ms);
            }
        } 
        //System.debug('msList   '+ msList); 
        insert msList;
     
    }
    
}