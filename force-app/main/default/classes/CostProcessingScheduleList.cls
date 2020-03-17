global class CostProcessingScheduleList
{
    global class CostProcessingSchedule{
        webservice String bt_no;
        webservice String name;
        webservice Decimal invoice_amount;
        webservice String status;
        webservice String update_time;
        webservice String business_type;

    }
    
     global class Response{
        webservice String flag;
        webservice String message;
    }
    
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
                     List<contractFee__c> contractFeeList = [select id,Hnumber__c,name,ownerid,contract__c from  contractFee__c where name =:sosp_name];

                     //查询费用办理过程列表
                     List<CustomObject1__c> CustomObjectList = [select id,name,contract__c,ownerid from  CustomObject1__c where contractFeeName__c =:sosp_name];

                     //查询费用办理进度列表
                     List<CustomObject2__c> CostProcessList = [select id,name,BPM__c,YSZC__c,Field20__c,bpmUpdate_time__c,status__c  from  CustomObject2__c where BPM__c =:bpm_code];
                     if(contractFeeList.size() > 0){
                        if(CostProcessList.size() > 0){ //已有费用办理进度
                             CostProcessList.get(0).BPM__c = CostProcessingScheduleList.get(i).BT_NO;
                            if(contractFeeList.get(0).get('Hnumber__c') != null){
                              CostProcessList.get(0).Field21__c = CostProcessingScheduleList.get(i).invoice_amount;
                            }else{
                              CostProcessList.get(0).YSZC__c = CostProcessingScheduleList.get(i).invoice_amount;

                            }
                             CostProcessList.get(0).Field20__c = contractFeeList.get(0).ownerid;
                             CostProcessList.get(0).bpmUpdate_time__c = CostProcessingScheduleList.get(i).update_time;
                             CostProcessList.get(0).status__c = CostProcessingScheduleList.get(i).status;
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
                             if(contractFeeList.get(0).get('Hnumber__c') != null){
                                CostProcessingSchedule.Field21__c = CostProcessingScheduleList.get(i).invoice_amount;
                             }else{
                                 CostProcessingSchedule.YSZC__c = CostProcessingScheduleList.get(i).invoice_amount;
                                 
                             }
                             CostProcessingSchedule.Field20__c = contractFeeList.get(0).ownerid;
                             CostProcessingSchedule.bpmUpdate_time__c = CostProcessingScheduleList.get(i).update_time;
                             CostProcessingSchedule.status__c = CostProcessingScheduleList.get(i).status;
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

}