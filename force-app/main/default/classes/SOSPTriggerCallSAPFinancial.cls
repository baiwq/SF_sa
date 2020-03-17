public class SOSPTriggerCallSAPFinancial {
    @future(callout=true)
    public static void triggerCallMethod(String contractNo) {
        SOSPCallSAPFinancial.callSapFinancial(contractNo);
    }
}