trigger MonthPlanAutoCreate on monthlyPlan__c (after insert) {
    List<PlanAndExeStatus__c> PESList = new List<PlanAndExeStatus__c>();
    ID RecordTypeID_Contract = [SELECT Id, Name, DeveloperName from recordtype where SobjectType=:'PlanAndExeStatus__c' and Name=:'财务类 合同'].id;
    ID RecordTypeID_Return = [SELECT Id, Name, DeveloperName from recordtype where SobjectType=:'PlanAndExeStatus__c' and Name=:'财务类 回款'].id;
    for(monthlyPlan__c mp:trigger.new){
       PESList.add(new PlanAndExeStatus__c(name = '财务类 合同', type__c = '财务管理-合同', Monthplan__c = mp.id, recordtypeid = RecordTypeID_Contract, Cant_Be_Delete__c = true, contractOrReturn__c = '合同'));
       PESList.add(new PlanAndExeStatus__c(name = '财务类 回款', type__c = '财务管理-回款', Monthplan__c = mp.id, recordtypeid = RecordTypeID_Return,  Cant_Be_Delete__c = true, contractOrReturn__c = '回款'));
    }
    insert PESList;
}