trigger PlanAndExeStatusDetele on PlanAndExeStatus__c (before Delete) {
   for(PlanAndExeStatus__c pe:Trigger.old){
      if(pe.Cant_Be_Delete__c){
         pe.addError(System.Label.PlanExe_Delete);
      }
   }
}