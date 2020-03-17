global class DealServiceContract {
  
    global class Response{
        webservice String flag;
        webservice String message;
    }

    //服务类合同签订
    global class  ServiceContractSignVo{
        webservice String ContractCostCode;
        webservice String ServiceContractSigningNo;
        webservice String PurchasingContractName;
        webservice String SupplierName;
        webservice String IsFrameworkContract;
        webservice String PurchaseContractAmount;
        webservice String PurchaseContractsPayment;

    }
       
    
     //服务类合同付款
    global class  CostProcessingSchedule{
        webservice String ContractCostCode;
        webservice String ServiceContractsPaymentNo;
        webservice String SCPaymentType;
        webservice String PaymentAmount;
        
        webservice String bt_no;
        webservice String name;
        webservice Decimal invoice_amount;
        webservice String status;
        webservice String update_time;
      	webservice String business_type;
    }
    
     //服务类合同发票登记
    global class  InvoiceServiceContractVo{
        webservice String ServiceContractSigningNo;
        webservice String ServiceContractInvoiceNo;
        webservice String InvoiceCategory;
        webservice String InvoiceAmount;
        webservice String InvoiceNumber;
        webservice String ContractCostCode;

    }
    
    
    
    //服务类合同签订
    webservice static Response getServiceContractSign(ServiceContractSignVo ServiceContractSignVo){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
           
             if(ServiceContractSignVo.ContractCostCode != ''){
                String ContractCostCode = ServiceContractSignVo.ContractCostCode;
                
                List<contractFee__c> ServiceContractSign_list = [select id,name from contractFee__c where Name like :ContractCostCode ]; 
                if(ServiceContractSign_list.size() > 0){
                    ServiceContractSign__c  InServiceContractSign = new ServiceContractSign__c();
                    InServiceContractSign.contractFee__c = ServiceContractSign_list.get(0).id;
					if(ServiceContractSignVo.ServiceContractSigningNo !='' || ServiceContractSignVo.ServiceContractSigningNo != null ){ 
                        InServiceContractSign.name = ServiceContractSignVo.ServiceContractSigningNo;
                    }
                    
                    if(ServiceContractSignVo.PurchasingContractName !='' || ServiceContractSignVo.PurchasingContractName != null ){ 
                        InServiceContractSign.PurchasingContractName__c = ServiceContractSignVo.PurchasingContractName;
                    }
                    
                    if(ServiceContractSignVo.SupplierName !='' || ServiceContractSignVo.SupplierName != null ){ 
                        InServiceContractSign.SupplierName__c = ServiceContractSignVo.SupplierName;
                    }
                    
                    if(ServiceContractSignVo.IsFrameworkContract !='' || ServiceContractSignVo.IsFrameworkContract != null ){ 
                        InServiceContractSign.IsFrameworkContract__c = ServiceContractSignVo.IsFrameworkContract;
                    }
                    
                    if(ServiceContractSignVo.PurchaseContractAmount !='' || ServiceContractSignVo.PurchaseContractAmount != null ){ 
                        InServiceContractSign.PurchaseContractAmount__c = ServiceContractSignVo.PurchaseContractAmount;
                    }
                    
                    if(ServiceContractSignVo.PurchaseContractsPayment !='' || ServiceContractSignVo.PurchaseContractsPayment != null ){ 
                        InServiceContractSign.PurchaseContractsPayment__c = ServiceContractSignVo.PurchaseContractsPayment;
                    }
                    
                    insert InServiceContractSign;

                     //转化为JSON字符串  
                    findv = 'true';  

                }

            }
            
            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '更新getServiceContractSign成功', '正常');
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getServiceContractSign查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','更新getServiceContractSign接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
    
    
     // //服务类合同付款
 //    webservice static Response getPaymentServiceContracts(PaymentServiceContractsVo PaymentServiceContractsVo){
 //        Response resp = new Response();
 //        String conJsonString = '';
 //        String findv = 'false';
 //        try{
           
 //             if(PaymentServiceContractsVo.ContractCostCode != ''){
 //                String ContractCostCode = PaymentServiceContractsVo.ContractCostCode;
                
 //                List<contractFee__c> PaymentServiceContracts_list = [select name,ServiceContractsPaymentNo__c,SCPaymentType__c,PaymentAmount__c from contractFee__c where Name like :ContractCostCode ]; 
 //                if(PaymentServiceContracts_list.size() > 0){
                     
 //                    if(PaymentServiceContractsVo.ServiceContractsPaymentNo != '' || PaymentServiceContractsVo.ServiceContractsPaymentNo != null ){ 
 //                        PaymentServiceContracts_list.get(0).ServiceContractsPaymentNo__c = PaymentServiceContractsVo.ServiceContractsPaymentNo;
 //                    }
                    
 //                    if(PaymentServiceContractsVo.SCPaymentType != '' || PaymentServiceContractsVo.SCPaymentType != null ){ 
 //                        PaymentServiceContracts_list.get(0).SCPaymentType__c = PaymentServiceContractsVo.SCPaymentType;
 //                    }
                    
 //                    if(PaymentServiceContractsVo.PaymentAmount != '' || PaymentServiceContractsVo.PaymentAmount != null ){ 
 //                        PaymentServiceContracts_list.get(0).PaymentAmount__c = PaymentServiceContractsVo.PaymentAmount;
 //                    }
				
                    
 //                    update PaymentServiceContracts_list.get(0);

 //                     //转化为JSON字符串  
 //                    findv = 'true';  

 //                }

 //            }
            
 //            if( findv == 'true'){
 //                resp.flag='Y';
 //                resp.message = conJsonString;
 //                logClass.returnLog('成功', '已处理', '更新getPaymentServiceContracts成功', '正常');
 //            }else{
 //                resp.flag='N';
 //                resp.message='查新信息失败，未查询到相关数据！';
 //                LogClass.returnLog('失败','未处理','getPaymentServiceContracts查新信息失败，未查询到相关数据！' ,'重要');
 //            }
            
 //        }catch(Exception e){
 //            resp.flag='E';
 //            resp.message=e.getMessage();
 //            LogClass.returnLog('失败','未处理','更新getPaymentServiceContracts接口异常:' + e.getMessage(),'重要');
 //        }
 //        return resp;
 //    }

    
    
     //查询用户费用申请列表
    webservice static Response UpdateCostProcessingScheduleList(List<CostProcessingSchedule> CostProcessingScheduleList){
        Response resp = new Response();
        String findv = 'false';
        String conJsonString = '';
        try{
            if(CostProcessingScheduleList.size() > 0){
                CustomObject2__c  CostProcessingSchedule = null;
                CustomObject1__c  CustomObjectVo = null;
                for(integer i=0; i < CostProcessingScheduleList.size(); i++){

                    String sosp_name = CostProcessingScheduleList.get(i).name;
                    String bpm_code = CostProcessingScheduleList.get(i).BT_NO;
                     //查询费用申请列表
                     List<contractFee__c> contractFeeList = [select id,name,ownerid,contract__c from  contractFee__c where name =:sosp_name];

                     //查询费用办理过程列表
                     List<CustomObject1__c> CustomObjectList = [select id,name,contract__c,ownerid from  CustomObject1__c where contractFeeName__c =:sosp_name];

                     //查询费用办理进度列表
                     List<CustomObject2__c> CostProcessList = [select id,ServiceContractsPaymentNo__c,SCPaymentType__c,PaymentAmount__c,name,BPM__c,YSZC__c,Field20__c,bpmUpdate_time__c,status__c,FYGC__c  from  CustomObject2__c where BPM__c =:bpm_code];
                     if(contractFeeList.size() > 0){
                        if(CostProcessList.size() > 0){ //已有费用办理进度
                             CostProcessList.get(0).BPM__c = CostProcessingScheduleList.get(i).BT_NO;
                             CostProcessList.get(0).YSZC__c = CostProcessingScheduleList.get(i).invoice_amount;
                             CostProcessList.get(0).Field20__c = contractFeeList.get(0).ownerid;
                             CostProcessList.get(0).bpmUpdate_time__c = CostProcessingScheduleList.get(i).update_time;
                             CostProcessList.get(0).status__c = CostProcessingScheduleList.get(i).status;
                             CostProcessList.get(0).ServiceContractsPaymentNo__c = CostProcessingScheduleList.get(i).ServiceContractsPaymentNo;
  						     CostProcessList.get(0).SCPaymentType__c = CostProcessingScheduleList.get(i).SCPaymentType;
                             CostProcessList.get(0).PaymentAmount__c = CostProcessingScheduleList.get(i).PaymentAmount;

                             if( CustomObjectList.size() > 0){ // 已有费用办理过程
                                 CostProcessList.get(0).FYGC__c = CustomObjectList.get(0).id;
                             }else{  // 没有费用办理过程,先新建
                                 CustomObjectVo = new CustomObject1__c();
                                 CustomObjectVo.number__c = contractFeeList.get(0).id;
                                 CustomObjectVo.contract__c = contractFeeList.get(0).contract__c;
                                 CustomObjectVo.ownerid = contractFeeList.get(0).ownerid;
                                 insert CustomObjectVo;

                                 CostProcessList.get(0).FYGC__c = CustomObjectVo.id;
                             }
							  CostProcessList.get(0).business_code__c = CostProcessingScheduleList.get(i).business_type;
                             String business_code = '主营业务成本';
                             if(CostProcessingScheduleList.get(i).business_type == '01'){
                                 business_code = '成本中心';
                             }else if(CostProcessingScheduleList.get(i).business_type =='02'){
                                 business_code = 'T类订单';
                             }else if(CostProcessingScheduleList.get(i).business_type =='03'){
                                 business_code = 'H类订单';
                             }
                             CostProcessList.get(0).business_type__c = business_code;
                             update  CostProcessList.get(0);

                         }else{
                             CostProcessingSchedule = new CustomObject2__c();
                             if( CustomObjectList.size() > 0){ // 已有费用办理过程
                                 CostProcessingSchedule.FYGC__c = CustomObjectList.get(0).id;
                             }else{  // 没有费用办理过程,先新建
                                 CustomObjectVo = new CustomObject1__c();
                                 CustomObjectVo.number__c = contractFeeList.get(0).id;
                                 CustomObjectVo.contract__c = contractFeeList.get(0).contract__c;
                                 CustomObjectVo.ownerid = contractFeeList.get(0).ownerid;
                                 insert CustomObjectVo;

                                 CostProcessingSchedule.FYGC__c = CustomObjectVo.id;
                             }
                             CostProcessingSchedule.BPM__c = CostProcessingScheduleList.get(i).BT_NO;
                             CostProcessingSchedule.YSZC__c = CostProcessingScheduleList.get(i).invoice_amount;
                             CostProcessingSchedule.Field20__c = contractFeeList.get(0).ownerid;
                             CostProcessingSchedule.bpmUpdate_time__c = CostProcessingScheduleList.get(i).update_time;
                             CostProcessingSchedule.status__c = CostProcessingScheduleList.get(i).status;
                             CostProcessingSchedule.ServiceContractsPaymentNo__c = CostProcessingScheduleList.get(i).ServiceContractsPaymentNo;
  						     CostProcessingSchedule.SCPaymentType__c = CostProcessingScheduleList.get(i).SCPaymentType;
                             CostProcessingSchedule.PaymentAmount__c = CostProcessingScheduleList.get(i).PaymentAmount;
                             CostProcessingSchedule.business_code__c = CostProcessingScheduleList.get(i).business_type;
                             String business_code = '主营业务成本';
                             if(CostProcessingScheduleList.get(i).business_type == '01'){
                                 business_code = '成本中心';
                             }else if(CostProcessingScheduleList.get(i).business_type =='02'){
                                 business_code = 'T类订单';
                             }else if(CostProcessingScheduleList.get(i).business_type =='03'){
                                 business_code = 'H类订单';
                             }
                             CostProcessingSchedule.business_type__c = business_code;

                             insert CostProcessingSchedule;

                         }
                         findv = 'true';

                     }else{
                        conJsonString = sosp_name+'备案编号不存在。';
                     }
                    
                }   

                
              }


            if( findv == 'true'){
                resp.message = '更新信息成功';
                logClass.returnLog('成功', '已处理', '更新费用办理进度接口成功', '正常');
                resp.flag='Y';
            }else{
                resp.flag='N';
                resp.message='更新信息失败';
                LogClass.returnLog('失败','未处理','更新费用办理进度接口失败，未查询到相关数据！'+conJsonString ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','更新费用办理进度接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
    
    
     //服务类合同发票登记
    webservice static Response getInvoiceServiceContract(InvoiceServiceContractVo InvoiceServiceContractVo){
        Response resp = new Response();
        String conJsonString = '';
        String findv = 'false';
        try{
           
             if(InvoiceServiceContractVo.ServiceContractSigningNo != ''){
                String ServiceContractSigningNo = InvoiceServiceContractVo.ServiceContractSigningNo;
                
                List<ServiceContractSign__c > ServiceContractSign_list = [select id,name,contractFee__c from ServiceContractSign__c where Name like :ServiceContractSigningNo ]; 
                if(ServiceContractSign_list.size() == 0){
                    ServiceContractInvoice__c  ServiceContractInvoice  =  new ServiceContractInvoice__c();
                    List<contractFee__c> contractFee_list = [select id,name from contractFee__c where Name like :InvoiceServiceContractVo.ContractCostCode ]; 
                    if(contractFee_list.size() > 0){
                        ServiceContractInvoice.contractFee__c = contractFee_list.get(0).id;
                        if(InvoiceServiceContractVo.ServiceContractInvoiceNo != '' || InvoiceServiceContractVo.ServiceContractInvoiceNo != null ){ 
                            ServiceContractInvoice.name = InvoiceServiceContractVo.ServiceContractInvoiceNo;
                        }
                        
                        if(InvoiceServiceContractVo.InvoiceCategory != '' || InvoiceServiceContractVo.InvoiceCategory != null ){ 
                            ServiceContractInvoice.InvoiceCategory__c = InvoiceServiceContractVo.InvoiceCategory;
                        }
                        
                        if(InvoiceServiceContractVo.InvoiceAmount != '' || InvoiceServiceContractVo.InvoiceAmount != null ){ 
                            ServiceContractInvoice.InvoiceAmount__c = InvoiceServiceContractVo.InvoiceAmount;
                        }
                        
                        if(InvoiceServiceContractVo.InvoiceNumber != '' || InvoiceServiceContractVo.InvoiceNumber != null ){ 
                            ServiceContractInvoice.InvoiceNumber__c = InvoiceServiceContractVo.InvoiceNumber;
                        }
                        
                        insert ServiceContractInvoice;
                        
                        //转化为JSON字符串  
                        findv = 'true';  
                    }
                }else{
                    ServiceContractInvoice__c  ServiceContractInvoice  =  new ServiceContractInvoice__c();
					ServiceContractInvoice.ServiceContractSign__c = ServiceContractSign_list.get(0).id;
                    ServiceContractInvoice.contractFee__c =  ServiceContractSign_list.get(0).contractFee__c;
                    if(InvoiceServiceContractVo.ServiceContractInvoiceNo != '' || InvoiceServiceContractVo.ServiceContractInvoiceNo != null ){ 
                         ServiceContractInvoice.name = InvoiceServiceContractVo.ServiceContractInvoiceNo;
                     }
                    
                    if(InvoiceServiceContractVo.InvoiceCategory != '' || InvoiceServiceContractVo.InvoiceCategory != null ){ 
                         ServiceContractInvoice.InvoiceCategory__c = InvoiceServiceContractVo.InvoiceCategory;
                     }
                    
                    if(InvoiceServiceContractVo.InvoiceAmount != '' || InvoiceServiceContractVo.InvoiceAmount != null ){ 
                         ServiceContractInvoice.InvoiceAmount__c = InvoiceServiceContractVo.InvoiceAmount;
                     }
                    
                    if(InvoiceServiceContractVo.InvoiceNumber != '' || InvoiceServiceContractVo.InvoiceNumber != null ){ 
                         ServiceContractInvoice.InvoiceNumber__c = InvoiceServiceContractVo.InvoiceNumber;
                     }
                    
                    insert ServiceContractInvoice;

                     //转化为JSON字符串  
                    findv = 'true';  

                    
                }

            }
            
            if( findv == 'true'){
                resp.flag='Y';
                resp.message = conJsonString;
                logClass.returnLog('成功', '已处理', '更新getInvoiceServiceContract成功', '正常');
            }else{
                resp.flag='N';
                resp.message='查新信息失败，未查询到相关数据！';
                LogClass.returnLog('失败','未处理','getInvoiceServiceContract查新信息失败，未查询到相关数据！' ,'重要');
            }
            
        }catch(Exception e){
            resp.flag='E';
            resp.message=e.getMessage();
            LogClass.returnLog('失败','未处理','更新getInvoiceServiceContract接口异常:' + e.getMessage(),'重要');
        }
        return resp;
    }
}