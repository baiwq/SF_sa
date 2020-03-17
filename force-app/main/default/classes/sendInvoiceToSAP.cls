public class sendInvoiceToSAP{
    public boolean sendInvoiceToSAP(Set<Id> idList){
        List<log__c> logList = new List<log__c>();
        Boolean sussessFLg = true;
        List<invoice__c> headList = new List<invoice__c>();
        try{            
            headList = [select id,Name,invoiceCompanyCode__c,taxRate__c from invoice__c where id in :idList];
            List<invoiceItem__c> items = new List<invoiceItem__c>();
            for(invoice__c head : headList){
                List<invoiceItem__c> itemList = [select id,Name,pushSAPTime__c,invoice__c,invoiceName__c,contractNumber__c,sumAmount__c,tax__c,invoiceNumber__c,SAPDocumentNo__c,sendBackTime__c,invoiceCompanyCode__c,AccountCode__c,invoiceAmount__c, ALLBHS_SAP__c, ALLHS_SAP__c, ALL_SAP__c from invoiceItem__c where invoice__c =:head.id and SAPDocumentNo__c = null];
                System.Debug('AAAA');                           
                for(invoiceItem__c item : itemList){
                    if(item.SAPDocumentNo__c==null||item.SAPDocumentNo__c.trim().equals('')){
                        System.Debug('AAAB'); 
                        Integer count = 1;
                        OrgCurrencyZfiDocumentGeneral.CURRENCY_ZFI_DOCUMENT_GENERALSOAP inVoiceInfoObj = new OrgCurrencyZfiDocumentGeneral.CURRENCY_ZFI_DOCUMENT_GENERALSOAP();
                        //声明所需的参数
                        //凭证总账行科目
                        List<OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType> GENERAL_LEDGER = new List<OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType>();
                        //凭证应收行
                        List<OrgCurrencyZfiDocumentGeneral.RECEIVABLESType> RECEIVABLES = new List<OrgCurrencyZfiDocumentGeneral.RECEIVABLESType>();
                        //凭证应付行-省略
                        List<OrgCurrencyZfiDocumentGeneral.PAYABLESType> PAYABLES= new List<OrgCurrencyZfiDocumentGeneral.PAYABLESType>();
                        //金额
                        List<OrgCurrencyZfiDocumentGeneral.AMOUNTType> AMOUNT= new List<OrgCurrencyZfiDocumentGeneral.AMOUNTType>();
                        //扩展行
                        List<OrgCurrencyZfiDocumentGeneral.EXTENSION2Type> EXTENSION2= new List<OrgCurrencyZfiDocumentGeneral.EXTENSION2Type>();
                        //Tax
                        List<OrgCurrencyZfiDocumentGeneral.TAXType> TaxType= new List<OrgCurrencyZfiDocumentGeneral.TAXType>();
                        //抬头
                        OrgCurrencyZfiDocumentGeneral.HEADType HEAD1 = new OrgCurrencyZfiDocumentGeneral.HEADType();
                        HEAD1.COMP_CODE = head.invoiceCompanyCode__c;
                        System.Debug('AAAC'); 
                        HEAD1.HEADER_TXT = '';
                        HEAD1.DOC_DATE = datetime.newinstance(Date.valueOf(item.sendBackTime__c.substring(0,10)).year(),Date.valueOf(item.sendBackTime__c.substring(0,10)).month(), Date.valueOf(item.sendBackTime__c.substring(0,10)).day()).format('yyyyMMdd');
                        HEAD1.PSTNG_DATE = datetime.newinstance(Date.valueOf(item.sendBackTime__c.substring(0,10)).year(),Date.valueOf(item.sendBackTime__c.substring(0,10)).month(), Date.valueOf(item.sendBackTime__c.substring(0,10)).day()).format('yyyyMMdd');
                        HEAD1.DOC_TYPE = 'DR';
                        System.Debug('AAAD'); 
                        //凭证总账行科目0510190000
                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGER = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                        single_GENERAL_LEDGER.ITEMNO_ACC = String.valueOf(count);
                        single_GENERAL_LEDGER.GL_ACCOUNT = '0510190000';
                        single_GENERAL_LEDGER.ALLOC_NMBR = item.contractNumber__c;
                        single_GENERAL_LEDGER.ITEM_TEXT = item.contractNumber__c + ' 税控开票收入 ' + item.invoiceNumber__c;
                        single_GENERAL_LEDGER.TRADE_ID = '';
                        GENERAL_LEDGER.add(single_GENERAL_LEDGER);
                        //金额
                        //扣税额  
                        System.Debug('AAAE');                      
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT1 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNT1.ITEMNO_ACC = String.valueOf(count);
                        single_AMOUNT1.CURRENCY_x = 'RMB';
                        single_AMOUNT1.AMT_DOCCUR = '-' + item.ALLBHS_SAP__c;
                        AMOUNT.add(single_AMOUNT1);
                        count = count + 1;
                        //凭证总账行科目0217101020
                        System.Debug('AAAF');
                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGER2 = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                        single_GENERAL_LEDGER2.ITEMNO_ACC = String.valueOf(count);
                        single_GENERAL_LEDGER2.GL_ACCOUNT = '0217101020';
                        single_GENERAL_LEDGER2.ALLOC_NMBR = item.contractNumber__c;
                        single_GENERAL_LEDGER2.ITEM_TEXT = item.contractNumber__c + ' 税控开票收入 ' + item.invoiceNumber__c;
                        single_GENERAL_LEDGER2.TRADE_ID = '';
                        GENERAL_LEDGER.add(single_GENERAL_LEDGER2);
                        //金额
                        //税额
                        System.Debug('AAAG');
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT2 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNT2.ITEMNO_ACC = String.valueOf(count);
                        single_AMOUNT2.CURRENCY_x = 'RMB';
                        single_AMOUNT2.AMT_DOCCUR = '-' + item.ALLHS_SAP__c;
                        AMOUNT.add(single_AMOUNT2);
                        count = count + 1;
                        //凭证应收行
                        System.Debug('AAAH');
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLES = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        single_RECEIVABLES.ITEMNO_ACC = String.valueOf(count);
                        single_RECEIVABLES.CUSTOMER = item.AccountCode__c;
                        //single_RECEIVABLES.CUSTOMER = 'C00001';
                        single_RECEIVABLES.ALLOC_NMBR = item.contractNumber__c;
                        single_RECEIVABLES.ITEM_TEXT = item.contractNumber__c + ' 税控开票收入 ' + item.invoiceNumber__c;
                        RECEIVABLES.add(single_RECEIVABLES);
                        //金额
                        System.Debug('AAAI');
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT3 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNT3.ITEMNO_ACC = String.valueOf(count);
                        single_AMOUNT3.CURRENCY_x = 'RMB';
                        single_AMOUNT3.AMT_DOCCUR = String.valueof(item.ALL_SAP__c);
                        AMOUNT.add(single_AMOUNT3);
                        //扩展字段列表
                        System.Debug('AAAJ');
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_1.STRUCTURE = 'BSCHL';
                        single_EXTENSION2_1.VALUEPART1 = String.valueOf(count);
                        single_EXTENSION2_1.VALUEPART2 = '09';
                        EXTENSION2.add(single_EXTENSION2_1);
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_2 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_2.STRUCTURE = 'UMSKZ';
                        single_EXTENSION2_2.VALUEPART1 = String.valueOf(count);
                        single_EXTENSION2_2.VALUEPART2 = '2';
                        EXTENSION2.add(single_EXTENSION2_2);
                        OrgCurrencyZfiDocumentGeneral.CurrenyOutputRootType inVoiceInfoResponse = inVoiceInfoObj.ZFI_DOCUMENT_GENERAL(HEAD1,AMOUNT,EXTENSION2,GENERAL_LEDGER,PAYABLES,RECEIVABLES,TaxType);
                        System.Debug('AAAK');
                        if(inVoiceInfoResponse.BELNR!=null){
                            item.SAPDocumentNo__c = inVoiceInfoResponse.BELNR;
                            System.Debug('AAAL');
                            item.pushSAPTime__c = system.now();
                            items.add(item);
                            log__c log1 =LogClass.reLog('成功','已处理','【推送开票信息给Sap】开票号：' + item.Name + '，Sap返回凭证号：' + inVoiceInfoResponse.BELNR,'正常');
                            logList.add(log1);
                        }else{                          
                            
                            item.pushSAPTime__c = system.now();
                            items.add(item);
                            //写入日志
                            List<OrgCurrencyZfiDocumentGeneral.RETURNTypes> list_return = new List<OrgCurrencyZfiDocumentGeneral.RETURNTypes>();
                            list_return = inVoiceInfoResponse.RETURN_x;
                            String errMsg='';
                            for(OrgCurrencyZfiDocumentGeneral.RETURNTypes returnObj:list_return){
                                errMsg = errMsg + '，' + returnObj.MESSAGE;
                            }
                            log__c log2 =LogClass.reLog('失败','未处理','【推送开票信息给Sap】开票号：' + item.Name + '，Sap返回错误信息：' + errMsg,'重要');
                            logList.add(log2);
                            if(sussessFLg){
                                sussessFLg = false;
                            }
                        }
                    }    
                }
            }
            //更新日志
            LogClass.insertLog(logList);
            //更新凭证号
            if(headList.size()>0){
                if(items.size()>0){
                    update items;
                }  
            }
        }catch(Exception e){
            LogClass.returnLog('失败','未处理','【推送开票信息给Sap】Sosp系统：' + e.getMessage()+ ':' + headList,'重要');
            System.Debug('BBBB:'+ e);
            sussessFLg = false;
        }
        return sussessFLg;
    }
}