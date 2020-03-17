public with sharing class Cal_StagePayment_Controller{
    public String conNumValue{get;set;}
    public String info{get;set;}    
    public void calculateStagePayment(){      
        String[] strs= conNumValue.subString(0,conNumValue.length()).split(',');
        Cal_StagePayment(strs);             
    }  
    public void Cal_StagePayment(List<String> conNumber){
    try{
        List<Contract__c> ContractALL= [Select id, (Select id, percentage__c, stage__c, contract__c, collectionAmount__c, backMoney__c, returnAmount__c, 
                                surplusMoney__c, No__c from MScontractPayment__r order by No__c) from Contract__c where  Name in:conNumber or oldContractNumber__c in:conNumber];//根据合同号查询合同信息和付款阶段信息
        List<PaymentTerm__c> ptList = new List<PaymentTerm__c>();//一条合同下的 付款条件信息
        List<PaymentTerm__c> ptListALL = new List<PaymentTerm__c>();//所有合同下的 付款条件信息
        Decimal tempAmount;// 金额临时变量  
        for(Contract__c ctemp:ContractALL){
             ptList = ctemp.MScontractPayment__r;
             tempAmount = ctemp.MScontractPayment__r[0].returnAmount__c;
             for(Integer b = 0;b < ptList.size(); b++){
                if(ptList[b].collectionAmount__c == 0){
                   ptList[b].backMoney__c = 0;
                   ptList[b].collectionStatus__c = '已回款';
                   
                }
                if(tempAmount == 0){
                   ptList[b].backMoney__c = 0;
                   ptList[b].collectionStatus__c = '未回款';
                }else if(tempAmount >= ptList[b].collectionAmount__c){   
                   ptList[b].backMoney__c = ptList[b].collectionAmount__c;
                   tempAmount = tempAmount - ptList[b].collectionAmount__c;
                   ptList[b].collectionStatus__c = '已回款';
                }else if(tempAmount < ptList[b].collectionAmount__c){
                   ptList[b].backMoney__c = tempAmount;
                   tempAmount = 0;
                   ptList[b].collectionStatus__c = '回款中';
                }
                ptListALL.add(ptList[b]);//存放所有的付款条件信息。
             }
         }
         update ptListALL; 
         if(ptListALL.size()>0){
             info='重新计算付款阶段金额成功';
         }else{
             info='计算失败，请检查输入的合同号格式是否正确';
         }
         }catch(exception e){
             Apexpages.addMessage(new ApexPages.Message (ApexPages.Severity.FATAL,String.ValueOf(e)));
         }
   }
}