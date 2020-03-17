public class returnPoolToSAP {
    
    public boolean returnPoolToSAP(Map<String,String> m){
        List<log__c> logList = new List<log__c>();
        System.debug('mmmm'+m.size());
        Boolean successFlag=true;
        try{
            set<String> sid = new set<String>();
            for(String s : m.keySet()){
                sid.add(s);
            }
            
            List<returnPool__c> rpList = [select id,ID_18__c,Name,contractAccountCode__c,dateOfPromise__c,type1__c,interfaceAmount__c,invoiceUnit__c,accountImport__c,contractSAP__c,ConfirmTime__c,finalSynchronizationStatus__c,finalSyncTime__c,accountCodeD__c,bankofissue__c,amount__c,needAssignAmount__c,recordType__c, accountName__c,accountCode__c,category__c,numberofDraft__c,date__c,SAPDocumentNo__c,returnCompanyCode__c,temporaryIsExcited__c from returnPool__c where ID_18__c in : sid];
            System.debug('rrpList:' +rpList.size());
            for(returnPool__c rp : rpList){
                OrgCurrencyZfiDocumentGeneral.CURRENCY_ZFI_DOCUMENT_GENERALSOAP returnInfoObj = new OrgCurrencyZfiDocumentGeneral.CURRENCY_ZFI_DOCUMENT_GENERALSOAP();
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
                HEAD1.COMP_CODE = rp.returnCompanyCode__c;
                //HEAD1.COMP_CODE = 'CC01';
                HEAD1.HEADER_TXT = '';
                //if(rp.recordType__c=='承兑汇票'){
                //    HEAD1.DOC_DATE = datetime.newinstance(rp.dateOfPromise__c.year(),rp.dateOfPromise__c.month(), rp.dateOfPromise__c.day()).format('yyyyMMdd');
                //}else{
                    HEAD1.DOC_DATE = datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd');
                //}
                HEAD1.PSTNG_DATE = m.get(rp.ID_18__c);
                //log__c la =LogClass.reLog('失败','未处理','rp,id:' +rp.id,'重要');
                //logList.add(la);
                //HEAD1.DOC_DATE = '20161031';
                //HEAD1.PSTNG_DATE = '20161031';
                if(rp.SAPDocumentNo__c==null){
                    if(rp.category__c=='投标保证金'||rp.category__c=='履约保证金'){
                        HEAD1.DOC_TYPE = 'ZV';
                    }
                    if(rp.category__c=='货款'){
                        if(rp.returnCompanyCode__c=='CC01'||rp.returnCompanyCode__c=='CC03'||rp.returnCompanyCode__c=='CC11'||rp.returnCompanyCode__c=='CC21'){
                            HEAD1.DOC_TYPE = 'DZ';
                        }
                        if(rp.returnCompanyCode__c=='CC08'||rp.returnCompanyCode__c=='CC09'||rp.returnCompanyCode__c=='CC23'||rp.returnCompanyCode__c=='U003'||rp.returnCompanyCode__c=='CC02'||rp.returnCompanyCode__c=='U004'){
                            HEAD1.DOC_TYPE = 'ZV';
                        }
                    }
                    
                }else{
                    HEAD1.DOC_TYPE = 'AB';
                }
                if(rp.category__c=='货款'){
                    Integer count=1;
                    //金额
                    OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT1 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                    single_AMOUNT1.ITEMNO_ACC = String.valueOf(count);
                    single_AMOUNT1.CURRENCY_x = 'RMB';
                    single_AMOUNT1.AMT_DOCCUR = Math.abs(rp.interfaceAmount__c).format().replace(',','');
                    //system.debug('Double.valueOf(rp.amount__c).format()---'+Double.valueOf(rp.amount__c).format());
                    //single_AMOUNT1.AMT_DOCCUR =  '30000';
                    AMOUNT.add(single_AMOUNT1);
                    if(rp.recordType__c=='电汇'){
                        //凭证总账行科目0510190000
                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGER = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                        single_GENERAL_LEDGER.ITEMNO_ACC = String.valueOf(count);
                        single_GENERAL_LEDGER.GL_ACCOUNT = '0100201088';
                        single_GENERAL_LEDGER.ALLOC_NMBR = returnFen(rp.contractSAP__c);
                        single_GENERAL_LEDGER.ITEM_TEXT =returnStr('101 '+rp.contractSAP__c+' 到款 '+rp.accountImport__c);
                        //single_GENERAL_LEDGER.ITEM_TEXT = '101 '+''+' 到款 '+'';
                        single_GENERAL_LEDGER.TRADE_ID ='';
                        GENERAL_LEDGER.add(single_GENERAL_LEDGER);
                        //扩展行
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_1.STRUCTURE = 'RSTGR';
                        single_EXTENSION2_1.VALUEPART1 = String.valueOf(count);
                        single_EXTENSION2_1.VALUEPART2 = '101';
                        EXTENSION2.add(single_EXTENSION2_1);
                        count++;
                    }
                    if(rp.recordType__c=='承兑汇票'){
                        //凭证应收行
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLES = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        single_RECEIVABLES.ITEMNO_ACC = String.valueOf(count);
                        //single_RECEIVABLES.CUSTOMER = t.AccountCode__c;
                        //分配
                        single_RECEIVABLES.CUSTOMER = rp.contractAccountCode__c;
                        //single_RECEIVABLES.CUSTOMER = 'C00001';
                        if(rp.type1__c=='银行承兑汇票'){
                            single_RECEIVABLES.ALLOC_NMBR = returnFen(rp.numberofDraft__c);
                        }else{
                            single_RECEIVABLES.ALLOC_NMBR = returnFen(rp.numberofDraft__c);
                        }
                        
                        single_RECEIVABLES.ITEM_TEXT = returnStr(rp.numberofDraft__c+' 承兑汇票到款 '+rp.invoiceUnit__c);
                        single_RECEIVABLES.BlineDate =datetime.newinstance(rp.dateOfPromise__c.year(),rp.dateOfPromise__c.month(), rp.dateOfPromise__c.day()).format('yyyyMMdd');
                        RECEIVABLES.add(single_RECEIVABLES);
                        //扩展行
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_2 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_2.STRUCTURE = 'BSCHL';
                        single_EXTENSION2_2.VALUEPART1 = String.valueOf(count);
                        single_EXTENSION2_2.VALUEPART2 = '09';
                        EXTENSION2.add(single_EXTENSION2_2);
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_3 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_3.STRUCTURE = 'UMSKZ';
                        single_EXTENSION2_3.VALUEPART1 = String.valueOf(count);
                        if(rp.type1__c=='商业承兑汇票'){
                            single_EXTENSION2_3.VALUEPART2 = 'N';
                        }
                        if(rp.type1__c=='银行承兑汇票'){
                            single_EXTENSION2_3.VALUEPART2 = 'B';
                        }   
                        EXTENSION2.add(single_EXTENSION2_3);
                        
                        count++;
                    }
                    
                    List<returnItem__c> riList = [select amount__c,contractName__c,center__c,incomeType__c,accountCode__c,accountName__c from returnItem__c where returnPool__c=:rp.Id];
                    for(returnItem__c ri : riList){
                        //应收
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLES2 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        single_RECEIVABLES2.ITEMNO_ACC = String.valueOf(count);
                        single_RECEIVABLES2.CUSTOMER=ri.accountCode__c;
                        //single_RECEIVABLES2.CUSTOMER = 'C00001';
                        single_RECEIVABLES2.ALLOC_NMBR = returnFen(ri.contractName__c);
                        if(rp.recordType__c=='承兑汇票'){
                            if(ri.incomeType__c=='预收款'){
                                single_RECEIVABLES2.ITEM_TEXT=returnStr(ri.contractName__c+' 承兑汇票到款 ' +rp.numberofDraft__c+ ' 转预收 '+rp.invoiceUnit__c);
                            }
                            if(ri.incomeType__c=='应收款'){
                                single_RECEIVABLES2.ITEM_TEXT=returnStr(ri.contractName__c+' 承兑汇票到款 ' +rp.numberofDraft__c+ ' 冲应收 '+rp.invoiceUnit__c);
                            }
                            
                            
                        }else{
                            single_RECEIVABLES2.ITEM_TEXT=returnStr('101 ' +ri.contractName__c+' '+ri.incomeType__c+' '+rp.accountImport__c);
                            
                        }
                        if(ri.incomeType__c=='预收款'){
                            //预收扩展行
                            OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                            single_EXTENSION2_1.STRUCTURE = 'BSCHL';
                            single_EXTENSION2_1.VALUEPART1 = String.valueOf(count);
                            single_EXTENSION2_1.VALUEPART2 = '19';
                            EXTENSION2.add(single_EXTENSION2_1);
                            OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_2 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                            single_EXTENSION2_2.STRUCTURE = 'UMSKZ';
                            single_EXTENSION2_2.VALUEPART1 = String.valueOf(count);
                            single_EXTENSION2_2.VALUEPART2 = '1';
                            EXTENSION2.add(single_EXTENSION2_2);    
                        }
                        if(ri.incomeType__c=='应收款'){
                            //应收扩展行
                            OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                            single_EXTENSION2_1.STRUCTURE = 'BSCHL';
                            single_EXTENSION2_1.VALUEPART1 = String.valueOf(count);
                            if(rp.recordType__c=='电汇'){
                                if(ri.center__c=='四方三伊'){
                                    single_EXTENSION2_1.VALUEPART2 = '15';
                                }else{
                                    single_EXTENSION2_1.VALUEPART2 = '17';
                                }
                                
                            }else{
                                single_EXTENSION2_1.VALUEPART2 = '15';
                            }
                            
                            EXTENSION2.add(single_EXTENSION2_1);
                            
                        }
                        RECEIVABLES.add(single_RECEIVABLES2);
                        //金额
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT2 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNT2.ITEMNO_ACC = String.valueOf(count);
                        single_AMOUNT2.CURRENCY_x = 'RMB';
                        single_AMOUNT2.AMT_DOCCUR ='-'+Math.abs(ri.amount__c).format().replace(',','');
                        //single_AMOUNT2.AMT_DOCCUR =  '-20000';
                        AMOUNT.add(single_AMOUNT2);
                        count++;
                    }
                   /* if(rp.temporaryIsExcited__c==true){
                        //应收行
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLES3 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        //暂收扩展行
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_4 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_5 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        if(rp.recordType__c=='电汇'){
                            single_RECEIVABLES3.ITEMNO_ACC = String.valueOf(rp.itemCount__c+2);
                            //出票单位***客户名
                            single_RECEIVABLES3.ITEM_TEXT =returnStr( '101 暂收款 '+rp.accountImport__c);
                            //扩展行行号
                            single_EXTENSION2_4.VALUEPART1 = String.valueOf(rp.itemCount__c+1);
                            single_EXTENSION2_5.VALUEPART1 = String.valueOf(rp.itemCount__c+1);
                        }
                        if(rp.recordType__c=='承兑汇票'){
                            single_RECEIVABLES3.ITEMNO_ACC = String.valueOf(rp.itemCount__c+2);
                            //出票单位****
                            single_RECEIVABLES3.ITEM_TEXT = returnStr('暂收款 预收承兑汇票 '+rp.numberofDraft__c+' '+rp.invoiceUnit__c);
                            //扩展行好
                            single_EXTENSION2_4.VALUEPART1 = String.valueOf(rp.itemCount__c+2);
                            single_EXTENSION2_5.VALUEPART1 = String.valueOf(rp.itemCount__c+2);
                        }
                        //single_RECEIVABLES3.CUSTOMER = t.AccountCode__c;
                        single_RECEIVABLES3.CUSTOMER = rp.accountCode__c;
                        //single_RECEIVABLES3.CUSTOMER = 'C00001';
                        single_RECEIVABLES3.ALLOC_NMBR = '';       
                        RECEIVABLES.add(single_RECEIVABLES3);
                        
                        single_EXTENSION2_4.STRUCTURE = 'BSCHL';
                    
                        single_EXTENSION2_4.VALUEPART2 = '19';
                        EXTENSION2.add(single_EXTENSION2_4);
                    
                        single_EXTENSION2_5.STRUCTURE = 'UMSKZ';
                    
                        single_EXTENSION2_5.VALUEPART2 = 'Z';
                        EXTENSION2.add(single_EXTENSION2_5);
                        //暂收金额
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNT3 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNT3.ITEMNO_ACC = String.valueOf(count);
                        single_AMOUNT3.CURRENCY_x = 'RMB';
                        single_AMOUNT3.AMT_DOCCUR ='-'+rp.needAssignAmount__c.format().replace(',','');
                        //single_AMOUNT3.AMT_DOCCUR =  '-10000';
                        AMOUNT.add(single_AMOUNT3);                    
                    } */                         
                }
                if(rp.category__c=='投标保证金'){
                    Integer countTB=1;
                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:投标保证金','重要');
                    //总账行1
                    //凭证总账行科目0100201088
                    OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGERTB1 = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                   
                    single_GENERAL_LEDGERTB1.ITEMNO_ACC = String.valueOf(countTB);
                    single_GENERAL_LEDGERTB1.GL_ACCOUNT = '0100201088';
                    single_GENERAL_LEDGERTB1.ALLOC_NMBR = returnFen(rp.bankofissue__c);
                    //single_GENERAL_LEDGERTB1.ALLOC_NMBR = '';
                    single_GENERAL_LEDGERTB1.ITEM_TEXT = returnStr(rp.accountImport__c+' 退保证金 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                    //single_GENERAL_LEDGERTB.ITEM_TEXT = '101 '+''+' 到款 '+'';
                    single_GENERAL_LEDGERTB1.TRADE_ID ='';
                    GENERAL_LEDGER.add(single_GENERAL_LEDGERTB1);
                    //金额1
                    OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB1 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                    single_AMOUNTTB1.ITEMNO_ACC = String.valueOf(countTB);
                    single_AMOUNTTB1.CURRENCY_x = 'RMB';
                    single_AMOUNTTB1.AMT_DOCCUR =  Math.abs(rp.interfaceAmount__c).format().replace(',','');
                    //single_AMOUNTTB1.AMT_DOCCUR =  '40000';
                    AMOUNT.add(single_AMOUNTTB1);
                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:金额','重要');
                    //扩展行1
                    OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_TB1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                    single_EXTENSION2_TB1.STRUCTURE = 'RSTGR';
                    single_EXTENSION2_TB1.VALUEPART1 = String.valueOf(countTB);
                    single_EXTENSION2_TB1.VALUEPART2 = '190';
                    EXTENSION2.add(single_EXTENSION2_TB1);
                    countTB++;
                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:扩展行','重要');
                    List<returnItem__c> TBList =[select Id,Name,accountCodeD__c,salesOwner__c,accountCodeLV__c,accountNameLV__c,accountCode__c,TBName__c,TtransferL__c,TtranzferZ__c,contractNOLY__c,amount__c,contractName__c,recordTypeName__c from returnItem__c where returnPool__c=:rp.id];
                    if(TBList.size()>0){
                        for(returnItem__c tb : TBList){
                            if(rp.interfaceAmount__c==0.00){
                                if(tb.TtransferL__c==true){
                                    //应收行 转履约  分配到履约保证金的C类客户,合同上
                                    OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESTB1 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                                    single_RECEIVABLESTB1.ITEMNO_ACC = String.valueOf(countTB);
                                    single_RECEIVABLESTB1.CUSTOMER = tb.accountCodeLV__c;
                                    //single_RECEIVABLESTB1.CUSTOMER = 'C100014';
                                    //履约所属合同号
                                    single_RECEIVABLESTB1.ALLOC_NMBR = returnFen(tb.contractNOLY__c);
                                    single_RECEIVABLESTB1.ITEM_TEXT = returnStr(tb.salesOwner__c+' '+rp.accountImport__c+' 投标转履约保证金 '+tb.TBName__c);
                                    RECEIVABLES.add(single_RECEIVABLESTB1);
                                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:5','重要');
                                    //金额
                                    OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB5 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                    single_AMOUNTTB5.ITEMNO_ACC = String.valueOf(countTB);
                                    single_AMOUNTTB5.CURRENCY_x = 'RMB';
                                    single_AMOUNTTB5.AMT_DOCCUR =  Math.abs(tb.amount__c).format().replace(',','');
                                    //single_AMOUNTTB5.AMT_DOCCUR =  '10000';
                                    AMOUNT.add(single_AMOUNTTB5);
                                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:6','重要');
                                    //扩展行
                                    OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_TB3 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                                    single_EXTENSION2_TB3.STRUCTURE = 'BSCHL';
                                    single_EXTENSION2_TB3.VALUEPART1 = String.valueOf(countTB);
                                    single_EXTENSION2_TB3.VALUEPART2 = '09';
                                    EXTENSION2.add(single_EXTENSION2_TB3);
                                    OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_TB4 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                                    single_EXTENSION2_TB4.STRUCTURE = 'UMSKZ';
                                    single_EXTENSION2_TB4.VALUEPART1 = String.valueOf(countTB);
                                    single_EXTENSION2_TB4.VALUEPART2 = 'C';
                                    EXTENSION2.add(single_EXTENSION2_TB4);
                                    countTB++;
                                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:7','重要');
                                    //应收行 转履约  分配到投标保证金的D类客户上
                                    OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESTB2 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                                    single_RECEIVABLESTB2.ITEMNO_ACC = String.valueOf(countTB);
                                    single_RECEIVABLESTB2.CUSTOMER = tb.accountCodeD__c;
                                    single_RECEIVABLESTB2.ALLOC_NMBR = returnFen(tb.TBName__c);
                                    //#合同号
                                    single_RECEIVABLESTB2.ITEM_TEXT = returnStr(tb.salesOwner__c+' '+rp.accountImport__c+' 投标转履约保证金 '+tb.contractNOLY__c);
                                    RECEIVABLES.add(single_RECEIVABLESTB2);
                                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:8','重要');
                                    //金额
                                    OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB6 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                    single_AMOUNTTB6.ITEMNO_ACC = String.valueOf(countTB);
                                    single_AMOUNTTB6.CURRENCY_x = 'RMB';
                                    single_AMOUNTTB6.AMT_DOCCUR ='-' + Math.abs(tb.amount__c).format().replace(',','');
                                    //single_AMOUNTTB6.AMT_DOCCUR =  '10000';
                                    AMOUNT.add(single_AMOUNTTB6);
                                    countTB++;       
                                   // LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:9','重要');
                                }
                            }else{
                                if(tb.recordTypeName__c=='利息'||tb.TtranzferZ__c==true){
                                    if(tb.recordTypeName__c=='利息'){
                                        //总账2利息1
                                        //凭证总账行科目0100201088
                                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGERTB2 = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                                        single_GENERAL_LEDGERTB2.ITEMNO_ACC = String.valueOf(countTB);
                                        single_GENERAL_LEDGERTB2.GL_ACCOUNT = '0100201088';
                                        single_GENERAL_LEDGERTB2.ALLOC_NMBR = returnFen(rp.bankofissue__c);
                                        //single_GENERAL_LEDGERTB2.ALLOC_NMBR = '';
                                        single_GENERAL_LEDGERTB2.ITEM_TEXT = returnStr(rp.accountImport__c+' 退保证金 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                                        //single_GENERAL_LEDGERTB2.ITEM_TEXT = '101 '+''+' 到款 '+'';
                                        single_GENERAL_LEDGERTB2.TRADE_ID='';
                                        GENERAL_LEDGER.add(single_GENERAL_LEDGERTB2);
                                        //金额2
                                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB2 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                        single_AMOUNTTB2.ITEMNO_ACC = String.valueOf(countTB);
                                        single_AMOUNTTB2.CURRENCY_x = 'RMB';
                                        single_AMOUNTTB2.AMT_DOCCUR =  Math.abs(tb.amount__c).format().replace(',','');
                                        //single_AMOUNTTB2.AMT_DOCCUR =  '50';
                                        AMOUNT.add(single_AMOUNTTB2);
                                        // 利息扩展 2
                                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_TB2 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                                        single_EXTENSION2_TB2.STRUCTURE = 'RSTGR';
                                        single_EXTENSION2_TB2.VALUEPART1 = String.valueOf(countTB);
                                        single_EXTENSION2_TB2.VALUEPART2 = '191';
                                        EXTENSION2.add(single_EXTENSION2_TB2);
                                        countTB++;
                                        //总账3，记录利息2
                                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGERTB3 = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                                        single_GENERAL_LEDGERTB3.ITEMNO_ACC = String.valueOf(countTB);
                                        single_GENERAL_LEDGERTB3.GL_ACCOUNT = '0550403000';
                                        single_GENERAL_LEDGERTB3.ALLOC_NMBR = returnFen(rp.bankofissue__c);
                                        //single_GENERAL_LEDGERTB3.ALLOC_NMBR = '';
                                        single_GENERAL_LEDGERTB3.ITEM_TEXT = returnStr(rp.accountImport__c+' 退保证金利息 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                                        //single_GENERAL_LEDGERTB3.ITEM_TEXT = '101 '+''+' 到款 '+'';
                                        single_GENERAL_LEDGERTB3.TRADE_ID='';
                                        GENERAL_LEDGER.add(single_GENERAL_LEDGERTB3);
                                        //总账 记录 金额2
                                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB3 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                        single_AMOUNTTB3.ITEMNO_ACC = String.valueOf(countTB);
                                        single_AMOUNTTB3.CURRENCY_x = 'RMB';
                                        single_AMOUNTTB3.AMT_DOCCUR ='-' + Math.abs(tb.amount__c).format().replace(',','');
                                        //single_AMOUNTTB3.AMT_DOCCUR =  '-50';
                                        AMOUNT.add(single_AMOUNTTB3);
                                        countTB++;    
                                    }
                                    if(tb.TtranzferZ__c==true){
                                        
                                        //log__c ll5 =LogClass.reLog('失败','未处理',rp.Name+':countTB:' +countTB,'重要');
                                    //logList.add(ll5);
                                    //总账 中标服务费
                                        OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGERTB3 = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                                        single_GENERAL_LEDGERTB3.ITEMNO_ACC = String.valueOf(countTB);
                                        single_GENERAL_LEDGERTB3.GL_ACCOUNT = '0114108000';
                                        single_GENERAL_LEDGERTB3.ALLOC_NMBR = returnFen(tb.TBName__c);
                                        //single_GENERAL_LEDGERTB3.ALLOC_NMBR = '';
                                        single_GENERAL_LEDGERTB3.ITEM_TEXT = returnStr(tb.salesOwner__c+' '+rp.accountImport__c+' 扣中标费 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                                        //single_GENERAL_LEDGERTB3.ITEM_TEXT = '101 '+''+' 到款 '+'';
                                        single_GENERAL_LEDGERTB3.TRADE_ID='';
                                        GENERAL_LEDGER.add(single_GENERAL_LEDGERTB3);
                                        //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:中标服务费；总账','重要');
                                        //中标费金额
                                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB4 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                        single_AMOUNTTB4.ITEMNO_ACC = String.valueOf(countTB);
                                        single_AMOUNTTB4.CURRENCY_x = 'RMB';
                                        single_AMOUNTTB4.AMT_DOCCUR = Math.abs(tb.amount__c).format().replace(',','');
                                        //single_AMOUNTTB4.AMT_DOCCUR =  '10000';
                                        AMOUNT.add(single_AMOUNTTB4);
                                        countTB++;
                                       // LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:2','重要');
                                        //应收行
                                        //应收行 中标服务费
                                        /*OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESTBFW3 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                                        single_RECEIVABLESTBFW3.ITEMNO_ACC = String.valueOf(countTB);
                                        single_RECEIVABLESTBFW3.CUSTOMER = tb.accountCodeD__c;
                                        single_RECEIVABLESTBFW3.ALLOC_NMBR = returnFen(tb.Name);
                                        single_RECEIVABLESTBFW3.ITEM_TEXT = returnStr(rp.accountImport__c+'保证金扣中标服务费 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                                        RECEIVABLES.add(single_RECEIVABLESTBFW3);
                                       // LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:3','重要');
                                        //金额
                                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTBFW5 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                        single_AMOUNTTBFW5.ITEMNO_ACC = String.valueOf(countTB);
                                        single_AMOUNTTBFW5.CURRENCY_x = 'RMB';
                                        single_AMOUNTTBFW5.AMT_DOCCUR = '-'+ Math.abs(tb.amount__c).format().replace(',','');
                                        //single_AMOUNTTBFW5.AMT_DOCCUR =  '10000';
                                        AMOUNT.add(single_AMOUNTTBFW5);
                                        countTB++;*/
                                        //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:4','重要');
                                    }   
                                
                                }else{
                                    //应收行 分配到投标保证金的D类客户上
                                    if(tb.TtranzferZ__c==false){
                                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESTB3 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                                        single_RECEIVABLESTB3.ITEMNO_ACC = String.valueOf(countTB);
                                        single_RECEIVABLESTB3.CUSTOMER = tb.accountCodeD__c;
                                        single_RECEIVABLESTB3.ALLOC_NMBR = returnFen(tb.TBName__c);
                                        single_RECEIVABLESTB3.ITEM_TEXT = returnStr(rp.accountImport__c+' 退保证金 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                                        RECEIVABLES.add(single_RECEIVABLESTB3);
                                        //金额
                                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB7 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                                        single_AMOUNTTB7.ITEMNO_ACC = String.valueOf(countTB);
                                        single_AMOUNTTB7.CURRENCY_x = 'RMB';
                                        single_AMOUNTTB7.AMT_DOCCUR ='-' + Math.abs(tb.amount__c).format().replace(',','');
                                        //single_AMOUNTTB7.AMT_DOCCUR =  '-10000';
                                        AMOUNT.add(single_AMOUNTTB7);
                                        countTB++;
                                    }
                                     
                                }
                            }
                        }
                    }
                    //暂收
                   /*if(rp.temporaryIsExcited__c==true){
                        //应收行
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESTB3 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        //暂收扩展行
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2TB_4 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2TB_5 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_RECEIVABLESTB3.ITEMNO_ACC = String.valueOf(countTB);
                        single_RECEIVABLESTB3.ITEM_TEXT = returnStr(rp.accountImport__c+ '暂收款 '+rp.date__c.format().replace('-',''));
                        //扩展行行号
                        single_EXTENSION2TB_4.VALUEPART1 = String.valueOf(countTB);
                        single_EXTENSION2TB_5.VALUEPART1 = String.valueOf(countTB);
                        //投标 分配D类客户
                        single_RECEIVABLESTB3.CUSTOMER = rp.accountCodeD__c;
                        single_RECEIVABLESTB3.ALLOC_NMBR = returnFen('暂收 '+rp.date__c.format().replace('-',''));       
                        RECEIVABLES.add(single_RECEIVABLESTB3);
                        
                        single_EXTENSION2TB_4.STRUCTURE = 'BSCHL';
                        
                        single_EXTENSION2TB_4.VALUEPART2 = '19';
                        EXTENSION2.add(single_EXTENSION2TB_4);
                        
                        single_EXTENSION2TB_5.STRUCTURE = 'UMSKZ';
                    
                        single_EXTENSION2TB_5.VALUEPART2 = 'Z';
                        EXTENSION2.add(single_EXTENSION2TB_5);
                        //暂收金额
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTTB3 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNTTB3.ITEMNO_ACC = String.valueOf(countTB);
                        single_AMOUNTTB3.CURRENCY_x = 'RMB';
                        single_AMOUNTTB3.AMT_DOCCUR ='-'+rp.needAssignAmount__c.format().replace(',','');
                        //single_AMOUNTTB3.AMT_DOCCUR =  '-10000';
                        AMOUNT.add(single_AMOUNTTB3);                    
                    }   */
                }
                if(rp.category__c=='履约保证金'){
                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]: 履约保证金','重要');
                    Integer countLV=1;
                    //金额
                    OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTLV1 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                    single_AMOUNTLV1.ITEMNO_ACC = String.valueOf(countLV);
                    single_AMOUNTLV1.CURRENCY_x = 'RMB';
                    single_AMOUNTLV1.AMT_DOCCUR =  Math.abs(rp.interfaceAmount__c).format().replace(',','');
                    //single_AMOUNTLV1.AMT_DOCCUR =  '40000';
                    AMOUNT.add(single_AMOUNTLV1);
                   // LogClass.returnLog('失败','未处理',+'[SOSP回款异常]: 2','重要');
                    //凭证总账行科目0510190000
                    OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType single_GENERAL_LEDGERLV = new OrgCurrencyZfiDocumentGeneral.GENERAL_LEDGERType();
                    single_GENERAL_LEDGERLV.ITEMNO_ACC = String.valueOf(countLV);
                    single_GENERAL_LEDGERLV.GL_ACCOUNT = '0100201088';
                    single_GENERAL_LEDGERLV.ALLOC_NMBR = returnFen(rp.bankofissue__c);
                    //single_GENERAL_LEDGERLV.ALLOC_NMBR = '';
                    single_GENERAL_LEDGERLV.ITEM_TEXT = returnStr(rp.accountImport__c+' 退履约保证金 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                    //single_GENERAL_LEDGER.ITEM_TEXT = '101 '+''+' 到款 '+'';
                    single_GENERAL_LEDGERLV.TRADE_ID ='';
                    GENERAL_LEDGER.add(single_GENERAL_LEDGERLV);
                    //扩展行
                   // LogClass.returnLog('失败','未处理',+'[SOSP回款异常]: 3','重要');
                    OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_LV1 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                    single_EXTENSION2_LV1.STRUCTURE = 'RSTGR';
                    single_EXTENSION2_LV1.VALUEPART1 = String.valueOf(countLV);
                    single_EXTENSION2_LV1.VALUEPART2 = '190';
                    EXTENSION2.add(single_EXTENSION2_LV1);
                    countLV++;
                    //LogClass.returnLog('失败','未处理',+'[SOSP回款异常]: 4','重要');
                    List<returnItem__c> lvList =[select id,accountCodeLV__c,accountNameLV__c,accountName__c,LYName__c,contractNOLY__c,amount__c,contractName__c from returnItem__c where returnPool__c = :rp.Id];
                    for(returnItem__c lv : lvList){
                        //凭证应收行
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESLV = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        single_RECEIVABLESLV.ITEMNO_ACC = String.valueOf(countLV);
                        single_RECEIVABLESLV.CUSTOMER = lv.accountCodeLV__c;
                        //single_RECEIVABLESLV.CUSTOMER = lv.accountNameLV__c;
                        //single_RECEIVABLESLV.ALLOC_NMBR = '';
                        //分配合同号
                        single_RECEIVABLESLV.ALLOC_NMBR = returnFen(lv.contractNOLY__c);
                        single_RECEIVABLESLV.ITEM_TEXT = returnStr(rp.accountImport__c+' 退履约保证金 '+datetime.newinstance(rp.date__c.year(),rp.date__c.month(), rp.date__c.day()).format('yyyyMMdd'));
                        RECEIVABLES.add(single_RECEIVABLESLV);
                        //扩展行1
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_LV2 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_LV2.STRUCTURE = 'BSCHL';
                        single_EXTENSION2_LV2.VALUEPART1 = String.valueOf(countLV);
                        single_EXTENSION2_LV2.VALUEPART2 = '19';
                        EXTENSION2.add(single_EXTENSION2_LV2);
                        //扩展行2
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2_LV3 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_EXTENSION2_LV3.STRUCTURE = 'UMSKZ';
                        single_EXTENSION2_LV3.VALUEPART1 = String.valueOf(countLV);
                        single_EXTENSION2_LV3.VALUEPART2 = 'C';
                        EXTENSION2.add(single_EXTENSION2_LV3);
                        //金额
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTLV2 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNTLV2.ITEMNO_ACC = String.valueOf(countLV);
                        single_AMOUNTLV2.CURRENCY_x = 'RMB';
                        single_AMOUNTLV2.AMT_DOCCUR = '-'+ Math.abs(lv.amount__c).format().replace(',','');
                        //single_AMOUNTLV2.AMT_DOCCUR =  '-40000';
                        AMOUNT.add(single_AMOUNTLV2);
                        countLV++;
                    }
                    /*if(rp.temporaryIsExcited__c==true){
                        //应收行
                        OrgCurrencyZfiDocumentGeneral.RECEIVABLESType single_RECEIVABLESLV3 = new OrgCurrencyZfiDocumentGeneral.RECEIVABLESType();
                        //暂收扩展行
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2LV_4 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        OrgCurrencyZfiDocumentGeneral.EXTENSION2Type single_EXTENSION2LV_5 = new OrgCurrencyZfiDocumentGeneral.EXTENSION2Type();
                        single_RECEIVABLESLV3.ITEMNO_ACC = String.valueOf(countLV);
                        single_RECEIVABLESLV3.ITEM_TEXT = returnStr(rp.accountImport__c+' 暂收款 '+rp.date__c.format().replace('-',''));
                        //扩展行行号
                        single_EXTENSION2LV_4.VALUEPART1 = String.valueOf(countLV);
                        single_EXTENSION2LV_5.VALUEPART1 = String.valueOf(countLV);
                        single_RECEIVABLESLV3.CUSTOMER = rp.accountCode__c;
                        single_RECEIVABLESLV3.ALLOC_NMBR = '';       
                        RECEIVABLES.add(single_RECEIVABLESLV3);
                    
                        single_EXTENSION2LV_4.STRUCTURE = 'BSCHL';
                    
                        single_EXTENSION2LV_4.VALUEPART2 = '19';
                        EXTENSION2.add(single_EXTENSION2LV_4);
                    
                        single_EXTENSION2LV_5.STRUCTURE = 'UMSKZ';
                        
                        single_EXTENSION2LV_5.VALUEPART2 = 'Z';
                        EXTENSION2.add(single_EXTENSION2LV_5);
                        //暂收金额
                        OrgCurrencyZfiDocumentGeneral.AMOUNTType single_AMOUNTLV3 = new OrgCurrencyZfiDocumentGeneral.AMOUNTType();
                        single_AMOUNTLV3.ITEMNO_ACC = String.valueOf(countLV);
                        single_AMOUNTLV3.CURRENCY_x = 'RMB';
                        single_AMOUNTLV3.AMT_DOCCUR ='-'+rp.needAssignAmount__c.format().replace(',','');
                        //single_AMOUNTLV3.AMT_DOCCUR =  '-10000';
                        AMOUNT.add(single_AMOUNTLV3);                    
                    }*/
            
                }
                
                OrgCurrencyZfiDocumentGeneral.CurrenyOutputRootType returnInfoResponse = returnInfoObj.ZFI_DOCUMENT_GENERAL(HEAD1,AMOUNT,EXTENSION2,GENERAL_LEDGER,PAYABLES,RECEIVABLES,TaxType);
                List<OrgCurrencyZfiDocumentGeneral.RETURNTypes> list_return1 = new List<OrgCurrencyZfiDocumentGeneral.RETURNTypes>();
                list_return1 = returnInfoResponse.RETURN_x;
                   
                if(list_return1.size()>0){
                    OrgCurrencyZfiDocumentGeneral.RETURNTypes returnObj1 = new OrgCurrencyZfiDocumentGeneral.RETURNTypes();
                    returnObj1 = list_return1[0];
                    
                    if(returnObj1.TYPE_x=='S'){
                        if(rp.SAPDocumentNo__c==null){
                            rp.SAPDocumentNo__c = returnInfoResponse.BELNR;
                            
                        }
                        //上次同步日期
                        rp.finalSyncTime__c=system.now();
                        //无暂收最终同步状态
                        //if(rp.temporaryIsExcited__c==false){
                        rp.finalSynchronizationStatus__c=true;
                        //}                        
                                           
                        log__c l3 =LogClass.reLog('成功','已处理','【SAP回款】:Sap返回回款凭证：' + returnInfoResponse.BELNR,'正常');
                        logList.add(l3);
                    }else{
                        successFlag=false;
                        String mess = '';
                        for(OrgCurrencyZfiDocumentGeneral.RETURNTypes sMo:list_return1){
                            mess = mess + sMo.MESSAGE + ';';
                        }
                        log__c l4 =LogClass.reLog('失败','未处理','【SAP回款】:返回错误信息:' +rp.Name+':'+ mess,'重要');
                        logList.add(l4);
                    }
                }else{
                    log__c l5 =LogClass.reLog('失败','未处理','【SAP回款】:Sap返回回款凭证：' + '返回值为空','重要');
                    logList.add(l5);
                }
                
            }
            update rpList;
            LogClass.insertLog(logList);
        }catch(Exception e){
            successFlag=false;
            LogClass.returnLog('失败','未处理',+'[SOSP回款异常]:'+e.getMessage(),'重要');
        }
        return successFlag;
    }
    public static String returnStr(String text){
        String str='';
        if(text.length()>50){
            str=text.substring(0, 50);
        }else{
            str = text;
        }
        return str;
    }
    public static String returnFen(String text){
        String str='';
        if(text.length()>18){
            str=text.substring(0, 18);
        }else{
            str = text;
        }
        return str;
    }
}