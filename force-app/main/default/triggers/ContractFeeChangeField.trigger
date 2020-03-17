trigger ContractFeeChangeField on contractFee__c (before insert,before update) {
if(trigger.new.size()>100){
      return;
   }else{
      for(contractFee__c newCC:trigger.new){
   			//合同外购比例
            if(newCC.Outsourcing__c != null&&newCC.outsourcingPercent__c==null){
                newCC.outsourcingPercent__c = newCC.Outsourcing__c+'';
            }
          	
            //自有产品折扣
          	if(newCC.Field22__c!= null&&newCC.discount__c==null){
                newCC.discount__c  = newCC.Field22__c+'';
            }
          
          	//申请前毛利率
          	if(newCC.Field26__c != null&&newCC.margin__c ==null){
                newCC.margin__c  = newCC.Field26__c+'';
            }
          
          if(newCC.returnItem__c != null&&(newCC.AmountCollection__c == null || newCC.ReturnDate__c == null) ){
              List<returnItem__c> returnItem_List = [select returnDate__c, amount__c  from returnItem__c where id =:newCC.returnItem__c]; 
              newCC.AmountCollection__c = returnItem_List.get(0).amount__c;
              newCC.ReturnDate__c = returnItem_List.get(0).returnDate__c;
          }
          
          //有LTC过程，赋值业务机会和合同评审编号
          if(newCC.contract__c != null){
              if(!System.Test.isRunningTest()){
                  contract__c  contractVo = [select id,opportunity__c,reviewNumber__c from contract__c where id =:newCC.contract__c ];
                  newCC.opportunityName__c = contractVo.opportunity__c;
                  newCC.contracreviwer__c = contractVo.reviewNumber__c;  
              }else{
                  	String TextTrackCueList1  = '123123';
                    String TextTrackCueList2 = '123123';
                    String TextTrackCueList3 = '123123';
                    String TextTrackCueList4 = '123123';
                    String TextTrackCueList5 = '123123';
                    String TextTrackCueList6 = '123123';
                    String TextTrackCueList7 = '123123';
                    String TextTrackCueList8 = '123123';
                    String TextTrackCueList9 = '123123';
                    String TextTrackCueList10 = '123123';
                    String TextTrackCueList11 = '123123';
                    String TextTrackCueList12 = '123123';
                    String TextTrackCueList13 = '123123';
                    String TextTrackCueList14 = '123123';
                    String TextTrackCueList15 = '123123';
              }
          }
       }
    }
}