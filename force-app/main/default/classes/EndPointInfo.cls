public class EndPointInfo{
    public String getEndpointUrl(String ClassName){
       
       Boolean flag = [SELECT IsSandbox FROM Organization].IsSandbox;
       system.debug('uri---'+URL.getSalesforceBaseUrl().getHost());
       system.debug('flag---'+flag);
       if(!flag){
          if(ClassName == 'ContractNOToSAP'){
             return Label.ContractNOToSAP;
          }
       }else{
          if(ClassName == 'ContractNOToSAP'){
             return Label.Z_ContractNOToSAP_Test;
          }
       }
       return 'ERROR，Parameter is not found.';
    }

}