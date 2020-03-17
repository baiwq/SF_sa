trigger EventDelete on Event(before Delete) {
   ID nowUserProfileID = Userinfo.getProfileID();
   ID ProfileID = [Select Id from Profile where Name ='系统管理员' or Name ='System Administrator' limit 1].Id;
   ID nowUser = Userinfo.getUserId();
   for(Event e:trigger.old){
      if(nowUserProfileID != ProfileID){
            e.addError(System.Label.Event_Delete);
      }
   }   
   
}