/*
 * 功能:SAP接口增加客户传递时机
 * 创建:任艳新 2018-3-19
 */
trigger AccountInfoChangedToSAP on Account (after update) {
    if(Trigger.new.size()>100){
        return;
    }else{
        for(Account newAcc:Trigger.new){
            Boolean flag=false;
            Account oldAcc = Trigger.oldMap.get(newAcc.Id);
            if((newAcc.SAP_ID__c!=null&&newAcc.SAP_ID__c.trim()!='')||(newAcc.SAPIDD__c!=null&&newAcc.SAPIDD__c.trim()!='')){
                //客户名称
                if(newAcc.Name!=oldAcc.Name){
                    flag=true;
                }
                //国家
                if(newAcc.billingNation__c!=oldAcc.billingNation__c){
                    flag=true;
                }
                //省份
                if(newAcc.billingState__c!=oldAcc.billingState__c){
                    flag=true;
                }
                //城市
                if(newAcc.city__c!=oldAcc.city__c){
                    flag=true;
                }
                //街道
                if(newAcc.billingStreet__c!=oldAcc.billingStreet__c){
                    flag=true;
                }
                //邮编
                if(newAcc.postcode__c!=oldAcc.postcode__c){
                    flag=true;
                }
                //社会信用统一编码
                if(newAcc.taxpayerNumber__c!=oldAcc.taxpayerNumber__c){
                    flag=true;
                }
                if(flag){
                    if(newAcc.SAP_ID__c!=null&&newAcc.SAP_ID__c.trim()!=''){
                    	SoapSendAccountToSap.soapSendAccountToSap('客户基本信息变化', newAcc.Id, 'C', null, null);
                    }
                    if(newAcc.SAPIDD__c!=null&&newAcc.SAPIDD__c.trim()!=''){
                        SoapSendAccountToSap.soapSendAccountToSap('客户基本信息变化', newAcc.Id, 'D', null, null);
                    }
                }
                
                
            }
        }
    }
    
}