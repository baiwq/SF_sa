/*封装方法供触发器调用*/
public class SoapSendAccountToSap{
    @future(callout=true)
    public static void soapSendAccountToSap(String step,String accountId,String sType,String subCompanyCode,String salesOrgNameCode){
        sendAccountToSap obj = new sendAccountToSap();
        Boolean bool = obj.sendAccountToSap(step,accountId,sType,subCompanyCode,salesOrgNameCode);
    }
}