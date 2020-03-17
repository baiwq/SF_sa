trigger ContractFincialAttachment on Contract__c (after insert) {
    if(trigger.new.size() > 100){
        System.Debug('Account Batch DMLs, ignore...');
    }else{
        for(Contract__c con:Trigger.new){  
                           /**
                    更新：安全服务合同的合同文本附件来源于框架合同 2019-03-08  任艳新         
                 **/
                if(con.RecordTypeName__c  == '安全服务合同'){
                    if(con.FrameworkContact__c !=null){
                        List<attachment__c> attList = [Select id,contract__c,encryptURL__c,contractTextType__c,documentName__c ,
                                                      isValid__c,type__c ,attachmentURL__c ,URLAddress__c from attachment__c 
                                                       where contract__c=:con.FrameworkContact__c and type__c=:'合同文本' and isValid__c=:'有效' limit 1];
                        if(attList.size()>0){
                            attachment__c att = new attachment__c();
                            att.contract__c =con.Id;
                            att.encryptURL__c = attList[0].encryptURL__c;
                            att.contractTextType__c =attList[0].contractTextType__c ;
                            att.documentName__c =attList[0].documentName__c ;
                            att.isValid__c=attList[0].isValid__c;
                            att.type__c =attList[0].type__c;
                            att.attachmentURL__c =attList[0].attachmentURL__c;
                            att.URLAddress__c =attList[0].URLAddress__c;
                            insert att;
                        }
                    }
                }
        }
    }
}