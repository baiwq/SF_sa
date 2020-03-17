public class SOSPToCPQStageStatusPublicClass {
    @future(callout=true)
	public static void sendStageStatus(String businessNodes,String contractNumber,String contractNumber2,
                                       String employeeNo, String materialName,String orderNumber,String orderStauts,String projectCode){
    	try{
        	SOSPToCPQStageStatusClass.sendStageStatus(businessNodes, contractNumber, contractNumber2, employeeNo, materialName, orderNumber, orderStauts, projectCode);                                       
        }catch(Exception e){
            
        }
    }
}