public class SOSPControllerGoSFClass {
	@future(callout=true)
    public static void createOrderToSF(String recordId,String ObjectAPIName,String ApplyName,String ApplyPhone ,String ApplyAddress ,
                                         String ApplyCompany,String ReceptName,String ReceptPhone,String ReceptAddress,String ReceptCompany){
        SOSPToSFOrder.createSFOrder(recordId, ObjectAPIName, ApplyName, ApplyPhone, ApplyAddress, ApplyCompany, ReceptName, ReceptPhone, ReceptAddress, ReceptCompany);
    }
    
    public static void createOrderToSF_BD(String recordId,String ObjectAPIName,String ApplyName,String ApplyPhone ,String ApplyAddress ,
                                         String ApplyCompany,String ReceptName,String ReceptPhone,String ReceptAddress,String ReceptCompany){
        SOSPToSFOrder_BD.createSFOrder(recordId, ObjectAPIName, ApplyName, ApplyPhone, ApplyAddress, ApplyCompany, ReceptName, ReceptPhone, ReceptAddress, ReceptCompany);
    }
}