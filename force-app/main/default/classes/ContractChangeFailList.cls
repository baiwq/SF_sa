Global class ContractChangeFailList {
    Global static void getContractChangeFailList(){
        Date nowdays = System.today();
  		String SynchronousFlag = '失败';
        String ContractChange_sql = 'select id from contractchange__c where  SynchronousFlag__c =:SynchronousFlag and CreatedDate <=:nowdays ';

        List<contractchange__c> conList = database.query(ContractChange_sql); 
        if(conList.size() > 0){
            String changeId = null;
            for(integer i=0;i<conList.size();i++){
                changeId = conList.get(i).get('id').toString();
                SOSPContractChangeToBPM.change(changeId);                
            }
        }
    }
}