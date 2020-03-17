global with sharing class FilesRemoter { 
   public static String SR;
   public static String outpubMes;
   
   @RemoteAction
   global static String deleteLog(){
      List<log__c> listLog = new List<log__c>();
      listLog = [select id from log__c limit 5000];
      Delete listLog;
      return '删除成功';
   }
   @RemoteAction
   global static String insertInvoice(String sId){
      insertInvoice insObj = new insertInvoice();
      if(sId==null){
          sId = 'a0XN0000002eDX0';
      }
      Boolean bool = insObj.insertInvoice(sId);
      return String.valueOf(bool);
   }
    //回款
   @RemoteAction
   global static String sendReturn(String rId){
      returnPoolToSAP reObj = new returnPoolToSAP();
      Map<String,String> s =new Map<String,String>();
      //List<String> s = new List<String>();
      //s.put('a00N000000Et9gk');
      //s.put('a00N000000EtOj9','20160930');
      //s.put('a00N000000EtAKB');
      if(rId!=null){
           s.put(rId,'20161030');
      }
      
      Boolean bool = reObj.returnPoolToSAP(s);
      //logClass.returnLog('成功', '已处理', s.get(rId), '正常'); 
      return String.valueOf(bool);
   }
   
   @RemoteAction
   global static String sendToSap(Id sId){
       //sendInvoiceToSAP obj = new sendInvoiceToSAP();
       sendInvoiceToSAP obj = new sendInvoiceToSAP();
       //logClass.returnLog('成功', '已处理',sId, '正常'); 
       Set<Id> l = new Set<Id>();
       l.add(sId);
       //l.add('a0XN0000002eqEB');
       //l.add('a0XN0000002eqDp');
       //Boolean boole = obj.sendInvoiceToSAP(l);
       Boolean boole = obj.sendInvoiceToSAP(l);
       return String.valueOf(boole);
   }
   @RemoteAction
   global static String sendacctoSap(String step,String accountId,String sType,String subCompanyCode,String salesOrgNameCode){
       sendAccountToSap obj = new sendAccountToSap();
       //String accountId = '001N000000pEKsH';
       //String sType='D';
       //String subCompanyCode;
       //String salesOrgNameCode;
       //subCompanyCode = 'CC01'; 
       //if(sType=='C'){ 
                    
           //salesOrgNameCode= 'S001';
       //}
       
       Boolean bool = obj.sendAccountToSap(step,accountId,sType,subCompanyCode,salesOrgNameCode);
       return String.valueOf(bool);
   }
   @RemoteAction
   global static Boolean getInvoiceInfo(String startDt,String endDt){
       
       //String startDt = '2013-01-01';
       //String endDt = '2016-11-01';
       //LogClass.returnLog('成功', '已处理', '【获取开票中间库返回数据】开始日期：' + startDt+ ' 结束日期：' + endDt, '重要');  
       getInvoiceInfo obj = new getInvoiceInfo();
       Boolean bool = obj.getInvoiceInfo(startDt,endDt);
       return bool;
   }
   @RemoteAction
   global static String GetContractStPlanDate(String startDt,String endDt){
       GetContractStPlanDate obj = new GetContractStPlanDate();
       //String startDt = '2016-01-01';
       //String endDt = '2016-11-01';
       Boolean bool = obj.GetContractStPlanDate(startDt,endDt );
       return String.valueOf(bool);
   }
   @RemoteAction 
   global static String upload() {
     
      try{
          //String engStr = 'Tranzvision';
          //String zhsStr = '创景咨询';
          //SR = engStr.length() + '<-->' + zhsStr.length();
          //String s = 'SOSP%5CContractId12345%5Cu4EF6.txt';
          //SR = EncodingUtil.urlDecode(s,'utf-8');
          invoice__c invoiceObject2 = new invoice__c();
          invoiceObject2.id = 'a0XN0000002eOZx';
          invoiceObject2.pushSKJStatus__c = '同步成功';
          invoiceObject2.pushSKJTime__c = System.now();
          update invoiceObject2;
          return SR;
          
      }catch(Exception e){
          SR = e.getMessage();
      }
      return SR;
   } 
   @RemoteAction
   global static String pushInvoiceToSF(String invoName){
       
           invoice__c temp = [Select id,Name,accountName__c ,expressNumber__c,orderIDSF__c, applyByName__c, applyPhone__c, receiver__c, receiverPhone__c, receiverCompany__c, 
                 shippingAddress__c from invoice__c where Name=:invoName limit 1][0];
           SOSPToSFOrder.createSFOrder(temp.Id, 'invoice__c', temp.applyByName__c, temp.applyPhone__c, '北京市海淀区上地四街9号', '北京四方继保公司', temp.receiver__c, temp.receiverPhone__c, temp.shippingAddress__c, temp.receiverCompany__c);
       //String startDt = '2016-01-01';
       //String endDt = '2016-11-01';
       //Boolean bool = obj.GetContractStPlanDate(startDt,endDt );
           return '是否成功，请查看开票：'+invoName;
       
   }
   @RemoteAction
   global static String pushReceiveToSF(String receName){
       receipt__c temp =[Select id,Name,accountName__c,orderNumberSF__c,orderIDSF__c, applyByName__c, applyPhone__c, receiverSF__c, receiverPhoneSF__c, receiverCompany__c, 
                 shippingAddressSF__c from receipt__c where Name=:receName limit 1][0];
       SOSPToSFOrder.createSFOrder(temp.Id, 'receipt__c', temp.applyByName__c, temp.applyPhone__c, '北京市海淀区上地四街9号', '北京四方继保公司', temp.receiverSF__c, temp.receiverPhoneSF__c, temp.shippingAddressSF__c, temp.receiverCompany__c); 
       return '是否成功，请查看收据：'+receName;         
   }
   @RemoteAction
   global static String pushContractChangeToBPM(String concName){
       contractchange__c temp = [select id from contractchange__c where Name =:concName limit 1][0];
       SOSPContractChangeToBPM.change(temp.id);     
       return '是否成功，请查看合同变更：'+concName;    
   }
 }