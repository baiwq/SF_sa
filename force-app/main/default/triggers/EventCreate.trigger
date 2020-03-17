//事件的时间不能大于现在时间
trigger EventCreate on Event(before insert) {
   for(Event e:trigger.new){
      if(e.EndDateTime > System.now() && e.finishOrNot__c =='是'){
         e.addError(System.Label.Event_FinishTime);
      }
      
      if(e.finishOrNot__c == '是'){
         e.finishTime__c = System.now();
      }
   }

}