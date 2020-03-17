trigger CommisionInsertAutoCreateMember on commisionSplit__c (after insert) {
   for(commisionSplit__c CS:trigger.new){
      if(cs.OpportunityRecordType__c=='备品备件'||cs.OpportunityRecordType__c=='小额订单'){
      
      }else{
          List<OpportunityTeamMember> OTList = [Select id, UserId from OpportunityTeamMember where OpportunityId = :CS.opportunity__c and (TeamMemberRole like :'%销售经理' or TeamMemberRole like :'%Sales Manager')];
          List<commisionUser__c> CUList = new List<commisionUser__c>();
          if(OTList.size() > 0){
             for(OpportunityTeamMember ot:OTList){
                CUList.add(new commisionUser__c(commisionSplit__c = CS.id, member__c = ot.UserId));
             } 
             insert CUList;
          }else{
             CS.addError(System.Label.CommisionUser_T);
          }
      }
       
      Opportunity OpportunityVo = [Select id,MainIndustrySales__c  from Opportunity where id =:CS.opportunity__c ];
       if(OpportunityVo.MainIndustrySales__c != null){
           IndustryProportion__c  IndustryProportionVo = new IndustryProportion__c();
           IndustryProportionVo.commisionSplit__c  = CS.id;
           IndustryProportionVo.Allocation__c = 100;
           IndustryProportionVo.MainIndustrySales__c = OpportunityVo.MainIndustrySales__c ;
           insert IndustryProportionVo;
       }

   }
}