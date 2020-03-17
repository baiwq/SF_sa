trigger TempGetPayment on Product2 (before update) {

  /* 
   String beginning = trigger.new[0].companyCode__c;
   Integer k = Integer.ValueOf(beginning.substring(6,beginning.length()));
   
   Set<String> sSet = new Set<String>();
   for(Integer i=0; i<31; i++){
      String tempName = 'SC2000' + Y(k+i);
      sSet.add(tempName);
   }
   
   
   List<Contract__c> CList = [SELECT id, returnAmount__c from Contract__c where Name in :sSet limit 31];
   if(CList.size() > 0){
      FuncPools fp = new FuncPools();
      for(Contract__c ctemp: CList){
         fp.SyncPayment(ctemp.id,ctemp.returnAmount__c);
      }
   }
   trigger.new[0].companyCode__c = 'SC2000' + Y(k +31);
   
   
   String Y(Integer u){
   String KK = String.valueOf(u);
   if(KK.length()==1){
      return '000' + KK;
   }if(KK.length()==2){
      return '00' + KK;
   }if(KK.length()==3){
      return '0' + KK;
   }if(KK.length()==4){
      return KK;
   }else{
      return 'KK';
   }
}
*/
}