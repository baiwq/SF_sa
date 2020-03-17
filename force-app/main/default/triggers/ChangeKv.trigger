trigger ChangeKv on Contract__c (before insert,before update) {
   
    for(Contract__c conc : Trigger.new){ 
        if( conc.contractName__c != null && conc.contractName__c != ''){
            conc.contractName__c = conc.contractName__c.replaceAll('Kv', 'kV');
            conc.contractName__c = conc.contractName__c.replaceAll('kv', 'kV');
            conc.contractName__c = conc.contractName__c.replaceAll('KV', 'kV');
        }
        
    }
}