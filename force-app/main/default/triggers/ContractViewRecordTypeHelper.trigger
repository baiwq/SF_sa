trigger ContractViewRecordTypeHelper on contractreview__c (before insert) {
   for(contractreview__c cv:Trigger.new){
        User createdby = [Select id,center__c,department__c,Province__c from User  where id=:UserInfo.getUserId()];
        if(cv.DeliveryPerson__c==null){
            cv.DeliveryPerson__c=createdby.Id;
            cv.DeliveryTeamCenter__c = createdby.center__c;
            cv.DeliveryTeamDepartment__c = createdby.department__c;
            cv.DeliveryTeamProvince__c = createdby.Province__c;
        }else{
            cv.DeliveryTeamCenter__c = createdby.center__c;
            cv.DeliveryTeamDepartment__c = createdby.department__c;
            cv.DeliveryTeamProvince__c = createdby.Province__c;
        }

        if(cv.AccountManager__c==null){
            cv.AccountManager__c = createdby.Id;
            cv.SalesTeamCenter__c = createdby.center__c;
            cv.SalesTeamDepartment__c = createdby.department__c;
            cv.SalesTeamProvince__c = createdby.Province__c;
        }else{
            cv.SalesTeamCenter__c = createdby.center__c;
            cv.SalesTeamDepartment__c = createdby.department__c;
            cv.SalesTeamProvince__c = createdby.Province__c;
        }

        if(cv.SignedBy__c==null){
            cv.SignedBy__c = createdby.Id;
            cv.SignTeamCenter__c = createdby.center__c;
            cv.SignTeamDepartment__c = createdby.department__c;
            cv.SignTeamProvince__c = createdby.Province__c;
        }else{
            cv.SignTeamCenter__c = createdby.center__c;
            cv.SignTeamDepartment__c = createdby.department__c;
            cv.SignTeamProvince__c = createdby.Province__c;
        }

        if(cv.SalesCenter__c==null){
            cv.SalesCenter__c = createdby.center__c;
            cv.SalesDepartment__c = createdby.department__c;
            cv.SalesProvince__c = createdby.Province__c;
        }else{
            cv.SalesDepartment__c = createdby.department__c;
            cv.SalesProvince__c = createdby.Province__c;
        }
   
      if(cv.quatation__c!=null){
          quatation__c qua = [select id, CIHEMaterialCost__c, SPSEMaterialCost__c, RPCEMaterialCost__c, NPCBMaterialCost__c, PCBMaterialCost__c, NIHEMaterialCost__c, Packaging__c, Freight__c,OtherCost__c
                                        ,CIHEBidCost__c, SPSEBidCost__c, RPCEBidCost__c, NPCBBidCost__c, PCBBidCost__c, NIHEBidCost__c
                                        from quatation__c where id=:cv.quatation__c limit 1][0];
          if(cv.CIHEMaterialCost__c==null||cv.CIHEMaterialCost__c==0){
              cv.CIHEMaterialCost__c=qua.CIHEMaterialCost__c;
          }
          if(cv.SPSEMaterialCost__c==null||cv.SPSEMaterialCost__c==0){
              cv.SPSEMaterialCost__c=qua.SPSEMaterialCost__c;
          }
          if(cv.RPCEMaterialCost__c==null||cv.RPCEMaterialCost__c==0){
              cv.RPCEMaterialCost__c=qua.RPCEMaterialCost__c;
          }
          if(cv.NPCBMaterialCost__c==null||cv.NPCBMaterialCost__c==0){
              cv.NPCBMaterialCost__c=qua.NPCBMaterialCost__c;
          }
          if(cv.PCBMaterialCost__c==null||cv.PCBMaterialCost__c==0){
              cv.PCBMaterialCost__c=qua.PCBMaterialCost__c;
          }
          if(cv.NIHEMaterialCost__c==null||cv.NIHEMaterialCost__c==0){
              cv.NIHEMaterialCost__c=qua.NIHEMaterialCost__c;
          }
          if(cv.Packaging__c==null||cv.Packaging__c==0){
              cv.Packaging__c=qua.Packaging__c;
          }
          if(cv.Freight__c==null||cv.Freight__c==0){
              cv.Freight__c=qua.Freight__c;
          }
          if(cv.OtherCost__c==null||cv.OtherCost__c==0){
              cv.OtherCost__c=qua.OtherCost__c;
          }
          if(cv.CIHEBidCost__c==null||cv.CIHEBidCost__c==0){
              cv.CIHEBidCost__c=qua.CIHEBidCost__c;
          }
          if(cv.SPSEBidCost__c==null||cv.SPSEBidCost__c==0){
              cv.SPSEBidCost__c=qua.SPSEBidCost__c;
          }
          if(cv.RPCEBidCost__c==null||cv.RPCEBidCost__c==0){
              cv.RPCEBidCost__c=qua.RPCEBidCost__c;
          }
          if(cv.NPCBBidCost__c==null||cv.NPCBBidCost__c==0){
              cv.NPCBBidCost__c=qua.NPCBBidCost__c;
          }
          if(cv.PCBBidCost__c==null||cv.PCBBidCost__c==0){
              cv.PCBBidCost__c=qua.PCBBidCost__c;
          }
          if(cv.NIHEBidCost__c==null||cv.NIHEBidCost__c==0){
              cv.NIHEBidCost__c=qua.NIHEBidCost__c;
          }
      }
      String DevelopName = [Select id,DeveloperName from RecordType where Id =:cv.RecordTypeId and SobjectType=:'contractreview__c'].DeveloperName;
      System.Debug('DevelopName:' + DevelopName);
      if(DevelopName == 'RecordType1'){
          if(cv.isUpdate__c =='需要修改') 
              DevelopName = 'RecordType1Update';
          else
              DevelopName = 'RecordType1ReadOnly';
      }else if(DevelopName == 'RecordType2'){
          if(cv.isUpdate__c =='需要修改') 
              DevelopName = 'RecordType2Update';
          else
              DevelopName = 'RecordType2ReadOnly';
      }
      
      cv.RecordTypeId = [Select id from RecordType where DeveloperName =:DevelopName and SobjectType=:'contractreview__c'].id;
      
    }
}