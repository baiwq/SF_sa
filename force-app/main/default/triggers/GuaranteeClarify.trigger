trigger GuaranteeClarify on guaranteeLetter__c (after insert,after update) {
    public boolean flag = true;
    for(guaranteeLetter__c gl : Trigger.new){
        if(gl.contract__c == null)
        {
            break;
        }
        List<guaranteeLetter__c> GLlist = [Select id,returnOrNot__c from guaranteeLetter__c where contract__c=:gl.contract__c ];
        for(guaranteeLetter__c gltemp:GLlist){
           if(gltemp.returnOrNot__c==false){
              flag = false;
              break;
           }
        }
        
        Contract__c cc = [select assignIsExisted__c from Contract__c where id=:gl.contract__c ];
        if(flag){       
           cc.assignIsExisted__c = true;
           update cc;
        }else{
           cc.assignIsExisted__c = false;
           update cc;
        }
    }
}