trigger EventUpdate on Event (before update){
   for(Event e:trigger.new){
      Event eOld = Trigger.OldMap.get(e.id);
      if(e.EndDateTime > System.now() && e.finishOrNot__c =='是'){
         e.addError(System.Label.Event_FinishTime);
      }
      if(e.finishOrNot__c != eOld.finishOrNot__c && e.finishOrNot__c == '是'){
         e.finishTime__c = System.now();
      }
      ID nowUserProfileID = Userinfo.getProfileID();
      ID nowUser = Userinfo.getUserId();
      ID ProfileID = [Select Id from Profile where Name ='系统管理员' or Name ='System Administrator' limit 1].Id;
      if(nowUserProfileID != ProfileID){
         if(nowUser != e.OwnerId){
            e.addError(System.Label.Event_ModifyOthers);
         }
      }
   }
}