trigger TaskUpdate on Task (before Update) {
   for(Task t:trigger.new){
     ID nowUser = Userinfo.getUserId();
     ID nowUserProfileID = Userinfo.getProfileID();
     ID ProfileID = [Select Id from Profile where Name ='系统管理员' or Name ='System Administrator' limit 1].Id;
     if(nowUserProfileID != ProfileID){
         if(nowUser != t.OwnerId){
            t.addError(System.Label.Task_ModifyOthers);
         }
      }
   }
}