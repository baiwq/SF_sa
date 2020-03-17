global class SOSPToSFOrder_BD {
	 webservice static void createSFOrder(String recordId,String ObjectAPIName,String ApplyName,String ApplyPhone ,String ApplyAddress ,
                                         String ApplyCompany,String ReceptName,String ReceptPhone,String ReceptAddress,String ReceptCompany){
        
        String orderId=createOrderId()+recordId.substring(recordId.length()-8,recordId.length()-3);
        string xml='<Request service="OrderService" lang="zh-CN">'+
            '<Head>0104351628</Head><Body><Order orderid="'+orderId+'" j_company="'+ApplyCompany+'" j_contact="'+ApplyName
            +'" j_tel="'+ApplyPhone+'" j_address="'+ApplyAddress+'" '+
            'd_company="'+ReceptCompany+'" d_contact="'+ReceptName+'" d_tel="'+ReceptPhone+'" d_address="'+ReceptAddress+'" pay_method="1" express_type="1" custid="3122004820"><Cargo name="文件"/></Order></Body></Request>';
     
        string code = 'FYEbLyDKpfAyXUUST7b10IG83nKAe8L5';
        String xmls=xml+code;
        string ApexMD5 = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(xmls)));
        System.Debug('ApexMD5: ' + ApexMD5);
        System.Debug('orderId: ' + orderId);                                    
     
     //string base64 = EncodingUtil.base64Encode(Blob.valueOf(ApexMD5));
        string base64 = EncodingUtil.base64Encode(Crypto.generateDigest('MD5', Blob.valueOf(xmls)));
        System.Debug('base64: ' + base64);
        try{
            SFServiceExpressserviceIntegrationSfCo.CommonExpressServicePort SFCE  = new SFServiceExpressserviceIntegrationSfCo.CommonExpressServicePort();
            String results = SFCE.sfexpressService(xml,base64);
            DOM.Document xmlDoc = new DOM.Document();
            xmlDoc.load(results);
            Dom.XMLNode xmlNode = xmlDoc.getRootElement();
            String head= xmlNode.getChildElement('Head', null).getText();
             
            if(head=='OK'){
                String mailno= xmlNode.getChildElement('Body', null).getChildElement('OrderResponse', null). getAttributeValue('mailno',null);
                String filter_result= xmlNode.getChildElement('Body', null).getChildElement('OrderResponse', null).getAttributeValue('filter_result',null);
                String destcode= xmlNode.getChildElement('Body', null).getChildElement('OrderResponse', null).getAttributeValue('destcode',null);
                String remark= '';
                if(filter_result=='3'){
                    remark= xmlNode.getChildElement('Body', null).getChildElement('OrderResponse', null).getAttributeValue('remark',null);
                }
                if(ObjectAPIName=='invoice__c'){
                    invoice__c invo=[select id,orderIDSF__c,expressNumber__c,orderResultSF__c,notToSendSF__c, errorInterfaceSF__c,
                                     sendOrderStatusSF__c,sendOrderTimeSF__c from invoice__c where id=:recordId limit 1][0];
                    if(destcode!=null){
                        invo.orderIDSF__c=orderId;
                        invo.expressNumber__c=mailno;
                        if(filter_result=='1'){
                            invo.orderResultSF__c='人工确认';
                        }else if(filter_result=='2'){
                            invo.orderResultSF__c='可收派';
                        }else if(filter_result=='3'){
                            invo.orderResultSF__c='不可以收派';
                            invo.notToSendSF__c=remark;
                        }
                        invo.sendOrderStatusSF__c='成功';
                        invo.sendOrderTimeSF__c=system.now();
                        
                    }else{
                        invo.sendOrderStatusSF__c='失败';
                        invo.sendOrderTimeSF__c=system.now();
                        invo.errorInterfaceSF__c='收件人地址错误';
                    }
                    update invo;
                }else{
                    receipt__c rece=[select id,orderIDSF__c,orderNumberSF__c,orderResultSF__c,notToSendSF__c, errorInterfaceSF__c,
                                     sendOrderStatusSF__c,sendOrderTimeSF__c from receipt__c where id=:recordId limit 1][0];
                    if(destcode!=null){
                        rece.orderIDSF__c=orderId;
                        rece.orderNumberSF__c=mailno;
                        if(filter_result=='1'){
                            rece.orderResultSF__c ='人工确认';
                        }else if(filter_result=='2'){
                            rece.orderResultSF__c ='可收派';
                        }else if(filter_result=='3'){
                            rece.orderResultSF__c ='不可以收派';
                            rece.notToSendSF__c=remark;
                        }
                        rece.sendOrderStatusSF__c='成功';
                        rece.sendOrderTimeSF__c=system.now();
                    }else{
                        rece.sendOrderStatusSF__c='失败';
                        rece.sendOrderTimeSF__c=system.now();
                        rece.errorInterfaceSF__c='收件人地址错误';
                    }
                    update rece;
                }
                logClass.returnLog('成功', '已处理', '顺丰接口：'+results+'--获取XMLbody：'+mailno, '正常');
            }else{
                String code1= xmlNode.getChildElement('ERROR', null).getAttributeValue('code',null);
                String error= xmlNode.getChildElement('ERROR', null).getText();
                if(ObjectAPIName=='invoice__c'){
                    invoice__c invo=[select id,expressNumber__c,orderResultSF__c,notToSendSF__c,
                                     sendOrderStatusSF__c,sendOrderTimeSF__c from invoice__c where id=:recordId limit 1][0];
                    invo.sendOrderStatusSF__c='失败';
                    invo.sendOrderTimeSF__c=system.now();
                    update invo;
                }else{
                    receipt__c rece=[select id,orderNumberSF__c,orderResultSF__c,notToSendSF__c,
                                     sendOrderStatusSF__c,sendOrderTimeSF__c from receipt__c where id=:recordId limit 1][0];
                    
                    rece.sendOrderStatusSF__c='失败';
                    rece.sendOrderTimeSF__c=system.now();
                    update rece;
                }
                logClass.returnLog('失败', '未处理', '顺丰接口：顺丰错误编码：'+code1+';错误信息：'+error, '正常');
            }
         }catch(Exception e){
            logClass.returnLog('失败', '未处理', '顺丰接口：SOSP失败信息：'+e.getMessage(), '正常');
         }
    }
    /*webservice static void confirmSFOrder(String recordId,String ObjectAPIName,
                                          String Confirm,String OrderID,String OrderNumberSF){
        
        String dealType;
        if(Confirm=='确认'){
            dealType='1';
        }else{
            dealType='2';
        }
        string xml='<Request service="OrderConfirmService" lang="zh-CN"><Head>BSPdevelop</Head>'+
            '<Body><OrderConfirm orderid="'+OrderID+'" mailno="'+OrderNumberSF+'" dealtype="'+dealType+'"></OrderConfirm></Body></Request>';
     
        string code = 'j8DzkIFgmlomPt0aLuwU';
        String xmls=xml+code;
        string ApexMD5 = EncodingUtil.convertToHex(Crypto.generateDigest('MD5', Blob.valueOf(xmls)));
        System.Debug('ApexMD5: ' + ApexMD5);
     
     //string base64 = EncodingUtil.base64Encode(Blob.valueOf(ApexMD5));
        string base64 = EncodingUtil.base64Encode(Crypto.generateDigest('MD5', Blob.valueOf(xmls)));
        System.Debug('base64: ' + base64);
        try{
            serviceExpressserviceIntegrationSfCo.CommonExpressServicePort SFCE  = new serviceExpressserviceIntegrationSfCo.CommonExpressServicePort();
            String results = SFCE.sfexpressService(xml,base64);
            DOM.Document xmlDoc = new DOM.Document();
            xmlDoc.load(results);
            Dom.XMLNode xmlNode = xmlDoc.getRootElement();
            String head= xmlNode.getChildElement('Head', null).getText();
             
            if(head=='OK'){
                String mailno= xmlNode.getChildElement('Body', null).getChildElement('OrderConfirmResponse', null).getAttributeValue('mailno',null);
                String res_status= xmlNode.getChildElement('Body', null).getChildElement('OrderConfirmResponse', null).getAttributeValue('res_status',null);
                //String remark= xmlNode.getChildElement('OrderConfirmResponse', null).getAttributeValue('remark',null);
                if(ObjectAPIName=='invoice__c'){
                    invoice__c invo=[select id,confirmOrderSF__c,confirmOrderTimeSF__c from invoice__c where id=:recordId limit 1][0];
                    //invo.expressNumber__c=mailno;
                    //invo.orderResultSF__c=filter_result;
                    //invo.notToSendSF__c=remark;
                    if(res_status=='2'){
                        invo.confirmOrderSF__c=Confirm;
                    }else{
                        invo.confirmOrderSF__c='客户订单号与顺丰运单不匹配';
                    }
                    invo.confirmOrderTimeSF__c =system.now();
                    update invo;
                }else{
                    receipt__c rece=[select id,confirmOrderSF__c,confirmOrderTimeSF__c from receipt__c where id=:recordId limit 1][0];
                    //rece.orderNumberSF__c=mailno;
                    //rece.orderResultSF__c=filter_result;
                    //rece.notToSendSF__c=remark;
                    if(res_status=='2'){
                        rece.confirmOrderSF__c=Confirm;
                    }else{
                        rece.confirmOrderSF__c='客户订单号与顺丰运单不匹配';
                    }
                    rece.confirmOrderTimeSF__c=system.now();
                    update rece;
                }
                logClass.returnLog('成功', '已处理', results+'--获取XMLbody：'+mailno, '正常');
            }else{
                String code1= xmlNode.getChildElement('ERROR', null).getAttributeValue('code',null);
                String error= xmlNode.getChildElement('ERROR', null).getText();
                if(ObjectAPIName=='invoice__c'){
                    invoice__c invo=[select id,confirmOrderSF__c,confirmOrderTimeSF__c from invoice__c where id=:recordId limit 1][0];              
                    invo.confirmOrderSF__c='推送失败';
                    invo.sendOrderTimeSF__c=system.now();
                    update invo;
                }else{
                    receipt__c rece=[select id,confirmOrderSF__c,confirmOrderTimeSF__c from receipt__c where id=:recordId limit 1][0];
                    
                    rece.confirmOrderSF__c='推送失败';
                    rece.confirmOrderTimeSF__c=system.now();
                    update rece;
                }
                logClass.returnLog('失败', '未处理', '获取错误编码：'+code1+';错误信息：'+error, '正常');
            }
         }catch(Exception e){
            logClass.returnLog('失败', '未处理', '失败信息：'+e.getMessage(), '正常');
         }
    }*/
    public static String createOrderId(){
        Datetime nowDate =System.now();
        String nowStr=nowDate.format('yyyyMMddHHmmss');
        //Double ran = Math.random();
        String orderId='OID'+nowStr;
        return orderId;
    }
}