global class SOSPToCPQStageStatusClass {
    webservice static void sendStageStatus(String businessNodes,String contractNumber,String contractNumber2,
                                          String employeeNo, String materialName,String orderNumber,String orderStauts,String projectCode){
        try{
            wwwExampleOrgSospCpqCos013.SOSPCPQCOS013InputRootType inputRoot = new wwwExampleOrgSospCpqCos013.SOSPCPQCOS013InputRootType();
            wwwExampleOrgSospCpqCos013.SOSPCPQCOS013OutputRootType outputRoot = new wwwExampleOrgSospCpqCos013.SOSPCPQCOS013OutputRootType();
            wwwExampleOrgSospCpqCos013.SOSP_CPQ_COS_013SOAP requObj = new wwwExampleOrgSospCpqCos013.SOSP_CPQ_COS_013SOAP();
            //业务节点
            inputRoot.businessNodes = businessNodes;
            //合同号
            inputRoot.contractNumber = contractNumber;
            //合同变更号
            inputRoot.contractNumber2 = contractNumber2;
            //用户名，最后修改人姓名
            inputRoot.employeeNo = employeeNo;
            //合同评审单号
            inputRoot.materialName = materialName;
            //订单号
            inputRoot.orderNumber = orderNumber;
            //状态 
            inputRoot.orderStauts = orderStauts;
            //报价单号
            inputRoot.projectCode = projectCode;
            outputRoot=requObj.SOSP_CPQ_COS_013(inputRoot);
            String typeFlag=outputRoot.type_x;
            if(typeFlag=='S'){
                LogClass.returnLog('成功','已处理','【CPQ接口COS013】SOSP调用成功'+',报价编号:'+projectCode+',合同评审编号:'+materialName+',合同变更编号:'+contractNumber2,'重要');
            }else{ 
                LogClass.returnLog('失败','未处理','【CPQ接口COS013】SOSP调用失败,CPQ返回错误信息:'+outputRoot.message ,'重要');
            }
        }catch(Exception e){
            LogClass.returnLog('失败','未处理','【CPQ接口COS013】SOSP调用失败,SOSP返回错误信息:'+e.getMessage() ,'重要');
        }
    }
}