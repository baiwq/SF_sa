trigger ReturnPoolBeforeInsert on returnPool__c (before insert) {
   SetDefaultValue(Trigger.new);
    
   void SetDefaultValue(List<returnPool__c> LPList){
      List<Account> AList = new List<Account>();
      for(Integer i=0; i< LPList.size(); i++){
         AList = [Select id, Name from Account where name = :LPList[i].accountImport__c limit 1];
         if(AList.size()==1){
            LPList[i].account__c = AList[0].id;
         }
      }
   } 
}