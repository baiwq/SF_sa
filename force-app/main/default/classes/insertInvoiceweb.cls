global class insertInvoiceweb{

       webservice  static boolean insertInvoice(String sId){
        //id为开票ID
        Boolean breakFlg = false;
        String nullMessage = ''; 
        Boolean sussessFLg = true; 
        String tbSta='';
        try{
            EsbMossInsertContractInvoice EIC = new EsbMossInsertContractInvoice();
            
            EsbMossInsertContractInvoice.ESB_MOSS_InsertContractInvoiceSOAP insertObject = new EsbMossInsertContractInvoice.ESB_MOSS_InsertContractInvoiceSOAP();
            EsbMossInsertContractInvoice.InsertContractInvoiceType insertInvoiceResponse = new EsbMossInsertContractInvoice.InsertContractInvoiceType();
            EsbMossInsertContractInvoice.InsertContractInvoiceInputType inRequest = new EsbMossInsertContractInvoice.InsertContractInvoiceInputType();
            
            invoice__c invoiceObject = new invoice__c();
            invoiceObject = [SELECT id,Name,postOrNot__c,billingMachine__c,accountName__c,taxpayerCode__c,invoiceAddress__c,accountPhone__c,bank__c,bankAccount__c, isIncludingTaxCode__c,invoiceAmountSum__c, invoiceTypeCode__c,taxRate__c,commentsInterface__c,isWriteListCode__c,CreatedDate,invoiceCompanyCode__c,invoiceCompany__c from invoice__c where id=:sId][0];
            inRequest.ApplicationID = invoiceObject.billingMachine__c;
            inRequest.CustomerName = invoiceObject.accountName__c;
            inRequest.TaxCode = invoiceObject.taxpayerCode__c;        
            inRequest.CustomerAddress = invoiceObject.invoiceAddress__c;
            inRequest.CustomerPhone = invoiceObject.accountPhone__c;
            
            inRequest.CustomerBankName = invoiceObject.bank__c;
            inRequest.CustomerAccountNum = invoiceObject.bankAccount__c;
            inRequest.IsIncludingTax = invoiceObject.isIncludingTaxCode__c;
            //inRequest.IsIncludingTax = 'true';
            inRequest.SumAmount = String.valueOf(invoiceObject.invoiceAmountSum__c);
            inRequest.InvoiceType = invoiceObject.invoiceTypeCode__c;//需要编码
            inRequest.TaxRate = invoiceObject.taxRate__c;
            inRequest.Remarks = invoiceObject.commentsInterface__c;
            inRequest.IsWriteList = invoiceObject.isWriteListCode__c;
            //inRequest.IsWriteList = 'false';
            inRequest.IsValid = '1';
            //inRequest.IsValid='true';
            //inRequest.CreateTime = String.valueOf(invoiceObject.CreatedDate.format('yyyy-MM-dd HH:mm:ss'));
            inRequest.CreateTime = String.valueOf(System.now().format('yyyy-MM-dd HH:mm:ss'));            
            inRequest.InvoiceCompanyID = invoiceObject.invoiceCompanyCode__c;
            inRequest.InvoiceCompanyName = invoiceObject.invoiceCompany__c;
            if(invoiceObject.postOrNot__c){
                inRequest.IsMail ='1';
            }else{
                inRequest.IsMail ='0';
            }
            //合同号从开票项上任取一个
            String contractNo;
            List<invoiceitem__c> invoiceItemList=[SELECT contractNumber__c from invoiceitem__c where invoice__c=:sId and contractNumber__c!=null];
            if(invoiceItemList.size()>0){
                contractNo = invoiceItemList[0].contractNumber__c;
            }else{
                breakFlg = true;
                nullMessage = nullMessage + '开票项上无合同；';
            }
            inRequest.ContractCode = contractNo ;
            inRequest.ReadFlag = '0';
            
            
            if(String.valueOf(invoiceObject.invoiceAmountSum__c)==null){
                breakFlg = true;
                nullMessage = nullMessage + '总金额字段为空；';
            }
            if(invoiceObject.invoiceTypeCode__c==null){
                breakFlg = true;
                nullMessage = nullMessage + '发票类型字段为空；';
            }
            if(invoiceObject.taxRate__c==null){
                breakFlg = true;
                nullMessage = nullMessage + '税率字段为空；';
            }
            if(invoiceObject.isWriteListCode__c==null){
                breakFlg = true;
                nullMessage = nullMessage + '是否开清单字段为空；';
            }
            
            EsbMossInsertContractInvoice.ArrayDetailInputType inRequestArray = new EsbMossInsertContractInvoice.ArrayDetailInputType();   
            List<EsbMossInsertContractInvoice.ContractInvoiceDetail> sInvoList = new List<EsbMossInsertContractInvoice.ContractInvoiceDetail>();
            
            List<goodsName__c> invoiceItemObjectList = new List<goodsName__c>();
            invoiceItemObjectList = [SELECT Id,UUID__c,Name,specificationsModel__c,unit__c,quantity__c,amount__c from goodsName__c where invoice__c=:sId Order by CreatedDate Asc];
            integer intCount = 1;
            for(goodsName__c item:invoiceItemObjectList){
                 EsbMossInsertContractInvoice.ContractInvoiceDetail inRequestDetail = new EsbMossInsertContractInvoice.ContractInvoiceDetail();
                 inRequestDetail.ID = item.UUID__c;
                 inRequestDetail.ApplicationID = invoiceObject.billingMachine__c;
                 inRequestDetail.SpecificationsModel = item.specificationsModel__c;
                 inRequestDetail.GoodsName = item.Name;
                 inRequestDetail.Unit = item.unit__c;
                 inRequestDetail.Quantity= String.valueOf(item.quantity__c);
                 inRequestDetail.AmontMoney= String.valueOf(item.amount__c);
                 inRequestDetail.InvoiceCount= String.valueOf(intCount);
                 sInvoList.add(inRequestDetail);
                 intCount = intCount + 1;
                 if(String.valueOf(item.quantity__c)==null){
                    breakFlg = true;
                    nullMessage = nullMessage + '数量字段为空；';
                 }
                 if(String.valueOf(item.amount__c)==null){
                    breakFlg = true;
                    nullMessage = nullMessage + '开票金额字段为空；';
                 }
            }

            inRequestArray.ContractInvoiceDetail = sInvoList;
            insertObject.timeout_x = 90000;
            
            if(breakFlg){
                //有空值字段，停止插入
                tbSta = '同步失败';
                LogClass.returnLog('失败','未处理','【推送开票信息到中间库】开票编号：' + invoiceObject.Name + '。' + nullMessage,'重要');
            }else{
                system.debug('ada----ada');
                insertInvoiceResponse = insertObject.ESB_MOSS_InsertContractInvoice(inRequest,inRequestArray);                
                if(insertInvoiceResponse.ResultFlag=='S'){
                    tbSta = '同步成功';
                    LogClass.returnLog('成功','已处理','【推送开票信息到中间库】开票系统编号：' + sId + '推送成功','正常');
                    sussessFLg = true;
                }else{
                    tbSta = '同步失败';
                    LogClass.returnLog('失败','未处理','【推送开票信息到中间库】开票编号：' + invoiceObject.Name + '。 Esb返回:' + insertInvoiceResponse.Message,'重要');
                    sussessFLg = false;
                }
                
             }    
         }catch(Exception e){
            tbSta = '同步失败';
            LogClass.returnLog('失败','未处理','【推送开票信息到中间库】开票系统编号：' + sId + '。Sosp返回错误消息:' + e.getMessage(),'重要');
            sussessFLg = false;
         }
         if(sId!=null){
             invoice__c invoiceObject2 = new invoice__c();
             invoiceObject2.id = sId;
             invoiceObject2.pushSKJStatus__c = tbSta;
             invoiceObject2.pushSKJTime__c = System.now();
             update invoiceObject2;
         }
         return sussessFLg;
    }
}