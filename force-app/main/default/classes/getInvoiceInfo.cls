public class getInvoiceInfo {
    public  integer getNumByArray(String sListString,String sCon){
        List<String> sList = sListString.split(',');
        for(integer i=0;i<sList.size();i++){
            if(sList[i]==sCon){
                integer re = i + 1;
                return re;
            }
        }
        return 0;
    }
    //s-发票类型    t-作废状态
    public String getDescByValue(String type,String value){
        String descr;
        if(type=='s'){
            if(value=='0'){
                descr = '专用';
            }else{
                descr= '普通';
            }
        }else{
            if(value=='1'){
                descr= '作废';
            }else{
                descr= '正常';
            }
        }
        return descr;
    }
    
    public String ConvertToDateString(String str){
       String temp = '';
       String Pre = str.subString(0,str.indexOf(' '));
       String suf = str.subString(str.indexOf(' '),str.length());
       String[] StrAll = Pre.split('/');
       for(String s:StrAll){
          if(Integer.valueOf(s) < 10){
             temp = temp + '0' + Integer.valueOf(s) + '-';
          }else{
             temp = temp + Integer.valueOf(s) + '-';
          }
       }
       return temp.substring(0,temp.length() -1) + suf;
   }
    public Boolean getInvoiceInfo(String startDate, String endDate) {
             
        try{
            Boolean flag=false;
            List<Log__c> logList = new List<Log__c>();
            Log__c l = new Log__c();
            //通过webservice获取税控机返回信息，成功
            EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceSOAP getInvoiceObject = new EsbMossGetcontractinvo.ESB_MOSS_GetContractInvoiceSOAP();
            EsbMossGetcontractinvo.GetContractInvoiceOutPutType getinvoiceResponse;

            EsbMossGetcontractinvo.GetContractInvoiceType inRequest = new EsbMossGetcontractinvo.GetContractInvoiceType();
            inRequest.startDate = startDate;
            inRequest.endDate = endDate;
              
            getinvoiceResponse = getInvoiceObject.ESB_MOSS_GetContractInvoice(inRequest);
            List < EsbMossGetcontractinvo.OutputCiType > sList = new List < EsbMossGetcontractinvo.OutputCiType > ();
            sList = getinvoiceResponse.OutputCi;
            Map<String,EsbMossGetcontractinvo.OutputCiType> sMap = new Map<String, EsbMossGetcontractinvo.OutputCiType>();
            Map<String,List<EsbMossGetcontractinvo.OutputCiType>> sMapList = new Map<String, List<EsbMossGetcontractinvo.OutputCiType>>();
            List<String> idList = new List<String>();
            Map<String,String> ApplicationID_Map = new Map<String,String>();
            Map<String,String> CustomerName_Map = new Map<String,String>();
            Map<String,String> SumAmount_Map = new Map<String,String>();
            Map<String,String> InvoiceStatus_Map = new Map<String,String>();
            Map<String,String> SendBackTime_Map = new Map<String,String>();
            Map<String,String> ImportTime_Map = new Map<String,String>();
            Map<String,String> Tax_Map = new Map<String,String>();
            Map<String,String> CombineFlag_Map = new Map<String,String>();
            Map<String,String> InvoiceType_Map = new Map<String,String>();
            Map<String,String> InvoiceNumber_Map = new Map<String,String>();
            Map<String,String> InvoiceCode_Map = new Map<String,String>();
            for (EsbMossGetcontractinvo.OutputCiType sItem: sList) {
                String SItemID = sItem.id.trim();
                idList.add(SItemID);
                if(ApplicationID_Map.get(SItemID)!=null){
                    String OldData1 = ApplicationID_Map.get(SItemID);
                    ApplicationID_Map.remove(SItemID);
                    ApplicationID_Map.put(SItemID,OldData1 + ',' + sItem.ApplicationID.trim());
                }else{                
                    ApplicationID_Map.put(SItemID,sItem.ApplicationID.trim());
                }
                if(CustomerName_Map.get(SItemID)!=null){
                    String OldData2 = CustomerName_Map.get(SItemID);
                    CustomerName_Map.remove(SItemID);
                    CustomerName_Map.put(SItemID,OldData2 + ',' + sItem.CustomerName.trim());
                }else{                
                    CustomerName_Map.put(SItemID,sItem.CustomerName.trim());
                }
                if(SumAmount_Map.get(SItemID)!=null){
                    String OldData3 = SumAmount_Map.get(SItemID);
                    SumAmount_Map.remove(SItemID);
                    SumAmount_Map.put(SItemID,OldData3 + ',' + sItem.SumAmount);
                }else{                
                    SumAmount_Map.put(SItemID,sItem.SumAmount);
                }
                if(InvoiceStatus_Map.get(SItemID)!=null){
                    String OldData4 = InvoiceStatus_Map.get(SItemID);
                    InvoiceStatus_Map.remove(SItemID);
                    InvoiceStatus_Map.put(SItemID,OldData4 + ',' + getDescByValue('t',sItem.InvoiceStatus));
                }else{                
                    InvoiceStatus_Map.put(SItemID,getDescByValue('t',sItem.InvoiceStatus));
                }
                if(SendBackTime_Map.get(SItemID)!=null){
                    String OldData5 = SendBackTime_Map.get(SItemID);
                    SendBackTime_Map.remove(SItemID);
                    SendBackTime_Map.put(SItemID,OldData5 + ',' + ConvertToDateString(sItem.SendBackTime));
                }else{                
                    SendBackTime_Map.put(SItemID,ConvertToDateString(sItem.SendBackTime));
                }
                if(ImportTime_Map.get(SItemID)!=null){
                    String OldData6 = ImportTime_Map.get(SItemID);
                    ImportTime_Map.remove(SItemID);
                    ImportTime_Map.put(SItemID,OldData6 + ',' + ConvertToDateString(sItem.ImportTime));
                }else{                
                    ImportTime_Map.put(SItemID,ConvertToDateString(sItem.ImportTime));
                }
                if(Tax_Map.get(SItemID)!=null){
                    String OldData7 = Tax_Map.get(SItemID);
                    Tax_Map.remove(SItemID);
                    Tax_Map.put(SItemID,OldData7 + ',' + sItem.Tax);
                }else{                
                    Tax_Map.put(SItemID,sItem.Tax);
                }
                if(CombineFlag_Map.get(SItemID)!=null){
                    String OldData8 = CombineFlag_Map.get(SItemID);
                    CombineFlag_Map.remove(SItemID);
                    CombineFlag_Map.put(SItemID,OldData8 + ',' + sItem.CombineFlag);
                }else{                
                    CombineFlag_Map.put(SItemID,sItem.CombineFlag);
                }
                if(InvoiceType_Map.get(SItemID)!=null){
                    String OldData9 = InvoiceType_Map.get(SItemID);
                    InvoiceType_Map.remove(SItemID);
                    InvoiceType_Map.put(SItemID,OldData9 + ',' + getDescByValue('s',sItem.InvoiceType));
                }else{                
                    InvoiceType_Map.put(SItemID,getDescByValue('s',sItem.InvoiceType));
                }
                if(InvoiceNumber_Map.get(SItemID)!=null){
                    String OldData10 = InvoiceNumber_Map.get(SItemID);
                    InvoiceNumber_Map.remove(SItemID);
                    InvoiceNumber_Map.put(SItemID,OldData10 + ',' + sItem.InvoiceNumber.trim());
                }else{                
                    InvoiceNumber_Map.put(SItemID,sItem.InvoiceNumber.trim());
                }
                if(InvoiceCode_Map.get(SItemID)!=null){
                    String OldData11 = InvoiceCode_Map.get(SItemID);
                    InvoiceCode_Map.remove(SItemID);
                    InvoiceCode_Map.put(SItemID,OldData11 + ',' + sItem.InvoiceCode.trim());
                }else{                
                    InvoiceCode_Map.put(SItemID,sItem.InvoiceCode.trim());
                }
            }
            
            List<invoiceItem__c> invoiceList = new List<invoiceItem__c>();
            invoiceList = [select id, invoiceUUID__c, applicationID__c, customerName__c, sumAmount__c, invoiceStatus__c, sendBackTime__c, tax__c, importTime__c, combineFlag__c, invoiceNumber__c, invoiceCode__c, invoiceType__c,  invoiceName__c, contractNumber__c from invoiceItem__c where invoiceUUID__c in :idList];
            for(invoiceItem__c itemObject:invoiceList){
                String sId = itemObject.invoiceUUID__c;
                String ApplicationIDs = ApplicationID_Map.get(sId);
                String CustomerNames = CustomerName_Map.get(sId);
                String SumAmounts = SumAmount_Map.get(sId);
                String InvoiceStatuss = InvoiceStatus_Map.get(sId);
                String SendBackTimes = SendBackTime_Map.get(sId);
                String ImportTimes = ImportTime_Map.get(sId);
                String Taxs = Tax_Map.get(sId);
                String CombineFlags = CombineFlag_Map.get(sId);
                String InvoiceTypes = InvoiceType_Map.get(sId);
                String InvoiceNumbers = InvoiceNumber_Map.get(sId);
                String InvoiceCodes = InvoiceCode_Map.get(sId);
                //将数据写入发票项上，全部覆盖原有信息
                //税控机返回的申请ID
                itemObject.applicationID__c = ApplicationIDs;
                //客户名称
                itemObject.customerName__c = CustomerNames;
                //开票金额
                itemObject.sumAmount__c = SumAmounts;
                //开票状态
                itemObject.invoiceStatus__c = InvoiceStatuss;
                //回传时间
                itemObject.sendBackTime__c = SendBackTimes;
                //导入时间
                itemObject.importTime__c = ImportTimes;
                //税额
                itemObject.Tax__c = Taxs;
                //不清楚
                itemObject.combineFlag__c = CombineFlags;
                //发票类型
                itemObject.invoiceType__c = InvoiceTypes;
                //发票号
                itemObject.invoiceNumber__c = InvoiceNumbers;
                //发票版本号
                itemObject.invoiceCode__c = InvoiceCodes;
                
                System.Debug('AAAF:' + InvoiceCodes);
            }
            try{                        
                update invoiceList;
                flag=true; 
            }catch(Exception e2){
                System.debug('e2--'+e2.getMessage());
                LogClass.returnLog('失败', '未处理','【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + '。更新开票项返回错误信息：'+e2.getMessage(), '重要'); 
                 
                return false; 
            }
            
                //更新开票信息上获取开票中间库接口信息状态
            List<invoice__c> invoiceList2 = new List<invoice__c>();
            String SOSPInvoiceNo = '';
            try{
                invoiceList2 = [select id,billingMachine__c,pullSKJStatus__c,pullSKJTime__c,Name from invoice__c where billingMachine__c in :idList];
                for(invoice__c isInvo:invoiceList2){
                    SOSPInvoiceNo = SOSPInvoiceNo + isInvo.Name + '; ';
                    if(flag){
                        isInvo.pullSKJStatus__c = '同步成功';
                    }else{
                        isInvo.pullSKJStatus__c = '同步失败';
                    }
                    isInvo.pullSKJTime__c = System.now();               
                }
             
                if(flag){                        
                	
                    update invoiceList2;
                }
            }catch(Exception e3){
                 System.debug('e3--'+e3.getMessage());
                 LogClass.returnLog('失败', '未处理','【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + '。更新开票头返回错误信息：'+e3.getMessage(), '重要'); 
                 
                 return false;
            }
            
            String LogString = '【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + '##########。开票机返回的数据长度为：' + sList.size() + '########## SOSP找到的数据长度为: ' + invoiceList.size() +  '########## SOSP找到的开票项编号: ' + SOSPInvoiceNo + '##########';
            
            LogClass.returnLog('成功', '已处理', '【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + ';数据' + LogString  , '重要');
            return true;
        }catch(NullPointerException e){
            LogClass.returnLog('成功', '已处理', '【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + ' 没有取得信息!' , '重要'); 
            return true;
        }catch(Exception e){
            System.debug('eDD:' + e);
            LogClass.returnLog('失败', '未处理', '【获取开票中间库返回数据】开始日期：' + startDate + ' 结束日期：' + endDate + '。错误信息：' + e.getMessage() + ':::' + e, '重要'); 
            return false;
        }
    }
    
}