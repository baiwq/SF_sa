public with sharing class SOSPCallSAPFinancial {

    public static String callSapFinancial(String contractNo){
    	try{
    		if(contractNo!=null&&contractNo.trim()!=''){
    			wwwExampleOrgSapZsdSaleorderAbgru.inputType  requestInput = new wwwExampleOrgSapZsdSaleorderAbgru.inputType();
    			wwwExampleOrgSapZsdSaleorderAbgru.outType responseOutput = new wwwExampleOrgSapZsdSaleorderAbgru.outType();
    			List<wwwExampleOrgSapZsdSaleorderAbgru.IT_RETURNType> ittype = new List<wwwExampleOrgSapZsdSaleorderAbgru.IT_RETURNType>();
    			requestInput.P_BSTKD = contractNo;
    			wwwExampleOrgSapZsdSaleorderAbgru.SAP_ZSD_SALEORDER_ABGRUSOAP requestMethod = new wwwExampleOrgSapZsdSaleorderAbgru.SAP_ZSD_SALEORDER_ABGRUSOAP();
    			responseOutput = requestMethod.SAP_ZSD_SALEORDER_ABGRU(requestInput);
    			ittype=responseOutput.IT_RETURN;
    			if(ittype[0].TYPE_x=='S'){
                    System.debug('SAP返回信息：'+ittype[0].MESSAGE);
    				logClass.returnLog('成功', '已处理', '【推送合同号到SAP接口】合同号：'+contractNo, '正常');
    				return '成功';
    			}else{
    				logClass.returnLog('失败', '未处理', '【推送合同号到SAP接口】合同号：'+contractNo+',SAP返回错误信息：'+ittype[0].MESSAGE, '重要');
    				return 'SAP系统错误信息：'+ittype[0].MESSAGE;
    			}
    		}else{
    			logClass.returnLog('失败', '未处理', '【推送合同号到SAP接口】合同号为空', '重要');
    			return '合同号为空，推送SAP失败';
    		}
    	}catch(Exception e){
    		logClass.returnLog('失败', '未处理', '【推送合同号到SAP接口】合同号：'+contractNo+',SOSP错误信息：'+e.getMessage(), '重要');
    		return e.getMessage();
    	}
    }
}