public class getContractIdSetFromStr{
    public Set<id> getIdSet(String str){
        Set<ID> idSet = new Set<ID>();
        Set<ID> accidSet = new Set<ID>();
        Set<ID> oppoidSet = new Set<ID>();              
        String[] sList = str.trim().subString(0,str.trim().length()).split(',');       
        for(String s:sList){  
            if(s == null || s.trim() == ''){
                System.debug('null');
            }else{ 
                String sq = '*'+s+'*';             
                List<List<SObject>> searchList = [FIND :s IN ALL FIELDS RETURNING Account (Id), opportunity(Id),contract__c(Id where deliveryPerson__c =:UserInfo.getUserId())];              
                List<Account> accList = ((List<Account>)searchList[0]);
                if(accList.size()>0){
                    for(Account a:accList){
                        accidSet.add(a.id); //所有客户IDSet
                    }       
                    List<contract__c> accContractList = [select id,account__c from contract__c where account__c in:accidSet and deliveryPerson__c =:UserInfo.getUserId()];
                    for(contract__c c:accContractList){
                        idSet.add(c.id);
                    }
                }            
                List<Opportunity>  oppoList = ((List<Opportunity>)searchList[1]);    
                if(oppoList.size()>0){
                    for(Opportunity o:oppoList){
                        oppoidSet.add(o.id); //所有机会IDSet
                    }       
                    List<contract__c> oppoContractList = [select id,opportunity__c from contract__c where opportunity__c in:oppoidSet and deliveryPerson__c =:UserInfo.getUserId()];
                    for(contract__c c:oppoContractList){
                        idSet.add(c.id);
                    }
                }            
                List<contract__c> conList = ((List<contract__c>)searchList[2]);    
                if(conList.size()>0){
                    for(contract__c c:conList){
                        idSet.add(c.id);
                    }
                }          
            }  
        }  
        return idSet;              
    }
}