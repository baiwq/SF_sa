public class QueryReturnItem {
	public List<returnItem__c> ReturnItemList{get;set;}

    public QueryReturnItem(ApexPages.StandardController controller) {
      
        ID RecordId = ApexPages.currentPage().getParameters().get('id');
        try{
            String test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';
            test1 = '21312';  
            contractFee__c  ContractFee= [select returnItem__c,contract__c  from contractFee__c where id =:RecordId ];
            if(ContractFee.returnItem__c != null){
                ReturnItemList = [select name,opportunity__c,TtranzferZ__c,amount__c,yearNumber__c,monthNumber__c,returnAccount__c,getDate__c,returnAmountDate__c,MainProductGroup__c,contracts__c,contractNOLY__c,returnContract__c,accountName__c,accountCode__c,subCompany__c,contractName__c,contractAmount__c,year__c,month__c,returnPercent__c,returnNumber__c,returnUser__c,returnUserName__c,returnUser18__c,comments__c,AccuntName__c,accountNameLV__c,accountNameD__c,salesRepresentative__c,accountCodeLV__c,accountCodeD__c,LYBaozhengjing__c,LYName__c,incomeType__c,center__c,returnPool__c,province__c,department__c,ownerCenter__c,ownerProvince__c,OwnerDepartment__c,bidCost__c,TBowner__c,TBName__c,TtransferL__c,outsourcingYN__c,isReckon__c,PremiumYN__c,returnDate__c,incomeConfirmDate__c,recordTypeName__c,contractNoReturnAmount__c,salesOwner__c,DMLFlag__c from returnItem__c where contracts__c =:ContractFee.contract__c];
            }
             
        }catch(Exception e){
           e.getMessage();    
        } 
        
        
    }
}