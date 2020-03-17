public class QueryContractFee {

     public List<AchivementRecognization__c> AchivementList{get;set;}

    public QueryContractFee(ApexPages.StandardController controller) {
      
        ID RecordId = ApexPages.currentPage().getParameters().get('id');
        try{
            contractFee__c  ContractFee= [select Field31__c, Field15__c, Field16__c, amountFee__c, receivetim__c, To90time__c, owner__c, opportunityName__c, opportunityOwner__c, number__c, center__c, divisionalLeader__c, centerCost__c, cetrefee__c, other__c, productType__c, tpe__c, paymentbond__c, paymentType__c, paymentbondscore__c, agreementNumber__c, agency__c, agencyPayment__c, goodContract__c, goodContractAmount__c, place__c, stay__c, trainAmount__c, trainStandardAmount__c, TOP__c, account1__c, accept__c, accceptAmount__c, divisionalLeaderCost__c, subcenterFee__c, unload__c, unloadAmount__c, OldContract__c, completelyDeliverDate__c, contractName__c, outsourcingPercent__c, contractReceive__c, contractaccept__c, contractRate__c, Field28__c, contract__c, returnProportion__c, contracreviwer__c, Field27__c, estimateDeliverDate__c, discount__c, othershoulders__c, borrower__c, explain2__c, outsourcingSGAmount__c, outsourcingStandardSGAmount__c, outsourcingAmount__c, outsourcingServiceAmount__c, outsourcingServiceStandardAmount__c, outsourcingStandardAmount__c, Outsourcing__c, install__c, installAmount__c, Field34__c, Field35__c, approveState__c, approveTime__c, account__c, accountcredit__c, Field29__c, accountType__c, accountnumber__c, projectCategory__c, marketing__c, target__c, Field33__c, cost__c, reason__c, costAmount__c, center1__c, department__c, Provice__c, profile__c, technicalservices__c, technicalserviceAmount__c, amount__c, quotation__c, bidtype__c, paymentPercentage__c, specifyAmount__c, operation__c, operationAmount__c, Field1__c, travel__c, detection__c, detectionAmount__c, starttime__c, city__c, province__c, activity__c, endtime__c, SpecialProductBiddingPrice__c, SpecialProductStandardPrice__c, executeAmount__c, ApplyReason__c, CostAaccumulation__c, margin__c, Field26__c, margin1__c, Field7__c, provincialCost__c, Field9__c, Field30__c, Field22__c, productAmount__c, productStandardAmount__c, softAmount__c, softStandardAmount__c, kaohe__c, SL__c, SLF__c, guaranteePeriod__c, Field23__c, Field24__c, Field21__c, Field36__c, Field32__c, Field5__c, Field6__c, Field11__c, purchaser__c, Field10__c, Field14__c, Field25__c, ZONG__c, Field19__c, standardAmount__c, Projecttype__c, Field20__c, expectAmount__c, predictContractAmount__c, margin2__c, serve__c, HAmount__c, Hnumber__c, TNumber__c, TOPsign__c from contractFee__c where id =:RecordId ];
            if(ContractFee.contract__c != null){
                AchivementList = [select name,achivementOwner__c, upperID3__c, upperID2__c, upperID1__c, performanceProportion__c, achivementOwner18__c, pType__c, contract__c, contractReceptDate__c, contractAmount__c, comments__c, ARMember__c, year__c, date__c, month__c, centerWriting__c, departmentLevelcenter__c, provinceWriting__c, departmentLevelProvince__c, departmentWriting__c, departmentLevelDepartment__c from AchivementRecognization__c where contract__c =:ContractFee.contract__c];
            }
             
        }catch(Exception e){
           e.getMessage();    
        } 
        
        
    }
}