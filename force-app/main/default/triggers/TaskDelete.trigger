trigger TaskDelete on Task(before Delete) {

   ID nowUserProfileID = Userinfo.getProfileID();
   ID ProfileID = [Select Id from Profile where Name ='系统管理员' or Name ='System Administrator' limit 1].Id;
   for(Task t:trigger.old){
      if(nowUserProfileID != ProfileID){
         t.addError(System.Label.Task_Delete);
      }
   }
}