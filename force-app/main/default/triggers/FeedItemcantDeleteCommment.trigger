trigger FeedItemcantDeleteCommment on FeedComment (before delete) {
    for(FeedComment fi:trigger.old){
       Profile p = [Select id from Profile where name =:'System Administrator' or name = :'系统管理员' limit 1];
       if(p.id != Userinfo.getProfileId()){
           fi.addError(System.Label.Chatter_DeleteComments);
       }
    }
}